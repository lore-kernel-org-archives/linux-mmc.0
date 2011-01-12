From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH v5] mmc: davinci: add support for SDIO irq handling
Date: Wed, 12 Jan 2011 19:33:02 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930248349F12@dbde02.ent.ti.com>
References: <1294038807-16450-1-git-send-email-nsekhar@ti.com>
 <20110110001738.GB26898@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55487 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648Ab1ALOD1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 09:03:27 -0500
In-Reply-To: <20110110001738.GB26898@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Alagu Sankar <alagusankar@embwise.com>

Hi Chris,

On Mon, Jan 10, 2011 at 05:47:38, Chris Ball wrote:
> Hi Sekhar,
> 
> On Mon, Jan 03, 2011 at 12:43:27PM +0530, Sekhar Nori wrote:
> > From: Alagu Sankar <alagusankar@embwise.com>
> > 
> > This patch adds support for handling SDIO interrupt on
> > DaVinci MMC/SD controller.
> > 
> > The patch has been tested on DM355 and DA850 EVMs with
> > Marvell Libertas based SDIO wireless LAN card.
> > 
> > Signed-off-by: Alagu Sankar <alagusankar@embwise.com>
> > Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> > ---
> > Applies to mmc-next branch of the mmc tree
> > 
> > Since v4, fixed a typo in patch description
> > 
> >  drivers/mmc/host/davinci_mmc.c |   78 +++++++++++++++++++++++++++++++++++++---
> >  1 files changed, 73 insertions(+), 5 deletions(-)
> 
> Thanks, pushed to mmc-next for .38 with some trivial indentation fixes
> as below:

Thanks for pushing this for .38 and for making the
fixes. Will take care of this next time.

Thanks,
Sekhar

> 
> diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> index 6b09752..0076c74 100644
> --- a/drivers/mmc/host/davinci_mmc.c
> +++ b/drivers/mmc/host/davinci_mmc.c
> @@ -882,7 +882,7 @@ mmc_davinci_xfer_done(struct mmc_davinci_host *host, struct mmc_data *data)
>  		 * 2.1.6): Signal SDIO interrupt only if it is enabled by core
>  		 */
>  		if (host->sdio_int && !(readl(host->base + DAVINCI_SDIOST0) &
> -							SDIOST0_DAT1_HI)) {
> +					SDIOST0_DAT1_HI)) {
>  			writel(SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
>  			mmc_signal_sdio_irq(host->mmc);
>  		}
> @@ -962,7 +962,7 @@ static irqreturn_t mmc_davinci_sdio_irq(int irq, void *dev_id)
>  	status = readl(host->base + DAVINCI_SDIOIST);
>  	if (status & SDIOIST_IOINT) {
>  		dev_dbg(mmc_dev(host->mmc),
> -				"SDIO interrupt status %x\n", status);
> +			"SDIO interrupt status %x\n", status);
>  		writel(status | SDIOIST_IOINT, host->base + DAVINCI_SDIOIST);
>  		mmc_signal_sdio_irq(host->mmc);
>  	}
> @@ -1124,12 +1124,12 @@ static void mmc_davinci_enable_sdio_irq(struct mmc_host *mmc, int enable)
>  		} else {
>  			host->sdio_int = true;
>  			writel(readl(host->base + DAVINCI_SDIOIEN) |
> -				SDIOIEN_IOINTEN, host->base + DAVINCI_SDIOIEN);
> +			       SDIOIEN_IOINTEN, host->base + DAVINCI_SDIOIEN);
>  		}
>  	} else {
>  		host->sdio_int = false;
>  		writel(readl(host->base + DAVINCI_SDIOIEN) & ~SDIOIEN_IOINTEN,
> -				host->base + DAVINCI_SDIOIEN);
> +		       host->base + DAVINCI_SDIOIEN);
>  	}
>  }
>  
> @@ -1331,7 +1331,7 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
>  
>  	if (host->sdio_irq >= 0) {
>  		ret = request_irq(host->sdio_irq, mmc_davinci_sdio_irq, 0,
> -				mmc_hostname(mmc), host);
> +				  mmc_hostname(mmc), host);
>  		if (!ret)
>  			mmc->caps |= MMC_CAP_SDIO_IRQ;
>  	}
> -- 
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> 

