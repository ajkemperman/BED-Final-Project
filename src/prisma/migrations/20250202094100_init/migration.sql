/*
  Warnings:

  - You are about to drop the column `pictureUrl` on the `Host` table. All the data in the column will be lost.
  - You are about to drop the column `propertyIdRev` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `userIdRev` on the `Review` table. All the data in the column will be lost.
  - Added the required column `profilePicture` to the `Host` table without a default value. This is not possible if the table is not empty.
  - Added the required column `propertyId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Host" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phoneNumber" TEXT NOT NULL,
    "profilePicture" TEXT NOT NULL,
    "aboutMe" TEXT NOT NULL
);
INSERT INTO "new_Host" ("aboutMe", "email", "id", "name", "password", "phoneNumber", "username") SELECT "aboutMe", "email", "id", "name", "password", "phoneNumber", "username" FROM "Host";
DROP TABLE "Host";
ALTER TABLE "new_Host" RENAME TO "Host";
CREATE UNIQUE INDEX "Host_username_key" ON "Host"("username");
CREATE TABLE "new_Review" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "propertyId" TEXT NOT NULL,
    CONSTRAINT "Review_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Review_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Review" ("comment", "id", "rating") SELECT "comment", "id", "rating" FROM "Review";
DROP TABLE "Review";
ALTER TABLE "new_Review" RENAME TO "Review";
CREATE INDEX "Review_userId_idx" ON "Review"("userId");
CREATE INDEX "Review_propertyId_idx" ON "Review"("propertyId");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
