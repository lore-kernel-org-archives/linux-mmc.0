From: Sachin Nikam <Snikam@nvidia.com>
Subject: RE: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 17:11:54 +0530
Message-ID: <723849F6A4B5A3408299DF1FFE37CA776C0B3DE737@BGMAIL02.nvidia.com>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de> <20110701091753.GE1922@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:10509 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755104Ab1GALl6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 07:41:58 -0400
In-Reply-To: <20110701091753.GE1922@pengutronix.de>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Wolfram Sang' <w.sang@pengutronix.de>, Koen Beel <koen.beel.barco@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "shawn.guo@freescale.com" <shawn.guo@freescale.com>

How to increase the number blocks for SD Read operation? Any sysfs entry?

-----Original Message-----
From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Wolfram Sang
Sent: Friday, July 01, 2011 2:48 PM
To: Koen Beel
Cc: linux-mmc@vger.kernel.org; shawn.guo@freescale.com
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting

* PGP Signed by an unknown key

On Thu, Jun 30, 2011 at 04:55:07PM +0200, Wolfram Sang wrote:
> On Thu, Jun 30, 2011 at 12:13:34PM +0200, Koen Beel wrote:
> > Fix clock rate setting on mxs-mmc driver.
> > Previously, if div2 was zero the value for TIMING_CLOCK_RATE would
> > have been 255 instead of 0.
> > Also the limits for div1 (TIMING_CLOCK_DIVIDE) and div2
> > (TIMING_CLOCK_RATE + 1) where not correctly defined.
> > 
> > Can easily be reproduced on mx23evk: default clock for high speed sdio
> > cards is 50 MHz. With a SSP_CLK of 28.8 MHz (default), this resulted in
> > an actual clock rate of about 56 kHz.
> > 
> > Signed-off-by: Koen Beel <koen.beel.barco <at> gmail.com>
> 
> Looks promising, but your tabs are garbled (0xa0 0x20 here?)

Can you repost a patch which applies? I'd like to test it.

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

* Unknown Key
* 0x7D7F551B
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
