From: Icenowy Zheng <icenowy@aosc.xyz>
Subject: [PATCH] mmc: sunxi: mask all Response Timeout error messages
Date: Mon,  6 Mar 2017 00:45:35 +0800
Message-ID: <20170305164535.36259-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Icenowy Zheng <icenowy@aosc.xyz>
List-Id: linux-mmc@vger.kernel.org

Response Timeout is very usual: it will happen when trying to run some
commands that do not belong to the card; it will happen when some SDIO
card transfer beyond its SDIO bandwidth; and when the MMC controller is
set to poll the card with "broken-cd" property (the Lichee Pi series of
boards do this), it will flood to the console and make the console
unusable.

Mask all response-timeout-only error messages, only show it when another
error happens.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 drivers/mmc/host/sunxi-mmc.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 6ffcd2838272..7828e1f57cf0 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -483,10 +483,15 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
 	struct mmc_command *cmd = host->mrq->cmd;
 	struct mmc_data *data = host->mrq->data;
 
-	/* For some cmds timeout is normal with sd/mmc cards */
-	if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) ==
-		SDXC_RESP_TIMEOUT && (cmd->opcode == SD_IO_SEND_OP_COND ||
-				      cmd->opcode == SD_IO_RW_DIRECT))
+	/*
+	 * Reading timeout is usually normal, especially when doing
+	 * card-polling with "broken-cd" in device tree.
+	 * If do not mask it, the RTO error message will flood the console
+	 * and even hide useful error messages.
+	 *
+	 * Some SDIO commands will also normally timeout with non-SDIO cards.
+	 */
+	if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) == SDXC_RESP_TIMEOUT)
 		return;
 
 	dev_err(mmc_dev(host->mmc),
-- 
2.11.1
