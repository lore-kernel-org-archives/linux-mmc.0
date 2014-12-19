From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] mmc: sunxi: General fixup (v2)
Date: Fri, 19 Dec 2014 13:32:38 +0100
Message-ID: <CAPDyKFoDQyrvZbCUYgvJFr-OVDkhm_EVc3TJ6Fuw1fD4ZQ6ABw@mail.gmail.com>
References: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:63500 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaLSMcj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Dec 2014 07:32:39 -0500
Received: by mail-qc0-f176.google.com with SMTP id i17so555931qcy.7
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2014 04:32:39 -0800 (PST)
In-Reply-To: <20141216140921.3036.14668.stgit@dizzy-6.o2s.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer@o2s.ch>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Griffin <peter.griffin@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, =?UTF-8?B?5p2O5oOz?= <lixiang@allwinnertech.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 16 December 2014 at 15:10, David Lanzend=C3=B6rfer
<david.lanzendoerfer@o2s.ch> wrote:
> Hello
> This patchset was inspired questions from =E6=9D=8E=E6=83=B3 of Allwi=
nner and incorporates as
> well suggestions from Hans related to spin locks.
> For example have not all attributes of the shared host object been pr=
otected
> by the spin lock, this has been changed.
> Also some register names and reset behavior have been fixed now.
> And a minor cleanup happened at the clock frequecy setting, since the=
re has
> been a piece of left over code which has been there because it was in=
 the Android
> driver and we just adapted it because we didn't have proper documenta=
tion about
> the timing of the module.
>
> Looking forward to your feedback
> Cheers David

Thanks! Queued for 3.20.

Kind regards
Uffe

>
> ---
>
> David Lanzend=C3=B6rfer (3):
>       mmc: sunxi: Lock fix
>       mmc: sunxi: Correcting SDXC_HARDWARE_RESET bit
>       mmc: sunxi: Removing unused code
>
> Hans de Goede (1):
>       mmc: sunxi: Fix setup of last descriptor of dma transfer
>
>
>  drivers/mmc/host/sunxi-mmc.c |   29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
>
> --
> Signature
