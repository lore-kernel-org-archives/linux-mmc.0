Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6DEC38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 21:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A5552173E
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 21:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JZkj3f8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgEHVJT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 17:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHVJT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 17:09:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CE5C061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 14:09:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s9so2450379eju.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 14:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYNow1O967GcEu/bIxfxl+jbMiO9U7jzDDXb5QD1Jjw=;
        b=JZkj3f8NeZbdXgRt8za83+21BOIJTaQ8FrdabKuNv+aVTkAdFx5AEu8q4ujasG0ERD
         /RD9Vzep3y2rjBlNjxQf2FxIkgKJtb0lPjki8K6nMBjApkQWZk5Z7JzCthGMVCiPkuqY
         0fjJGqBcGuYAm9voqt0GTvQ0A27rOfFUa/9Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYNow1O967GcEu/bIxfxl+jbMiO9U7jzDDXb5QD1Jjw=;
        b=gDPU2E+6B9iJHccgYvCAblKmF/d6ZVhtmuK3tuTXd1fS8J6aFBf7ndAPyVwjsehQAB
         1jIYgaP5qOtcXTL4NgbySkmwZGoTBiyaVVOvXSIrPwKR8EPiqS4kh06KvQWg7h35+tJH
         KS8uE+THd02KMtZCcFlQ/HRbStZNODEpRgEFowUhx8PqQhTyvsWIHyC4gyWuj7OFdCD8
         ZIcKcd4BJze2cGxKFSzR3WVFYPXmoEGsPw0C2+7m6YE3U7FyJnAjv2ahvLjhXSsDfFBo
         +6gUcw7MD5IvxCb9SSAY4Wn8JYraQ7zCrBDWyJm6Q7Uk+HWljA8P6ZUz+tbE82s3anst
         EbAA==
X-Gm-Message-State: AGi0PuYXTLe8DDv69ejslNGirvecWmcM25qcM2cgjFSaVuWMxXq8oT4b
        mSdtlxzQsPDAr9ANnpWJ61swQRx068U=
X-Google-Smtp-Source: APiQypJOACmrC3a7nEl50FsxLTOdJqUEqCUzh11WLDZmSJxwwIsUf+mZ0764bSMMNSKGk4hfXrmbhQ==
X-Received: by 2002:a17:906:6b1b:: with SMTP id q27mr3534468ejr.158.1588972157351;
        Fri, 08 May 2020 14:09:17 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id m5sm280031ejk.27.2020.05.08.14.09.16
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 14:09:16 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id w2so2444457edx.4
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 14:09:16 -0700 (PDT)
X-Received: by 2002:a05:6402:44f:: with SMTP id p15mr3696605edw.87.1588972155864;
 Fri, 08 May 2020 14:09:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de> <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
 <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
In-Reply-To: <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 8 May 2020 15:09:04 -0600
X-Gmail-Original-Message-ID: <CAHQZ30DXbDiAEXWVAv1V-wiEYm7=rrRj6k224reXvHDWe6bcow@mail.gmail.com>
Message-ID: <CAHQZ30DXbDiAEXWVAv1V-wiEYm7=rrRj6k224reXvHDWe6bcow@mail.gmail.com>
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

> > > Two possibilities:
> > >
> > >         1) Please try the 5 patches from this branch:
> > >            https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=iommu/fixes
> > >
> > >            The fix some race-condition issues, I think it is unlikely
> > >            you hit them, but it is worth a test.
> > >
> > >         2) Dma-iommu code does sg-merging, which the previous DMA-API
> > >            implementation did not. Can you try attached diff from Robin
> > >            Murphy to disable sg-merging? It that helps it is an issue in
> > >            the eMMC driver.
> > >
> > > Regards,
> > >
> > >         Joerg
> > >
> > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > index a2e96a5fd9a7..a6b71bad518e 100644
> > > --- a/drivers/iommu/dma-iommu.c
> > > +++ b/drivers/iommu/dma-iommu.c
> > > @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct
> > > scatterlist *sg, int nents,
> > >                  * - but doesn't fall at a segment boundary
> > >                  * - and wouldn't make the resulting output segment too long
> > >                  */
> > > -               if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > > +               if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> > >                     (max_len - cur_len >= s_length)) {
> > >                         /* ...then concatenate it with the previous one */
> > >                         cur_len += s_length;
> > > @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct
> > > scatterlist *sg, int nents,
> > >                 if (s_length + s_iova_off < s_iova_len)
> > >                         cur_len = 0;
> > >         }
> > > +       WARN_ON(count < nents);
> > >         return count;
> > >   }

So I tried the 5 patches you listed in 1, and the patch in 2. It still
results in the same failure.

Here is a cleaner link to the trace: https://0paste.com/66912

It's pretty straight forward:

 0)               |        /* iommu_dma_alloc: sdhci-acpi AMDI0040:00:
size: 3596 */
 0)               |                              /* iommu_dma_map_sg:
sdhci-acpi AMDI0040:00: nents: 1 */
 0)               |                            /* sdhci_set_adma_addr:
dma_addr: 0xfffffffffffff200 */
 0)               |      sdhci_adma_show_error() {


I'm going to try reverting be62dbf554c5 now that we know why the ACPI
matching wasn't working.
