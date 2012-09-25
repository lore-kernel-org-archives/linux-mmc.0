From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 11:45:25 +0200
Message-ID: <20120925094525.GC1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <20120925074548.GJ27291@S2101-09.ap.freescale.net>
 <20120925080525.GA1322@pengutronix.de>
 <20120925085040.GA14216@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55898 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753230Ab2IYJpc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 05:45:32 -0400
Content-Disposition: inline
In-Reply-To: <20120925085040.GA14216@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 04:50:52PM +0800, Shawn Guo wrote:
> On Tue, Sep 25, 2012 at 10:05:25AM +0200, Sascha Hauer wrote:
> > Ok, how about this:
> > 
> > - I add a bus-width = <4> property to all i.MX dtsi files
> > - we merge the patch adding bus-width as an optional property
> > - Make the bus-width option mandatory in the next step.
> > 
> > This way we can merge the mmc related patches through the mmc tree and
> > the dts changes through arm-soc.
> > 
> Sounds good to me.  How the last step should be done will depend
> on the common spec.  Per Chris, there are already two drivers
> implementing the property as optional.  Not sure if Chris will change
> spec to have the property defined as optional (probably default to 1?).

It won't hurt if we add the property now for all i.MX. Then Chris is
free to do whatever he wants (at least from the i.MX perspective)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
