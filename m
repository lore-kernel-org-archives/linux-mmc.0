From: Loc Ho <lho@apm.com>
Subject: [PATCH v2 0/3] mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI driver
Date: Tue,  3 Jun 2014 15:13:02 -0600
Message-ID: <1401829985-5212-1-git-send-email-lho@apm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:34836 "HELO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754632AbaFCVNZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Jun 2014 17:13:25 -0400
Received: by mail-pd0-f169.google.com with SMTP id w10so5165251pde.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Jun 2014 14:13:24 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net, ulf.hansson@linaro.org, michal.simek@xilinx.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jcm@redhat.com, patches@apm.com, Loc Ho <lho@apm.com>

This patch adds support for the APM X-Gene SoC SDHC controller to Arasan
SDHCI driver.

v2:
* Update binding documentation
* Change compatible string from "xgene,arasan" to "apm,arasan"

Signed-off-by: Loc Ho <lho@apm.com>
---
Loc Ho (3):
  Documentation: Update Arasan SDHC documentation for the APM X-Gene
    SoC SDHC DTS binding
  mmc: Add APM X-Gene SoC SDHC controller support to Arasan SDHCI
    driver
  arm64: Add APM X-Gene SoC SDHC controller DTS entry

 .../devicetree/bindings/mmc/arasan,sdhci.txt       |   16 ++-
 arch/arm64/boot/dts/apm-storm.dtsi                 |    8 ++
 drivers/mmc/host/Kconfig                           |    4 +-
 drivers/mmc/host/sdhci-of-arasan.c                 |  126 ++++++++++++++++++--
 4 files changed, 140 insertions(+), 14 deletions(-)

