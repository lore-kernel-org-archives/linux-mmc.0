From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC 0/3] UHS-I SDR-104 support for sh_mobile_sdhi
Date: Thu, 12 May 2016 14:32:54 +0200
Message-ID: <CAMuHMdW_VkpjoLyXOvbdwwm=h5L8A8JrGKf_P6ig_pBqM-tGtw@mail.gmail.com>
References: <1462859524-28522-1-git-send-email-horms+renesas@verge.net.au>
	<SG2PR06MB09190A986DDC6D2220603AA6D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdWKu7wLDthh2QXKJBS_a7yz38HFbi4wSLMnWV0Y5qbbbQ@mail.gmail.com>
	<SG2PR06MB0919A06B80C8231816200645D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdVmA7t3k+56yP9n++WGRqLy1pkbtmpe+SmJRaDJmU04zA@mail.gmail.com>
	<SG2PR06MB0919E39A668AD2ECA9DEE018D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
	<CAMuHMdWaZ-sbx3JXc2h59R6OzkiKnmbmPDaSKZ+4aRie0YMYuA@mail.gmail.com>
	<SG2PR06MB0919824AFCAE20C395E50738D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB0919824AFCAE20C395E50738D8730@SG2PR06MB0919.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Ian Molton <ian@mnementh.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shimoda-san,

On Thu, May 12, 2016 at 11:26 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
>> From: Geert Uytterhoeven
>> Sent: Thursday, May 12, 2016 5:32 PM
>> On Thu, May 12, 2016 at 10:09 AM, Yoshihiro Shimoda
>> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> From: Geert Uytterhoeven
>> >> Sent: Thursday, May 12, 2016 4:47 PM
>> >> On Thu, May 12, 2016 at 9:45 AM, Yoshihiro Shimoda
>> >> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> >> From: Geert Uytterhoeven
>> >> >> Sent: Thursday, May 12, 2016 3:46 PM
>> >> >>
>> >> >> On Thu, May 12, 2016 at 8:30 AM, Yoshihiro Shimoda
>> >> >> <yoshihiro.shimoda.uh@renesas.com> wrote:
>> >> >> > - I tried 3 Lager boards:
>> >> >> >  - One of board (No.701 / ES2.0) sometimes works correctly.
>> >> >> >   - " mmc1: tuning execution failed: -110" appeared.
>> >> >> >  - Other 2 boards (No.465 / ES2.0 and No.322 / ES3.0) always works correctly.
>> >> >> >
>> >> >> > Perhaps the issue is related to hardware problem.
>> >> >>
>> >> >> Do they have the same U-Boot version?
>> >> >> Does the failing one have a newer U-Boot that disables unused MSTP clocks?
>> >> >
>> >> > Thank you for the comment! The No.701 was difference U-Boot version.
>> >> > So, I wrote the same U-Boot version into the No.701 board, and then
>> >> > SDR104 works correctly on the board.
>> >>
>> >> What are the U-Boot versions?
>> >
>> > "U-Boot 2013.01.01-gcb82c56": SDR104 works fine.
>> > http://git.denx.de/?p=u-boot/u-boot-sh.git;a=log;h=refs/heads/renesas/bsp/rcar-gen2-1.9.4
>> >
>> > "U-Boot 2015.04-dirty": Sometimes SDR104 works fine.
>> > Sorry, I don't know actual commit id.
>>
>> v2015.04 is good enough the confirm my suspicion.
>>
>> >> This is still a kernel bug that needs to be fixed...
>> >
>> > I think so...
>>
>> I suppose it fails again if you merge topic/renesas-debug from my
>> renesas-drivers
>> git repo, as that will disable the unused MSTP clocks again on boot?
>
> I tried the topic/renesas-debug from your renesas-drivers git repo.
> However, the issue still appeared.

That's what I expected...

> For your reference, I changed the pr_debug() to pr_info() in clk-mstp.c
> and I pasted the kernel log to the end of this email.

Good, so we know which module clocks are enabled/disabled...

> [    0.024351] Disabling MSTP clocks for the System Core
> [    0.024364]   SMSTPCR0: *0xe6150130 |= 0x00640801
> [    0.024377]   SMSTPCR1: *0xe6150134 |= 0xdb6e9bdf
> [    0.024390]   SMSTPCR2: *0xe6150138 |= 0x300da1fc
> [    0.024402]   SMSTPCR3: *0xe615013c |= 0xf08cfc31
> [    0.024415]   SMSTPCR4: *0xe6150140 |= 0x80000004
> [    0.024427]   SMSTPCR5: *0xe6150144 |= 0x44c00046
> [    0.024439]   SMSTPCR6: *0xe615014c |= 0x07d30718
> [    0.024452]   SMSTPCR7: *0xe6150990 |= 0x01f0ff84
> [    0.024464]   SMSTPCR8: *0xe6150994 |= 0xf5d79fcf
> [    0.024476]   SMSTPCR9: *0xe6150998 |= 0xfffeffe0
> [    0.024489]   SMSTPCR10: *0xe615099c |= 0x00000000
> [    0.024501] Disabling MSTP clocks for the Realtime Core
> [    0.024513]   RMSTPCR0: *0xe6150110 |= 0x00640801
> [    0.024526]   RMSTPCR1: *0xe6150114 |= 0xdb6e9bdf
> [    0.024538]   RMSTPCR2: *0xe6150118 |= 0x300da1fc
> [    0.024550]   RMSTPCR3: *0xe615011c |= 0xf08cfc31
> [    0.024562]   RMSTPCR4: *0xe6150120 |= 0x80000184
> [    0.024574]   RMSTPCR5: *0xe6150124 |= 0x44c00046
> [    0.024586]   RMSTPCR6: *0xe615012c |= 0x07f30718
> [    0.024599]   RMSTPCR7: *0xe6150980 |= 0x01f0ff84
> [    0.024611]   RMSTPCR8: *0xe6150984 |= 0xf5d79fcf
> [    0.024623]   RMSTPCR9: *0xe6150988 |= 0xfffeffe0
> [    0.024635]   RMSTPCR10: *0xe615098c |= 0x00000000

The above disabled all unused MSTP clocks...

> [    0.024687] INTC_SYS            : S .
> [    0.024700] IRQC                : S .
> [    0.024730] SCIF0               : S .

... after which only the 3 above are still enabled.

> [    3.884952] MSTP sdhi0 ON

The sdhi0 MSTP clock is now enabled (and never disabled later)...

> [    4.023731] sh_mobile_sdhi ee100000.sd: mmc1 base at 0xee100000 max clock rate 195 MHz
> [    4.032324] sh_mobile_sdhi ee140000.sd: Got CD GPIO

> root@192:~# [   26.983564] mmc1: tuning execution failed: -110
> [   26.988177] mmc1: error -110 whilst initialising SD card
> [   26.995011] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   27.003101] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   27.011225] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   27.019313] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   27.027418] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.034962] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.056492] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.074949] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.095257] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.103655] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.112020] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.135220] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.155239] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   32.163633] sh_mobile_sdhi ee100000.sd: timeout waiting for SD bus idle
> [   37.173569] sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD52)
> [   42.223562] sh_mobile_sdhi ee100000.sd: timeout waiting for hardware interrupt (CMD52)

... still it failed.

As the sdhi0 MSTP clock is still enabled, there must be an unknown clock that's
needed for proper operation, but that's currently not controlled by software.

With topic/renesas-debug, you can enable/disable module clocks from the
shell, e.g.

              echo sdhi0=on > /proc/mstp
              echo sdhi0=0 > /proc/mstp
              echo 314=off > /proc/mstp

or control which clocks are disabled at boot time by modifying the
SMSTPx_DISABLE macros.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
