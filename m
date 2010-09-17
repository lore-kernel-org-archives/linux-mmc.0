From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v2 0/2] sdhci-s3c: Add support S5PV310/S5PC210 HSMMC
Date: Fri, 17 Sep 2010 18:44:59 +0900
Message-ID: <1284716701-5140-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

This patch adds support S5PV310/S5PC210 HSMMC and additional host capabilities.

HSMMC of S5PV310 does not have internal clock divider so need to update for it.
(used SDHCI_QUIRK_NONSTANDARD_CLOCK quirk and added clk_type plat data)

Changes since v1:
- Separated to each topic

[PATCH v2 1/2] sdhci-s3c: Add support additional host capabilities
[PATCH v2 2/2] sdhci-s3c: Add support no internal clock divider in host controller
