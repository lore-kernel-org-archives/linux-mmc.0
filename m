From: Neil Armstrong <narmstrong@neotion.com>
Subject: [PATCH 1/3] Add BOOT_PARTITION_ENABLE definition to MMC EXT_CSD PART_CONFIG
Date: Fri, 19 Apr 2013 14:41:31 +0200
Message-ID: <51713B7B.3060402@neotion.com>
Reply-To: narmstrong@neotion.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Namjae Jeon <linkinjeon@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Subhash Jadavani <subhashj@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Add bit mask for the BOOT_PARTITION_ENABLE values.

Signed-off-by: Neil Armstrong <narmstrong@neotion.com>
---
 include/linux/mmc/mmc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 50bcde3..eb5b361 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -347,6 +347,7 @@ struct _mmc_csd {
 #define EXT_CSD_PART_CONFIG_ACC_BOOT0    (0x1)
 #define EXT_CSD_PART_CONFIG_ACC_RPMB    (0x3)
 #define EXT_CSD_PART_CONFIG_ACC_GP0    (0x4)
+#define EXT_CSD_PART_CONFIG_EN_MASK    (0x38)
 
 #define EXT_CSD_PART_SUPPORT_PART_EN    (0x1)
 
-- 
1.7.0.4
