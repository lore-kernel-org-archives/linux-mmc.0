From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v2 2/3] ACPI: add SDHCI to ACPI platform devices
Date: Fri, 23 Nov 2012 15:25:18 +0200
Message-ID: <20121123132518.GZ3867@intel.com>
References: <1353670561-22515-1-git-send-email-adrian.hunter@intel.com>
 <1353670561-22515-3-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1353670561-22515-3-git-send-email-adrian.hunter@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 23, 2012 at 01:36:00PM +0200, Adrian Hunter wrote:
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/acpi/scan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 8c4ac6d..67a7fa6 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -35,6 +35,8 @@ static const char *dummy_hid = "device";
>   */
>  static const struct acpi_device_id acpi_platform_device_ids[] = {
>  
> +	{ "PNP0D40" },
> +
>  	{ }
>  };
>  
> -- 
> 1.7.11.7
