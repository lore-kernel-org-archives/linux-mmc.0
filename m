From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 0/3] mmc: sh_mobile_sdhi: Add r7s72100 support
Date: Mon, 7 Nov 2016 19:38:30 +0100
Message-ID: <CAPDyKFp=d7nQ94wv_LnvuJ4HMD8Hv3X+BanhRoc1wu1i+pmEPw@mail.gmail.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35526 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933287AbcKGSid (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 13:38:33 -0500
Received: by mail-wm0-f42.google.com with SMTP id a197so200573143wmd.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2016 10:38:32 -0800 (PST)
In-Reply-To: <20160912141507.6837-1-chris.brandt@renesas.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <chris.brandt@renesas.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 12 September 2016 at 16:15, Chris Brandt <chris.brandt@renesas.com> wrote:
> For the most part, the SDHI controller in the RZ/A1 (r7s72100)
> is the same as other Renesas SoC...except for the fact that the
> data port register was widened to 32-bits and the 16-bit accesses
> in the current tmio driver aren't going to cut it.
>
> Also, the tmio driver allows you to pass in what voltages you
> support via the ocr_mask. For the RZ/A1, it's just simple 3.3v.
> So, I added the ability to pass that when using DT.
>
> Chris Brandt (3):
>   mmc: sh_mobile_sdhi: add ocr_mask option
>   mmc: tmio-mmc: add support for 32bit data port
>   mmc: sh_mobile_sdhi: Add r7s72100 support
>
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt |  1 +
>  drivers/mmc/host/sh_mobile_sdhi.c                  |  9 +++++++
>  drivers/mmc/host/tmio_mmc.h                        | 12 +++++++++
>  drivers/mmc/host/tmio_mmc_pio.c                    | 30 ++++++++++++++++++++++
>  include/linux/mfd/tmio.h                           |  5 ++++
>  5 files changed, 57 insertions(+)
>
> --
> 2.9.2
>
>

Thanks, applied for next!

Kind regards
Uffe
