From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 182/304] mmc: bcm2835: Recover from MMC_SEND_EXT_CSD
Date: Mon, 28 Jan 2019 10:41:39 -0500
Message-ID: <20190128154341.47195-182-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.org>, Stefan Wahren <stefan.wahren@i2se.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Phil Elwell <phil@raspberrypi.org>

[ Upstream commit 07d405769afea5718529fc9e341f0b13b3189b6f ]

If the user issues an "mmc extcsd read", the SD controller receives
what it thinks is a SEND_IF_COND command with an unexpected data block.
The resulting operations leave the FSM stuck in READWAIT, a state which
persists until the MMC framework resets the controller, by which point
the root filesystem is likely to have been unmounted.

A less heavyweight solution is to detect the condition and nudge the
FSM by asserting the (self-clearing) FORCE_DATA_MODE bit.

Link: https://github.com/raspberrypi/linux/issues/2728
Signed-off-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Eric Anholt <eric@anholt.net>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/bcm2835.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 768972af8b85..aef40e1739ee 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -772,6 +772,8 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 
 		if (!(sdhsts & SDHSTS_CRC7_ERROR) ||
 		    (host->cmd->opcode != MMC_SEND_OP_COND)) {
+			u32 edm, fsm;
+
 			if (sdhsts & SDHSTS_CMD_TIME_OUT) {
 				host->cmd->error = -ETIMEDOUT;
 			} else {
@@ -780,6 +782,13 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
 				bcm2835_dumpregs(host);
 				host->cmd->error = -EILSEQ;
 			}
+			edm = readl(host->ioaddr + SDEDM);
+			fsm = edm & SDEDM_FSM_MASK;
+			if (fsm == SDEDM_FSM_READWAIT ||
+			    fsm == SDEDM_FSM_WRITESTART1)
+				/* Kick the FSM out of its wait */
+				writel(edm | SDEDM_FORCE_DATA_MODE,
+				       host->ioaddr + SDEDM);
 			bcm2835_finish_request(host);
 			return;
 		}
-- 
2.19.1
