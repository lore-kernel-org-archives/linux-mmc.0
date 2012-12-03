From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card detection on Dove
Date: Mon, 03 Dec 2012 14:11:59 -0500
Message-ID: <87y5hfhrwg.fsf@octavius.laptop.org>
References: <20121122235426.GT3332@n2100.arm.linux.org.uk>
	<E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
	<20121123083117.GA25754@S2100-06.ap.freescale.net>
	<20121123085726.GK5764@n2100.arm.linux.org.uk>
	<20121123121422.GA26168@S2100-06.ap.freescale.net>
	<20121123125507.GO5764@n2100.arm.linux.org.uk>
	<871ufh8lza.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1211260955070.11501@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59562 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244Ab2LCTMF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 3 Dec 2012 14:12:05 -0500
In-Reply-To: <Pine.LNX.4.64.1211260955070.11501@axis700.grange> (Guennadi
	Liakhovetski's message of "Mon, 26 Nov 2012 10:43:10 +0100 (CET)")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi Guennadi,

On Mon, Nov 26 2012, Guennadi Liakhovetski wrote:
>> Guennadi, what are your thoughts about consolidating this reset logic
>> between the sdhci tasklet and slot-gpio?  It would certainly be nice to
>> use slot-gpio in cases like this one, so it's worth fixing.
>
> Sure, this can be added. As for how - I see at least two possibilities: 
> (1) put the complete above block in a new mmc host operation and just call 
> it from the GPIO card-detect ISR, (2) taking into account, that many 
> (nearly all? all?) host drivers keep a pointer to the current mrq in their 
> private data struct, we could instead add such a pointer to struct 
> mmc_host, then the check "request in progress" could also be generalised, 
> and the operation would just have to reset the host and complete the 
> request (in the sdhci case schedule the task).

They both sound pretty attractive.  Maybe we start out with (1), which
would create a patch we could more reasonably send to stable@ to get
slot-gpio handling the reset during transfers properly in older kernels,
and then refactor into (2) later?

> Note, that there's already a .hw_reset() operation, used by sdhci-pci
> only so far, still, it seems we cannot (easily) hijack it.

That one's implementing an eMMC 4.5 spec feature, not related to this
kind of reset.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
