From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH v2 0/2] mmc: core: process ECC errors raised in stop cmds
Date: Sat,  8 Apr 2017 22:20:04 +0200
Message-ID: <20170408202006.27276-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
List-Id: linux-mmc@vger.kernel.org

Here is the second RFC for handling ECC errors flagged in the stop command
after a multiblock transfer. It is still RFC because I could only test it by
inducing ECC errors in software (see patch for TMIO below). Shimoda-san, can
you try this series with the SD tester again? That would be very kind.

Other than that, I hope the patch descriptions and comments explain the single
steps. Looking forward for thoughts.

Kind regards,

   Wolfram

Changes since RFC v1:

* rebased to mmc/next as of today
* reworded commit message for patch 1
* added tested-tag from Shimoda-san for patch 1
* added patch 2

Wolfram Sang (2):
  mmc: core: check also R1 response for stop commands
  mmc: core: for data errors, take response of stop cmd into account

 drivers/mmc/core/block.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

Patch to simulate ECC errors:

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index a2d92f10501bdd..9773c7e5e4d154 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -553,6 +553,8 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 	}
 
 	if (stop) {
+		static unsigned int induce_cnt = 0;
+
 		if (stop->opcode != MMC_STOP_TRANSMISSION || stop->arg)
 			dev_err(&host->pdev->dev, "unsupported stop: CMD%u,0x%x. We did CMD12,0\n",
 				stop->opcode, stop->arg);
@@ -560,6 +562,9 @@ void tmio_mmc_do_data_irq(struct tmio_mmc_host *host)
 		/* fill in response from auto CMD12 */
 		stop->resp[0] = sd_ctrl_read16_and_16_as_32(host, CTL_RESPONSE);
 
+		if (induce_cnt++ % 100 == 0)
+			stop->resp[0] |= R1_CARD_ECC_FAILED;
+
 		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, 0);
 	}

-- 
2.11.0
