From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 7/7] ARM: mxs/mx28evk: add mmc device
Date: Wed, 16 Feb 2011 07:11:46 +0800
Message-ID: <20110215231145.GK10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
 <1297650746-12841-8-git-send-email-shawn.guo@freescale.com>
 <20110214102646.GB30100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:32508
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751106Ab1BOPN0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 10:13:26 -0500
Received: from mail80-va3 (localhost.localdomain [127.0.0.1])	by
 mail80-va3-R.bigfish.com (Postfix) with ESMTP id 30DAC1A30371	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 15:13:20 +0000 (UTC)
Received: from VA3EHSMHS016.bigfish.com (unknown [10.7.14.251])	by
 mail80-va3.bigfish.com (Postfix) with ESMTP id F0322E48050	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 15:13:19 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id p1FFCvqM024169	for
 <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 08:12:58 -0700 (MST)
Received: from S2100-06.ap.freescale.net (S2100-06.ap.freescale.net
 [10.192.242.50])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
 p1FFCutG014205	for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 09:12:57
 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <20110214102646.GB30100@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: cjb@laptop.org, s.hauer@pengutronix.de, arnd@arndb.de, LW@KARO-electronics.de, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 14, 2011 at 11:26:46AM +0100, Wolfram Sang wrote:
> Shawn,
> 
> > +/* mmc */
> > +static void __init mx28evk_mmc_slot_poweron(int gpio)
> > +{
> > +	int ret;
> > +
> > +	ret = gpio_request(gpio, "mmc-slot-power");
> > +	if (ret) {
> > +		pr_err("Failed to request gpio mmc-slot-power: %d\n", ret);
> > +		return;
> > +	}
> > +
> > +	ret = gpio_direction_output(gpio, 0);
> > +	if (ret) {
> > +		pr_err("Failed to drive gpio mmc-slot-power: %d\n", ret);
> > +		return;
> > +	}
> > +}
> 
> Minor nit: You could use gpio_request_one(), and doing so maybe even get rid of
> this function and simply do it the init-function. The advantage would be, that
> you can name the two GPIOs independently.
> 
OK. Will take it.

Thanks,
Shawn

