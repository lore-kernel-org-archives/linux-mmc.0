From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: remove linux/blkdev.h include from host drivers
Date: Wed, 11 Apr 2012 17:05:48 +0200
Message-ID: <4F859DCC.6040307@atmel.com>
References: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1334084783-3572-1-git-send-email-mad_soft@inbox.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Pavel Pisa <ppisa@pikron.com>, Sascha Hauer <s.hauer@pengutronix.de>, Will Newton <will.newton@imgtec.com>
List-Id: linux-mmc@vger.kernel.org

Hi Dmitry,

Le 04/10/2012 09:06 PM, Dmitry Artamonow a =C3=A9crit :
> None of mmc host drivers using linux/blkdev.h header
> really need anything from it. The slight exception is
> atmel-mci, which uses blkdev.h only because it indirectly
> pulls asm/cacheflush.h
>
> So remove any inclusion of blkdev.h - it should also fix
> build errors of dw_mmc and atmel-mci drivers when
> CONFIG_BLOCK is disabled, like following:
> ------------------------------------------------------
> In file included from drivers/mmc/host/dw_mmc.c:14:0:
> include/linux/blkdev.h:1408:42: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
> include/linux/blkdev.h:1408:42: warning: its scope is only this defin=
ition or declaration, which is probably not what you want [enabled by d=
efault]
> include/linux/blkdev.h:1412:51: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
> include/linux/blkdev.h:1417:1: error: unknown type name =E2=80=98bool=
=E2=80=99
> include/linux/blkdev.h:1417:48: warning: =E2=80=98struct task_struct=E2=
=80=99 declared inside parameter list [enabled by default]
> include/linux/blkdev.h: In function =E2=80=98blk_needs_flush_plug=E2=80=
=99:
> include/linux/blkdev.h:1419:9: error: =E2=80=98false=E2=80=99 undecla=
red (first use in this function)
> include/linux/blkdev.h:1419:9: note: each undeclared identifier is re=
ported only once for each function it appears in
> make[1]: *** [drivers/mmc/host/dw_mmc.o] Error 1
> make: *** [drivers/mmc/host/dw_mmc.o] Error 2
> ------------------------------------------------------
>
> Cc: Ludovic Desroches<ludovic.desroches@atmel.com>
> Cc: Pavel Pisa<ppisa@pikron.com>
> Cc: Sascha Hauer<s.hauer@pengutronix.de>
> Cc: Will Newton<will.newton@imgtec.com>
> Signed-off-by: Dmitry Artamonow<mad_soft@inbox.ru>
> ---
>
>   drivers/mmc/host/at91_mci.c  |    1 -
>   drivers/mmc/host/atmel-mci.c |    2 +-

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Thanks for your patch.

Regards

Ludovic
