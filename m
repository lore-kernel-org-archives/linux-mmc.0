From: "Nath, Arindam" <Arindam.Nath@amd.com>
Subject: RE: [PATCH v2 05/12] mmc: sdhci: reset sdclk before setting high
 speed enable
Date: Fri, 4 Mar 2011 23:07:11 -0600
Message-ID: <6C03668EAF45B747AF947A1603D1B300E38E72FD@SAUSEXMBP01.amd.com>
References: <1299238369-1768-1-git-send-email-arindam.nath@amd.com>
 <1299238369-1768-6-git-send-email-arindam.nath@amd.com>
 <4CC9533A-376B-4E2F-B108-E789C9D3B10A@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:11033 "EHLO
	TX2EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab1CEFHS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Mar 2011 00:07:18 -0500
In-Reply-To: <4CC9533A-376B-4E2F-B108-E789C9D3B10A@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "zhangfei.gao@gmail.com" <zhangfei.gao@gmail.com>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Su, Henry" <Henry.Su@amd.com>, "Lu, Aaron" <Aaron.Lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

Hi Philip,


> -----Original Message-----
> From: Philip Rakity [mailto:prakity@marvell.com]
> Sent: Saturday, March 05, 2011 10:27 AM
> To: Nath, Arindam
> Cc: cjb@laptop.org; zhangfei.gao@gmail.com; subhashj@codeaurora.org;
> linux-mmc@vger.kernel.org; Su, Henry; Lu, Aaron; anath.amd@gmail.com
> Subject: Re: [PATCH v2 05/12] mmc: sdhci: reset sdclk before setting
> high speed enable
> 
> 
> On Mar 4, 2011, at 3:32 AM, Arindam Nath wrote:
> 
> > As per Host Controller spec v3.00, we reset SDCLK before setting
> > High Speed Enable, and then set it back to avoid generating clock
> > gliches.
> >
> > Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> > ---
> > drivers/mmc/host/sdhci.c |   25 ++++++++++++++++++++++---
> > 1 files changed, 22 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 1645687..5d3bb11 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -1277,13 +1277,12 @@ static void sdhci_set_ios(struct mmc_host
> *mmc, struct mmc_ios *ios)
> > 	else
> > 		ctrl &= ~SDHCI_CTRL_HISPD;
> >
> > -	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > -
> > 	if (host->version >= SDHCI_SPEC_300) {
> > 		u16 ctrl_2;
> >
> > 		ctrl_2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
> > 		if (!(ctrl_2 & SDHCI_CTRL_PRESET_VAL_ENABLE)) {
> > +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > 			/*
> > 			 * We only need to set Driver Strength if the
> > 			 * preset value enable is not set.
> > @@ -1294,8 +1293,28 @@ static void sdhci_set_ios(struct mmc_host
> *mmc, struct mmc_ios *ios)
> > 				ctrl_2 |= SDHCI_CTRL_DRV_TYPE_C;
> >
> > 			sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
> > +		} else {
> > +			/*
> > +			 * According to SDHC Spec v3.00, if the Preset Value
> > +			 * Enable in the Host Control 2 register is set, we
> > +			 * need to reset SD Clock Enable before changing High
> > +			 * Speed Enable to avoid generating clock gliches.
> > +			 */
> > +			u16 clk;
> > +
> > +			/* Reset SD Clock Enable */
> > +			clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
> > +			clk &= ~SDHCI_CLOCK_CARD_EN;
> > +			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> > +
> > +			/* Re-enable SD Clock */
> > +			clk |= SDHCI_CLOCK_CARD_EN;
> > +			sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> 
> Need to ensure clock is stable before using it ---- use sdhci_set_clock

Thanks for the suggestion. I will add the modification in next version.

Regards,
Arindam

> 
> > 		}
> 
> 
> 
> > -	}
> > +	} else
> > +		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL1);
> >
> > 	/*
> > 	 * Some (ENE) controllers go apeshit on some ios operation,
> > --
> > 1.7.1
> >
> 


