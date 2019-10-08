From: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v3 6/6] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Date: Tue, 8 Oct 2019 14:46:09 -0700
Message-ID: <20191008214609.wk2imvejk2h2pvil@cantor>
References: <20191001142725.30857-1-andriy.shevchenko@linux.intel.com>
	<20191001142725.30857-7-andriy.shevchenko@linux.intel.com>
Reply-To: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20191001142725.30857-7-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue Oct 01 19, Andy Shevchenko wrote:
>Since we have a generic helper, drop custom implementation in the driver.
>
>Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>---
> drivers/iommu/amd_iommu.c | 30 +++++-------------------------
> 1 file changed, 5 insertions(+), 25 deletions(-)
>
>diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
>index 2369b8af81f3..40f3cf44aa98 100644
>--- a/drivers/iommu/amd_iommu.c
>+++ b/drivers/iommu/amd_iommu.c
>@@ -124,30 +124,6 @@ static struct lock_class_key reserved_rbtree_key;
>  *
>  ****************************************************************************/
>
>-static inline int match_hid_uid(struct device *dev,
>-				struct acpihid_map_entry *entry)
>-{
>-	struct acpi_device *adev = ACPI_COMPANION(dev);
>-	const char *hid, *uid;
>-
>-	if (!adev)
>-		return -ENODEV;
>-
>-	hid = acpi_device_hid(adev);
>-	uid = acpi_device_uid(adev);
>-
>-	if (!hid || !(*hid))
>-		return -ENODEV;
>-
>-	if (!uid || !(*uid))
>-		return strcmp(hid, entry->hid);
>-
>-	if (!(*entry->uid))
>-		return strcmp(hid, entry->hid);
>-
>-	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
>-}
>-
> static inline u16 get_pci_device_id(struct device *dev)
> {
> 	struct pci_dev *pdev = to_pci_dev(dev);
>@@ -158,10 +134,14 @@ static inline u16 get_pci_device_id(struct device *dev)
> static inline int get_acpihid_device_id(struct device *dev,
> 					struct acpihid_map_entry **entry)
> {
>+	struct acpi_device *adev = ACPI_COMPANION(dev);
> 	struct acpihid_map_entry *p;
>
>+	if (!adev)
>+		return -ENODEV;
>+
> 	list_for_each_entry(p, &acpihid_map, list) {
>-		if (!match_hid_uid(dev, p)) {
>+		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> 			if (entry)
> 				*entry = p;
> 			return p->devid;
>-- 
>2.23.0
>
>_______________________________________________
>iommu mailing list
>iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
>https://lists.linuxfoundation.org/mailman/listinfo/iommu

Reviewed-by: Jerry Snitselaar <jsnitsel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
