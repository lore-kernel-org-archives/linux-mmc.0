From: Tomasz Figa <tomasz.figa@gmail.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Wed, 28 May 2014 13:47:50 +0200
Message-ID: <5385CCE6.9070204@gmail.com>
References: <537E31F7.1030505@gmail.com>	<537F1148.3010102@redhat.com>	<20140523112239.GB12304@sirena.org.uk>	<537F3610.3050104@redhat.com>	<20140523162718.GE22111@sirena.org.uk>	<53806F26.6050706@redhat.com>	<20140525123452.GS22111@sirena.org.uk>	<53824294.1090609@redhat.com>	<20140526103807.GV22111@sirena.org.uk>	<538321AB.4050006@redhat.com>	<20140526142225.GF22111@sirena.org.uk>	<538356DA.7090302@redhat.com>	<CAPDyKFqgvaPhMH3PFh7+6u+Am6pWYhxBFdvUZFfekUfpFJxdKw@mail.gmail.com>	<53838023.2080807@redhat.com> <CAPDyKFpg_2RQabM044C1hsNTcuxdVVOvw0ZONVRdysk=eom8UA@mail.gmail.com> <5385AF94.90004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39566 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbaE1Lr6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 07:47:58 -0400
In-Reply-To: <5385AF94.90004@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>, Linus Walleij <linus.walleij@linaro.org>

I'm following this discussion continuously, but (un)fortunately I'm on
vacation right now and don't have much time to work on this, so sorry
for a very selective reply.

On 28.05.2014 11:42, Hans de Goede wrote:
> Hi,
> 
> On 05/27/2014 03:50 PM, Ulf Hansson wrote:
>> [snip]
>>
>> Powerup driver's ->probe():
>> Typically the "powerup driver" will need to register a few callback
>> functions towards the mmc core. Typically at mmc_of_parse(), those
>> callbacks will have to be connected to a particular mmc host.
>>
>> I would like to see three different callbacks, mirroring each of the
>> mmc_ios power_mode states MMC_POWER_OFF|UP|ON.
> 
> Hmm, can't we do something with runtime pm here instead? I would be
> nice if we could use the platform bus for this instead of inventing
> a new bus for this. Both from not needing to add extra count pov, but
> also from the pov of having a solution which other subsystems can
> later easily copy. I can even envision the parts of mmc_of_parse
> dealing with this being a separate function taking a child node as
> argument from day one, which can then hopefully later be moved out
> of the mmc subsys and be used elsewhere too (*).

This is actually a real use case, because we already have HSIC (USB with
heavily stripped down physical layer) modems on certain Samsung boards
and similarly to the kind of SDIO devices being discussed here they
can't be discovered until a certain power up sequence is done.
Analogically, the modem chip uses OOB interrupts and certain GPIO lines
for various purposes and they need to be provided by DT.

Moreover, there are already WLAN chips available that can use HSIC as
their host interface and I'm not talking here about some exotic
products, but rather widely recognized products of Broadcom (BCM4335),
Marvell (88W8797) or Qualcomm Atheros (AR6004).

My conclusion is that I see the discussion here being too much focused
on MMC, especially considering the fact that the whole problem doesn't
have anything to do with MMC, which is just used as (one of possible)
host interface.

IMHO, all we need here is a way to tell the MMC (or HSIC) core when to
look for a new device and when not (e.g. power down the host controller
completely). Anything else, including proper power sequencing is up to
the platform driver of such non-discoverable device - it's only its host
interface that is discoverable when enabled. I believe this simplistic
approach would lead to much less new code added, better reusability of
code (power sequencing independent of host interface) and no need to
create overly generic code, which usually turns out to be not generic
enough.

Best regards,
Tomasz
