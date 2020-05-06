Return-Path: <SRS0=wp20=6U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5356C28CBC
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC99F207DD
	for <linux-mmc@archiver.kernel.org>; Wed,  6 May 2020 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dX6R/hSQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgEFVAj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 6 May 2020 17:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728535AbgEFVAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 6 May 2020 17:00:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F59BC061A0F
        for <linux-mmc@vger.kernel.org>; Wed,  6 May 2020 14:00:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w2so3337278edx.4
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2020 14:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BWkEDRcCLnDyTvsta1O6uzyqwD21wsx5lQFKk6NnF4g=;
        b=dX6R/hSQOijbffGXFnHpfY93Q/7sv6m+rhabyPGSUiA/mKsVOf1KLZ90eAuKlNuIhT
         saoV5VMFf6o+gJYThzjcIz89UTaoCebaUJNnRgBNRUh95+vgFf/UM4X0VSV7Posemobq
         3yfejkUGLAnkZVbnHrgoOUKCc3yyRliN0RWvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BWkEDRcCLnDyTvsta1O6uzyqwD21wsx5lQFKk6NnF4g=;
        b=WH1elTrDXoOvQhE2/nfrkUvu3DOVcVKED4CYEYfwrBknNxKEfV3o0XDYPyjC4PRKS2
         eE3L9qyeVKyngmnFFgj+D8rnv07xO2YFIDap9CItlR6e6UHjz3uZdOBmJUv1SUdXqoDM
         qEjtyG/g9DccEdQqlPswipFVlk0rVQTJAVd/hI5tuPGzRPxviy80tBn6P7PWDwZh6+wV
         x4twe0HcQcaulyXmPWtf2bVsI6xJ91Cmf+iHvfA5zLs+iEplIeG/rfmZiD6787mAAfn5
         2Ke2zeIzEYiksGKEIN6PldMUpY5qtYgPrZYLyeMvJQt7wc1k3GNR2+P6w0v1Q4QjNdON
         +DfA==
X-Gm-Message-State: AGi0PuZq6iN26Au78LKnqVKV4tGDqmpnuYvCp+E2qS6TeCCKmHmFpr2k
        v30vS8VJKlDV2pNar3r8oJe2ohKumM0=
X-Google-Smtp-Source: APiQypLfIDLiqTgUs1bc4Z0UxGv+NasnXaHf45KPBH9Vjp0+GbBlCXRKrKDDV1UZAovcNpgcv6vbrQ==
X-Received: by 2002:a05:6402:1713:: with SMTP id y19mr9281915edu.40.1588798835367;
        Wed, 06 May 2020 14:00:35 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id a15sm286183edf.44.2020.05.06.14.00.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 14:00:34 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id a8so3346635edv.2
        for <linux-mmc@vger.kernel.org>; Wed, 06 May 2020 14:00:33 -0700 (PDT)
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr8424445edm.87.1588798833034;
 Wed, 06 May 2020 14:00:33 -0700 (PDT)
MIME-Version: 1.0
From:   Raul Rangel <rrangel@chromium.org>
Date:   Wed, 6 May 2020 15:00:21 -0600
X-Gmail-Original-Message-ID: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
Message-ID: <CAHQZ30CXW7W6Wv12u45Mpn4+_oQhcR=_hpu-gOv8PqvajnLC4Q@mail.gmail.com>
Subject: Problems using AMD eMMC with AMD IOMMU
To:     linux-mmc@vger.kernel.org
Cc:     murphyt7@tcd.ie, jroedel@suse.de, dianders@chromium.org,
        evgreen@chromium.org, Daniel Kurtz <djkurtz@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tip of Tree (47cf1b422e60) I'm seeing the following IOMMU error
when enumerating my eMMC device:

[   13.097314] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA 64-bit
[   13.104550] mmc1: SDHCI controller on ACPI [AMDI0040:00] using ADMA 64-bit
[   13.136359] mmc1: Allocated DMA: align_addr: 0x000000041ab55000,
adma_addr: 0x000000041ab55200, dma_size: e0c. <- I added this to
sdhci_setup_host
[   13.340852] mmc1: ADMA error: 0x02000000
[   13.344780] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
[   13.351222] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00001002
[   13.357669] mmc1: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000001
[   13.364118] mmc1: sdhci: Argument:  0x00000000 | Trn mode: 0x00000013
[   13.370567] mmc1: sdhci: Present:   0xf1ff0000 | Host ctl: 0x00000019
[   13.377014] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
[   13.383463] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x0000fa07
[   13.389911] mmc1: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
[   13.396360] mmc1: sdhci: Int enab:  0x03ff000b | Sig enab: 0x03ff000b
[   13.402808] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   13.409257] mmc1: sdhci: Caps:      0x71fec8b2 | Caps_1:   0x00000577
[   13.415706] mmc1: sdhci: Cmd:       0x0000083a | Max curr: 0x00c80064
[   13.422154] mmc1: sdhci: Resp[0]:   0x00000700 | Resp[1]:  0xffffffff
[   13.428603] mmc1: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x00d00f00
[   13.435048] mmc1: sdhci: Host ctl2: 0x00000000
[   13.439506] mmc1: sdhci: ADMA Err:  0x00000001 | ADMA Ptr: 0x000000041ab55200
[   13.446641] mmc1: sdhci: ============================================
[   13.453077] mmc1: sdhci: 41ab55200: DMA 0x000000041a462400, LEN
0x0200, Attr=0x21
[   13.460551] mmc1: sdhci: 41ab5520c: DMA 0x0000000000000000, LEN
0x0000, Attr=0x03
[   13.468070] AMD-Vi: Event logged [IO_PAGE_FAULT device=00:13.1
domain=0x0000 address=0x41ab55200 flags=0x0050]
[   13.478109] mmc1: error -5 whilst initialising MMC card

If I read the error correctly (not sure), it looks like the ADMA
descriptor was at 0x41ab55200. The fault was also for 0x41ab55200.

Decoding the flags:
2.5.3 IO_PAGE_FAULT Event
* PE (peripheral did not have the permissions required to perform the
transaction)
* PR (transaction was to a page marked as present (including V=1b in
DTE) or interrupt marked as remapped (RemapEn=1)).

So it looks like the eMMC controller had a page fault trying to read
the DMA descriptor. Is this a known issue? Does anyone have any
suggestions?

I little background:
We recently cherry-picked `be62dbf554c5 iommu/amd: Convert AMD iommu
driver to the dma-iommu api` into the chromiumos 5.4 tree:
https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2169153
This caused the eMMC page faults to start happening on boot. When we
reverted the patch from our tree the problems went away.

When I tried on ToT, I saw the same errors. So I reverted be62dbf554c5
from my ToT branch expecting the errors to go away, but they remained.
So this makes me wonder if we are missing an mmc patch or the iommu
wasn't working correctly on 5.4 before we landed be62dbf554c5. I
looked through the recent mmc patches, but didn't see anything that
stood out.

This is the driver we are using:
https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/third_party/kernel/v5.4/drivers/mmc/host/sdhci-acpi.c;l=607

Any suggestions would be appreciated.
