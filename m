From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Date: Wed, 16 Oct 2013 23:19:59 +0800
Message-ID: <20131016151954.GA3816@S2101-09.ap.freescale.net>
References: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
 <20131015073631.GA21188@b29396-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:22276 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756853Ab3JPPTE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Oct 2013 11:19:04 -0400
Content-Disposition: inline
In-Reply-To: <20131015073631.GA21188@b29396-Latitude-E6410>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org

On Tue, Oct 15, 2013 at 03:36:32PM +0800, Dong Aisheng wrote:
> On Mon, Oct 14, 2013 at 04:23:39PM +0800, Shawn Guo wrote:
> > When I was reviewing Dong's imx6sl standard tuning patches, I found that
> > it's a little clumsy to use enum imx_esdhc_type for handling features
> > and quirks on different esdhc variants.  
> >
> > Instead, the approach used in
> > fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
> > scalable in the long run.  It defines flags for all those features and
> > quirks and creates a mapping between esdhc variant and the flags.
> > 
> 
> It cause troubles if i try to rebase my patch series based on it
> because esdhc/usdhc also have a lot register difference.
> 
> Originally we could simply use is_imx*_usdhc to handle those tiny difference,

Okay.  After you demonstrate those register differences we will need to
handle, I agree that is_imx*_usdhc() thing might be more handy than
flags for handling those tiny register differences.  So I will respin
the series to create flags only for those features, quirk, errata such
things and leave the register differences to be handled by
is_imx*_usdhc().

Shawn

