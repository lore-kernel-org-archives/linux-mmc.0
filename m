From: yongd <yongd@marvell.com>
Subject: [PATCH V2 0/3] mmc: remove MMC_CAP_NEEDS_POLL setting in sdhci_add_host
Date: Tue, 30 Oct 2012 17:30:00 +0800
Message-ID: <1351589403-26398-1-git-send-email-yongd@marvell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>
Cc: zhangfei.gao@marvell.com, kevin.liu@marvell.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi all,
Sorry for my so late. And eventually these updated patches are here for your
review. Thanks in advance.
For patch 1, add SDHCI_QUIRK_BROKEN_CARD_DETECTION setting for ESDHC_CD_GPIO type,
or the host controller detection interrupts will be redundantly enabled. And its
comment is correspondingly updated.
For patch 2, broaden SDHCI_QUIRK_BROKEN_CARD_DETECTION setting for all detection
types except S3C_SDHCI_CD_INTERNAL. Then also update the comment.
For patch 3, no update.
