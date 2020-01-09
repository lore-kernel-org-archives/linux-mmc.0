Return-Path: <SRS0=zEeD=26=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DDFC33CA2
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3042C2075D
	for <linux-mmc@archiver.kernel.org>; Thu,  9 Jan 2020 09:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADzd4sIz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgAIJNZ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:13:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34663 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728793AbgAIJNZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Jan 2020 04:13:25 -0500
Received: by mail-pf1-f196.google.com with SMTP id i6so3087703pfc.1;
        Thu, 09 Jan 2020 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPrFCrM6KwJYTjriuFL5VoYsunJfk+aWDMKtdLsKHkg=;
        b=ADzd4sIziesJUzuW0zPL+tj6sFWHWdzNFWYaXMAfaAAmk2fy8URqPsDg3FSPySGryj
         KuQDPTE+LWWx71s48stbNMXZgVzhQTWRhl47EZ4EgIJ7FHPKpikCcxosgWoYDVza4/bz
         rTSW7QsxCfKygveR3QmoJjAKi6PKYLz4mgaVXUIb4XHbULfaFX1pYzma3qR0y3Rh1z6y
         svTDVpRihIjj5KsV9M3DUjubgDT260OocPYvbKV1F6Dra/8gT1kxWnXQ4IbcnxyOu+oa
         6be8EzbW/hJGbDMju3YtPe+8FSUi8KHvFfyuSXQ17sMkGz0vmO6ZpstLs+d13X4ATwL4
         R3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VPrFCrM6KwJYTjriuFL5VoYsunJfk+aWDMKtdLsKHkg=;
        b=MX9mBduprtAiaWRXFYQ8OMWQ0/TNQZFtfNknwa4XgykNqJMkzHvTKLLrHdvPvkhb0A
         Urbm/IbJNpvNVdPvzwgWuvAL5HRae+U6QSF/hMud7aSZJUi4QX7sr/krvv88DtYmKug/
         SqfinwP0R6pOT4Jo53Tlz/Q94bF/TKvVr64mJmLQD1i0f/i34wQ1LRO9KI2hhyH/GzxK
         LxSnJbP36LK1otCQ6Hz8482JR09d/opZMM3x5JIc/63sLGaYSSH3S1bRWHk4d/NbqJ2S
         /m7R87ZkjfuG580yUYroi8keL8yzcx3i4L/omCQLwinANsR0NyFkrtfgWmxIfJorhtM8
         6FZQ==
X-Gm-Message-State: APjAAAWNep4k80pNmf2sPG7lE1gD+QuQdtmLX4Go6h0N9M8vZMqNerxt
        BGq9guMiSWBq8Uf79TRcxWU=
X-Google-Smtp-Source: APXvYqySz2w9/3ai890d7I4StxP6IqCN+p2I1wmGSQZP39LMR4sqY07Z8cJtvB/v7uOhLbY8qHJtFQ==
X-Received: by 2002:aa7:9816:: with SMTP id e22mr10311252pfl.229.1578561204341;
        Thu, 09 Jan 2020 01:13:24 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t23sm6951429pfq.106.2020.01.09.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 01:13:23 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC PATCH v2 0/6] Add support UHS-II for GL9755
Date:   Thu,  9 Jan 2020 17:13:17 +0800
Message-Id: <cover.1578560282.git.benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Uffe and Adrian,

These patches support UHS-II and fix GL9755 UHS-II compatibility.

The parts of UHS-II are based on [1][2] and porting to Linux 5.5-rc5.
I have seen that Uffe comment that splitting the UHS-II parts into smaller
patches. Other than splitting into small patches, could you give me some 
suggestions for refactoring/splitting files?

Best regards,
Ben

References:
1. [RFC,1/2] mmc: core: support UHS-II in core stack.
   (https://patchwork.kernel.org/patch/5544441/)
2. [RFC,2/2] mmc: sdhci: support UHS-II in SDHCI host. 
   (https://patchwork.kernel.org/patch/5544451/)

v2:
  - base on Linux v5.5-rc5

Ben Chuang (6):
  mmc: Add UHS-II support in public headers
  mmc: core: Add UHS-II support in core layer
  mmc: host: Add UHS-II support in host layer
  mmc: uhs2: Introduce a uhs2_post_attach_sd function
  mmc: sdhci-uhs2: Introduce a uhs2_pre_detect_init function
  mmc: sdhci-pci-gli: Fix power/reset/ZC/timeout for GL9755 UHS-II mode

 drivers/mmc/core/Makefile                  |   3 +-
 drivers/mmc/core/block.c                   |   7 +-
 drivers/mmc/core/bus.c                     |   5 +-
 drivers/mmc/core/core.c                    |  65 +-
 drivers/mmc/core/core.h                    |   3 +-
 drivers/mmc/core/regulator.c               |  14 +
 drivers/mmc/core/sd.c                      |  27 +-
 drivers/mmc/core/sd_ops.c                  |  12 +
 drivers/mmc/core/uhs2.c                    | 995 +++++++++++++++++++++
 drivers/mmc/core/uhs2.h                    |  23 +
 drivers/mmc/host/Makefile                  |   1 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 285 +++++-
 drivers/mmc/host/sdhci-milbeaut.c          |   4 +-
 drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
 drivers/mmc/host/sdhci-of-at91.c           |   4 +-
 drivers/mmc/host/sdhci-omap.c              |   2 +-
 drivers/mmc/host/sdhci-pci-core.c          |   4 +-
 drivers/mmc/host/sdhci-pci-gli.c           | 361 +++++++-
 drivers/mmc/host/sdhci-pxav3.c             |   4 +-
 drivers/mmc/host/sdhci-uhs2.c              | 754 ++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h              |  34 +
 drivers/mmc/host/sdhci-xenon.c             |   4 +-
 drivers/mmc/host/sdhci.h                   | 286 +++++-
 drivers/mmc/host/sdhci_am654.c             |   4 +-
 include/linux/mmc/card.h                   |   1 +
 include/linux/mmc/core.h                   |   6 +
 include/linux/mmc/host.h                   |  31 +
 include/linux/mmc/uhs2.h                   | 270 ++++++
 28 files changed, 3137 insertions(+), 76 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h


base-commit: c79f46a282390e0f5b306007bf7b11a46d529538
-- 
2.24.1

