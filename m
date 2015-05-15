From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] Revert "sdhci-of-esdhc: Support 8BIT bus width."
Date: Fri, 15 May 2015 08:20:52 +0000
Message-ID: <1431678052.13197.26.camel@transmode.se>
References: <1431671349-12759-1-git-send-email-haokexin@gmail.com>
	 <1431673364.13197.10.camel@transmode.se>
	 <1431674695.13197.14.camel@transmode.se>
	 <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.transmode.se ([31.15.61.139]:51829 "EHLO smtp.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934716AbbEOIU4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2015 04:20:56 -0400
In-Reply-To: <20150515074254.GP8870@pek-khao-d1.corp.ad.wrs.com>
Content-Language: en-US
Content-ID: <9E813007FAE6C74E8372E480B0909068@transmode.com>
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

What about this then:

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 7a98a22..569fce1 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -262,6 +262,24 @@ static void esdhc_of_platform_init(struct sdhci_host *host)
                host->quirks &= ~SDHCI_QUIRK_NO_BUSY_IRQ;
 }
 
+static void esdhc_pltfm_set_bus_width(struct sdhci_host *host, int width)
+{
+       u8 ctrl;
+
+       ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+       if (width == MMC_BUS_WIDTH_8) {
+               ctrl &= ~SDHCI_CTRL_4BITBUS;
+               ctrl |= SDHCI_CTRL_8BITBUS;
+       } else {
+               ctrl &= ~SDHCI_CTRL_8BITBUS;
+               if (width == MMC_BUS_WIDTH_4)
+                       ctrl |= SDHCI_CTRL_4BITBUS;
+               else
+                       ctrl &= ~SDHCI_CTRL_4BITBUS;
+       }
+       sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
 static void esdhc_reset(struct sdhci_host *host, u8 mask)
 {
        sdhci_reset(host, mask);
@@ -283,6 +301,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
        .get_min_clock = esdhc_of_get_min_clock,
        .platform_init = esdhc_of_platform_init,
        .adma_workaround = esdhci_of_adma_workaround,
+       .set_bus_width = esdhc_pltfm_set_bus_width,
        .reset = esdhc_reset,
        .set_uhs_signaling = sdhci_set_uhs_signaling,
 };
