From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v3 2/4] omap4 hsmmc: Fix the init if CONFIG_MMC_OMAP_HS
 is 	not set
Date: Wed, 22 Sep 2010 22:05:47 +0400
Message-ID: <4C9A457B.4060500@ru.mvista.com>
References: <14880.10.24.255.18.1285173821.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <14880.10.24.255.18.1285173821.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: kishore kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hello.

kishore kadiyala wrote:

> From: Benoit Cousson <b-cousson@ti.com>

> Avoid possible crash if CONFIG_MMC_OMAP_HS is not set

> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> ---
>  arch/arm/mach-omap2/board-4430sdp.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index a49f285..ac8541c 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -240,8 +240,14 @@ static int omap4_twl6030_hsmmc_late_init(struct device *dev)
> 
>  static __init void omap4_twl6030_hsmmc_set_late_init(struct device *dev)
>  {
> -	struct omap_mmc_platform_data *pdata = dev->platform_data;
> +	struct omap_mmc_platform_data *pdata;
> 
> +	/* dev can be null if CONFIG_MMC_OMAP_HS is not set */
> +	if (!dev) {
> +		pr_err("Failed omap4_twl6030_hsmmc_set_late_init\n");

    pr_err("Failed %s\n", __func__);

WBR, Sergei
