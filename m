From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through
 DT
Date: Sat, 15 Feb 2014 14:22:30 +0100
Message-ID: <52FF6A16.5080201@gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net> <3871646.18hjUjnpmg@wuerfel> <20140215122733.GK30257@n2100.arm.linux.org.uk> <1580658.FIe4en5bEU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f175.google.com ([209.85.215.175]:48336 "EHLO
	mail-ea0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753194AbaBONWl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 08:22:41 -0500
In-Reply-To: <1580658.FIe4en5bEU@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, mark.rutland@arm.com, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Tomasz Figa <t.figa@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, robh+dt@kernel.org, Kumar Gala <galak@codeaurora.org>, Olof Johansson <olof@lixom.net>, Fabio Estevam <festevam@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>

On 15.02.2014 14:09, Arnd Bergmann wrote:
> On Saturday 15 February 2014 12:27:33 Russell King - ARM Linux wrote:
>> On Sat, Feb 15, 2014 at 01:18:02PM +0100, Arnd Bergmann wrote:
>>> If a wlan adapter has both SPI and SDIO front-ends, the external
>>> dependencies (reset, clock, voltage, ...) will be the same, and
>>> from the kernel perspective the main difference is that SPI cannot
>>> be probed at all, while SDIO can be probed as long as the device
>>> is powered on already.
>>
>> Remember that MMC/SD/SDIO cards can be driven by either a MMC host
>> interface, or a SPI interface.  Both are probe-able.
>
> I knew about MMC/SD cards being required to understand simple SPI,
> I wasn't sure about SDIO. My understanding however is that you
> have to use the mmc_spi host driver to actually use MMC/SD devices
> as a block device, and that requires having either a DT description
> for the host or an spi_board_info, which I would not consider
> discoverable.
>
> For spi-mode SDIO devices I'm assuming it's similar, except that
> you'd describe the actual SDIO device in the board info rather than
> create a fake SDIO controller. Still not discoverable unless I'm
> missing your point.

I'm not sure if we should assume that SPI = MMC over SPI. I believe 
there might be a custom protocol involved as well.

Stepping aside from SPI, I already gave an example of a WLAN chip that 
supports multiple control busses [1]. In addition to the commonly used 
SDIO, it supports USB and HSIC as well:

[1] http://www.marvell.com/wireless/assets/marvell_avastar_88w8797.pdf

Moreover, some of Samsung boards use HSIC to communicate with modem 
chips, which have exactly the same problem as we're trying to solve here 
- they need to be powered on to be discovered.

So I really don't think we should be limiting this to MMC alone by any 
means.

Now I don't really know why we want that badly to represent low level 
control parts of such devices as children of control buses of their 
enumerable parts. Could you tell me what benefits it has to justify the 
added complexity of having to instantiate fake devices in respective 
devices, even though they can be fully detected later?

Best regards,
Tomasz
