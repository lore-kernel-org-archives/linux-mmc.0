Return-Path: <SRS0=NqgV=6W=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2559C38A2A
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 15:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20E22173E
	for <linux-mmc@archiver.kernel.org>; Fri,  8 May 2020 15:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMJYNtNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgEHPrI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 8 May 2020 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728148AbgEHPrH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 8 May 2020 11:47:07 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615DBC061A0C
        for <linux-mmc@vger.kernel.org>; Fri,  8 May 2020 08:47:07 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id d16so1577011edq.7
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 08:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tIrKeDRiYu5Cj7jGJ69Oqt3uyuasZH+yerl3HPEcWYU=;
        b=BMJYNtNrZcW0/Biiei3BolRzUBo8a+8BuIDpM+PGNBLFZ4hgCHQoNepQPG7vGIiv9j
         XBgZHggcY7wujL0fqW7T4kD86PfWmNgeys1WnU2OUhA9st68+yu3ys0d/KLnqgOCKIJi
         mVYPIKGuSNy5oGc2C0alLNQR8aqgtOTfJ+n3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tIrKeDRiYu5Cj7jGJ69Oqt3uyuasZH+yerl3HPEcWYU=;
        b=FWOwn6r/tip4kFT4lNP5GEb/uswJJI++9WAZozErwNz1KBcOftP1IHYbergbGxYFMZ
         M8JY6u0HtgSL06pJ3vyasY1jOEkgohE8TcrfvPXgtlCnG7TvsXxfnnaYk6p7fn/xqEkX
         boxYuSMKpWhLH3pouAAS+6xWQWXXE8bWxA7UCtICK4UVyxt/HO3AXFejLWatt/O/1WL9
         9qCIUrQgaTLBFsrS7z/y1KtX3e96x805asjhvVGknQHzUB7XPCoB+QpD4LlPTTAs9SSn
         0kMf8RKFxFMOtWS/HeEB8UKyjLn0K/Qmwt+DtMofz1mkYUMQl69DhGpE7zTNlj7KlqGY
         vc0Q==
X-Gm-Message-State: AGi0PuZYbBtM50CDWHZ0aHwdDOBYErNL5GQD599mii6VJ5G5qmtguM3Z
        ehviGo/VUeia3aGbQOom6hFtH3Dxifk=
X-Google-Smtp-Source: APiQypLmEQKssfybLWl4CVCZjSOdazAIEiA2NTmeT3Tng/JT8GKebXPF28WMnLXyMsXSt/CM5Ecifw==
X-Received: by 2002:a05:6402:1d88:: with SMTP id dk8mr2776013edb.52.1588952825483;
        Fri, 08 May 2020 08:47:05 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id w8sm301519edq.80.2020.05.08.08.47.04
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2020 08:47:04 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id s9so1604369eju.1
        for <linux-mmc@vger.kernel.org>; Fri, 08 May 2020 08:47:04 -0700 (PDT)
X-Received: by 2002:a17:906:4548:: with SMTP id s8mr2291493ejq.349.1588952823434;
 Fri, 08 May 2020 08:47:03 -0700 (PDT)
MIME-Version: 1.0
References: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
 <20200508152236.GQ8135@suse.de>
In-Reply-To: <20200508152236.GQ8135@suse.de>
From:   Raul Rangel <rrangel@chromium.org>
Date:   Fri, 8 May 2020 09:46:52 -0600
X-Gmail-Original-Message-ID: <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
Message-ID: <CAHQZ30BkdaiTfCY0XsgTQW3g1n_BQoRtNnj0L4-EVAG1HZonUQ@mail.gmail.com>
Subject: Re: Problems using AMD eMMC with AMD IOMMU
To:     Joerg Roedel <jroedel@suse.de>
Cc:     linux-mmc@vger.kernel.org, Tom Murphy <murphyt7@tcd.ie>,
        Douglas Anderson <dianders@chromium.org>, evgreen@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Thanks for the suggestions. I will try them out. I did some more
digging yesterday and it looks like the device isn't getting
associated with the IOMMU. I added some extra logging.

[   11.670073] AMD-Vi: Using IVHD type 0x40
[   11.674766] AMD-Vi: device: 00:00.2 cap: 0040 seg: 0 flags: b0 info 0000
[   11.682232] AMD-Vi:        mmio-addr: 00000000fd200000
[   11.687952] AMD-Vi:   DEV_SELECT_RANGE_START  devid: 00:01.0 flags: 00
[   11.695219] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.6
[   11.701267] AMD-Vi:   DEV_ALIAS_RANGE                 devid:
ff:00.0 flags: 00 devid_to: 00:14.4
[   11.709699] AMD-Vi:   DEV_RANGE_END           devid: ff:1f.7
[   11.715224] AMD-Vi:   DEV_SPECIAL(HPET[0])           devid: 00:14.0
[   11.721327] AMD-Vi:   DEV_SPECIAL(IOAPIC[33])                devid: 00:14.0
[   11.727720] AMD-Vi:   DEV_ACPI_HID(AMDI0040[])               devid:
00:13.1 <- You can see the ACPI ID in the IVRS table.
[   11.734211] AMD-Vi: ivrs, add hid:AMDI0040, uid:, rdevid:152
[   11.913253] pci 0000:00:00.2: AMD-Vi: IOMMU performance counters supported
[   11.920969] pci 0000:00:01.0: AMD-Vi: Init IOMMU for device
[   11.927224] pci 0000:00:01.0: Adding to iommu group 0
[   11.932910] pci 0000:00:01.0: AMD-Vi: IOMMU set to DMA
[   11.938635] pci 0000:00:01.2: AMD-Vi: Init IOMMU for device
[   11.944858] pci 0000:00:01.2: Adding to iommu group 1
[   11.950527] pci 0000:00:01.2: AMD-Vi: IOMMU set to DMA
[   11.956257] pci 0000:00:01.3: AMD-Vi: Init IOMMU for device
... More PCI
[   12.244008] pci 0000:02:00.0: Adding to iommu group 10
[   12.249784] pci 0000:02:00.0: AMD-Vi: IOMMU set to DMA
[   12.255514] pci 0000:03:00.0: AMD-Vi: Init IOMMU for device
[   12.261736] pci 0000:03:00.0: Adding to iommu group 11
[   12.267519] pci 0000:03:00.0: AMD-Vi: IOMMU set to DMA
[   12.273261] pci 0000:04:00.0: AMD-Vi: Init IOMMU for device
[   12.279568] pci 0000:04:00.0: Adding to iommu group 12
[   12.285427] pci 0000:04:00.0: Using iommu direct mapping
[   12.291336] pci 0000:04:00.0: AMD-Vi: IOMMU set to passthrough
[   12.297833] pci 0000:04:00.1: AMD-Vi: Init IOMMU for device
[   12.304087] pci 0000:04:00.1: Adding to iommu group 13
[   12.309852] pci 0000:04:00.1: AMD-Vi: IOMMU set to DMA
[   12.315576] pci 0000:04:00.2: AMD-Vi: Init IOMMU for device
... Even More PCI
[   12.415860] pci 0000:04:00.7: AMD-Vi: IOMMU set to DMA
[   12.421586] pci 0000:05:00.0: AMD-Vi: Init IOMMU for device
[   12.427815] pci 0000:05:00.0: Adding to iommu group 14
[   12.433589] pci 0000:05:00.0: AMD-Vi: IOMMU set to DMA
[   12.439583] pci 0000:00:00.2: AMD-Vi: Found IOMMU cap 0x40
[   12.445687] pci 0000:00:00.2: AMD-Vi: Extended features (0x4f77ef22294ada):
[   12.453433]  PPR NX GT IA GA PC GA_vAPIC
[   12.457898] AMD-Vi: Lazy IO/TLB flushing enabled
[   12.464067] amd_uncore: AMD NB counters detected
[   12.469208] amd_uncore: AMD LLC counters detected
[   12.474453] perf/amd_iommu: Detected AMD IOMMU #0 (2 banks, 4 counters/bank).

Never saw the ACPI device listed.

Listing sysfs I don't see iommu either:

$ find /sys/ -iname iommu
/sys/kernel/debug/tracing/events/iommu
/sys/kernel/debug/iommu
/sys/class/iommu
/sys/devices/pci0000:00/0000:00:08.0/iommu
/sys/devices/pci0000:00/0000:00:18.3/iommu
/sys/devices/pci0000:00/0000:00:01.2/0000:01:00.0/iommu
/sys/devices/pci0000:00/0000:00:01.2/iommu
/sys/devices/pci0000:00/0000:00:18.1/iommu
/sys/devices/pci0000:00/0000:00:01.0/iommu
/sys/devices/pci0000:00/0000:00:14.3/iommu
/sys/devices/pci0000:00/0000:00:01.7/0000:03:00.0/iommu
/sys/devices/pci0000:00/0000:00:01.7/iommu
/sys/devices/pci0000:00/0000:00:00.2/iommu
/sys/devices/pci0000:00/0000:00:18.6/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.7/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.5/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.3/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.1/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.6/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.4/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.2/iommu
/sys/devices/pci0000:00/0000:00:08.1/iommu
/sys/devices/pci0000:00/0000:00:08.1/0000:04:00.0/iommu
/sys/devices/pci0000:00/0000:00:18.4/iommu
/sys/devices/pci0000:00/0000:00:01.3/0000:02:00.0/iommu
/sys/devices/pci0000:00/0000:00:01.3/iommu
/sys/devices/pci0000:00/0000:00:18.2/iommu
/sys/devices/pci0000:00/0000:00:18.0/iommu
/sys/devices/pci0000:00/0000:00:18.7/iommu
/sys/devices/pci0000:00/0000:00:14.0/iommu
/sys/devices/pci0000:00/0000:00:08.2/0000:05:00.0/iommu
/sys/devices/pci0000:00/0000:00:08.2/iommu
/sys/devices/pci0000:00/0000:00:18.5/iommu

I'm going to do a bit more tracing.

I'll post back with what I find and I'll also test the patches you provided.

Thanks

On Fri, May 8, 2020 at 9:22 AM Joerg Roedel <jroedel@suse.de> wrote:
>
> On Wed, May 06, 2020 at 03:00:21PM -0600, Raul Rangel wrote:
> > Any suggestions would be appreciated.
>
> Two possibilities:
>
>         1) Please try the 5 patches from this branch:
>            https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git/log/?h=iommu/fixes
>
>            The fix some race-condition issues, I think it is unlikely
>            you hit them, but it is worth a test.
>
>         2) Dma-iommu code does sg-merging, which the previous DMA-API
>            implementation did not. Can you try attached diff from Robin
>            Murphy to disable sg-merging? It that helps it is an issue in
>            the eMMC driver.
>
> Regards,
>
>         Joerg
>
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index a2e96a5fd9a7..a6b71bad518e 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -779,7 +779,7 @@ static int __finalise_sg(struct device *dev, struct
> scatterlist *sg, int nents,
>                  * - but doesn't fall at a segment boundary
>                  * - and wouldn't make the resulting output segment too long
>                  */
> -               if (cur_len && !s_iova_off && (dma_addr & seg_mask) &&
> +               if (0 && cur_len && !s_iova_off && (dma_addr & seg_mask) &&
>                     (max_len - cur_len >= s_length)) {
>                         /* ...then concatenate it with the previous one */
>                         cur_len += s_length;
> @@ -799,6 +799,7 @@ static int __finalise_sg(struct device *dev, struct
> scatterlist *sg, int nents,
>                 if (s_length + s_iova_off < s_iova_len)
>                         cur_len = 0;
>         }
> +       WARN_ON(count < nents);
>         return count;
>   }
