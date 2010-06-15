From: Kukjin Kim <kgene.kim@samsung.com>
Subject: ARM: S5PV210: Add support SDMMC Write Protection on SMDKV210
Date: Tue, 15 Jun 2010 20:27:45 +0900
Message-ID: <1276601268-7226-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: ben-linux@fluff.org
List-Id: linux-mmc@vger.kernel.org

This patch adds support SDMMC write protection pin on SMDKV210.

Note: Depends on following patch set

[PATCH 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
[PATCH 2/2 RE-SEND] ARM: S5PV210: Add support HSMMC on Samsung SMDKV210

And this patch set includes the following patches:

[PATCH 1/3] ARM: SAMSUNG: Add the member of platdata to implement SDMMC Write Protection
[PATCH 2/3] ARM: S5PV210: Add support SDMMC WP through EXT_INT on SMDKV210
[PATCH 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT for Samsung SoC
