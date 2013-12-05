From: Olivier Sobrie <olivier@sobrie.be>
Subject: [PATCH] atmel-mci: fix transfers < 16 bytes problem in PDC mode
Date: Thu,  5 Dec 2013 10:45:16 +0100
Message-ID: <1386236716-25163-1-git-send-email-olivier@sobrie.be>
References: <20131204080943.GK3582@odulo-laptop>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:49559 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab3LEJ7Q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Dec 2013 04:59:16 -0500
Received: by mail-ee0-f49.google.com with SMTP id c41so2909002eek.8
        for <linux-mmc@vger.kernel.org>; Thu, 05 Dec 2013 01:59:15 -0800 (PST)
In-Reply-To: <20131204080943.GK3582@odulo-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-mmc@vger.kernel.org, Olivier Sobrie <olivier@sobrie.be>

This patch attempts to fix a problem when trying to transfer
small data.

Without the patch, when there is a transfer of less than 16 bytes,
it hangs. Here is what I observed for a transfer of 4 bytes with
the traces enabled in the driver:

[   31.690000] atmel_mci fff84000.mmc: FSM: state=0
[   31.900000] atmel_mci fff84000.mmc: MRQ: cmd 53
[   31.900000] atmel_mci fff84000.mmc: start request: cmd 53
[   31.900000] atmel_mci fff84000.mmc: IRQ: tx buffer empty
[   31.900000] atmel_mci fff84000.mmc: (atmci_pdc_complete) set pending xfer complete
[   31.900000] atmel_mci fff84000.mmc: IRQ: cmd ready
[   31.900000] atmel_mci fff84000.mmc: set pending cmd rdy
[   31.900000] atmel_mci fff84000.mmc: FSM: state=1
[   31.900000] atmel_mci fff84000.mmc: FSM: cmd ready?
[   31.900000] atmel_mci fff84000.mmc: set completed cmd ready
[   31.900000] atmel_mci fff84000.mmc: command with data transfer
[   31.900000] atmel_mci fff84000.mmc: FSM: state=2
[   31.900000] atmel_mci fff84000.mmc: FSM: xfer complete?
[   31.900000] atmel_mci fff84000.mmc: (atmci_tasklet_func) set completed xfer complete
[   31.900000] atmel_mci fff84000.mmc: FSM: state=3
[   31.900000] atmel_mci fff84000.mmc: FSM: not busy?
[   33.900000] atmel_mci fff84000.mmc: software timeout
[   33.900000] atmel_mci fff84000.mmc: FSM: state=5
[   33.900000] atmel_mci fff84000.mmc: FSM: state=0

The BLKE bit is never set by the hardware.

By setting the ATMEL_PDC_TCR register with a value equals to 4 when the
datasize sent is smaller than 16 bytes, it looks to solve the problem.

Note that in the old at91_mci driver, the value was set to 3 but in my
case it doesn't work...
http://lxr.free-electrons.com/source/drivers/mmc/host/at91_mci.c?v=3.7#L580
So I made the assumption that the transfer size should be >= 16 bytes.

This patch has been tested with a TI wl1271 sdio module.

Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
---

Hi Ludovic,

With this patch I'm able to use the wlan sdio module wl1271.
When you've time, it would be nice to validate or fix this
patch.

Thanks for your help,

Olivier

 drivers/mmc/host/atmel-mci.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index b86b482..c599731 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -45,6 +45,7 @@
 
 #define ATMCI_DATA_ERROR_FLAGS	(ATMCI_DCRCE | ATMCI_DTOE | ATMCI_OVRE | ATMCI_UNRE)
 #define ATMCI_DMA_THRESHOLD	16
+#define ATMCI_PDC_MIN_DATASIZE	16
 
 enum {
 	EVENT_CMD_RDY = 0,
@@ -765,7 +766,10 @@ static void atmci_pdc_set_single_buf(struct atmel_mci *host,
 	}
 
 	if (host->data_size <= buf_size) {
-		if (host->data_size & 0x3) {
+		if ((host->data_size < ATMCI_PDC_MIN_DATASIZE) &&
+		    (dir == XFER_TRANSMIT)) {
+			atmci_writel(host, counter_reg, 4);
+		} else if (host->data_size & 0x3) {
 			/* If size is different from modulo 4, transfer bytes */
 			atmci_writel(host, counter_reg, host->data_size);
 			atmci_writel(host, ATMCI_MR, host->mode_reg | ATMCI_MR_PDCFBYTE);
-- 
1.7.9.5

