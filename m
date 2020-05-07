Return-Path: <SRS0=7UF0=6V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C938AC38A2A
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 21:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C8A6206B9
	for <linux-mmc@archiver.kernel.org>; Thu,  7 May 2020 21:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="jDdQCSJo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgEGVPB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 17:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgEGVPA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 17:15:00 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F77C05BD43;
        Thu,  7 May 2020 14:14:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id s10so6667000edy.9;
        Thu, 07 May 2020 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlDs+U3XxwFlGFdtHF+fukVcWtwSF1Z0OgPl62MgGJM=;
        b=jDdQCSJovln1Lf/24UzvqlU8zkkJWIfjYA8K+reeYoaXMDZLRywoTaRrYgEansIOVu
         xLDFmXjMpJywubKmEutMQlk4l18GDY8473pkQf8vSB05ajTGkQ8G/n2IHySx0L1iIo5Q
         XSoSoDy4G3w6Sijg9QV3RwtwbIXO8y9Reeyw3HCX7C8Okrcv4LaDY/c+pOS31n72xoax
         vyXE8BHk9Ft8OGqHdtspBUDb0OvZVedrRZVkgbIdCSDZWf+808WZYW1fZYiLQM+IC22v
         30a+DwGTvsExUQsCWFmykcnHJsdKApvvUMcuwdHbO56L6qD2+mRguIIIGqazyKBHdKip
         nuSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlDs+U3XxwFlGFdtHF+fukVcWtwSF1Z0OgPl62MgGJM=;
        b=sHWoNwNR+ZxmemJxQ2XmpyKJiYDINkJP/KPJ0CkF3Bj7W04wCHLuSan3VbTjB2CwHx
         JXNxGwYsT524fKzbGp0kcqquSs4B7tymx+ELle8M2e5YPLFUU/YDupZBwZ5oMxN/ghBC
         ctVzDMdpcDvP3OyssGRCo4S32FcnhIrDd5NwxHWo8wtzQkL1FyM4/WD5xddeaKCLqhdQ
         FtdPdxTXr1rfxG+TEZ2l9w5VYzIwv9xswjD/3ddPSXFGpxWVewfgAuxaxDtiZcZI9j32
         xhwNs0qNn9rmBOUfSDZWES8SL3aMkFNmTvP+acokbiGCgP2VbPpD+X2FP9FmALnF8rS9
         K/aA==
X-Gm-Message-State: AGi0PuZ9C1spkTlmTovOnXHxgnU1ilnRtVXS04ILhzYdnmjkGCeLXEnf
        1ys0gkU+idSQgwu0hrfureM8oVdh/BK/xM8bTto=
X-Google-Smtp-Source: APiQypKEh0NTeD0wH+GLzSZXKy7BF/ZjCae+PeiLcsewYN+o1b/IW2FRBmqOJLsZfWNktV5E+osIzub72f9+pPe6WZE=
X-Received: by 2002:a50:a985:: with SMTP id n5mr13773610edc.338.1588886097684;
 Thu, 07 May 2020 14:14:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200503222805.2668941-1-martin.blumenstingl@googlemail.com> <CAPDyKFrY0ApUCNL4gVHRc2FRcYaS0PKr_P4a18RUZHxcVceVWg@mail.gmail.com>
In-Reply-To: <CAPDyKFrY0ApUCNL4gVHRc2FRcYaS0PKr_P4a18RUZHxcVceVWg@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 7 May 2020 23:14:46 +0200
Message-ID: <CAFBinCAhLiunUvw+BAHnv3XVmmU=Wxs1i=WLAAFL5=Hn0RPOvQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: trigger a soft reset after a timeout
 or CRC error
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tobias Baumann <017623705678@o2online.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, May 7, 2020 at 11:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 4 May 2020 at 00:28, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > The vendor driver (from the 3.10 kernel) triggers a soft reset every
> > time before starting a new command. While this fixes a problem where
> > SDIO cards are not detected at all (because all commands simply
> > timed out) this hurts SD card read performance a bit (in my tests
> > between 10% to 20%).
> >
> > Trigger a soft reset after we got a CRC error or if the previous command
> > timed out (just like the vendor driver from the same 3.10 kernel for the
> > newer SDHC controller IP does). This fixes detection of SDIO cards and
> > doesn't hurt SD card read performance at the same time.
> >
> > With this patch the initialization of an RTL8723BS SDIO card looks like
> > this:
> >   req done (CMD52): -110: 00000000 00000000 00000000 00000000
> >   clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
> >   starting CMD0 arg 00000000 flags 000000c0
> >   req done (CMD0): 0: 00000000 00000000 00000000 00000000
> >   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
> >   starting CMD8 arg 000001aa flags 000002f5
> >   req done (CMD8): -110: 00000000 00000000 00000000 00000000
> >   starting CMD5 arg 00000000 flags 000002e1
> >   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
> >   starting CMD5 arg 00200000 flags 000002e1
> >   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
> >   starting CMD3 arg 00000000 flags 00000075
> >   req done (CMD3): 0: 00010000 00000000 00000000 00000000
> >   starting CMD7 arg 00010000 flags 00000015
> >   req done (CMD7): 0: 00001e00 00000000 00000000 00000000
> >   starting CMD52 arg 00000000 flags 00000195
> >   req done (CMD52): 0: 00001032 00000000 00000000 00000000
> >   [... more CMD52 omitted ...]
> >   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
> >   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
> >   starting CMD52 arg 00000e00 flags 00000195
> >   req done (CMD52): 0: 00001000 00000000 00000000 00000000
> >   starting CMD52 arg 80000e02 flags 00000195
> >   req done (CMD52): 0: 00001002 00000000 00000000 00000000
> >   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 2
> >   starting CMD52 arg 00020000 flags 00000195
> >   req done (CMD52): 0: 00001007 00000000 00000000 00000000
> >   [... more CMD52 omitted ...]
> >   new high speed SDIO card at address 0001
> >
> > Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > ---
> > Ulf, I consider this non-critical because as long as the meson-mx-sdhc
> > driver is not merged we only have one MMC driver for these platforms.
> > I don't know anybody to prefer SDIO wifi over SD card access, so this
> > can go into -next (in my option at least).
> >
>
> Alright, applied for next, thanks!
thank you for taking this patch!

I received a confirmation (off-list) saying that this patch works as it should.
Tobias was not Cc'ed on the original mail so he gave me to permission
(again, off-list - he's Cc'ed now) to add his:
Tested-by: Tobias Baumann <017623705678@o2online.de>


Martin
