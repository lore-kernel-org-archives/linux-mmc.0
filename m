Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD57DC38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 21:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8541B218AC
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 21:45:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ad/FVPCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgEHVpF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 17:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgEHVpE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 17:45:04 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19EF4C061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 14:45:04 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id pg17so2497242ejb.9
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 14:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=toR4px5zKHyRFFe60UxbLZe9iVSlsn5za2Z886lbDXo=;
        b=Ad/FVPCRpTte8m/WOSBVLlNMA3Q2ZRAFJa3RIuSggre3QEAg139dHib9wyRfbHRgF+
         44rI5lCol+jZcTHJNuKUB4CDtoxeq38sb13f7fA11vl+6iO07koF4fTmfDlI0dKm39yx
         /aNFNIWWwiQNrmixQ7MfFCaKg5EHznUMVy5rQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=toR4px5zKHyRFFe60UxbLZe9iVSlsn5za2Z886lbDXo=;
        b=DmTr9TIBpBNVVStRX10ZYgtQ22kPlmSFFRShrFVTlx/08Ghv9QzJBb7/g9DulRTFjz
         LPHZmxdn5zR1UUJEtkGTR+KRadxhAvPTyb2ePr9IWAy+RexzoqHiEFSRmM3Cx3XTtRBD
         YaqBGKVsCaqZGbhRkD8DH9vuqoz/VWM1hxZdHDKNpY0Jv/dsrGJ2/rTT7forTdl374gJ
         3V3iGzeLAovjVQYFO+pm3ZaP83QDrVPvTs3ACweodgreXqgHv4o2419e1IhRKMBI1SiE
         IeZul1j9vgVjXIa7xLJcC7TkFPzERXnPAeUMP8RmZ4Yjawy6Vc3xMUlBvfrm4ymbyYvY
         Z+yA==
X-Gm-Message-State: AGi0PubuKL6b2W9DOdV+Nm/XLjaFhpeqnHKG0QzNyg+03KPDq9y6CBKl
        Uo8K4DtmqicFcwDKaHIMar+iaiaR4/k=
X-Google-Smtp-Source: APiQypJL/D4x8bGfVai+2+MPpYLGogGSdAhsX29UzTlTIBWcmRIVtLlKDkIhb0gzqhzbLfXXN1iocA==
X-Received: by 2002:a17:907:4272:: with SMTP id nq2mr3787777ejb.205.1588974302270;
        Fri, 08 May 2020 14:45:02 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id dr8sm281203ejc.18.2020.05.08.14.45.01
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 14:45:01 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id l3so2491462edq.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 14:45:01 -0700 (PDT)
X-Received: by 2002:a50:c01a:: with SMTP id r26mr4047731edb.361.1588974300868;
 Fri, 08 May 2020 14:45:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de> <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
 <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com> <CAHQZ30DXbDiAEXWVAv1V-wiEYm7=rrRj6k224reXvHDWe6bcow@mail.gmail.com>
In-Reply-To: <CAHQZ30DXbDiAEXWVAv1V-wiEYm7=rrRj6k224reXvHDWe6bcow@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 8 May 2020 15:44:49 -0600
X-Gmail-Original-Message-ID: <CAHQZ30AGYVGE-0AWdOLyPGhjwsiz+B7=ni4tnY8Hjxa62x19Cg@mail.gmail.com>
Message-ID: <CAHQZ30AGYVGE-0AWdOLyPGhjwsiz+B7=ni4tnY8Hjxa62x19Cg@mail.gmail.com>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-mmc@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

So with the following CLs + the fix for the ACPI name matching:
f9d9f441a7a Revert "iommu/amd: Convert AMD iommu driver to the dma-iommu api"
f3ed2aa65e67 Revert "iommu: amd: Use generic_iommu_put_resv_regions()"
47cf1b422e60 (origin/master) Merge branch 'for-linus' of
git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid

Everything works correctly.

Here is the trace for the working scenario: https://0paste.com/66921

The big difference is the 32 bit address vs the 64 bit address.

Without be62dbf554c5 we get the following: adma_addr:
0x00000000fffff200. While with it we get 0xfffffffffffff200

I tried adding SDHCI_QUIRK2_BROKEN_64_BIT_DMA to
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci-acpi.c;l=607
and it worked!

So it looks like be62dbf554c5 made it so it starts honoring
`dma_set_mask_and_coherent`. This exposed a hardware quirk that was
missing.

I'll get some patches pushed up.

On Fri, May 8, 2020 at 3:09 PM Raul Rangel <rrangel@chromium.org> wrote:
>
> > > > Two possibilities:
> > > >
> > > >         1) Please try the 5 patches from this branch:
> > > >            https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=iommu/fixes
> > > >
> > > >            The fix some race-condition issues, I think it is unlikely
> > > >            you hit them, but it is worth a test.
> > > >
> > > >         2) Dma-iommu code does sg-merging, which the previous DMA-API
> > > >            implementation did not. Can you try attached diff from Robin
> > > >            Murphy to disable sg-merging? It that helps it is an issue in
> > > >            the eMMC driver.
> > > >
> > > > Regards,
> > > >
> > > >         Joerg
> > > >
> > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > index a2e96a5fd9a7..a6b71bad518e 100644
> > > > --- a/drivers/iommu/dma-iommu.c
> > > > +++ b/drivers/iommu/dma-iommu.c
> > > > @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct
> > > > scatterlist *sg, int nents,
> > > >                  * - but doesn't fall at a segment boundary
> > > >                  * - and wouldn't make the resulting output segment too long
> > > >                  */
> > > > -               if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > > > +               if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > > >                     (max_len - cur_len >= s_length)) {
> > > >                         /* ...then concatenate it with the previous one */
> > > >                         cur_len += s_length;
> > > > @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct
> > > > scatterlist *sg, int nents,
> > > >                 if (s_length + s_iova_off < s_iova_len)
> > > >                         cur_len = 0;
> > > >         }
> > > > +       WARN_ON(count < nents);
> > > >         return count;
> > > >   }
>
> So I tried the 5 patches you listed in 1, and the patch in 2. It still
> results in the same failure.
>
> Here is a cleaner link to the trace: https://0paste.com/66912
>
> It's pretty straight forward:
>
>  0)               |        /* iommu_dma_alloc: sdhci-acpi AMDI0040:00:
> size: 3596 */
>  0)               |                              /* iommu_dma_map_sg:
> sdhci-acpi AMDI0040:00: nents: 1 */
>  0)               |                            /* sdhci_set_adma_addr:
> dma_addr: 0xfffffffffffff200 */
>  0)               |      sdhci_adma_show_error() {
>
>
> I'm going to try reverting be62dbf554c5 now that we know why the ACPI
> matching wasn't working.
