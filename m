Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65ACEC4332F
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Dec 2022 08:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbiLBIfq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Dec 2022 03:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiLBIfS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Dec 2022 03:35:18 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F8EBF911
        for <linux-mmc@vger.kernel.org>; Fri,  2 Dec 2022 00:33:26 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so6303753lfb.13
        for <linux-mmc@vger.kernel.org>; Fri, 02 Dec 2022 00:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVzvAUcs+pe9QgxoA/HnlnK/S+641sb2KvL8G5I/JNY=;
        b=i7PEmYYkzgLRz6PZ8y/HBf+T54YBa+jmIpzZ/dncYFG/jAr0a05Ok7iVbnWNERg+yz
         p1jQqtMHQnPzh7q/FTDWuxtBXGha7LRAKydy1FBoxxEP6+cVpDb73FOlkzcfj23Ht8Rq
         v9VAKc+sq7kfq6xX885Eu/CX5yeVppI8dXXTpMIqxVanbKLTumcqV3/oK8EYivag3/oy
         Uty6rKfWdGSScZ8e/6HY9pqTqfsfEphu0tJ4v770M+niW/1uQAhMkniVVN6XDSbYORBA
         FbHOoZU66XWh9KIpk844UJ1Fr0FOMsT5+DNMmfgRAsxVMppmYS2Owl/OqXlrIY2Qdfn6
         zFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WVzvAUcs+pe9QgxoA/HnlnK/S+641sb2KvL8G5I/JNY=;
        b=NI+jWdjodrdHEhOs/NSnSONFOpFi6BhNGdyA2WhlVHo6MWWPhpLXhtUNzCypD+NVuj
         38MFVUV1Pt1B1Qau/01HO7MwhNB2YImBJ+AjL8i80H9c6g+XKbsBjRF7T1sTomNiMrGm
         e/fpmdi2cXomV0pDstDpgEIFYebel1CK5tQK+WzBRqLnJjH1aGCBRvd19VMMPEPa5dB4
         692FcVIiLs1yQoVsdQ/VDiwYqbbcDaHMdDItTWDhca1BB8wrH5ogyIgui9tbxiRq4dNZ
         FZSCRb+qBR9Lo4N6ru7nv/47d+/a3A7kSbEzQoH6Wvy27e4V19F26Bj+42AF1sSHqNQb
         uQpw==
X-Gm-Message-State: ANoB5plKywxR18VhFBLR/ZXq6mMRsN1Y0K/o4L4SrUb73Rrxy9CMxsig
        yAHMKhy/iTck4GZzirBifWftgQ==
X-Google-Smtp-Source: AA0mqf6IoHRI5SGuUrPmvfzVcaSe27jWfxi92PQYNR/yCBomfHy+oXIL1a+61mCpztE45BogZoufSA==
X-Received: by 2002:ac2:43d8:0:b0:4ab:7f8d:472 with SMTP id u24-20020ac243d8000000b004ab7f8d0472mr9137lfl.65.1669970005181;
        Fri, 02 Dec 2022 00:33:25 -0800 (PST)
Received: from uffe-XPS13.. ([148.122.187.2])
        by smtp.gmail.com with ESMTPSA id r10-20020a19ac4a000000b00499cf3e3edcsm939326lfc.296.2022.12.02.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 00:33:24 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.1-rc7
Date:   Fri,  2 Dec 2022 09:33:10 +0100
Message-Id: <20221202083310.136427-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.1-rc7. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 222cfa0118aa68687ace74aab8fdf77ce8fbd7e6:

  mmc: sdhci-pci: Fix possible memory leak caused by missing pci_dev_put() (2022-11-16 17:00:39 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.1-rc5-2

for you to fetch changes up to dd30dcfa7a74a06f8dcdab260d8d5adf32f17333:

  mmc: sdhci-sprd: Fix no reset data and command after voltage switch (2022-12-01 11:28:39 +0100)

----------------------------------------------------------------
MMC core:
 - Fix ambiguous TRIM and DISCARD args
 - Fix removal of debugfs file for mmc_test

MMC host:
 - mtk-sd: Add missing clk_disable_unprepare() in an error path
 - sdhci: Fix I/O voltage switch delay for UHS-I SD cards
 - sdhci-esdhc-imx: Fix CQHCI exit halt state check
 - sdhci-sprd: Fix voltage switch

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci: Fix voltage switch delay

Christian Löhle (1):
      mmc: core: Fix ambiguous TRIM and DISCARD arg

Gaosheng Cui (1):
      mmc: mtk-sd: Fix missing clk_disable_unprepare in msdc_of_clock_parse()

Sebastian Falbesoner (1):
      mmc: sdhci-esdhc-imx: correct CQHCI exit halt state check

Wenchao Chen (1):
      mmc: sdhci-sprd: Fix no reset data and command after voltage switch

Ye Bin (1):
      mmc: mmc_test: Fix removal of debugfs file

 drivers/mmc/core/core.c            |  9 ++++--
 drivers/mmc/core/mmc_test.c        |  3 +-
 drivers/mmc/host/mtk-sd.c          |  6 ++--
 drivers/mmc/host/sdhci-esdhc-imx.c |  2 +-
 drivers/mmc/host/sdhci-sprd.c      |  4 ++-
 drivers/mmc/host/sdhci.c           | 61 +++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/sdhci.h           |  2 ++
 include/linux/mmc/mmc.h            |  2 +-
 8 files changed, 72 insertions(+), 17 deletions(-)
