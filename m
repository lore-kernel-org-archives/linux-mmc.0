From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Mon, 14 Oct 2013 21:27:59 +0800
Message-ID: <20131014132757.GF27668@S2101-09.ap.freescale.net>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
 <1381739024-24924-6-git-send-email-shawn.guo@linaro.org>
 <1381739511.4093.124.camel@weser.hi.pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:18127
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755955Ab3JNN1N (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Oct 2013 09:27:13 -0400
Content-Disposition: inline
In-Reply-To: <1381739511.4093.124.camel@weser.hi.pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Dong Aisheng <b29396@freescale.com>, linux-arm-kernel@lists.infradead.org

On Mon, Oct 14, 2013 at 10:31:51AM +0200, Lucas Stach wrote:
> > +#define IMX25_ESDHC	(ESDHC_FLAG_NO_DMAS_BITS | ESDHC_FLAG_ENGCM07207)
> > +#define IMX35_ESDHC	(ESDHC_FLAG_ENGCM07207)
> > +#define IMX51_ESDHC	(0)
> > +#define IMX53_ESDHC	(ESDHC_FLAG_MULTIBLK_NO_INT)
> > +#define IMX6Q_USDHC	(ESDHC_FLAG_USDHC)
> >  
> This looks really nasty to me, especially with the needed void pointer
> cast you added in the previous patch.

Yes, it does, when you look at from of_device_id.data.  But keep it in
mind, that platform_device_id.driver data is type kernel_ulong_t not
void *.  So while we add a structure with the flags field in it to save
the cast on of_device_id.data, we will have to add a cast for
platform_device_id.driver.

> Can you please introduce a proper driver data struct, with the flags
> field in it? This will make this thing a lot cleaner, more future proof
> and shouldn't add any overhead in the generated code.

But I agree with you that using a data structure is more future proof,
so will do in v2.

Shawn

