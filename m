Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825C8C6FA99
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 18:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbjCLSbq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 14:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbjCLSba (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 14:31:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0673B3C3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:27:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i9so348242wrp.3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678645559;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=qQ4knfObBpY3x3MuAG/35lWw0ENhfRadHBJvDnaPA0rK5CRD9vvoYJ+NhZyXUSETzd
         veZ36ZdELbbTt0tsPo2vd6v5gWssHH1Gmx1kUMQaIHJMQGy4MYrChjyPG5GVhcpzGb9v
         Tjj+1ujeTi09TaHzjw0dSbKyg88/SwTz43EzTvWTDrCn2Z0cTmQFop5QO6IBgn/9B9IB
         6ocyN92cS9b2QT2A4lZkXHfclh1CY8JQR55g6xws4UTlSSKN/eoeyzHvDBZaZVRmG7Oo
         bD5G5R1OV2/1ov1YVjBMUnU3Ov4wKSHbPNPEWtP306hO+3yqt0Ojas15a0Vjx2N+5eB+
         M3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678645559;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdTNsWpg9ZM8ehZQeKtTu+6KMOIWutkVZQ0G5s6b6sY=;
        b=Hx3MpqOGXaIvYWqMyIBxiCUm//xWib+tjpwGQ8QhF+gi+6UTYqleQbFI0JERO5w15I
         9qXd90IKBgD0tVBscQw7IsytIKRvfD6EjbDbJ5u1NYFGUo5DJNgVuTgI4+aBjDVB+XMO
         Vjgt6ufIIJnfcSIYt3tYmnLW/2cY/TDFqJZoUb+7hF5Qfl9AqpIFSZ0WXE+35Li5aOUT
         FnvaRz3NxfLanz9B06hFPGCL/1sDSqfrcll5AuWV0+nGpdS0EvVDLXTyf6fyqJbpPNGV
         Bi2yHkpXeXige3ztexALHLArxz2ZNSEzJcrrEUzjaX6nFo9pqpG0fjaGCpRBcm/5aTvh
         oj0w==
X-Gm-Message-State: AO0yUKX0BTjI5lbMP0+YZB15OheBy14sbS3QCERaU5fMQ/CxjS6QmvOg
        63N6xQRv/orB7IAgluutFrTjySppnhcTLMQC
X-Google-Smtp-Source: AK7set+lf1Z3UX+lC0B2q/KNJC0zPTcySYS9tVeis5762sCnBRA+9cngwo/nWevxv/fzYvxoplpL3Q==
X-Received: by 2002:a2e:b891:0:b0:292:8283:2c03 with SMTP id r17-20020a2eb891000000b0029282832c03mr12615806ljp.51.1678644623052;
        Sun, 12 Mar 2023 11:10:23 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id c3-20020a2e9d83000000b0029352fc39fbsm700236ljj.63.2023.03.12.11.10.22
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 11:10:22 -0700 (PDT)
Message-Id: <1678644516.665314-0-sleirsgoevy@gmail.com>
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


