From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 1/3] mmc: sdhci: rename platform_8bit_width to
 platform_bus_width
Date: Tue, 25 Sep 2012 08:15:04 +0200
Message-ID: <20120925061504.GV1322@pengutronix.de>
References: <1348471345-30785-1-git-send-email-s.hauer@pengutronix.de>
 <1348471345-30785-2-git-send-email-s.hauer@pengutronix.de>
 <50611862.7010201@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59866 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743Ab2IYGPJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 02:15:09 -0400
Content-Disposition: inline
In-Reply-To: <50611862.7010201@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Eric =?iso-8859-15?Q?B=E9nard?= <eric@eukrea.com>, kernel@pengutronix.de

On Tue, Sep 25, 2012 at 11:35:14AM +0900, Jaehoon Chung wrote:
> On 09/24/2012 04:22 PM, Sascha Hauer wrote:
> >  	/*
> >  	 * If your platform has 8-bit width support but is not a v3 controller,
> >  	 * or if it requires special setup code, you should implement that in
> > -	 * platform_8bit_width().
> > +	 * platform_bus_width().
> >  	 */
> > -	if (host->ops->platform_8bit_width)
> > -		host->ops->platform_8bit_width(host, ios->bus_width);
> > -	else {
> > +	if (host->ops->platform_bus_width) {
> > +		host->ops->platform_bus_width(host, ios->bus_width);
> > +	} else {
> Why add the brackets?

Took the chance to cleanup the codingstyle when changing these lines
anyway.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
