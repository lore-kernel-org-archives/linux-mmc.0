From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] dma: add new DMA control commands
Date: Thu, 18 Oct 2012 11:11:15 -0400
Message-ID: <CAMiH66HCDLZaxXckQz1bfqscNm2X2480HTr4bFHdJNteDLb=ig@mail.gmail.com>
References: <1350538335-29026-1-git-send-email-b32955@freescale.com>
	<201210181049.21556.marex@denx.de>
	<507FC827.40601@freescale.com>
	<201210181251.15116.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201210181251.15116.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, djbw-b10kYP2dOMg@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org, w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lrg-l0cyMroinI0@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Oct 18, 2012 at 6:51 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> Dear Huang Shijie,
>
>> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 16:49, Marek Vasut =E5=
=86=99=E9=81=93:
>> > Dear Huang Shijie,
>> >
>> >> =E4=BA=8E 2012=E5=B9=B410=E6=9C=8818=E6=97=A5 16:16, Marek Vasut =
=E5=86=99=E9=81=93:
>> >>> So we can't stream data from the chip? About time to adjust the =
MTD
>> >>> framework to allow that. Maybe implement a command queue?
>> >>
>> >> IMHO, it's not possible. Because the READ-PAGE(00h-30h) command n=
eeds to
>> >> check the busy status
>> >> which means we have to stop in the middle, so we can not chain th=
e all
>> >> the read-pages DMA commands.
>> >
>> > Can the DMA not branch?
>>
>> it's too complicated to the MTD layer, as well as the gpmi driver.
>
> Can you please elaborate ?
could you read the nand spec about how to read a page out with the
READ-PAGE(00-30) command,
and tell me how to make the DMA branch?
I really have no idea about how to make the DMA branch.

thanks
Huang Shijie
=2E


> Best regards,
> Marek Vasut
