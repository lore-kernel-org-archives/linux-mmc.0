From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 09/23] mmc: sdhci: fix incorrect get data interrupt during no data transfer
Date: Sat, 16 Apr 2016 01:29:33 +0800
Message-ID: <1460741387-23815-10-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0091.outbound.protection.outlook.com ([207.46.100.91]:43061
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750709AbcDORv4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 15 Apr 2016 13:51:56 -0400
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawnguo@kernel.org, adrian.hunter@intel.com, linux-arm-kernel@lists.infradead.org, aisheng.dong@nxp.com, haibo.chen@nxp.com, dongas86@gmail.com

Current code will report the wrong data interrupt got when no
data operation in progress assumed by getting !host->data in
sdhci_data_irq().

For a data command handling process, the driver will call
sdhci_finish_data() and clear host->data in case any data error,
then card finish_tasklet will do the rest controller reset work.

Before the tasklet got run, however, controllers may report the
TC(Transfer Complete) interrupt (SDHCI_INT_DATA_END) a bit later
than data CRC error and data end bit error interrupts for single
block transfer or the last block of multiblock transfer.

Controller usually detects and generates data CRC/end bit error
interrupts once one block on the bus is transferred completely.
For single block transfer, since there's only one bock to transfer,
the controller will report transfer complete interrupt as well,
but until the data in controller FIFO has been successfully
transferred to memory. The time gap of TC and CRC interrupt depends on
the system busy state at that point and memory bus access speed.

So it is possible when TC interrupt generated, host->data is already
equal to NULL due to cleared by former CRC/Data End Bit error which
is reasonable.

Thus we DO NOT report the weird data interrupt event for this case.

Else we may easily see warning below during SD3.0 card manually tuning
process (calling mmc_send_tuning() which is a single block transfer)
mmc0: Got data interrupt 0x00000002 even though no data operation was in progress

The detailed command log is as follows:
[ 1657.920983] mmc0: starting CMD19 arg 00000000 flags 00000035
[ 1657.921009] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[ 1657.921085] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00200001
[ 1657.921112] sdhci [sdhci_irq()]: *** mmc0 got interrupt: 0x00000002
[ 1657.921131] mmc0: Got data interrupt 0x00000002 even though no data operation was in progress.
[ 1657.929761] sdhci: =========== REGISTER DUMP (mmc0)===========
[ 1657.929780] sdhci: Sys addr: 0x3d5d6380 | Version:  0x00000002
[ 1657.929796] sdhci: Blk size: 0x00000040 | Blk cnt:  0x00000001
[ 1657.929814] sdhci: Argument: 0x00000000 | Trn mode: 0x00000013
[ 1657.929831] sdhci: Present:  0x01fd8008 | Host ctl: 0x00000023
[ 1657.929847] sdhci: Power:    0x00000002 | Blk gap:  0x00000080
[ 1657.929863] sdhci: Wake-up:  0x00000008 | Clock:    0x0000000f
[ 1657.929879] sdhci: Timeout:  0x0000000f | Int stat: 0x00000000
[ 1657.929896] sdhci: Int enab: 0x107f008b | Sig enab: 0x107f008b
[ 1657.929914] sdhci: AC12 err: 0x00000000 | Slot int: 0x00000003
[ 1657.929932] sdhci: Caps:     0x07eb0000 | Caps_1:   0x00002007
[ 1657.929949] sdhci: Cmd:      0x0000133a | Max curr: 0x00ffffff
[ 1657.929965] sdhci: Host ctl2: 0x000000c8
[ 1657.929981] sdhci: ADMA Err: 0x00000000 | ADMA Ptr: 0x8f042208
[ 1657.929995] sdhci: ===========================================
[ 1657.930156] mmc0: req done (CMD19): 0: 00000900 00000000 00000000 00000000
[ 1657.930179] mmc0:     0 bytes transferred: -84

It shows we first have a data CRC error interrupt then a data transfer
complete interrupt.
Then we got the !host->data case in sdhci_data_irq().

CC: stable <stable@vger.kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 40e3551..2eb0e34 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2325,6 +2325,17 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			}
 		}
 
+		/*
+		 * The "data complete" interrupt is possible to happen a bit
+		 * later than CRC error and data end bit error interrupts
+		 * separately for single block transfer or the last block of
+		 * multiblock transfer. For this case, we DO NOT report the
+		 * weird data interrupt event.
+		 */
+		if ((intmask & SDHCI_INT_DATA_END) &&
+		    (host->mrq && host->mrq->data && host->mrq->data->error))
+			return;
+
 		pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
 		       mmc_hostname(host->mmc), (unsigned)intmask);
 		sdhci_dumpregs(host);
-- 
1.9.1

