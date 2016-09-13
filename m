From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Tue, 13 Sep 2016 15:26:14 +0200
Message-ID: <CAMuHMdVGgWaVcC4Pfuf0NSTpU4ahdEg6Q7iKZ1n+mb7KexE6yg@mail.gmail.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-2-chris.brandt@renesas.com> <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f53.google.com ([209.85.214.53]:36551 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbcIMN0Q (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Sep 2016 09:26:16 -0400
In-Reply-To: <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Brandt <chris.brandt@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

Hi Ulf,

On Tue, Sep 13, 2016 at 2:57 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 September 2016 at 16:15, Chris Brandt <chris.brandt@renesas.com> wrote:
>> In moving platforms from board files to DT, there still needs to be a way
>> to set the ocr_mask setting for the tmio driver during probe. Without this
>> setting, the probe will fail because the supported voltages are not known.
>
> Regarding the ocr_mask; How do these SoCs provides the power to the mmc/sd card?
>
> Do note, I am *not* talking about the I/O voltage but the core power
> to the card.
>
> The reason for raising the question is that we have infrastructures in
> the mmc core which can create the ocr_mask, by parsing a regulator's
> voltage range. This is the recommended method to use, instead of using
> hard coded ocr mask values.

On RSKRZA1, 3.3V is provided to the SD/MMC socket through an MIC2026
MOSFET switch.
On Genmai, 3.3V or 5V is provided through an LTC1471 switch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
