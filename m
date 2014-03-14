From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH RESEND v3 1/7] mmc: clarify DDR timing mode between SD-UHS and
 eMMC
Date: Fri, 14 Mar 2014 21:11:56 +0900
Message-ID: <003301cf3f7e$9821b9d0$c8652d70$%jun@samsung.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
 <006001cf2a57$73a07290$5ae157b0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:44356 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722AbaCNML7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 Mar 2014 08:11:59 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N2F00CAFDVX4300@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 14 Mar 2014 21:11:57 +0900 (KST)
In-reply-to: 
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>

This change distinguishes DDR timing mode of current
mixed usage to clarify device type.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/core/debugfs.c |    3 +++
 drivers/mmc/core/mmc.c     |    2 +-
 include/linux/mmc/host.h   |    3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
index 54829c0..509229b 100644
--- a/drivers/mmc/core/debugfs.c
+++ b/drivers/mmc/core/debugfs.c
@@ -135,6 +135,9 @@ static int mmc_ios_show(struct seq_file *s, void *data)
 	case MMC_TIMING_UHS_DDR50:
 		str = "sd uhs DDR50";
 		break;
+	case MMC_TIMING_MMC_DDR52:
+		str = "mmc DDR52";
+		break;
 	case MMC_TIMING_MMC_HS200:
 		str = "mmc high-speed SDR200";
 		break;
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1ab5f3a..e22d851 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1264,7 +1264,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
 					goto err;
 			}
 			mmc_card_set_ddr_mode(card);
-			mmc_set_timing(card->host, MMC_TIMING_UHS_DDR50);
+			mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
 			mmc_set_bus_width(card->host, bus_width);
 		}
 	}
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cb61ea4..3535420 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -58,7 +58,8 @@ struct mmc_ios {
 #define MMC_TIMING_UHS_SDR50	5
 #define MMC_TIMING_UHS_SDR104	6
 #define MMC_TIMING_UHS_DDR50	7
-#define MMC_TIMING_MMC_HS200	8
+#define MMC_TIMING_MMC_DDR52	8
+#define MMC_TIMING_MMC_HS200	9
 
 #define MMC_SDR_MODE		0
 #define MMC_1_2V_DDR_MODE	1
-- 
1.7.0.4


