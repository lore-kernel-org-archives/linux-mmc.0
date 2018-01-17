From: Colin King <colin.king@canonical.com>
Subject: [PATCH] mmc: sh_mmcif: remove redundant initialization of 'opc'
Date: Wed, 17 Jan 2018 13:41:57 +0000
Message-ID: <20180117134157.23943-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable opc is initialized with a value that is never read, opc
is later re-assigned a newer value, hence the initialization can
be removed.

Cleans up clang warning:
drivers/mmc/host/sh_mmcif.c:919:6: warning: Value stored to 'opc'
during its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sh_mmcif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 53fb18bb7bee..7bb00c68a756 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -916,7 +916,7 @@ static void sh_mmcif_start_cmd(struct sh_mmcif_host *host,
 			       struct mmc_request *mrq)
 {
 	struct mmc_command *cmd = mrq->cmd;
-	u32 opc = cmd->opcode;
+	u32 opc;
 	u32 mask = 0;
 	unsigned long flags;
 
-- 
2.15.1
