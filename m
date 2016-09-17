From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 1/3] mmc: sh_mobile_sdhi: add ocr_mask option
Date: Sat, 17 Sep 2016 11:12:13 +0200
Message-ID: <CAPDyKFqBToUrSbErWrc+zV-WX29Dj5dm+XzWMCfBgOiEtoG8Jg@mail.gmail.com>
References: <20160912141507.6837-1-chris.brandt@renesas.com>
 <20160912141507.6837-2-chris.brandt@renesas.com> <CAPDyKFqdznJ4xr5=L862uOfvqjsRpR3d+yRWtN1-8H5ZvP9GeQ@mail.gmail.com>
 <CAMuHMdVGgWaVcC4Pfuf0NSTpU4ahdEg6Q7iKZ1n+mb7KexE6yg@mail.gmail.com>
 <SG2PR06MB1165D0EE862CCCFD713181938AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAPDyKFp1eSyVAnn4JohR=Cx0VeE-5U8eY5GVQA+ae0P-vDJJ8w@mail.gmail.com> <SG2PR06MB11655A641475D2E08A5A3DDC8AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36682 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932785AbcIQJMQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 17 Sep 2016 05:12:16 -0400
Received: by mail-wm0-f42.google.com with SMTP id b187so72361835wme.1
        for <linux-mmc@vger.kernel.org>; Sat, 17 Sep 2016 02:12:15 -0700 (PDT)
In-Reply-To: <SG2PR06MB11655A641475D2E08A5A3DDC8AFE0@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Simon Horman <horms+renesas@verge.net.au>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 13 September 2016 at 17:59, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> Hello Uffe
>
> Thank you for your reply.
>
> On 9/13/2016, Ulf Hansson wrote:
>> Because, if you have an external regulator feeding the mmc with power you
>> should set it up and use it.
>
> But in many board designs, there is no control over the regulator supply (or you would rather have your bootloader do that, not the kernel).
>
> So what this patch is doing is setting it to a default of 3.3v (for just this SoC) and if someone wants to add a regulator in the board's DT file, that will override the ocr_mask set by the driver.

That's perfectly okay to me! I just wanted to get clear picture of
*why* this change was needed.

>
>
> I'm assuming I'll have to do the same for MMC (sh_mmcif.c) once I get to that driver (I need to find my MMC PLUS card first for testing).

Okay!

Kind regards
Uffe
