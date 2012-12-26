From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Wed, 26 Dec 2012 10:56:04 +0800
Message-ID: <20121226025601.GF25478@S2101-09.ap.freescale.net>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <m3k3vilety.fsf@pullcord.laptop.org>
 <20120925075309.GL27291@S2101-09.ap.freescale.net>
 <m3fw66legd.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ch1ehsobe006.messaging.microsoft.com ([216.32.181.186]:24046
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753112Ab2LZCz6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Dec 2012 21:55:58 -0500
Content-Disposition: inline
In-Reply-To: <m3fw66legd.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 04:00:18AM -0400, Chris Ball wrote:
> Hi,
> 
> On Tue, Sep 25 2012, Shawn Guo wrote:
> > On Tue, Sep 25, 2012 at 03:52:09AM -0400, Chris Ball wrote:
> >> We could also break the stalemate by just changing the common spec to
> >> have bus-width become optional, default 4.  It's not going to break the
> >> code of anyone who's been treating it as required.  I don't think there
> >> there was a principled reason behind making it required.
> >> 
> > That would be the best :)
> 
> Ah, but sdhci-s3c and dw_mmc have been assuming that bus-width defaults
> 1 when it's not supplied.  That's going to make it complicated.
> 
Okay, we will do the same for esdhc driver, and also submit a change to
the common binding to make it clear.

Shawn

