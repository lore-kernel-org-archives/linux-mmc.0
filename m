From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH V3 3/3 ] mmc: add support for H/W clock gating of SD
 controller (resend)
Date: Wed, 08 Dec 2010 12:02:13 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1012081158490.10437@xanadu.home>
References: <5017B261-76AC-428D-BAC2-8E1BBEB09A49@marvell.com>
 <20101208001618.GA3338@void.printf.net>
 <4024F858-A92E-4DCC-8615-528BF48939D2@marvell.com>
 <AANLkTimqaiHg6xYOquftumB=ciK+YpVkbfP877HimyHP@mail.gmail.com>
 <A48DB098-1757-456E-A506-6E935144D645@marvell.com>
 <AANLkTinAR=shkVRuku+E1spF64J0hLVkwWX+EUp78AMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:43603 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0LHRCO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 12:02:14 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz24.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LD400JG7CNAON00@vl-mo-mrz24.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Wed, 08 Dec 2010 12:01:59 -0500 (EST)
In-reply-to: <AANLkTinAR=shkVRuku+E1spF64J0hLVkwWX+EUp78AMw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Zhangfei Gao <zgao6@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

On Wed, 8 Dec 2010, zhangfei gao wrote:

> On Tue, Dec 7, 2010 at 9:50 PM, Philip Rakity <prakity@marvell.com> wrote:
> >
> > On Dec 7, 2010, at 5:49 PM, zhangfei gao wrote:
> >> 2. we have to fully verify the hardware clk gating internally before
> >> sending the code.
> >
> > code tested under marvell 2.6.32 linux.
> 
> Thanks a lot, just wander could sdio be supported, since marvell8787
> requires around 10 clock cycles after cmd53 finished.

SDIO is currently left out as this is not clear if all SDIO cards still 
can send interrupts if their clock is disabled, or even function 
properly.  This might have to be a property that the SDIO function 
drivers could provide to the core.


Nicolas
