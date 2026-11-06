Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957561;
	b=0g0lOARRvflqEbn5QjauFj0+XEZaAnFhx9IA7csiH28phNE2fkQ5IHqXuvrbizBxhTnI
	 H7h+WTRAmma3ZtMJQE6TVtpYWv2aJttx6mrtdGKY/U4TGPn2q3dt7qfzJNi8LZc5MGY6y
	 nEgtu4R4GpzojeIrHDCpmM3Nk3jYduztFLCBq/84h8qHBmzch5lnp91IsvRl0RIdsPwPM
	 5n6sYN+3x0DClz+/cNtPr22yIQeEcNWikLKToFgdcHAju9OZV8MkDn75U2CJqRJeI50gR
	 ZiUwigNncjqHy7rC3Yymcs93nyO4TYiCqjccBvndYsx+v9LBxdEhWjz0ZXg++31ZsSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957561;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=/pk6ULmXfQ95ME0Gq8W2v45Asz28C+GIm9iPSb5AU18=;
	b=B5Ee6qg9yJpc95c98i7AQrbDMd0Tx0E/j5Y1RlAFZwobqPqP50ZWBD8eEGnJZOWY8D0Z
	 HMpLBmqGzAhypE6xIZB4rLdePqpYhVzondleriFLOS5/NsvFTPKkOYMjL2EG2iG3uzuIa
	 8x1e6nvr5ujIXkiGm1mCr2SgI0UMxXnUhgqVDZL2uB7Cw/FeGCyYr9wByEbeZyzQ6d1IR
	 gtQW0BZ/Ifo1fo0bNvsjHWPlEqNaesYD82y3U1bL26bEAmkMNE780AJFvDDlDa29/n8w/
	 nlsbunX5BIGDa7+fs+evEp+SDZ8kjOloW6BXEtFnRi3sFnV7gZBMzK1IUIvUQzV6tKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HDMy52k+;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96160A2630
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 09:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B96160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HDMy52k+
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 15E024E413E9;
	Fri,  6 Nov 2026 09:32:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB2A05FFBC;
	Fri,  6 Nov 2026 09:32:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4762D10329258;
	Fri,  6 Nov 2026 10:32:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957554; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=/pk6ULmXfQ95ME0Gq8W2v45Asz28C+GIm9iPSb5AU18=;
	b=HDMy52k+sl/ZYv442qVGeV8sQTenwpGjhJue16yO7oHavl8Ippl5QMLXDYHGBrpxX51bF5
	jmPYFVFMIaQmupnmTvT1wj2w+5D0rfHDnVuPrd53Oebc4+H15/X3Y3VYmDrKrA37zsLMRA
	gwhe+tUTkp3rbQ0ssHUoVUMgbhIdAM++kWn88qLRq7TQOgtA0JY+0aGMYnQaGCSeBOiNYs
	cL6F3Qy9Bp+RBiidUuMelS9S9oGLO5wuBfTEC2Qep1CCwj5meB1urZMUGZvaVpPOfyZO+f
	i6ED/vfk5nIheNjG27mh9NqVGu7qyoT+7oVknhnAenhvbqf3urJFlDvCVdMlQg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:14 +0100
Subject: [PATCH 17/25] spi: atcspi200: add optional interrupt support
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261106-mt2824-v1-17-86087eaf5af4@bootlin.com>
References: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
In-Reply-To: <20261106-mt2824-v1-0-86087eaf5af4@bootlin.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jun Chang <jun.chang@metanoia-comm.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Sebastian Reichel <sre@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Conor Dooley <conor@kernel.org>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Ben Zong-You Xie <ben717@andestech.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Jisheng Zhang <jszhang@kernel.org>, CL Wang <cl634@andestech.com>, 
 Mark Brown <broonie@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wim Van Sebroeck <wim@linux-watchdog.org>, 
 Guenter Roeck <linux@roeck-us.net>, Adrian Hunter <adrian.hunter@intel.com>, 
 Minas Harutyunyan <hminas@synopsys.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 =?utf-8?q?Randolph_Sheng-Kai_Lin=28=E6=9E=97=E8=81=96=E5=87=B1=29?= <randolph@andestech.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-phy@lists.infradead.org, Paul Walmsley <paul.walmsley@sifive.com>, 
 linux-mmc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

For PIO transfers, the driver busy-polls the FIFO empty/full flags and
the SPI active bit for completion. When the controller's interrupt is
available, use it instead of polling to keep the FIFO serviced and to
detect the end of transfer.

Interrupts are optional. Controllers without an interrupt keep using the
polling path, as do command-only transfers; the driver also falls back to
polling when the interrupt cannot be requested.

The command register is now written when a transfer is started instead of
in atcspi_prepare_trans(), so the interrupt path can enable interrupts
before starting the transfer and the first FIFO or end-of-transfer
event is not missed. As a result, it is also set at the beginning of
atcspi_dma_trans() and atcspi_xfer_data_poll(), and in the command-only
path of atcspi_exec_mem_op().

Introduce atcspi_reset_engine() as a helper to reset the SPI controller
and the FIFOs, and use on transfer error and in atcspi_setup().

The interrupt path configures the FIFO thresholds for the transfer and
restores them afterwards. It acknowledges the interrupt status before
servicing the FIFOs so events arriving during servicing are not lost,
and resets the controller if a transfer times out or completes with
transmit/receive words left unhandled.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/spi/spi-atcspi200.c | 255 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 245 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index b532c58c0ab9..df932620a690 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 #include <linux/err.h>
 #include <linux/errno.h>
+#include <linux/interrupt.h>
 #include <linux/jiffies.h>
 #include <linux/minmax.h>
 #include <linux/module.h>
@@ -20,6 +21,7 @@
 #include <linux/regmap.h>
 #include <linux/spi/spi.h>
 #include <linux/spi/spi-mem.h>
+#include <linux/unaligned.h>
 
 /* Register definitions  */
 #define ATCSPI_TRANS_FMT	0x10	/* SPI transfer format register */
@@ -29,6 +31,8 @@
 #define ATCSPI_DATA		0x2C	/* SPI data register */
 #define ATCSPI_CTRL		0x30	/* SPI control register */
 #define ATCSPI_STATUS		0x34	/* SPI status register */
+#define ATCSPI_INTR_EN		0x38	/* SPI interrupt enable register */
+#define ATCSPI_INTR_ST		0x3C	/* SPI interrupt status register */
 #define ATCSPI_TIMING		0x40	/* SPI interface timing register */
 #define ATCSPI_CONFIG		0x7C	/* SPI configuration register */
 
@@ -62,11 +66,23 @@
 #define CTRL_TX_FIFO_RST	BIT(2)
 #define CTRL_RX_DMA_EN		BIT(3)
 #define CTRL_TX_DMA_EN		BIT(4)
+#define CTRL_TX_THRES		GENMASK(23, 16)
+#define CTRL_RX_THRES		GENMASK(15, 8)
 
 /* Status register */
 #define ATCSPI_ACTIVE		BIT(0)
 #define ATCSPI_RX_EMPTY		BIT(14)
 #define ATCSPI_TX_FULL		BIT(23)
+#define ATCSPI_RXNUM_LO(x)	FIELD_GET(GENMASK(13, 8), (x))
+#define ATCSPI_RXNUM_HI(x)	FIELD_GET(GENMASK(25, 24), (x))
+#define ATCSPI_TXNUM_LO(x)	FIELD_GET(GENMASK(21, 16), (x))
+#define ATCSPI_TXNUM_HI(x)	FIELD_GET(GENMASK(29, 28), (x))
+
+/* Interrupt enable/status registers */
+#define ATCSPI_END_INT		BIT(4)
+#define ATCSPI_TX_FIFO_INT	BIT(3)
+#define ATCSPI_RX_FIFO_INT	BIT(2)
+#define ATCSPI_INTR_ALL		GENMASK(5, 0)
 
 /* Interface timing setting */
 #define TIMING_SCLK_DIV_MASK	GENMASK(7, 0)
@@ -104,6 +120,12 @@
  *                  the current transfer.
  * @use_dma:        Enable DMA mode if ATCSPI_DMA_SUPPORT is set and DMA is
  *                  successfully configured.
+ * @irq:            The controller interrupt, or 0 when it is not wired.
+ * @xfer_done:      Completion signalled by the interrupt handler.
+ * @tx_ptr:         Current position in the transmit buffer.
+ * @tx_words:       Number of FIFO entries left to transmit.
+ * @rx_ptr:         Current position in the receive buffer.
+ * @rx_words:       Number of FIFO entries left to receive.
  */
 struct atcspi_dev {
 	struct spi_controller	*host;
@@ -119,6 +141,12 @@ struct atcspi_dev {
 	unsigned int		rxfifo_size;
 	bool			data_merge;
 	bool			use_dma;
+	int			irq;
+	struct completion	xfer_done;
+	const void		*tx_ptr;
+	unsigned int		tx_words;
+	void			*rx_ptr;
+	unsigned int		rx_words;
 };
 
 static int atcspi_wait_fifo_ready(struct atcspi_dev *spi,
@@ -141,6 +169,193 @@ static int atcspi_wait_fifo_ready(struct atcspi_dev *spi,
 	return ret;
 }
 
+static unsigned int atcspi_rx_fifo_avail(unsigned int status)
+{
+	return ATCSPI_RXNUM_LO(status) | (ATCSPI_RXNUM_HI(status) << 6);
+}
+
+static unsigned int atcspi_tx_fifo_avail(struct atcspi_dev *spi, unsigned int status)
+{
+	unsigned int n = ATCSPI_TXNUM_LO(status) | (ATCSPI_TXNUM_HI(status) << 6);
+
+	return n < spi->txfifo_size ? spi->txfifo_size - n : 0;
+}
+
+static void atcspi_fifo_read(struct atcspi_dev *spi, void *dst, unsigned int nb_words)
+{
+	unsigned int val, i;
+
+	if (spi->data_merge) {
+		unsigned int *buf = dst;
+
+		for (i = 0; i < nb_words; i++) {
+			regmap_read(spi->regmap, ATCSPI_DATA, &val);
+			put_unaligned(val, buf++);
+		}
+	} else {
+		unsigned char *buf = dst;
+
+		for (i = 0; i < nb_words; i++) {
+			regmap_read(spi->regmap, ATCSPI_DATA, &val);
+			*buf++ = (unsigned char)val;
+		}
+	}
+}
+
+static void atcspi_fifo_write(struct atcspi_dev *spi, const void *src, unsigned int nb_words)
+{
+	unsigned int val, i;
+
+	if (spi->data_merge) {
+		const unsigned int *buf = src;
+
+		for (i = 0; i < nb_words; i++) {
+			val = get_unaligned(buf++);
+			regmap_write(spi->regmap, ATCSPI_DATA, val);
+		}
+	} else {
+		const unsigned char *buf = src;
+
+		for (i = 0; i < nb_words; i++) {
+			val = *buf++;
+			regmap_write(spi->regmap, ATCSPI_DATA, val);
+		}
+	}
+}
+
+static irqreturn_t atcspi_irq(int irq, void *dev_id)
+{
+	struct atcspi_dev *spi = dev_id;
+	int num_byte = spi->data_merge ? 4 : 1;
+	unsigned int st, en, status, n;
+
+	regmap_read(spi->regmap, ATCSPI_INTR_ST, &st);
+	regmap_read(spi->regmap, ATCSPI_INTR_EN, &en);
+	st &= en;
+	if (!st)
+		return IRQ_NONE;
+
+	regmap_write(spi->regmap, ATCSPI_INTR_ST, st);
+
+	regmap_read(spi->regmap, ATCSPI_STATUS, &status);
+
+	if (st & (ATCSPI_RX_FIFO_INT | ATCSPI_END_INT)) {
+		n = min(atcspi_rx_fifo_avail(status), spi->rx_words);
+		atcspi_fifo_read(spi, spi->rx_ptr, n);
+		spi->rx_words -= n;
+		spi->rx_ptr = (unsigned char *)spi->rx_ptr + n * num_byte;
+	}
+
+	if (st & ATCSPI_TX_FIFO_INT) {
+		n = min(atcspi_tx_fifo_avail(spi, status), spi->tx_words);
+		atcspi_fifo_write(spi, spi->tx_ptr, n);
+		spi->tx_words -= n;
+		spi->tx_ptr = (unsigned char *)spi->tx_ptr + n * num_byte;
+		if (!spi->tx_words) {
+			en &= ~ATCSPI_TX_FIFO_INT;
+			regmap_write(spi->regmap, ATCSPI_INTR_EN, en);
+		}
+	}
+
+	if (st & ATCSPI_END_INT) {
+		regmap_write(spi->regmap, ATCSPI_INTR_EN, 0);
+		complete(&spi->xfer_done);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int atcspi_reset_engine(struct atcspi_dev *spi)
+{
+	unsigned int ctrl_val = CTRL_SPI_RST | CTRL_TX_FIFO_RST | CTRL_RX_FIFO_RST;
+	unsigned int val;
+
+	regmap_write(spi->regmap, ATCSPI_CTRL, ctrl_val);
+
+	return regmap_read_poll_timeout(spi->regmap,
+					ATCSPI_CTRL,
+					val,
+					!(val & ctrl_val),
+					0,
+					ATCSPI_RDY_TIMEOUT_US);
+}
+
+static int atcspi_xfer_data_irq(struct atcspi_dev *spi,
+				const struct spi_mem_op *op)
+{
+	unsigned int ctrl, en = ATCSPI_END_INT;
+	int num_byte = spi->data_merge ? 4 : 1;
+	bool has_timedout = false;
+	int timeout;
+
+	spi->rx_words = 0;
+	spi->tx_words = 0;
+	spi->rx_ptr = op->data.buf.in;
+	spi->tx_ptr = op->data.buf.out;
+
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		spi->rx_words = op->data.nbytes / num_byte;
+		en |= ATCSPI_RX_FIFO_INT;
+	} else {
+		spi->tx_words = op->data.nbytes / num_byte;
+		en |= ATCSPI_TX_FIFO_INT;
+	}
+
+	regmap_read(spi->regmap, ATCSPI_CTRL, &ctrl);
+	ctrl &= ~(CTRL_TX_THRES | CTRL_RX_THRES);
+	ctrl |= FIELD_PREP(CTRL_TX_THRES, spi->txfifo_size / 2) |
+	FIELD_PREP(CTRL_RX_THRES, spi->rxfifo_size / 2);
+	regmap_write(spi->regmap, ATCSPI_CTRL, ctrl);
+
+	reinit_completion(&spi->xfer_done);
+
+	if (spi->tx_words) {
+		unsigned int status, nb_words;
+
+		regmap_read(spi->regmap, ATCSPI_STATUS, &status);
+		nb_words = min(atcspi_tx_fifo_avail(spi, status), spi->tx_words);
+		atcspi_fifo_write(spi, spi->tx_ptr, nb_words);
+		spi->tx_words -= nb_words;
+		spi->tx_ptr = (unsigned char *)spi->tx_ptr + nb_words * num_byte;
+	}
+
+	regmap_write(spi->regmap, ATCSPI_INTR_ST, ATCSPI_INTR_ALL);
+	regmap_write(spi->regmap, ATCSPI_INTR_EN, en);
+
+	regmap_write(spi->regmap, ATCSPI_CMD, op->cmd.opcode);
+
+	timeout = msecs_to_jiffies(ATCSPI_XFER_TIMEOUT(op->data.nbytes));
+	if (!wait_for_completion_timeout(&spi->xfer_done, timeout)) {
+		regmap_write(spi->regmap, ATCSPI_INTR_EN, 0);
+		synchronize_irq(spi->irq);
+
+		if (!completion_done(&spi->xfer_done))
+			has_timedout = true;
+	}
+
+	regmap_write(spi->regmap, ATCSPI_INTR_EN, 0);
+	regmap_write(spi->regmap, ATCSPI_INTR_ST, ATCSPI_INTR_ALL);
+
+	/* Reset the SPI controller if the transfer never completed */
+	if (has_timedout) {
+		atcspi_reset_engine(spi);
+
+		return -ETIMEDOUT;
+	}
+
+	/* Reset the controller for completed but truncated transfer */
+	if (spi->rx_words || spi->tx_words) {
+		atcspi_reset_engine(spi);
+
+		return -EIO;
+	}
+
+	/* restore FIFO thresholds for other transfer paths */
+	regmap_clear_bits(spi->regmap, ATCSPI_CTRL, CTRL_TX_THRES | CTRL_RX_THRES);
+
+	return 0;
+}
+
 static int atcspi_xfer_data_poll(struct atcspi_dev *spi,
 				 const struct spi_mem_op *op)
 {
@@ -151,6 +366,8 @@ static int atcspi_xfer_data_poll(struct atcspi_dev *spi,
 	int num_byte;
 	int ret = 0;
 
+	regmap_write(spi->regmap, ATCSPI_CMD, op->cmd.opcode);
+
 	num_byte = spi->data_merge ? 4 : 1;
 	while (trans_bytes) {
 		if (op->data.dir == SPI_MEM_DATA_OUT) {
@@ -249,7 +466,6 @@ static void atcspi_prepare_trans(struct atcspi_dev *spi,
 	atcspi_set_trans_ctl(spi, op);
 	if (op->addr.nbytes)
 		regmap_write(spi->regmap, ATCSPI_ADDR, op->addr.val);
-	regmap_write(spi->regmap, ATCSPI_CMD, op->cmd.opcode);
 }
 
 static int atcspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
@@ -313,6 +529,8 @@ static int atcspi_dma_trans(struct atcspi_dev *spi,
 	int timeout;
 	int ret;
 
+	regmap_write(spi->regmap, ATCSPI_CMD, op->cmd.opcode);
+
 	regmap_read(spi->regmap, ATCSPI_CTRL, &ctrl);
 	ctrl |= CTRL_TX_DMA_EN | CTRL_RX_DMA_EN;
 	regmap_write(spi->regmap, ATCSPI_CTRL, ctrl);
@@ -373,12 +591,16 @@ static int atcspi_exec_mem_op(struct spi_mem *mem, const struct spi_mem_op *op)
 	if (op->data.nbytes) {
 		if (spi->use_dma && op->data.nbytes >= ATCSPI_DMA_THRESHOLD)
 			ret = atcspi_dma_trans(spi, op);
+		else if (spi->irq)
+			ret = atcspi_xfer_data_irq(spi, op);
 		else
 			ret = atcspi_xfer_data_poll(spi, op);
 		if (ret) {
 			dev_info(spi->dev, "SPI transmission failed\n");
 			goto exec_mem_exit;
 		}
+	} else {
+		regmap_write(spi->regmap, ATCSPI_CMD, op->cmd.opcode);
 	}
 
 	ret = regmap_read_poll_timeout(spi->regmap,
@@ -403,20 +625,12 @@ static const struct spi_controller_mem_ops atcspi_mem_ops = {
 
 static int atcspi_setup(struct atcspi_dev *spi)
 {
-	unsigned int ctrl_val;
 	unsigned int val;
 	int actual_spi_sclk_f;
 	int ret;
 	unsigned char div;
 
-	ctrl_val = CTRL_TX_FIFO_RST | CTRL_RX_FIFO_RST | CTRL_SPI_RST;
-	regmap_write(spi->regmap, ATCSPI_CTRL, ctrl_val);
-	ret = regmap_read_poll_timeout(spi->regmap,
-				       ATCSPI_CTRL,
-				       val,
-				       !(val & ctrl_val),
-				       0,
-				       ATCSPI_RDY_TIMEOUT_US);
+	ret = atcspi_reset_engine(spi);
 	if (ret)
 		return dev_err_probe(spi->dev, ret,
 				     "Timed out waiting for ATCSPI_CTRL\n");
@@ -586,6 +800,27 @@ static int atcspi_probe(struct platform_device *pdev)
 			spi->use_dma = true;
 	}
 
+	spi->irq = platform_get_irq_optional(pdev, 0);
+	if (spi->irq == -ENXIO)
+		spi->irq = 0;
+	else if (spi->irq < 0)
+		return dev_err_probe(spi->dev, spi->irq,
+				     "Failed to get IRQ\n");
+
+	if (spi->irq) {
+		init_completion(&spi->xfer_done);
+		regmap_write(spi->regmap, ATCSPI_INTR_EN, 0);
+
+		ret = devm_request_irq(&pdev->dev, spi->irq, atcspi_irq, 0,
+				       dev_name(&pdev->dev), spi);
+		if (ret) {
+			dev_info(spi->dev,
+				 "Failed to request IRQ %d, fallback to polling\n",
+				 spi->irq);
+			spi->irq = 0;
+		}
+	}
+
 	ret = devm_spi_register_controller(&pdev->dev, host);
 	if (ret)
 		return dev_err_probe(spi->dev, ret,

-- 
2.56.0

