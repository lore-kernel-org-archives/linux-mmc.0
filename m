From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 3/6] ACPI / utils: Introduce acpi_dev_hid_uid_match()
	helper
Date: Tue, 1 Oct 2019 12:38:54 +0300
Message-ID: <20191001093854.GH2714@lahna.fi.intel.com>
References: <20190924193739.86133-1-andriy.shevchenko@linux.intel.com>
	<20190924193739.86133-4-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20190924193739.86133-4-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 24, 2019 at 10:37:36PM +0300, Andy Shevchenko wrote:
> There are users outside of ACPI realm which reimplementing the comparator
> function to check if the given device matches to given HID and UID.
> 
> For better utilization, introduce a helper for everyone to use.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>
> ---
>  drivers/acpi/utils.c    | 25 +++++++++++++++++++++++++
>  include/acpi/acpi_bus.h |  2 ++
>  include/linux/acpi.h    |  6 ++++++
>  3 files changed, 33 insertions(+)
> 
> diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
> index dbd1c4cfd7d1..804ac0df58ec 100644
> --- a/drivers/acpi/utils.c
> +++ b/drivers/acpi/utils.c
> @@ -701,6 +701,31 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
>  }
>  EXPORT_SYMBOL(acpi_check_dsm);
>  
> +/**
> + * acpi_dev_hid_uid_match - Match device by supplied HID and UID
> + * @adev: ACPI device to match.
> + * @hid2: Hardware ID of the device.
> + * @uid2: Unique ID of the device, pass NULL to not check _UID.
> + *
> + * Matches HID and UID in @adev with given @hid2 and @uid2.
> + * Returns true if matches.
> + */
> +bool acpi_dev_hid_uid_match(struct acpi_device *adev,
> +			    const char *hid2, const char *uid2)
> +{
> +	const char *hid1 = acpi_device_hid(adev);
> +	const char *uid1 = acpi_device_uid(adev);
> +
> +	if (strcmp(hid1, hid2))
> +		return false;
> +
> +	if (!uid2)
> +		return true;
> +
> +	return uid1 && !strcmp(uid1, uid2);
> +}
> +EXPORT_SYMBOL(acpi_dev_hid_uid_match);

Should this be _GPL?

In any case looks good,

Reviewed-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
