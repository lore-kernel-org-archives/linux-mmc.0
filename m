From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v5 1/4] ARM: davinci: mmc: derive version information
 from device name
Date: Thu, 14 Mar 2013 16:38:09 +0530
Message-ID: <5141AF99.5090608@ti.com>
References: <1363097637-11371-1-git-send-email-prakash.pm@ti.com> <1363097637-11371-2-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363097637-11371-2-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com
List-Id: linux-mmc@vger.kernel.org

Prakash,

The series looks good to me. I tested it again on DA850 EVM (with and
without DT).

On 3/12/2013 7:43 PM, Manjunathappa, Prakash wrote:
> Remove specifying mmc controller IP version information via platform
> data, instead specify device name so that driver derives it from
> platform_device_id table. Also change the clock node name to match
> the changed dev_id.
> Tested on da850-evm to make sure driver loads without clk_get failures.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Reviewed-by: Sekhar Nori <nsekhar@ti.com>
> ---

> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 27123f8..50e9782 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -1157,6 +1157,18 @@ static void __init init_mmcsd_host(struct mmc_davinci_host *host)
>  	mmc_davinci_reset_ctrl(host, 0);
>  }
>  
> +static struct platform_device_id davinci_mmc_devtype[] = {
> +	{
> +		.name	= "davinci-mmc-dm355",
> +		.driver_data = MMC_CTLR_VERSION_1,
> +	}, {
> +		.name	= "davinci-mmc-da830",
> +		.driver_data = MMC_CTLR_VERSION_2,
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(platform, davinci_mmc_devtype);

I should have mentioned this previously, but your choice of name here is
too long. You can simply use dm355-mmc (rather dm6441-mmc?) and
da830-mmc instead like you did for SPI. This would have saved some long
lines. Sorry about not asking for this earlier. I know it would have
saved you a bunch of effort.

Thanks,
Sekhar
