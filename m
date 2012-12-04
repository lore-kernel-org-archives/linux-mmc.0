From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 3/3] MMC: sdhci-dove: allow GPIOs to be used for card detection on Dove
Date: Tue, 04 Dec 2012 13:51:33 -0500
Message-ID: <87sj7lfy6i.fsf@octavius.laptop.org>
References: <E1TbgcZ-0007Kt-35@rmk-PC.arm.linux.org.uk>
	<20121123083117.GA25754@S2100-06.ap.freescale.net>
	<20121123085726.GK5764@n2100.arm.linux.org.uk>
	<20121123121422.GA26168@S2100-06.ap.freescale.net>
	<20121123125507.GO5764@n2100.arm.linux.org.uk>
	<871ufh8lza.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1211260955070.11501@axis700.grange>
	<87y5hfhrwg.fsf@octavius.laptop.org>
	<Pine.LNX.4.64.1212041651500.26918@axis700.grange>
	<87zk1tg5tc.fsf@octavius.laptop.org>
	<20121204164336.GI14363@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33626 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751370Ab2LDSvk (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 4 Dec 2012 13:51:40 -0500
In-Reply-To: <20121204164336.GI14363@n2100.arm.linux.org.uk> (Russell King's
	message of "Tue, 4 Dec 2012 16:43:36 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Shawn Guo <shawn.guo@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Mike Rapoport <mike@compulab.co.il>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org

Hi,

On Tue, Dec 04 2012, Russell King - ARM Linux wrote:
>> Russell, are you happy with switching sdhci-dove over to slot-gpio with
>> this patchset?
>
> I'd rather not until I've moved my cubox kernel tree to v3.7 (when it's
> out.)  Keeping stuff straight between that tree and mainline is far from
> easy - I'm having to maintain two independent patches for each change,
> one against each kernel tree, one gets tested (the one in the cubox tree)
> the other (against mainline) does not.

Okay -- I'll take the patchset as-is for 3.8, with a plan to move to
slot-gpio after you're caught up.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
