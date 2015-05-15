From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 12:40:35 +0000
Message-ID: <1431693634.13197.29.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
	 <1431674695.13197.14.camel@transmode.se>
	 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:50335 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422756AbbEOMkj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 08:40:39 -0400
In-Reply-To: <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <F1E30C94585AD2469C34D0D8749C7D78@transmode.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "haokexin@gmail.com" <haokexin@gmail.com>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, 2015-05-15 at 15:42 +0800, Kevin Hao wrote:
> On Fri, May 15, 2015 at 07:24:55AM +0000, Joakim Tjernlund wrote:
> > Ahh, now I see. Drivers are supposed to call sdhci_set_bus_width instead of NULL:
> > Instead of reverting this add:
> > 
> >  diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> > index 7a98a22..07b9df2 100644
> > --- a/drivers/mmc/host/sdhci-of-esdhc.c
> > +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> > @@ -283,6 +283,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
> >         .get_min_clock = esdhc_of_get_min_clock,
> >         .platform_init = esdhc_of_platform_init,
> >         .adma_workaround = esdhci_of_adma_workaround,
> > +       .set_bus_width = sdhci_set_bus_width,
> >         .reset = esdhc_reset,
> >         .set_uhs_signaling = sdhci_set_uhs_signaling,
> >  };
> > 
> > Should I repost the full "sdhci-of-esdhc: Support 8BIT bus width." with this fix added
> > of just the above fix?
> 
> Sorry, this still don't work.

How about this one:

>From af6b18c056b6064424bd2ab1f9989bbadae5e701 Mon Sep 17 00:00:00 2001
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Mon, 20 Apr 2015 22:36:55 +0200
Subject: [PATCHv3] sdhci-of-esdhc: Support 8BIT bus width.

esdhc_readb()/esdhc_writeb() did not adjust for 8BIT.

Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
---
 v3 - v2 had a few misunderstandings in it w.r.t bus_with handling.
      sdhci-of-esdhc.c appears to be a bit of a mess w.r.t to this so
      here is v3 which only touchs esdhc_readb()/esdhc_writeb() so
      8BIT is preserverd.

 v2 - I had fogotten to add bus-width = <8> to my DTS.
      Adding this simplified things
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 1804bdb..233e38d 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -82,6 +82,10 @@ static u8 esdhc_readb(struct sdhci_host *host, int reg)
                /* fixup the result */
                ret &= ~SDHCI_CTRL_DMA_MASK;
                ret |= dma_bits;
+
+               /* 8BIT is bit 29 in Control register */
+               ret |= ((ret << 3) & SDHCI_CTRL_8BITBUS);
+               ret &= ~(SDHCI_CTRL_8BITBUS >> 3);
        }
 
        return ret;
@@ -134,6 +138,10 @@ static void esdhc_writeb(struct sdhci_host *host, u8 val, int reg)
                        dma_bits);
                val &= ~SDHCI_CTRL_DMA_MASK;
                val |= in_be32(host->ioaddr + reg) & SDHCI_CTRL_DMA_MASK;
+
+               /* 8BIT is bit 29 in Control register */
+               val |= ((val & SDHCI_CTRL_8BITBUS) >> 3);
+               val = (val & ~SDHCI_CTRL_8BITBUS);
        }
 
        /* Prevent SDHCI core from writing reserved bits (e.g. HISPD). */
-- 
2.3.6
