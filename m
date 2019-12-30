Return-Path: <SRS0=mt+k=2U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C7FC2D0C2
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 183252053B
	for <linux-mmc@archiver.kernel.org>; Mon, 30 Dec 2019 11:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ns+rP4Iu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfL3LiM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:38:12 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39069 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbfL3LiM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Dec 2019 06:38:12 -0500
Received: by mail-pj1-f65.google.com with SMTP id t101so8002470pjb.4;
        Mon, 30 Dec 2019 03:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tN8NHVmrJCTvrrpZgXxHZpysazYrwt+KadAqQsHV5U=;
        b=Ns+rP4IuNRUJAP762je65CGdKWLekPf4wnP889zHIQWMY9D6rth3sTzSgjYkpkKqqJ
         eH+z64YldjNV5Qve5fGNAdTSABq5VwP3sAw5oNKlrZuwhLRK2kq8ZODtYEh7SHx6mKrF
         gR6l/2bEoHm652gOgHbuXpVbhC1gpea5wAtnt1N/6bW2yOWpHgUXTYaKydBTlIG4RBAO
         bEHBhqmZY8Q213jaapaJ4h872svMF2AG59ku/4fF4KfuJ+jYNP3f2JozL3OG5KnhDNyP
         GDW2Ml567St1bDpcBjSTfli9D2BM1QGuG3vmbFglTWO0cqbe4h5N4VxwVOEMi4ubuAFh
         9Vig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tN8NHVmrJCTvrrpZgXxHZpysazYrwt+KadAqQsHV5U=;
        b=B2f9wcilxuOrUmt4t54P+RKTxRHb2dPGflL1mglPrkXsR7oiH4Lk+7Zg+brUt6zzhA
         7hUZEwsoppl5S23lYbDueGIDJqr4JZA0DY1SqEomAZq/BTWi2Cg5xEN3ABxIeG4R9grt
         Ca895aX/G7BGw/JqdyzjEJ1PPOM69VjJnGmh8riGiLVlRf8kDKvP8Fsdj7c+JPYxb+JS
         K1PpTEY4ew2Vj7cfEf6flbJx452KO+JHMQfcyn07TpjDfzHupSThMtyPJCknLXRiQ4eT
         RR3ZwVYauxVzkLR7iQC8r4tEb+VQNrS4Gld/6/z/Q7A6CrqUxPgO0Dx089K+9U+MuXiT
         Sy1g==
X-Gm-Message-State: APjAAAW98wnF/lyrq8CrKInph24hJRwAMfdVL7A1D2J7Jqv3WgsiVySv
        wyTvjM9WXg5zkqGNdZ49nAU=
X-Google-Smtp-Source: APXvYqyTy2nruOpPgn+4FkAiKeFgIA4KffVM1veiTtjOzt1w4kBl8GC0nReV66pW9kkFuZwYv6cTEQ==
X-Received: by 2002:a17:902:b498:: with SMTP id y24mr15742781plr.97.1577705891527;
        Mon, 30 Dec 2019 03:38:11 -0800 (PST)
Received: from gli-arch.genesyslogic.com.tw (60-251-58-169.HINET-IP.hinet.net. [60.251.58.169])
        by smtp.gmail.com with ESMTPSA id t137sm47038069pgb.40.2019.12.30.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 03:38:11 -0800 (PST)
From:   Ben Chuang <benchuanggli@gmail.com>
To:     adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        Ben Chuang <benchuanggli@gmail.com>
Subject: [RFC,PATCH 0/6] Add support UHS-II for GL9755
Date:   Mon, 30 Dec 2019 19:37:51 +0800
Message-Id: <20191230113751.37852-1-benchuanggli@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf and Adrian,

These patches support UHS-II and fix GL9755 UHS-II compatibility.

The parts of UHS-II are based on [1][2] and porting to Linux 5.4 kernel.
I have seen that Ulf comment that splitting the UHS-II parts into smaller
patches. Other than splitting into small patches, could you give me some 
suggestions for refactoring/splitting files?

Best regards,
Ben

References:
1. [RFC,1/2] mmc: core: support UHS-II in core stack.
   (https://patchwork.kernel.org/patch/5544441/)
2. [RFC,2/2] mmc: sdhci: support UHS-II in SDHCI host. 
   (https://patchwork.kernel.org/patch/5544451/)

Ben Chuang (6):
  mmc: Add UHS-II support in public headers
  mmc: core: Add UHS-II support in core layer
  mmc: host: Add UHS-II support in host layer
  mmc: uhs2: Introduce a uhs2_post_attach_sd function
  mmc: sdhci-uhs2: Introduce a uhs2_pre_detec_init function
  mmc: sdhci-pci-gli: Fix power/reset/ZC/timeout for GL9755 UHS-II mode

 drivers/mmc/core/Makefile                  |   3 +-
 drivers/mmc/core/block.c                   |   7 +-
 drivers/mmc/core/bus.c                     |   5 +-
 drivers/mmc/core/core.c                    |  65 +-
 drivers/mmc/core/core.h                    |   3 +-
 drivers/mmc/core/regulator.c               |  14 +
 drivers/mmc/core/sd.c                      |  60 +-
 drivers/mmc/core/sd_ops.c                  |  12 +
 drivers/mmc/core/sdio_bus.c                |   2 +-
 drivers/mmc/core/uhs2.c                    | 995 +++++++++++++++++++++
 drivers/mmc/core/uhs2.h                    |  23 +
 drivers/mmc/host/Makefile                  |   1 +
 drivers/mmc/host/{sdhci.c => sdhci-core.c} | 285 +++++-
 drivers/mmc/host/sdhci-of-arasan.c         |   4 +-
 drivers/mmc/host/sdhci-of-at91.c           |   6 +-
 drivers/mmc/host/sdhci-omap.c              |   2 +-
 drivers/mmc/host/sdhci-pci-core.c          |   4 +-
 drivers/mmc/host/sdhci-pci-gli.c           | 361 +++++++-
 drivers/mmc/host/sdhci-pxav3.c             |   4 +-
 drivers/mmc/host/sdhci-uhs2.c              | 754 ++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h              |  34 +
 drivers/mmc/host/sdhci-xenon.c             |   4 +-
 drivers/mmc/host/sdhci.h                   | 286 +++++-
 drivers/mmc/host/sdhci_am654.c             |   4 +-
 include/linux/mmc/card.h                   |   2 +
 include/linux/mmc/core.h                   |   6 +
 include/linux/mmc/host.h                   |  31 +
 include/linux/mmc/uhs2.h                   | 270 ++++++
 28 files changed, 3161 insertions(+), 86 deletions(-)
 create mode 100644 drivers/mmc/core/uhs2.c
 create mode 100644 drivers/mmc/core/uhs2.h
 rename drivers/mmc/host/{sdhci.c => sdhci-core.c} (94%)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.c
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h
 create mode 100644 include/linux/mmc/uhs2.h

-- 
2.24.1

