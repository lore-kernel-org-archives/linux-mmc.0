From: Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH RFC 03/15] mmc: sunxi: Block signal voltage switching (CMD11)
Date: Thu, 21 Jan 2016 13:26:30 +0800
Message-ID: <1453354002-28366-4-git-send-email-wens@csie.org>
References: <1453354002-28366-1-git-send-email-wens@csie.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453354002-28366-1-git-send-email-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Hans de Goede <hdegoede@redhat.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: linux-mmc@vger.kernel.org

Allwinner's mmc controller supports signal voltage switching. This is
supported in code in Allwinner's kernel. However, publicly available
boards all tie it to a fixed 3.0/3.3V regulator, with options to tie
it to 1.8V for eMMC on some.

Since Allwinner's kernel is an ancient 3.4, it is hard to say whether
adapting it's code to a modern mainline kernel would work. Block signal
voltage switching until someone has proper hardware to implement and
test this.

This only affects SD UHS-1 modes, as eMMC switches the voltage directly
without any signaling.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 790f01662b4e..0495ae7da6d6 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -816,6 +816,20 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 	}
 
+	/*
+	 * TODO Support signal voltage switching
+	 *
+	 * Compared to Allwinner's kernel, recent updates in the mmc core
+	 * mean this should be as easy as setting the flags in cmd_val and
+	 * imask, and waiting for it to finish. However no boards support
+	 * this so this cannot be tested. Block it for now.
+	 */
+	if (cmd->opcode == SD_SWITCH_VOLTAGE) {
+		mrq->cmd->error = -EPERM;
+		mmc_request_done(mmc, mrq);
+		return;
+	}
+
 	if (cmd->opcode == MMC_GO_IDLE_STATE) {
 		cmd_val |= SDXC_SEND_INIT_SEQUENCE;
 		imask |= SDXC_COMMAND_DONE;
-- 
2.7.0.rc3
