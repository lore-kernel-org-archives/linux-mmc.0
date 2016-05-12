From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 12 May 2016 10:32:27 +0200
Message-ID: <CAMuHMdWaZ-sbx3JXc2h59R6OzkiKnmbmPDaSKZ+4aRie0YMYuA@mail.gmail.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
	<SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdWKu7wLDthh2QXKJBS_a7yz38HFbi4wSLMnWV0Y5qbbbQ@mail.gmail.com>
	<SG2PR06MB0919A06B80C8231816200645D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdVmA7t3k+56yP9n++WGRqLy1pkbtmpe+SmJRaDJmU04zA@mail.gmail.com>
	<SG2PR06MB0919E39A668AD2ECA9DEE018D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB0919E39A668AD2ECA9DEE018D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-sanm

On Thu, May 12, 2016 at 10:09 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> From: Geert Uytterhoeven
>> Sent: Thursday, May 12, 2016 4:47 PM
>> On Thu, May 12, 2016 at 9:45 AM, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> From: Geert Uytterhoeven
>> >> Sent: Thursday, May 12, 2016 3:46 PM
>> >>
>> >> On Thu, May 12, 2016 at 8:30 AM, Yoshihiro Shimoda
>> >> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> > - I tried 3 Lager boards:
>> >> >  - One of board (No.701 / ES2.0) sometimes works correctly.
>> >> >   - " mmc1: tuning execution failed: -110" appeared.
>> >> >  - Other 2 boards (No.465 / ES2.0 and No.322 / ES3.0) always works correctly.
>> >> >
>> >> > Perhaps the issue is related to hardware problem.
>> >>
>> >> Do they have the same U-Boot version?
>> >> Does the failing one have a newer U-Boot that disables unused MSTP clocks?
>> >
>> > Thank you for the comment! The No.701 was difference U-Boot version.
>> > So, I wrote the same U-Boot version into the No.701 board, and then
>> > SDR104 works correctly on the board.
>>
>> What are the U-Boot versions?
>
> "U-Boot 2013.01.01-gcb82c56": SDR104 works fine.
> http://git.denx.de/?p=u-boot/u-boot-sh.git;a=log;h=refs/heads/renesas/bsp/rcar-gen2-1.9.4
>
> "U-Boot 2015.04-dirty": Sometimes SDR104 works fine.
> Sorry, I don't know actual commit id.

v2015.04 is good enough the confirm my suspicion.

>> This is still a kernel bug that needs to be fixed...
>
> I think so...

I suppose it fails again if you merge topic/renesas-debug from my
renesas-drivers
git repo, as that will disable the unused MSTP clocks again on boot?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
