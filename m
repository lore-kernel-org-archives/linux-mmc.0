From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/5] davinci_mmc fixes
Date: Tue, 5 Apr 2016 13:12:33 +0200
Message-ID: <CAPDyKFp3UELfw2gNTh0GeX31bjwb8tbDiua6ZigLwhaUkcv3zA@mail.gmail.com>
References: <1458186341-6970-1-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:32833 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757963AbcDELMf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Apr 2016 07:12:35 -0400
Received: by mail-wm0-f41.google.com with SMTP id f198so27224635wme.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 Apr 2016 04:12:34 -0700 (PDT)
In-Reply-To: <1458186341-6970-1-git-send-email-david@lechnology.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Russell King <linux@arm.linux.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 17 March 2016 at 04:45, David Lechner <david@lechnology.com> wrote:
> I have replaced one of my patches with the patch from Peter Ujfalusi =
and fixed
> a mistake in the "fix unwinding..." patch.
>
> Tested working on LEGO MINDSTORMS EV3 (da850-ish).
>
> David Lechner (4):
>   mmc: davinci: remove matching string
>   mmc: davinci: fix unwinding in probe
>   mmc: davinci: prepare clock
>   ARM: davinci: remove mmc dma resources
>
> Peter Ujfalusi (1):
>   mmc: davinci_mmc: Use dma_request_chan() to requesting DMA channel
>
>  arch/arm/mach-davinci/devices-da8xx.c |  20 -----
>  arch/arm/mach-davinci/devices.c       |  16 ----
>  drivers/mmc/host/davinci_mmc.c        | 147 ++++++++++++------------=
----------
>  3 files changed, 50 insertions(+), 133 deletions(-)
>
> --
> 1.9.1
>

Patch 3 triggers a compiler warning, please fix it.

=2E./drivers/mmc/host/davinci_mmc.c: In function =E2=80=98davinci_mmcsd=
_probe=E2=80=99:
=2E./drivers/mmc/host/davinci_mmc.c:1208:6: warning: =E2=80=98ret=E2=80=
=99 may be used
uninitialized in this function [-Wmaybe-uninitialized]

I have applied patch 1->2 for next, so no need to resend these.

Kind regards
Uffe
