From: Kukjin Kim <kgene.kim@samsung.com>
Subject: [PATCH v3 0/3] Add support WP on SMDKV210 and SDHCI_QUIRK_NO_WP_BIT quirk
Date: Fri, 23 Jul 2010 20:56:28 +0900
Message-ID: <1279886191-9197-1-git-send-email-kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ben-linux@fluff.org, akpm@linux-foundation.org
List-Id: linux-mmc@vger.kernel.org

This patch adds support SDMMC write protection pin on SMDKV210.

Changes since v2:
Addressed comments from Marek Szyprowski

- modified wp_gpio checking method for support gpio number 0.
- removed unnecessary checking in dev-hsmmc.c

Changes since v1:
Addressed comments from Ben Dooks, Maurus Cuelenaere and Kyungmin Park

- just pass gpio numbers for support WP as Ben's suggestion
- use the gpio layer for specific machine
- use s3c_sdhcix_set_platdata() in machine_init()
- removed unnecessary EXPORT_SYMBOL

Note: Depends on following patch set

[PATCH v2 1/2] ARM: SAMSUNG: Add device definition for HSMMC3
[PATCH v2 2/2] ARM: S5PV210: Add support HSMMC on SMDKV210
[PATCH v4] Samsung: add new card detection methods in s3c-sdhci driver (platform part) from Marek Szyprowski 
[PATCH v4] sdhci-s3c: add support for new card detection methods (driver part) from Marek Szyprowski 

And this patch set includes the following patches:

[PATCH v3 1/2] ARM: SAMSUNG: Add the member of platdata to implement SDMMC Write Protection
[PATCH v3 2/2] ARM: S5PV210: Add support SDMMC WP through EXT_INT on SMDKV210
[PATCH v3 3/3] sdhci-s3c: Add SDHCI_QUIRK_NO_WP_BIT quirk for Samsung SoC
