From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH] mmc: sh_mmcif: fix MMC_GEN_CMD setting
Date: Tue, 17 Jan 2012 17:05:14 +0900
Message-ID: <4F152BBA.1040506@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, SH-Linux <linux-sh@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

The MMC_GEN_CMD (CMD56) doesn't need to check the busy signal.
So, this patch fixes the setting.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/mmc/host/sh_mmcif.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 4a2c5b2..e8b70e3 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -745,7 +745,6 @@ static u32 sh_mmcif_set_cmd(struct sh_mmcif_host *host,
 	case MMC_SET_WRITE_PROT:
 	case MMC_CLR_WRITE_PROT:
 	case MMC_ERASE:
-	case MMC_GEN_CMD:
 		tmp |= CMD_SET_RBSY;
 		break;
 	}
@@ -828,7 +827,6 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 	case MMC_SET_WRITE_PROT:
 	case MMC_CLR_WRITE_PROT:
 	case MMC_ERASE:
-	case MMC_GEN_CMD:
 		mask = MASK_START_CMD | MASK_MRBSYE;
 		break;
 	default:
-- 
1.7.1
