From: Marc Zyngier <maz@misterjones.org>
Subject: Re: [PATCH] drivers: MMC: enable SDHCI-S3C on S5PC1XX platform
Date: Tue, 17 Nov 2009 12:11:43 +0100
Message-ID: <20091117121143.09246257@life-in-the-fast-lane>
References: <1258444374-21479-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1258444374-21479-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, kyungmin.park@samsung.com, ben-linux@fluff.org, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

On Tue, 17 Nov 2009 08:52:54 +0100
Marek Szyprowski <m.szyprowski@samsung.com> wrote:

> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Samsung S5PC100 SoC has SDHCI controller compatible to the one known
> from S3C64xx SoCs. Enable support for sdhci-s3c driver also on
> S5PC1xx platform.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/mmc/host/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 432ae83..faddf82 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -96,7 +96,7 @@ config MMC_SDHCI_PLTFM
>  
>  config MMC_SDHCI_S3C
>  	tristate "SDHCI support on Samsung S3C SoC"
> -	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX)
> +	depends on MMC_SDHCI && (PLAT_S3C24XX || PLAT_S3C64XX ||
> PLAT_S5PC1XX) help
>  	  This selects the Secure Digital Host Controller Interface
> (SDHCI) often referrered to as the HSMMC block in some of the Samsung
> S3C

I think it was Ben that suggested once to introduce a HAVE_SDHCI_S3C
symbol, selected by interested parties (S3C, S5P, S5PC...).

Given the way Samsung SoCs are assembled (from an IP point of view), it
would make sense for one SoC to describe its features in
"HAVE_FEATURE_FOO" terms rather than each subsystem depending an ever
growing list of SoC.

	M.
-- 
Fast. Cheap. Reliable. Pick two.
