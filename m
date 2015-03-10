From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Possible regression in next-20150306 due to "mmc: tmio: Fix PIO
 mode with CONFIG_HIGHMEM"
Date: Tue, 10 Mar 2015 11:27:29 +0100
Message-ID: <CAMuHMdXGnCM_R0bg6+YUNynctqHpAgFqUdj2_visRU4pCLQ-6g@mail.gmail.com>
References: <20150307060915.GA24323@verge.net.au>
	<20150310072944.GA22869@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150310072944.GA22869@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: keita kobayashi <keita.kobayashi.ym@renesas.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Simon,

On Tue, Mar 10, 2015 at 8:29 AM, Simon Horman <horms@verge.net.au> wrote:
> On Sat, Mar 07, 2015 at 03:09:20PM +0900, Simon Horman wrote:
>> I have noticed what appears to be a regression in next-20150306.  Using
>> shmobile_defconfig I am unable to boot the koelsch or lager boards to
>> user-space. However, if I revert be7de0b8a90a0b06d ("mmc: tmio: Fix PIO

What happens exactly?

>> mode with CONFIG_HIGHMEM") then all seems well.
>
> Apologies, I seem to have messed up the commit id.
> It should be 5da0e63e268dc5120

I can't seem to reproduce this on koelsch. I tried next-20150306,
renesas-drivers-2015-03-09-v4.0-rc3, and my local tree based on the latter.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
