Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B3EC6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjCLShn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCLShl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:37:41 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F438149AE
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:37:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id j11so40267919edq.4
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678646174;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=RgSBIdonInQy0klj4zDx+qxaxPMhl1aZ33+BkTSiOetgJgw8YiWldWNmnU/PjsMkX9
         skIMkd6xy15nEUXN5HahV5AgFCnsUi+0avZWqKeYiwd2/B8/1zOrwbxWQI3W1O7O2hd8
         osGlrLMyztEZssvFpz37EGHi057Ob7N1PUsfREp3abmzKG2lQBtvS53TT4nD/sxsarq6
         a0jjdk8Hf7b0wCW022+FyTZxKNjB8EsJuhuMet4u38SFXzQrANAxTnYEZV+WiHLoqwiY
         SN7sUXk+SwQLqvf3M7DBJtIdObJNu8DHOFbUtdf0FiPz0ToaNlFV/+FCpkdPdtPDBBHy
         Yn6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678646174;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=h7ChtWugN27mxX050yBP7k+8XAaqCOLsdb8WYxdRthkC+BGzvanry60chYgbm9+IEf
         AQovG3eiMt+uWsdcHW9w/WN50YtGlPUjFDxsKR1UgPJy22Rw8J19eGR0kbFXDbI9Q09L
         Mh76EiJLKnieemfMNifvXthpConXg1PQAMnHBm4L9Q2CIJcmUP9eQm/lO7TjOaH4F6Vp
         1SQ4rq6WGczxCVLIFt7pvdj3nDrgHvh7wQHvUxu76hiNOHaoX7czgXXW2ep5f71AxGWe
         vSuJwBbDtxRQt79OBNmgEaVlcz8WPu5yuhwRH723AVsXyMUG9dlGv3WPVyYGwSpDLC7L
         KQ6g==
X-Gm-Message-State: AO0yUKU+GFKkrD58wQnlarldCTJMDFlobdHDI4zN4ANrY2QECzOT/yMd
        7NOJIFXBD0i+3I+Tsc10hCAQegINklsnyqyk
X-Google-Smtp-Source: AK7set8pAr0TY86u7Q15ofTVSifvEEx4D3Bl2KimG2WclOhDa1DoPyKpoB/+2Z92IT7+Hbm5SWg1cA==
X-Received: by 2002:ac2:44a9:0:b0:4d8:8ad1:a05f with SMTP id c9-20020ac244a9000000b004d88ad1a05fmr8803914lfm.48.1678644269026;
        Sun, 12 Mar 2023 11:04:29 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id o20-20020a056512051400b004db4fa67bf1sm714450lfb.157.2023.03.12.11.04.28
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:04:28 -0700 (PDT)
Message-ID: <640e142c.050a0220.faaed.1a43@mx.google.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 20:58:50 +0300
Subject: [PATCH v5 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems
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

v5:
- rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"
- rename "samsung,exynos78xx-dw-mshc" to "samsung,exynos7885-dw-mshc"

v4:
- split dt-bindings and dts update into separate commits
- add an explanation why it'ss necessary to change the compatible string

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

Sergey Lisov (3):
  dt-bindings: exynos-dw-mshc-common: add exynos7885 variants
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO
  arm64: dts: exynos: fix wrong mmc compatible in exynos7885.dtsi

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  43 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 167 insertions(+), 4 deletions(-)

-- 
2.38.3


