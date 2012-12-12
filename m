From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 11/14] mmc: sh-mmcif: reset error code for any opcode
Date: Wed, 12 Dec 2012 15:38:15 +0100
Message-ID: <1355323098-18061-12-git-send-email-g.liakhovetski@gmx.de>
References: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1355323098-18061-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

If a command execution has produced an error, it has to be reset as a part
of the error handling.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 96ab2e1..03493e4 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1041,7 +1041,6 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 		case MMC_SELECT_CARD:
 		case MMC_APP_CMD:
 			cmd->error = -ETIMEDOUT;
-			host->sd_error = false;
 			break;
 		default:
 			cmd->error = sh_mmcif_error_manage(host);
@@ -1049,6 +1048,7 @@ static bool sh_mmcif_end_cmd(struct sh_mmcif_host *host)
 				cmd->opcode, cmd->error);
 			break;
 		}
+		host->sd_error = false;
 		return false;
 	}
 	if (!(cmd->flags & MMC_RSP_PRESENT)) {
-- 
1.7.2.5

