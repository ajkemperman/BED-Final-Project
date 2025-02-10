/*
  Warnings:

  - You are about to drop the column `propertyId` on the `Review` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Review` table. All the data in the column will be lost.
  - Added the required column `propertyIdRev` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userIdRev` to the `Review` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Review" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "rating" INTEGER NOT NULL,
    "comment" TEXT NOT NULL,
    "userIdRev" TEXT NOT NULL,
    "propertyIdRev" TEXT NOT NULL,
    CONSTRAINT "Review_userIdRev_fkey" FOREIGN KEY ("userIdRev") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "Review_propertyIdRev_fkey" FOREIGN KEY ("propertyIdRev") REFERENCES "Property" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Review" ("comment", "id", "rating") SELECT "comment", "id", "rating" FROM "Review";
DROP TABLE "Review";
ALTER TABLE "new_Review" RENAME TO "Review";
CREATE INDEX "Review_userIdRev_idx" ON "Review"("userIdRev");
CREATE INDEX "Review_propertyIdRev_idx" ON "Review"("propertyIdRev");
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
