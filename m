From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH RESEND 2/3] mmc: mvsdio: workaround for spurious irqs
Date: Sat, 26 Apr 2014 21:34:14 +0200
Message-ID: <1398540855-27367-3-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398540855-27367-1-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

SDIO controllers found on Marvell Kirkwood SoCs seem to cause a late,
spurious irq although all interrupts have been disabled. This irq
doesn't do any harm, neither to HW nor driver. To avoid some
"unexpected irq" warning later, we workaround above issue by bailing
out of irq handler early, if we didn't expect any.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
Cc: Nicolas Pitre <nico@fluxnic.net>
Cc: Chris Ball <chris@printf.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/mmc/host/mvsdio.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 41aca7f28c23..9377284f8544 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -354,6 +354,20 @@ static irqreturn_t mvsd_irq(int irq, void *dev)
 		intr_status, mvsd_read(MVSD_NOR_INTR_EN),
 		mvsd_read(MVSD_HW_STATE));
 
+	/*
+	 * It looks like, SDIO IP can issue one late, spurious irq
+	 * although all irqs should be disabled. To work around this,
+	 * bail out early, if we didn't expect any irqs to occur.
+	 */
+	if (!mvsd_read(MVSD_NOR_INTR_EN) && !mvsd_read(MVSD_ERR_INTR_EN)) {
+		dev_dbg(host->dev, "spurious irq detected intr 0x%04x intr_en 0x%04x erri 0x%04x erri_en 0x%04x\n",
+			mvsd_read(MVSD_NOR_INTR_STATUS),
+			mvsd_read(MVSD_NOR_INTR_EN),
+			mvsd_read(MVSD_ERR_INTR_STATUS),
+			mvsd_read(MVSD_ERR_INTR_EN));
+		return IRQ_HANDLED;
+	}
+
 	spin_lock(&host->lock);
 
 	/* PIO handling, if needed. Messy business... */
-- 
1.9.1
