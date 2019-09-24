From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v1 3/5] ACPI / LPSS: Switch to use acpi_dev_hid_uid_match()
Date: Tue, 24 Sep 2019 15:01:51 +0300
Message-ID: <20190924120153.8382-3-andriy.shevchenko@linux.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190924120153.8382-1-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Since we have a generic helper, drop custom implementation in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/acpi/acpi_lpss.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index d696f165a50e..1e6d959bd968 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -476,31 +476,16 @@ static const struct lpss_device_links lpss_device_links[] = {
 	{"80860F41", "5", "LNXVIDEO", NULL, DL_FLAG_PM_RUNTIME},
 };
 
-static bool hid_uid_match(struct acpi_device *adev,
-			  const char *hid2, const char *uid2)
-{
-	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
-
-	if (strcmp(hid1, hid2))
-		return false;
-
-	if (!uid2)
-		return true;
-
-	return uid1 && !strcmp(uid1, uid2);
-}
-
 static bool acpi_lpss_is_supplier(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
+	return acpi_dev_hid_uid_match(adev, link->supplier_hid, link->supplier_uid);
 }
 
 static bool acpi_lpss_is_consumer(struct acpi_device *adev,
 				  const struct lpss_device_links *link)
 {
-	return hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
+	return acpi_dev_hid_uid_match(adev, link->consumer_hid, link->consumer_uid);
 }
 
 struct hid_uid {
@@ -516,7 +501,7 @@ static int match_hid_uid(struct device *dev, const void *data)
 	if (!adev)
 		return 0;
 
-	return hid_uid_match(adev, id->hid, id->uid);
+	return acpi_dev_hid_uid_match(adev, id->hid, id->uid);
 }
 
 static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
-- 
2.23.0
