import { PrismaClient } from "@prisma/client";

const createProperty = async (
  title,
  description,
  location,
  pricePerNight,
  bedroomCount,
  bathRoomCount,
  maxGuestCount,
  rating,
  image,
  hostId,
  amenitiesIds
) => {
  const prisma = new PrismaClient();

  const property = await prisma.property.create({
    data: {
      title,
      description,
      location,
      pricePerNight,
      bedroomCount,
      bathRoomCount,
      maxGuestCount,
      rating,
      image,
      host: {
        connect: { id: hostId },
      },
      amenities: amenitiesIds
        ? {
            connect: amenitiesIds.map((id) => ({ id })),
          }
        : undefined,
    },
  });

  return property;
};

export default createProperty;
