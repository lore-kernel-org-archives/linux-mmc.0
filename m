From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: [PATCH v4.4.y] mmc: tmio_mmc_core: don't claim spurious interrupts
Date: Sun, 24 Mar 2019 20:32:12 +0300
Message-ID: <948c139f-aef2-efb9-6b73-c293883ab368@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
Content-Language: en-MW
Sender: stable-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, GregKH <gregkh@linuxfoundation.org>
Cc: linux-renesas-soc@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Commit 5c27ff5db1491a947264d6d4e4cbe43ae6535bae upstream.

I have encountered an interrupt storm during the eMMC chip probing (and
the chip finally didn't get detected).  It turned out that U-Boot left
the DMAC interrupts enabled while the Linux driver  didn't use those.
The SDHI driver's interrupt handler somehow assumes that, even if an
SDIO interrupt didn't happen, it should return IRQ_HANDLED.  I think
that if none of the enabled interrupts happened and got handled, we
should return IRQ_NONE -- that way the kernel IRQ code recoginizes
a spurious interrupt and masks it off pretty quickly...

Fixes: 7729c7a232a9 ("mmc: tmio: Provide separate interrupt handlers")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'linux-4.4.y' branch of the -stable repo.

 drivers/mmc/host/tmio_mmc_pio.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

Index: linux-stable/drivers/mmc/host/tmio_mmc_pio.c
===================================================================
--- linux-stable.orig/drivers/mmc/host/tmio_mmc_pio.c
+++ linux-stable/drivers/mmc/host/tmio_mmc_pio.c
@@ -716,7 +716,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	unsigned int sdio_status;
 
 	if (!(pdata->flags & TMIO_MMC_SDIO_IRQ))
-		return IRQ_HANDLED;
+		return IRQ_NONE;
 
 	status = sd_ctrl_read16(host, CTL_SDIO_STATUS);
 	ireg = status & TMIO_SDIO_MASK_ALL & ~host->sdcard_irq_mask;
@@ -730,7 +730,7 @@ irqreturn_t tmio_mmc_sdio_irq(int irq, v
 	if (mmc->caps & MMC_CAP_SDIO_IRQ && ireg & TMIO_SDIO_STAT_IOIRQ)
 		mmc_signal_sdio_irq(mmc);
 
-	return IRQ_HANDLED;
+	return IRQ_RETVAL(ireg);
 }
 EXPORT_SYMBOL(tmio_mmc_sdio_irq);
 
@@ -747,9 +747,7 @@ irqreturn_t tmio_mmc_irq(int irq, void *
 	if (__tmio_mmc_sdcard_irq(host, ireg, status))
 		return IRQ_HANDLED;
 
-	tmio_mmc_sdio_irq(irq, devid);
-
-	return IRQ_HANDLED;
+	return tmio_mmc_sdio_irq(irq, devid);
 }
 EXPORT_SYMBOL(tmio_mmc_irq);
 
