From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH v3 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for
 Samsung SoC
Date: Wed, 28 Jul 2010 13:42:56 +0900
Message-ID: <008b01cb2e0f$5c2de590$1489b0b0$%kim@samsung.com>
References: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
 <1279886191-9197-4-git-send-email-kgene.kim@samsung.com>
 <4C49871D.8030702@gmail.com> <000d01cb2d83$16b7efb0$4427cf10$%kim@samsung.com>
 <4C4F06EC.2020902@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7BIT
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <4C4F06EC.2020902@gmail.com>
Content-language: ko
Sender: linux-samsung-soc-owner@vger.kernel.org
To: 'Maurus Cuelenaere' <mcuelenaere@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, ben-linux@fluff.org, akpm@linux-foundation.org, 'Hyuk Lee' <hyuk1.lee@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Maurus Cuelenaere wrote:
> 
>  Op 27-07-10 13:58, Kukjin Kim schreef:
> > Maurus Cuelenaere wrote:
> >>  Op 23-07-10 13:56, Kukjin Kim schreef:
> >>> From: Hyuk Lee <hyuk1.lee@samsung.com>
> >>>
> >>> If host controller doesn't have WP pin which should be connnected with
> SDMMC
> >>> card WP pin, can implement get_ro function with using the allocated gpio.
> >>> In order to use this quirk wp_gpio in the platform data must be set.
> >>>
> >>> Signed-off-by: Hyuk Lee <hyuk1.lee@samsung.com>
> >>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci-s3c.c |   43
> >> ++++++++++++++++++++++++++++++++++++++++++
> >>>  drivers/mmc/host/sdhci.c     |    3 ++
> >>>  drivers/mmc/host/sdhci.h     |    3 ++
> >>>  3 files changed, 49 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> >>> index 0d25285..0b75e57 100644
> >>> --- a/drivers/mmc/host/sdhci-s3c.c
> >>> +++ b/drivers/mmc/host/sdhci-s3c.c
> >>> @@ -22,6 +22,7 @@
> >>>
> >>>  #include <linux/mmc/host.h>
> >>>
> >>> +#include <plat/gpio-cfg.h>
> >>>  #include <plat/sdhci.h>
> >>>  #include <plat/regs-sdhci.h>
> >>>
> >>> @@ -213,6 +214,36 @@ static void sdhci_s3c_set_clock(struct sdhci_host
> *host,
> >> unsigned int clock)
> >>>  }
> >>>
> >>>  /**
> >>> + * sdhci_s3c_get_ro - callback for get_ro
> >>> + * @host: The SDHCI host being changed
> >>> + *
> >>> + * If the WP pin is connected with GPIO, can get the value which indicates
> >>> + * the card is locked or not.
> >>> +*/
> >>> +static int sdhci_s3c_get_ro(struct mmc_host *mmc)
> >>> +{
> >>> +	struct sdhci_s3c *sc;
> >>> +	struct sdhci_host *host;
> >>> +
> >>> +	host = mmc_priv(mmc);
> >>> +	sc = sdhci_priv(host);
> >> This can be done as static initializer if you reverse the order above.
> > Could you please kindly explain about this?
> > Sorry, I cannot get the exactly meaning...
> 
> +static int sdhci_s3c_get_ro(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	struct sdhci_s3c *sc = sdhci_priv(host);
> 
Hahaha, no need more words ;-)
Thanks for your kindly explanation.

I think, v4 patch seems to satisfy your suggestion...even though need v5 patch right now.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
