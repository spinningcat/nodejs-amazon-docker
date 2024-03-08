/*
  Warnings:

  - You are about to drop the column `aditional` on the `Camera` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[name]` on the table `Company` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[website]` on the table `Company` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[phone_number]` on the table `Company` will be added. If there are existing duplicate values, this will fail.
  - A unique constraint covering the columns `[address]` on the table `Company` will be added. If there are existing duplicate values, this will fail.
  - Made the column `age_range` on table `Age` required. This step will fail if there are existing NULL values in that column.
  - Made the column `confidence` on table `Age` required. This step will fail if there are existing NULL values in that column.
  - Made the column `role` on table `AppUser` required. This step will fail if there are existing NULL values in that column.
  - Made the column `account_status` on table `AppUser` required. This step will fail if there are existing NULL values in that column.
  - Made the column `branch_id` on table `AppUser` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `working_hours` to the `Branch` table without a default value. This is not possible if the table is not empty.
  - Made the column `resolution` on table `Camera` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `status` to the `Camera` table without a default value. This is not possible if the table is not empty.
  - Made the column `protocol` on table `Camera` required. This step will fail if there are existing NULL values in that column.
  - Made the column `host` on table `Camera` required. This step will fail if there are existing NULL values in that column.
  - Made the column `path` on table `Camera` required. This step will fail if there are existing NULL values in that column.
  - Made the column `event_time` on table `EnterExit` required. This step will fail if there are existing NULL values in that column.
  - Made the column `event_type` on table `EnterExit` required. This step will fail if there are existing NULL values in that column.
  - Made the column `gender` on table `Gender` required. This step will fail if there are existing NULL values in that column.
  - Made the column `confidence` on table `Gender` required. This step will fail if there are existing NULL values in that column.
  - Made the column `incident_date` on table `Incident` required. This step will fail if there are existing NULL values in that column.
  - Made the column `resolved` on table `Incident` required. This step will fail if there are existing NULL values in that column.
  - Made the column `action_description` on table `MaintenanceLog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `log_time` on table `MaintenanceLog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `movement_type` on table `Movement` required. This step will fail if there are existing NULL values in that column.
  - Made the column `start_time` on table `Movement` required. This step will fail if there are existing NULL values in that column.
  - Made the column `end_time` on table `Movement` required. This step will fail if there are existing NULL values in that column.
  - Made the column `detection_time` on table `Person` required. This step will fail if there are existing NULL values in that column.
  - Made the column `label` on table `Person` required. This step will fail if there are existing NULL values in that column.
  - Made the column `confidence` on table `Person` required. This step will fail if there are existing NULL values in that column.
  - Made the column `action_description` on table `SecurityLog` required. This step will fail if there are existing NULL values in that column.
  - Made the column `log_time` on table `SecurityLog` required. This step will fail if there are existing NULL values in that column.

*/
-- DropForeignKey
ALTER TABLE "AppUser" DROP CONSTRAINT "AppUser_branch_id_fkey";

-- DropIndex
DROP INDEX "AppUser_email_key";

-- AlterTable
ALTER TABLE "Age" ALTER COLUMN "age_range" SET NOT NULL,
ALTER COLUMN "confidence" SET NOT NULL;

-- AlterTable
ALTER TABLE "AppUser" ALTER COLUMN "full_name" SET DATA TYPE TEXT,
ALTER COLUMN "role" SET NOT NULL,
ALTER COLUMN "account_status" SET NOT NULL,
ALTER COLUMN "branch_id" SET NOT NULL;

-- AlterTable
ALTER TABLE "Branch" ADD COLUMN     "parent_branch_id" INTEGER,
ADD COLUMN     "working_hours" TIMESTAMP(3) NOT NULL;

-- AlterTable
ALTER TABLE "Camera" DROP COLUMN "aditional",
ADD COLUMN     "additional" JSONB,
ALTER COLUMN "resolution" SET NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" BOOLEAN NOT NULL,
ALTER COLUMN "protocol" SET NOT NULL,
ALTER COLUMN "host" SET NOT NULL,
ALTER COLUMN "path" SET NOT NULL;

-- AlterTable
ALTER TABLE "Company" ALTER COLUMN "registration_number" DROP NOT NULL,
ALTER COLUMN "industry" DROP NOT NULL,
ALTER COLUMN "website" DROP NOT NULL,
ALTER COLUMN "phone_number" DROP NOT NULL,
ALTER COLUMN "address" DROP NOT NULL;

-- AlterTable
ALTER TABLE "EnterExit" ALTER COLUMN "event_time" SET NOT NULL,
ALTER COLUMN "event_type" SET NOT NULL,
ALTER COLUMN "event_type" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "Gender" ALTER COLUMN "gender" SET NOT NULL,
ALTER COLUMN "confidence" SET NOT NULL;

-- AlterTable
ALTER TABLE "Incident" ALTER COLUMN "incident_date" SET NOT NULL,
ALTER COLUMN "resolved" SET NOT NULL;

-- AlterTable
ALTER TABLE "MaintenanceLog" ALTER COLUMN "action_description" SET NOT NULL,
ALTER COLUMN "log_time" SET NOT NULL;

-- AlterTable
ALTER TABLE "Movement" ALTER COLUMN "movement_type" SET NOT NULL,
ALTER COLUMN "start_time" SET NOT NULL,
ALTER COLUMN "end_time" SET NOT NULL;

-- AlterTable
ALTER TABLE "Person" ALTER COLUMN "detection_time" SET NOT NULL,
ALTER COLUMN "label" SET NOT NULL,
ALTER COLUMN "confidence" SET NOT NULL;

-- AlterTable
ALTER TABLE "SecurityLog" ALTER COLUMN "action_description" SET NOT NULL,
ALTER COLUMN "log_time" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Company_name_key" ON "Company"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Company_website_key" ON "Company"("website");

-- CreateIndex
CREATE UNIQUE INDEX "Company_phone_number_key" ON "Company"("phone_number");

-- CreateIndex
CREATE UNIQUE INDEX "Company_address_key" ON "Company"("address");

-- AddForeignKey
ALTER TABLE "Branch" ADD CONSTRAINT "Branch_parent_branch_id_fkey" FOREIGN KEY ("parent_branch_id") REFERENCES "Branch"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Camera" ADD CONSTRAINT "Camera_branch_id_fkey" FOREIGN KEY ("branch_id") REFERENCES "Branch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AppUser" ADD CONSTRAINT "AppUser_branch_id_fkey" FOREIGN KEY ("branch_id") REFERENCES "Branch"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
