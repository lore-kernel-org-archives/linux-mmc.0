Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A2DC6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 13:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCLNKT (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCLNKT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 09:10:19 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074D846097
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:10:18 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d36so12420100lfv.8
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678626616;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2tChENWyDZGQKa5Zk1lhzLBop14+1J962hBMY2G3xM=;
        b=VbTSC1wjrwcnZ6PDtbzrfyxQ08Dk5WFs4cg0nhO97wBuxrf+5b7tdtUDDy3YPOQbiZ
         i5m8sDK/dfp0dyA/OwTI8c2r5AqMj9sA9kKNhb+Vrx70xr79fbYVFrwtRTK+HLFq+OAQ
         xnTOVihs7ZHohiBbj/wnkSywVzdg4PmWcktXAYDV43pwvPN7ZjxF2QfxkMQEPs1UIG3k
         6rnwual4St+OgcwtX3OcVAjsR9kk7K/ULr2FgLwsrdPMYv0nrFz6Of9O2clpt4tERaXS
         3JKZJYEymjk8x2gaphKERftkrybVz/AU+pgdQUTYAVMe5XctDjhUwyfldEf5NIbTsyIN
         1/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678626616;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2tChENWyDZGQKa5Zk1lhzLBop14+1J962hBMY2G3xM=;
        b=yMrZW1TY3NadZ8I9UeY6HT69h24QNI/GmiKYpu5sOR5aBCd2R6Cs95BcRi115b1Mw9
         ZcYPQmGr5TBL9JyHqc+zwvtxsSBNHovHy9VTC0D1reLbRK4gVixrGBE8Mdf49ujZPS/4
         ammkID+6XnvnmdAhxNzDj/4X1QtZOvlQ3VqJTtUk1aHnymSMu1ROvp4ME7ftU0B3vDVg
         RVy6gco2IAdvYtO4CVuqksjrJLRt7pRaDfGWkAoOqbdI4If8cyLCAqtLzwgaKLwF2HWj
         5KmkBR5LqpEW07sD2eC1g3a7Aj5h6S3Tqk8PuDkskFznBpxYyGhXO5UYR2Pd7uVXttSi
         C+2g==
X-Gm-Message-State: AO0yUKW479O0O7qS3JJWxltWwa5a1Wex4CVbhqyRwyO90uPCDweBiufT
        ycbanYpEbTpglTvAD9RPlK6kKGL4wreeoG+f
X-Google-Smtp-Source: AK7set8QkoXKQHKT0kCoku7Q9zkecW+NTN6MS02hQ4PIkqu6oOv1bUwtiFZbvcAtoLAkSJyj4siGfg==
X-Received: by 2002:a19:ae15:0:b0:4b5:9b8f:cc82 with SMTP id f21-20020a19ae15000000b004b59b8fcc82mr8230601lfc.0.1678626616101;
        Sun, 12 Mar 2023 06:10:16 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id m4-20020ac24244000000b004d61af6771dsm644981lfl.41.2023.03.12.06.10.15
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 06:10:15 -0700 (PDT)
Message-Id: <1678626510.1783316-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 16:03:15 +0300
Subject: [PATCH v3 0/2] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems 
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

DesignWare MMC cores have a configurable data bus width of either 16, 32, or 64
bytes. It is possible, and some vendors actually do it, to ship a DW MMC core
configured for 32-bit data bus within a 64-bit SoC. In this case the kernel
will attempt 64-bit (readq) accesses to certain 64-bit MMIO registers, while
the core will expect pairs of 32-bit accesses.

It seems that currently the only register for which the kernel performs 64-bit
accesses is the FIFO. The symptom is that the DW MMC core never receives a read
on the second half of the register, does not register the datum as being read,
and thus not advancing its internal FIFO pointer, breaking further reads. It
also seems that this FIFO is only used for small (less than 16 bytes)
transfers, which probably means that only some SDIO cards are affected.

Changelog:

v3:
- removed "fifo-access-32bit" devicetree property
- added "samsung,exynos78xx-dw-mshc" compatible string
- added "samsung,exynos78xx-dw-mshc-smu" compatible string

v2:
- added commit messages

v1:
- added "fifo-access-32bit" devicetree property
- added DW_MMC_QUIRK_FIFO64_32
- added new dw_mci_{pull,push}_data* variants (...-data64_32)

Sergey Lisov (2):
  dt-bindings: exynos-dw-mshc-common: add exynos78xx variants
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  41 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.38.3


