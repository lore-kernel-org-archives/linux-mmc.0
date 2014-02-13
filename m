From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Thu, 13 Feb 2014 13:48:55 +0100
Message-ID: <2874395.Ul86gYA57i@wuerfel>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <201401281148.10670.arnd@arndb.de> <20140213104248.GU26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54160 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760AbaBMMtI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2014 07:49:08 -0500
In-Reply-To: <20140213104248.GU26684@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On Thursday 13 February 2014 10:42:48 Russell King - ARM Linux wrote:
> 
> What if we have a platform where things subtly change, like for instance,
> the wiring on the SD slot to fix a problem with UHS-1 cards, which means
> you don't have UHS-1 support for some platforms but do for others.
> 
> What if you have a platform which uses a brcm4329 chip for Wifi, but then
> later in the production run switch to using a different Wifi chipset?

As far as I can tell, the power sequencing is normally really
dependent on the device. If someone has an on-board brcm4329
that requires a specific set of clocks, resets, voltages etc
to be routed to the chip and enabled in the correct order to
allow probing, it seems unlikely that changing the wifi chipset
to something else would keep the exact same requirements.

> With this information encoded into DT, the number of DT files quickly
> increases, and then this presents its own problem - how do users get to
> know which DT file should be used for their platform when all they see
> externally is "a product of type A"?

I haven't seen a suggestion that would not encode this in DT. The
difference between Olof's original suggestion and mine is that he
proposed to put the data into the existing node of the host controller,
while my approach would be to add a node for each function with
these requirements and modify the sdio code so that we can deal
with it in the function driver. The data that would get passed
however is almost the same.

	Arnd
