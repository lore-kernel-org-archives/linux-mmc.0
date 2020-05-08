Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2316C47254
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 03:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE37E2495C
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 03:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ws3HSrFp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgEHDw6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 7 May 2020 23:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgEHDw6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2020 23:52:58 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B994C05BD43
        for <linux-mmc@vger.kernel.org>; Thu,  7 May 2020 20:52:56 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id h30so284182vsr.5
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2020 20:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AofEIL6YwXkUVr1SNl6pGav5cBT+5klZGSSb4tIGh2s=;
        b=Ws3HSrFplgBdKEF0d6Ef/CDW5EwS0mXz/l1DIcB7Yh88VTMzo5MJ1/iiMYqJgvjIps
         jZg+hxl63XPpkntjE6T09riZ2WW1K61v5WIqxg3xsIhYwQxmE9xabjYObXdDyEBG0BhN
         8VAe1as355JZIKEi5T6z7jcGg7UCgngipOJMay+JgSZzBvvfdm/Y/HE6PGURFLejYcae
         Qtj8iGyb6pngMMlDtfEwrZ0/7V8aPDpDm/HfLafQRWixtrEN1tg7Y1xjHAfOIXjAfH69
         mCETeiAkyA5W7hcljWLKKIu1/rag+QSkJSJ+/oMXE9NhCaqWtxFh2DTEV+zJZmpiIx2X
         Jxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AofEIL6YwXkUVr1SNl6pGav5cBT+5klZGSSb4tIGh2s=;
        b=OKMHbCqxynlw1KUurTwdECgtWP6ec4CvFz6KwTT+bXGMl8MGU5Zzm3jyETimQco5ff
         tL5ybdelWxSjJfR1fZLFRMhl9k3PLW2JYZ41jc/E+kCdkJM9P2oXBQSUWMx+a13yutMh
         Xk3N9ei+FeM4PWm91njT2zgujrXW0KX6HAnjfFwx5qZcDBFaxjtP6S9FCJ5eLwV7sfwj
         v0gj11xc5U810Bb2U5oXMkBxEAF7ccJXj0FP+Efig0xXxl4pwKLSKEMnhvQXULB0BfNb
         MTmjBYaK/JXgFTikZMGWSLJnt0LeCpmrwlIrkswN8kN7l5scXrU95EeFall2lb+t1ssZ
         Msng==
X-Gm-Message-State: AGi0PuYJuqTyEFg+icEepPEzfgDMvdmduN5iuAwh3W93AY5uS0OjPUu7
        8a5K8fjZ8C7N4mBnNv5tRZsfvqwRXA2ViWe6c54tFg==
X-Google-Smtp-Source: APiQypK0VwJrY4iB2MHXq8SKZlSKQAWMfhS/ZAicl7WYe0F28/ri1drVF8Qs2B+UBwYxgSQnt7BKpD8v0MZ88ZPq2H4=
X-Received: by 2002:a67:302:: with SMTP id 2mr347325vsd.165.1588909975527;
 Thu, 07 May 2020 20:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200503222805.2668941-1-martin.blumenstingl@googlemail.com>
 <CAPDyKFrY0ApUCNL4gVHRc2FRcYaS0PKr_P4a18RUZHxcVceVWg@mail.gmail.com> <CAFBinCAhLiunUvw+BAHnv3XVmmU=Wxs1i=WLAAFL5=Hn0RPOvQ@mail.gmail.com>
In-Reply-To: <CAFBinCAhLiunUvw+BAHnv3XVmmU=Wxs1i=WLAAFL5=Hn0RPOvQ@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 8 May 2020 05:52:18 +0200
Message-ID: <CAPDyKFqO8D-UUvq3Ebtnp73xfD_0kaWBq=75wvFL=4xbK5Zj-g@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-mx-sdio: trigger a soft reset after a timeout
 or CRC error
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
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

On Thu, 7 May 2020 at 23:14, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Thu, May 7, 2020 at 11:29 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Mon, 4 May 2020 at 00:28, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > The vendor driver (from the 3.10 kernel) triggers a soft reset every
> > > time before starting a new command. While this fixes a problem where
> > > SDIO cards are not detected at all (because all commands simply
> > > timed out) this hurts SD card read performance a bit (in my tests
> > > between 10% to 20%).
> > >
> > > Trigger a soft reset after we got a CRC error or if the previous command
> > > timed out (just like the vendor driver from the same 3.10 kernel for the
> > > newer SDHC controller IP does). This fixes detection of SDIO cards and
> > > doesn't hurt SD card read performance at the same time.
> > >
> > > With this patch the initialization of an RTL8723BS SDIO card looks like
> > > this:
> > >   req done (CMD52): -110: 00000000 00000000 00000000 00000000
> > >   clock 400000Hz busmode 2 powermode 2 cs 1 Vdd 21 width 1 timing 0
> > >   starting CMD0 arg 00000000 flags 000000c0
> > >   req done (CMD0): 0: 00000000 00000000 00000000 00000000
> > >   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 0
> > >   starting CMD8 arg 000001aa flags 000002f5
> > >   req done (CMD8): -110: 00000000 00000000 00000000 00000000
> > >   starting CMD5 arg 00000000 flags 000002e1
> > >   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
> > >   starting CMD5 arg 00200000 flags 000002e1
> > >   req done (CMD5): 0: 90ff0000 00000000 00000000 00000000
> > >   starting CMD3 arg 00000000 flags 00000075
> > >   req done (CMD3): 0: 00010000 00000000 00000000 00000000
> > >   starting CMD7 arg 00010000 flags 00000015
> > >   req done (CMD7): 0: 00001e00 00000000 00000000 00000000
> > >   starting CMD52 arg 00000000 flags 00000195
> > >   req done (CMD52): 0: 00001032 00000000 00000000 00000000
> > >   [... more CMD52 omitted ...]
> > >   clock 400000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
> > >   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 1 timing 2
> > >   starting CMD52 arg 00000e00 flags 00000195
> > >   req done (CMD52): 0: 00001000 00000000 00000000 00000000
> > >   starting CMD52 arg 80000e02 flags 00000195
> > >   req done (CMD52): 0: 00001002 00000000 00000000 00000000
> > >   clock 50000000Hz busmode 2 powermode 2 cs 0 Vdd 21 width 4 timing 2
> > >   starting CMD52 arg 00020000 flags 00000195
> > >   req done (CMD52): 0: 00001007 00000000 00000000 00000000
> > >   [... more CMD52 omitted ...]
> > >   new high speed SDIO card at address 0001
> > >
> > > Fixes: ed80a13bb4c4c9 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
> > > Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > ---
> > > Ulf, I consider this non-critical because as long as the meson-mx-sdhc
> > > driver is not merged we only have one MMC driver for these platforms.
> > > I don't know anybody to prefer SDIO wifi over SD card access, so this
> > > can go into -next (in my option at least).
> > >
> >
> > Alright, applied for next, thanks!
> thank you for taking this patch!
>
> I received a confirmation (off-list) saying that this patch works as it should.
> Tobias was not Cc'ed on the original mail so he gave me to permission
> (again, off-list - he's Cc'ed now) to add his:
> Tested-by: Tobias Baumann <017623705678@o2online.de>

I will add it next time I rebase my branch, probably on Monday, thanks!

Kind regards
Uffe
