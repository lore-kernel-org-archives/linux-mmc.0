From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: ARM: shmobile: Koelsch fails to resume due to sh_mobile_sdhi or regulator-fixed
Date: Thu, 14 Aug 2014 17:20:34 +0200
Message-ID: <CAMuHMdWRDHexT94Mxk2LSWDe-GpD2zXD_xv++H7aQDFeNfjJSA@mail.gmail.com>
References: <CAMuHMdWTudFK_EiL8xQpmL5OmJxYX1i80WjfAA+L2Dfn21NWtA@mail.gmail.com>
	<20140812214734.GA17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:58734 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755536AbaHNPUh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Aug 2014 11:20:37 -0400
In-Reply-To: <20140812214734.GA17528@sirena.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Ian Molton <ian.molton@codethink.co.uk>, Linux-sh list <linux-sh@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

On Tue, Aug 12, 2014 at 11:47 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Aug 12, 2014 at 04:28:39PM +0200, Geert Uytterhoeven wrote:
>> r8a7791/Koelsch fails to resume from s2ram with
>
>>     CONFIG_REGULATOR_FIXED_VOLTAGE=y
>>     CONFIG_REGULATOR_GPIO=y
>>     CONFIG_MMC_SDHI=y
>
>> Disabling CONFIG_REGULATOR_FIXED_VOLTAGE or CONFIG_MMC_SDHI,
>> or both, fixes resume.
>
>> Note that SDHI on r8a7791 uses both regulator-fixed and regulator-gpio.
>> However, CONFIG_REGULATOR_GPIO doesn't seem to have any impact
>> on the resume failure, it resumes fine with CONFIG_REGULATOR_GPIO=y.
>
>> Anyone with a clue?
>
> No idea, I expect it's some bug in the board description - both that
> regulator driver and that MMC driver should be very well tested.  Given
> the lack of traces are you sure that the system is actually suspending
> successfully and not just crashing?  First guess would be that the
> regulator is being powered off on suspend and the hardware is trying to
> boot from a powered off device on resume but that really is just a guess.

It's not a regulator issue.

Further investigation showed that he system locks up when suspending,
as the SDHI driver's tmio_mmc_host_suspend() accesses the SDHI registers
while the SDHI module clock is disabled.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
