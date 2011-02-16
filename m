From: David Brown <davidb@codeaurora.org>
Subject: Re: [RFC] MMC: error handling improvements
Date: Wed, 16 Feb 2011 11:28:15 -0800
Message-ID: <8ya8vxf4w4w.fsf@huya.qualcomm.com>
References: <20110215230311.GT4152@n2100.arm.linux.org.uk>
	<8yaoc6c7tan.fsf@huya.qualcomm.com>
	<AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:32221 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751556Ab1BPT2P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Feb 2011 14:28:15 -0500
In-Reply-To: <AANLkTikpdwfM19oirENbOhnz8Rh40ZnMXByGX_QKdu-V@mail.gmail.com>
	(Linus Walleij's message of "Wed, 16 Feb 2011 19:41:42 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Feb 16 2011, Linus Walleij wrote:

> 2011/2/16 David Brown <davidb@codeaurora.org>:

>> It's also possible this is finding problems in our SDCC driver.
>
> The SDCC is obviously an MMCI derivate, VHDL hacking
> on top of ARMs source code for PL180/PL181.
>
> Why do you insist on maintaining a forked driver?

Well, it's not me insisting on it.  I'll let the maintainers of the
driver chime in.

The changes we made to the block are significant, but even beyond that
we changed how the block is even accessed.  The driver doesn't directly
access the registers of the controller, but all accesses go through a
custom DMA engine.

> Please consider switching to using mmci.c like everyone else.
> The quirks we have in place for U300, Nomadik and Ux500
> should show you the way for how to do this (yes we did the
> same thing, hacking the ARM VHDL).

I suspect the changes to mmci would be fairly drastic.

> If I remember correctly I could even see that some early
> Android sources were using Russells mmci.c driver before this
> fork was created.

These old drivers are also not usable.  The SDCC block is shared between
the modem processor and the processor running Linux.  If the driver
doesn't go through the DMA engine, which coordinates this, the registers
will be stomped on by the other CPU whenever it decides to access it's
parts of the flash device.

David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
