Return-Path: <SRS0=ypud=CJ=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A15CC433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E1A620866
	for <linux-mmc@archiver.kernel.org>; Mon, 31 Aug 2020 11:25:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oeeE/PuR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHaLZU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 31 Aug 2020 07:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgHaLXd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 31 Aug 2020 07:23:33 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66EFFC0619C1
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 04:11:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y2so6206182ljc.1
        for <linux-mmc@vger.kernel.org>; Mon, 31 Aug 2020 04:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeV1i5lWS5ilgVHVwdjZqOEdjNx7M/tcM6QuH1mqWxI=;
        b=oeeE/PuRPNM0RLwf6s3xs1I8wmqzw/mMxpN5x0dgQOh1WJNugozsHSXKZy0ulJi9Tw
         lTguqxtZHQPiAka5zspnfcNDRChLgkaHAEdAtE2xXRnA3kNC3ckWkomiR8ojp4KAOqQQ
         Dw7DhLiw/CDMM3/V440PqlKDv/URSPrL75PfRbsvmT2eYSxzCufL4a58nNsEjKHDewgp
         HLjjkCjIhXMzyVwDUdvhD2tWo1ppV5dGDuJ3dDFnM2GCjk4oBRaNOq4d6rT1YBopYPHG
         A8hrsMsU0IbsJh6CxtVDpvXxnvPOi14aavTZ0Q1ZYS9mN8Bq0OT+Y1p3P7qktoCQPOTE
         7DgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JeV1i5lWS5ilgVHVwdjZqOEdjNx7M/tcM6QuH1mqWxI=;
        b=C1jnyFp9di4Kmd77v8wZfSLY8JW4fB2nQkj6arPkOZa1W5H2F5VueXDeI5dDfnCSSd
         goQBHdjmPa4DHb7fCAFjRdf8IcJLTqA7oA80qFnOoYRiL+5BLfyfKIynYcur1LvekyMA
         KBFN0exhu6w8oz0UX+xVu0PEBALxLO3Hj+kLpif4UxmtygG1HmYMQQ17VGSRrM5EVflj
         Jwf7WDT2xy5uvY+/lBXlerWNLIvykyaaFL7IMS/NAZyEawXNB0Ebnes5UDXmtt7kPGFe
         K+fqSTuVrh/p7zOnGYcVz6BGIC2WyNb4JARZVikW5KjjXZ3J82+WEqTRn78zD4vzUZVx
         wlMQ==
X-Gm-Message-State: AOAM533yROh0J2C3GhHqN7dJf8v/ciTEhIHl+tWnzpjsPbz/B8NJxg1J
        0mUOAplgQehyyID59tFlUNHg7g==
X-Google-Smtp-Source: ABdhPJxLcxE20sCGKOJbR/9yyDZnWfHcBcCwucZsZbu1c9zAD3CLOcuo1I6y7bEJJQUzr0tzk87Egg==
X-Received: by 2002:a2e:a49c:: with SMTP id h28mr447582lji.234.1598872303781;
        Mon, 31 Aug 2020 04:11:43 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-79.NA.cust.bahnhof.se. [98.128.180.79])
        by smtp.gmail.com with ESMTPSA id g63sm1891215lfd.28.2020.08.31.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 04:11:42 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Linus <torvalds@linux-foundation.org>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v5.9-rc4
Date:   Mon, 31 Aug 2020 13:11:41 +0200
Message-Id: <20200831111141.19238-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v5.9-rc4. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.9-rc1

for you to fetch changes up to 8048822bac01936fda2c7b924a52131da81e6198:

  sdhci: tegra: Add missing TMCLK for data timeout (2020-08-28 10:31:39 +0200)

----------------------------------------------------------------
MMC host:
 - sdhci-acpi: Fix HS400 tuning for AMDI0040
 - sdhci-pci: Fix reset of CQHCI for Intel GLK-based controllers
 - sdhci-tegra: Use correct timeout clock for Tegra186/194/210
 - mtk-sd: Fix eMMC mounting on mt7622/Bpi-64

----------------------------------------------------------------
Adrian Hunter (1):
      mmc: sdhci-pci: Fix SDHCI_RESET_ALL for CQHCI for Intel GLK-based controllers

Michal Simek (1):
      dt-bindings: mmc: Add missing description for clk_in/out_sd1

Raul E Rangel (1):
      mmc: sdhci-acpi: Fix HS400 tuning for AMDI0040

Sowjanya Komatineni (7):
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra210
      sdhci: tegra: Remove SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK for Tegra186
      dt-bindings: mmc: tegra: Add tmclk for Tegra210 and later
      arm64: tegra: Add missing timeout clock to Tegra210 SDMMC
      arm64: tegra: Add missing timeout clock to Tegra186 SDMMC nodes
      arm64: tegra: Add missing timeout clock to Tegra194 SDMMC nodes
      sdhci: tegra: Add missing TMCLK for data timeout

Wenbin Mei (3):
      mmc: dt-bindings: Add resets/reset-names for Mediatek MMC bindings
      mmc: mediatek: add optional module reset property
      arm64: dts: mt7622: add reset node for mmc device

 .../devicetree/bindings/mmc/arasan,sdhci.yaml      | 10 +++-
 Documentation/devicetree/bindings/mmc/mtk-sd.txt   |  2 +
 .../bindings/mmc/nvidia,tegra20-sdhci.txt          | 32 ++++++++++-
 arch/arm64/boot/dts/mediatek/mt7622.dtsi           |  2 +
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           | 20 ++++---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi           | 15 +++--
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           | 20 ++++---
 drivers/mmc/host/mtk-sd.c                          | 13 +++++
 drivers/mmc/host/sdhci-acpi.c                      | 67 ++++++++++++++++++----
 drivers/mmc/host/sdhci-pci-core.c                  | 10 +++-
 drivers/mmc/host/sdhci-tegra.c                     | 55 ++++++++++++++++--
 11 files changed, 203 insertions(+), 43 deletions(-)
