From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Sat, 09 Jul 2011 17:04:39 -0400
Message-ID: <m2ei1zkvx4.fsf@bob.laptop.org>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
	<BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:32859 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754591Ab1GIVEq (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 9 Jul 2011 17:04:46 -0400
In-Reply-To: <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com> (Koen Beel's
	message of "Thu, 30 Jun 2011 12:13:34 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Koen Beel <koen.beel.barco@gmail.com>
Cc: linux-mmc@vger.kernel.org, shawn.guo@freescale.com, w.sang@pengutronix.de

Hi Koen,

On Thu, Jun 30 2011, Koen Beel wrote:
> Fix clock rate setting on mxs-mmc driver.
> Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
> have been 255 instead of 0.
> Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
> (TIMING_CLOCK_RATE + 1) where not correctly defined.
>
> Can easily be reproduced on mx23evk: default clock for high speed sdio
> cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this resulted in
> an actual clock rate of about 56 kHz.

(I'm waiting for a v2 patch of this patch incorporating Wolfram's
requested changes before merging it.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
