Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4F7C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 20:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9344D21775
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 20:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m2Usgw6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEHUbb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 16:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726843AbgEHUba (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 16:31:30 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E669C061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 13:31:30 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id f12so2328943edn.12
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GYXYNWrnw0dScJyw6USP6AxBibv0CM9pdguCkRq4Xcs=;
        b=m2Usgw6ZygeRrGoiBrwRMuZLF4uIxyh8A2N2kY0wxhR69ClIkkQp3tuvVeNf0O+Okt
         zeUqvCBpstXULKNFI+L6OHr0HdZG5VPpxE4n+U2HyE78lAO26L+vKRAtgD6WJvPMtDgE
         SKoBwCUV6aIGHKNv3lMtfbKXve3XLzTye11Ys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GYXYNWrnw0dScJyw6USP6AxBibv0CM9pdguCkRq4Xcs=;
        b=I82jP3nox/3EatWBIJyCDVrdCgjTMYGvzwpuDzrx6IIY3f1IAlrg8/W8n3Ppt81aMB
         sOZF/23kdmGG+EfbBQoTmVh6K4DeGuHJMO0kUwjsRGlqYbZThu1sRcw64D73zxkvfVy3
         +PF+B5Zj5Zsq5kbvFw8x/MIXwxOGB6QiA5lIV4faFoB8AZwGK09N+Wsfz5ciazVj2bvt
         OWwRHZIelU19viQD8CMiGIxGGDCHRFOCaBwJHF57hOgtOetEZy8YF6fTtlY5D5GIrFiW
         sRs/i3KO2TNEh54zBV65XJptjxtz48Ia9VG/9aEX4r/sa4UGhrUiM+c2VmR6h8uo90q9
         mA7Q==
X-Gm-Message-State: AGi0Pubx/jA6MEHYaOWYKSSE5eiytzr7YN4NSfihRbF3+E6joKhiZJbh
        CsBCqRXCUAd4QBnWsi0VC8asLq5sRbQ=
X-Google-Smtp-Source: APiQypKhvQzfSCF1D1EoVNaoi0D8lt4+iWH0BhVFI+VJIUMNktpZizKjDBg/wFENbOYBaIGtbK7jaw==
X-Received: by 2002:a50:9e6a:: with SMTP id z97mr3602854ede.375.1588969887350;
        Fri, 08 May 2020 13:31:27 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id sb17sm269214ejb.75.2020.05.08.13.31.26
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 13:31:26 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id l3so2331686edq.13
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 13:31:26 -0700 (PDT)
X-Received: by 2002:a05:6402:1587:: with SMTP id c7mr3579723edv.61.1588969886000;
 Fri, 08 May 2020 13:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de> <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
 <CAHQZ30CHSYYZS8TBrKXw_QTEUk+Afbazwko34fdjyi0+Xm+OHw@mail.gmail.com> <20200508185326.GN185537@smile.fi.intel.com>
In-Reply-To: <20200508185326.GN185537@smile.fi.intel.com>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 8 May 2020 14:31:14 -0600
X-Gmail-Original-Message-ID: <CAHQZ30Cr=HgUN3uEe4J1GmpN1dUZw7uGKyMheYCWQ=J1_1TUSw@mail.gmail.com>
Message-ID: <CAHQZ30Cr=HgUN3uEe4J1GmpN1dUZw7uGKyMheYCWQ=J1_1TUSw@mail.gmail.com>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Joerg Roedel <jroedel@suse.de>, linux-mmc@vger.kernel.org,
        Tom Murphy <murphyt7@tcd.ie>,
        Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> It seems the _UID() in case of matching is present and not empty ("0" vs. "").
> The question is why we have no UID is not there?

Looking at the IOMMU IVRS spec:
```
Unique ID Format
0= UID not present
1= UID is an integer
2= UID is a character string
```

So it's optional. I added a bit of logging here:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/iommu/amd_iommu_init.c;l=1353

```
[   11.730159] AMD-Vi: UID is not present.
[   11.734422] AMD-Vi:   DEV_ACPI_HID(AMDI0040[])               devid: 00:13.1
[   11.740913] AMD-Vi: ivrs, add hid:AMDI0040, uid:, rdevid:152
```

> The quick fix looks like
>
> -               if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
> +               if (acpi_dev_hid_uid_match(adev, p->hid, *p->uid ? p->uid : NULL)) {
>
> Can you test it?
>

Your patch works and fixes the matching. Thanks!
