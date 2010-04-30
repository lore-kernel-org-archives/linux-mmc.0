From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH] MMC: atmel-mci: fix in debugfs: response value printing
Date: Fri, 30 Apr 2010 16:32:02 +0200
Message-ID: <1272637922-31418-1-git-send-email-nicolas.ferre@atmel.com>
References: <12c815b6060bc044238d63a686de517e43e90184.1272378853.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <12c815b6060bc044238d63a686de517e43e90184.1272378853.git.nicolas.ferre@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: haavard.skinnemoen@atmel.com, linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, kernel@avr32linux.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

In debugfs, printing of command response reports resp[2]
twice: fix it to resp[3].

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/mmc/host/atmel-mci.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index fd96ab9..1f0f30f 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -268,7 +268,7 @@ static int atmci_req_show(struct seq_file *s, void *v)
 				"CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
 				cmd->opcode, cmd->arg, cmd->flags,
 				cmd->resp[0], cmd->resp[1], cmd->resp[2],
-				cmd->resp[2], cmd->error);
+				cmd->resp[3], cmd->error);
 		if (data)
 			seq_printf(s, "DATA %u / %u * %u flg %x err %d\n",
 				data->bytes_xfered, data->blocks,
@@ -278,7 +278,7 @@ static int atmci_req_show(struct seq_file *s, void *v)
 				"CMD%u(0x%x) flg %x rsp %x %x %x %x err %d\n",
 				stop->opcode, stop->arg, stop->flags,
 				stop->resp[0], stop->resp[1], stop->resp[2],
-				stop->resp[2], stop->error);
+				stop->resp[3], stop->error);
 	}
 
 	spin_unlock_bh(&slot->host->lock);
-- 
1.5.6.5
