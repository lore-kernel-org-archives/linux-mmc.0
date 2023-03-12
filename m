Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F5FC6FD19
	for <linux-mmc@archiver.kernel.org>; Sun, 12 Mar 2023 17:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCLRCS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Mar 2023 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCLRCQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Mar 2023 13:02:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38137392AE
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:02:15 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id t11so12870894lfr.1
        for <linux-mmc@vger.kernel.org>; Sun, 12 Mar 2023 10:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678640533;
        h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UV8fqbjOdVKsnwcy5S2/ICsUmjKXmCtfZ/sJfhZkPI=;
        b=VUECS5rGvASZ5c+Sa3nm2n41suNVKEgstuUqVSIyi/CWAkGubPG8EMWbet63NEqDuM
         TMdQwUn0a7xxzRkyPt5z/VLL/OU+rJnNsiXc2jWROxERIwS2ejRKNof87/0hk5m4xpKI
         USU+doZprpVMcm+P1bw4+sMd7DN30VjowDa5S9qDKdNFkV3HB0qN9T+lW64kxU0iR20X
         2DkThmavm4Dg1RX4A3OAGqmTz94iS8u2/PMIrpo9X5ldmaXyZZGL4Weq6ZnwBKwJKzbR
         wZ3YOKxJSyu5ub977YqZrftnyMzgFZiq1GPsUUzyue4F0/iPCERe3AqptSyRaASJWPIl
         hfJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678640533;
        h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6UV8fqbjOdVKsnwcy5S2/ICsUmjKXmCtfZ/sJfhZkPI=;
        b=3FSG/T2zhRt+uIuSVsblttcRlssbQRR/FgWGtflDkPlr0ZlSW7mvx2NsD/hLrUMssW
         wgSUjhUgAk17pmhPQNKAZb/NYAy8xKwL7lpQfcXBvh5m8qXGvyCmuK0F0DRpJW5tB+lq
         RLuQZ/Bv0yVRm5M9piU+VtBFkLRJoyn+3ot/s7AnqoeLJ5TvHGddOMaBIs6SuMuyGfaU
         5vjWak7Ysw1pMaKBeaHkW/7HGsT8Pn3mSO5lMs8Eg31KiypLakxRq9DoDYFF5OoP99XI
         ocC3zb5TzreJW3v6/lZKsHLi1jmM54gOPHmSJe5CQGql+RKtTvBBWDIL0GLF6tXxe63S
         80oA==
X-Gm-Message-State: AO0yUKV1d0VfYpW4NcJW5QCuKCm6t73VEJmXa/lPlU3hEpoQt4z0em92
        yRaWGJhiSxzMuZ7WjAtLaognW1FOIl+121Aa
X-Google-Smtp-Source: AK7set8KSPd7OwGZqIBqnUz+IIPPyL3IqTrfg+rV75QbuSR/rD6bPQRTMF8ep19miVY9bLy2ayOM9w==
X-Received: by 2002:a05:6512:204:b0:4db:a19:6dfe with SMTP id a4-20020a056512020400b004db0a196dfemr8544162lfo.26.1678640533216;
        Sun, 12 Mar 2023 10:02:13 -0700 (PDT)
Received: from 0000-cover-letter.patch (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id b14-20020a056512218e00b004dafe604c2esm534355lft.211.2023.03.12.10.02.12
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:02:12 -0700 (PDT)
Message-Id: <1678640497.9030156-0-sleirsgoevy@gmail.com>
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Date:   Sun, 12 Mar 2023 19:59:30 +0300
Subject: [PATCH v4 0/3] mmc: dw_mmc: fix DW MMC cores with 32-bit bus on 64-bit Linux systems 
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
  dt-bindings: exynos-dw-mshc-common: add exynos78xx variants
  arm64: dts: exynos: fix wrong mmc compatible in exynos7885.dtsi
  mmc: dw_mmc: add an option to force 32-bit access to 64-bit FIFO

 .../bindings/mmc/samsung,exynos-dw-mshc.yaml  |   2 +
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    |   2 +-
 drivers/mmc/host/dw_mmc-exynos.c              |  41 +++++-
 drivers/mmc/host/dw_mmc.c                     | 122 +++++++++++++++++-
 drivers/mmc/host/dw_mmc.h                     |   2 +
 5 files changed, 165 insertions(+), 4 deletions(-)

-- 
2.38.3


