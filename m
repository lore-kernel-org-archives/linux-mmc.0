From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 3/3] mmc: esdhc i.MX: Support 8bit mode
Date: Tue, 25 Sep 2012 10:05:25 +0200
Message-ID: <20120925080525.GA1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-4-git-send-email-s.hauer@pengutronix.de>
 <20120925071505.GG27291@S2101-09.ap.freescale.net>
 <20120925072714.GY1322@pengutronix.de>
 <20120925073317.GI27291@S2101-09.ap.freescale.net>
 <20120925073808.GZ1322@pengutronix.de>
 <20120925074548.GJ27291@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40099 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548Ab2IYIF2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 04:05:28 -0400
Content-Disposition: inline
In-Reply-To: <20120925074548.GJ27291@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 03:45:50PM +0800, Shawn Guo wrote:
> On Tue, Sep 25, 2012 at 09:38:08AM +0200, Sascha Hauer wrote:
> > So you want to make the code conform to the common spec which has
> > bus-width as a required property. Is this really worth it to add an
> > incompatible change to our devicetrees?
> > 
> I do want to have our implementation conform to common spec.  At the
> current stage devicetrees are not stable anyway, so we should make
> them right as much as possible before they start getting maintained
> separately from kernel tree, where we will be asked to maintain
> devicetree compatibility a lot harder.

Ok, how about this:

- I add a bus-width = <4> property to all i.MX dtsi files
- we merge the patch adding bus-width as an optional property
- Make the bus-width option mandatory in the next step.

This way we can merge the mmc related patches through the mmc tree and
the dts changes through arm-soc.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
