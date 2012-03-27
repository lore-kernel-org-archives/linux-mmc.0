From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sh_mmcif: mmc->f_max should be half of the bus clock
Date: Tue, 27 Mar 2012 11:46:49 +0900
Message-ID: <CANqRtoTtXSess2UQAj1K80xmSuubrK5gw+YkWnBiyNyiY5mQfQ@mail.gmail.com>
References: <1332320549-28584-1-git-send-email-horms@verge.net.au>
	<1332320549-28584-3-git-send-email-horms@verge.net.au>
	<Pine.LNX.4.64.1203241904150.19427@axis700.grange>
	<20120325223033.GA6860@verge.net.au>
	<4F70027A.9020203@renesas.com>
	<20120326055256.GE2347@verge.net.au>
	<CANqRtoSrg5Niezq5tLA+a3j9PUoTGoBUBtEBazjEKbCFXHhX1g@mail.gmail.com>
	<20120327014343.GA28782@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:42601 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab2C0Cqu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Mar 2012 22:46:50 -0400
Received: by vbbff1 with SMTP id ff1so3065895vbb.19
        for <linux-mmc@vger.kernel.org>; Mon, 26 Mar 2012 19:46:49 -0700 (PDT)
In-Reply-To: <20120327014343.GA28782@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Cao Minh Hiep <hiepcm@gmail.com>

On Tue, Mar 27, 2012 at 10:43 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Mar 26, 2012 at 03:17:21PM +0900, Magnus Damm wrote:
>> On Mon, Mar 26, 2012 at 2:52 PM, Simon Horman <horms@verge.net.au> wrote:
>> > On Mon, Mar 26, 2012 at 02:45:30PM +0900, Yusuke Goda wrote:
>> >> Hi Simon-san, Guennadi-san
>> >>
>> >> (2012/03/26 7:30), Simon Horman wrote:
>> >> > On Sat, Mar 24, 2012 at 07:06:31PM +0100, Guennadi Liakhovetski wrote:
>> >> >> On Wed, 21 Mar 2012, Simon Horman wrote:
>> >> >>
>> >> >>> mmc->f_max should be half of the bus clock.
>> >> >>> And now that mmc->f_max is not equal to the bus clock the
>> >> >>> latter should be used directly to calculate mmc->f_min.
>> >> >>
>> >> >> The patch seems correct as it stands, however, looking at it - does anyone
>> >> >> understands why that "close to 400kHz" comment and such a complicated
>> >> >> calculation? Shouldn't it be just host->clk / 512 always? Maybe this
>> >> >> should be a separate patch, so, for this one
>> >> >>
>> >> >> Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> >> >
>> >> > Hi Guennadi,
>> >> >
>> >> > that code seems to date back to the original driver submission
>> >> > made by Goda-san. I have CCed him as perhaps he recalls why
>> >> > the code is like it is.
>> >> I thought to get closer to 400kHz if possible.
>> >> Probably even host->clk / 512 does not have any problem.
>> >
>> > Sorry for my ignorance, is ~400kHz desirable for some reason?
>>
>> The 400kHz frequency is used during initialization of the SD card.
>> Simply put, the SD frequency starts low out low and is then changed to
>> something higher depending on the capability of the memory card and
>> the host controller. Please have a look at the simplified SD
>> specification for more details.
>
> Thanks, got it.
>
> Do you have a feeling of if it it worth trying to start with a value close
> to 400kHz or if it would be better to simplify the code? I can try and
> measure the difference in start up time for particular hardware
> combinations, but I'm not sure how far that will get us.

I believe the correct way is to program the hardware to be as close to
400 kHz as possible. I may be wrong, but I guess that slower than 400
kHz is also acceptable during the initial phase, but faster may mean
out of spec. For optimal performance the code may need to be reworked
to support both correct and slow 400 kHz as well as whatever high
frequencies needed for fast transfers. It is easier said than done
though. Whenever the common clock framework is in place then we should
be able to reprogram the parent rate and with that get a wider range
of frequencies compared with today. If this will work or not depends
on the hardware - on some SoCs the parent clock is shared with other
peripherals which means we may not be able to change it during
runtime. Other SoCs have individual clocks tied to each MMC controller
which gives us freedom to change the frequency during runtime.

I would not bother optimizing this unless you have deep knowledge
about a wide range of SoCs including clocks and the MMC controller
hardware. So for now I think it's best to aim for correctness only.

Also, what is correct or not varies with SoC model. Since our MMC
controller drivers run on a wide range of hardware it is important to
compare the MMC portion of the data sheet. So in this particular case
it is a good idea to make sure that whatever frequency limitations
that are present in one SoC is also true on other models.

Cheers,

/ magnus
