From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH V3 3/3 ] mmc: add support for H/W clock gating of SD controller
 (resend)
Date: Mon, 13 Dec 2010 14:50:12 +0000
Message-ID: <4D0632A4.4050905@csr.com>
References: <5017B261-76AC-428D-BAC2-8E1BBEB09A49@marvell.com> <20101208001618.GA3338@void.printf.net> <4024F858-A92E-4DCC-8615-528BF48939D2@marvell.com> <AANLkTimqaiHg6xYOquftumB=ciK+YpVkbfP877HimyHP@mail.gmail.com> <A48DB098-1757-456E-A506-6E935144D645@marvell.com> <AANLkTinAR=shkVRuku+E1spF64J0hLVkwWX+EUp78AMw@mail.gmail.com> <alpine.LFD.2.00.1012081158490.10437@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:37101 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757747Ab0LMOvO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Dec 2010 09:51:14 -0500
Received: from rly13g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly13g.srv.mailcontrol.com (MailControl) with ESMTP id oBDEovUm027947
	for <linux-mmc@vger.kernel.org>; Mon, 13 Dec 2010 14:51:08 GMT
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly13g.srv.mailcontrol.com (MailControl) id oBDEoFur020332
	for <linux-mmc@vger.kernel.org>; Mon, 13 Dec 2010 14:50:15 GMT
In-Reply-To: <alpine.LFD.2.00.1012081158490.10437@xanadu.home>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, Philip Rakity <prakity@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Zhangfei Gao <zgao6@marvell.com>, Haojian Zhuang <haojian.zhuang@gmail.com>

Nicolas Pitre wrote:
> On Wed, 8 Dec 2010, zhangfei gao wrote:
> 
>> On Tue, Dec 7, 2010 at 9:50 PM, Philip Rakity <prakity@marvell.com> wrote:
>>> On Dec 7, 2010, at 5:49 PM, zhangfei gao wrote:
>>>> 2. we have to fully verify the hardware clk gating internally before
>>>> sending the code.
>>> code tested under marvell 2.6.32 linux.
>> Thanks a lot, just wander could sdio be supported, since marvell8787
>> requires around 10 clock cycles after cmd53 finished.

The specification requires only 8 clocks after end bit of a CMD53 data
block.  (SD physical spec 3.01 section 4.4, clock control).  It is
possible that the controller sends more than the minimum.

> SDIO is currently left out as this is not clear if all SDIO cards still 
> can send interrupts if their clock is disabled, or even function 
> properly.  This might have to be a property that the SDIO function 
> drivers could provide to the core.

It's a minefield.

Cards in 1-bit mode may interrupt at any time whether there is a clock
or not.

Cards compliant to SDIO v2.00 should require the clock to generate
interrupts when in 4-bit mode as this is what's specified in the
specification.  As a vendor-specific extension, some v2.00 cards (e.g.,
all CSR devices) do not require the clock.

Cards compliant to SDIO v3.00 may optionally have the clock turned off
if the card indicates support for asynchronous interrupts and support
has been enabled (via CCCR register bits).

Some host controllers will not detect interrupts if the clock is off and
4-bit mode is enabled.

I would suggest:

* Cards have a property: auto-clock-disable which indicates if the the
clock can be switched off automatically by mmc core or if hardware clock
gating may be used.

a. Memory cards would set this to true.
b. SDIO v2.00 cards would set this to false.
c. SDIO v3.00 cards would set this to true if asynchronous interrupts
are supported and enabled, otherwise false.
d. combo cards set this based on the SDIO function.

* If necessary, host controllers switch to 1-bit mode if the clock is
turned off and switch back to 4-bit mode when the clock is turned back
on (e.g., some sdhci controllers require this).

* SDIO function drivers can set auto-clock-disable to true if they're
for a v2.00 card that supports asynchronous interrupts.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
