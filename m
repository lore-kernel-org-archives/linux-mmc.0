From: Richard Ash <richardashaudacity@googlemail.com>
Subject: Re: error -110 sending stop command
Date: Fri, 3 Jun 2016 15:20:22 +0100
Message-ID: <CACOFwa=Hhjkp9BeHrmZp9oU4zVJz+cJQkzLsLy9a7+gynUdo-Q@mail.gmail.com>
References: <20160524093747.12bfe046@vostro.util.wtbts.net>
 <20160524173727.63441f1c@vostro> <1464160925.3204.17.camel@openproducts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:35768 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbcFCOUY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Jun 2016 10:20:24 -0400
Received: by mail-oi0-f54.google.com with SMTP id w184so128774108oiw.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Jun 2016 07:20:24 -0700 (PDT)
In-Reply-To: <1464160925.3204.17.camel@openproducts.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tor Krill <tor@openproducts.com>
Cc: Timo Teras <timo.teras@iki.fi>, Linux MMC / SD subsystem <linux-mmc@vger.kernel.org>

On 25 May 2016 at 08:22, Tor Krill <tor@openproducts.com> wrote:
> Hi Timo and others,
>
> Sorry for the late reply.
>
> On tis, 2016-05-24 at 17:37 +0300, Timo Teras wrote:
>> On Tue, 24 May 2016 09:37:46 +0300
>> Timo Teras <timo.teras@iki.fi> wrote:
>>
>> > I'm having the following errors on my SD-card when writing to them:
>> >
>> > mmc0: Timeout waiting for hardware interrupt.
>> > mmcblk0: error -110 sending stop command, original cmd response
>> > 0x900,
>> > card status 0x400e00
>> > [...]
>> >
>> > Any suggestions how to debug this further? Perhaps some quirks to
>> > test? Or already committed patches/fixes that might resolve this
>> > issue?
>
> As a comment on your first email. We still have problems with our board
> and the eMMC on it. (A solid run clearfog and the  MicroSoM A388)
>
> With any recent kernel we experience write operations that fail and
> then the no response on the status poll. After this any communication
> with the chip seems fruitless.
>
> Since we could not rule out that this could be an issue with the
> specific eMMC we are currently investigating if we can reproduce the
> problems with an SD-card instead and have to wait for tests on new SOMs
> without the eMMC. (These arrived yesterday and we should hopefully be
> able to test these shortly)
>
>> If I force PIO mode (sdhci.debug_quirks=0x60), I get:
>> [  111.201763] mmc0: Timeout waiting for hardware interrupt.
>> [  111.201887] mmc0: Got data interrupt 0x00000020 even though no
>> data operation was in progress.
>> [  111.202032] mmcblk0: error -110 sending stop command, original cmd
>> response 0x900, card status 0x400e00

Quick update to say that after banging my head against this for a
while I managed to RMA the microSD cards I was using and a ZedBoard
(Zynq eval board) back to my supplier (UK) and then on to the flash
vendor (Taiwan), who reproduced the problem and declared it to be a
bug in the firmware on the microSD card, which is fixed by more recent
firmware releases. I have since tested a number of cards with the more
recent firmware without problems. I also found that the AMD SD host
controller in my laptop (uses SDHCI-PCI driver) had the same problem,
same error message.

My microSD cards were from Phison (Toshiba flash chips, but Phison do
the firmware), the ones with 'FW 82.99' on the back caused the
problem, ones marked 'FW 82.101' are trouble free.

Richard
