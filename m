From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v1 5/5] iommu/amd: Switch to use acpi_dev_hid_uid_match()
Date: Tue, 24 Sep 2019 15:16:56 +0300
Message-ID: <20190924121656.GV2680@smile.fi.intel.com>
References: <20190924120153.8382-1-andriy.shevchenko@linux.intel.com>
	<20190924120153.8382-5-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190924120153.8382-5-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 24, 2019 at 03:01:53PM +0300, Andy Shevchenko wrote:
> Since we have a generic helper, drop custom implementation in the driver.

Actually we may get rid of match_hid_uid() completely and thus slightly speed
up get_acpihid_device_id().

I'll wait for other comments and then send v2.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> ---
>  drivers/iommu/amd_iommu.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 61de81965c44..bad1bcea4ea1 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -129,24 +129,11 @@ static inline int match_hid_uid(struct device *dev,
>  				struct acpihid_map_entry *entry)
>  {
>  	struct acpi_device *adev = ACPI_COMPANION(dev);
> -	const char *hid, *uid;
>  
>  	if (!adev)
>  		return -ENODEV;
>  
> -	hid = acpi_device_hid(adev);
> -	uid = acpi_device_uid(adev);
> -
> -	if (!hid || !(*hid))
> -		return -ENODEV;
> -
> -	if (!uid || !(*uid))
> -		return strcmp(hid, entry->hid);
> -
> -	if (!(*entry->uid))
> -		return strcmp(hid, entry->hid);
> -
> -	return (strcmp(hid, entry->hid) || strcmp(uid, entry->uid));
> +	return acpi_dev_hid_uid_match(adev, entry->hid, entry->uid) ? 0 : -ENODEV;
>  }
>  
>  static inline u16 get_pci_device_id(struct device *dev)
> -- 
> 2.23.0
> 

-- 
With Best Regards,
Andy Shevchenko
