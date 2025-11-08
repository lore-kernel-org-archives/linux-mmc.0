Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12FE27D77D
	for <linux-mmc@vger.kernel.org>; Sat,  8 Nov 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762643601; cv=none; b=K73FVuGSluA+Jo6QUHHW0vbP/OIKURoyzrFr46TQa/FttvaRtyYhT04gpGGq6+paMzP7HKKeTu2OEZyO9dJrnpe5vH8hWN/IgjY+xCLWxbG+tSZey0Q3hZaBI/V1QmC1/VNBnjtIL6JXIdOxrl34PE8IUJLMnEQ3tiJ6B44Abck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762643601; c=relaxed/simple;
	bh=t6OdCqHs88/HVmaNTXkOdzH+CqRafKqsTXZ8TPidQC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scOuY/ae1MYd/pPNR1DqSY5LuL96LV6hWj14AjFITCAvDGkMxReEnRcSQvVC2XEVHTXsQ86SuiSwkQFL848NM6rKaOUJw/JWGqFCIb1IUd0edFnUzNCOxDGY1LNlmf1CLflTm6jK1bANUX0h1aqEztoVHTvpSBYq1CV1HB8WA5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=hgcVt39f; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="hgcVt39f"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso2118234a12.3
        for <linux-mmc@vger.kernel.org>; Sat, 08 Nov 2025 15:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1762643598; x=1763248398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWMhP1DF9JlU6IACRYH5DYXfm0imCEwHF1aCiJZS7sI=;
        b=hgcVt39fNnm4ipVGwdrcl0eqtxmzN+COewm/Q5N8T7gvT+8UfyWRtac+KxAtsCXWoP
         kiSV319Ei6r9PRrPK4U0oSQgQr4HILtYcblBCmmsVdu7jUwC4xg5W8qeMpU6En88W+Cn
         2eAB5BwzuCLxyK5Oj/Jb9OKFs2WAiLjzxCgBcNlVpwfcoG7FOgemLRvEd60StpmE227F
         u7icVGIY6WxFXRJenTBhWyZXrvpLiw2TNcYRI5obFMfP6yQ08ZRQVipZisfCW7HG6m9L
         QW0f4mgHBJM6itE7WeMP4nnyP7jMgKlL5R64b7pTfi+nbdoW86qVroNmWl7oYd35NIDs
         inIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762643598; x=1763248398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kWMhP1DF9JlU6IACRYH5DYXfm0imCEwHF1aCiJZS7sI=;
        b=u4HNju9tfjSSvkxd3WVYIL0Dz5k9gDmL3N/0kin4vVmZPyndOsx/zw/jlkSEUpZSAo
         ex/A76yX9aQgh8JbvcKi59T4vcj0+ofvsyps3QtGnZSlIMPJSE2YI0uHZht19wyfPoUL
         iluBkGt0eMeTeeGUuSqg6dSQ2kPQQmAE/wb1xpgrSp7/V1PRk78rqY/y5Dss6KZTNmee
         PJI0ubChRPSZLlB1KTzPst3Sufg+R7tJcSCeMw+E2HxmDgsSnnOGOx3yAlexsRHv+nBc
         nx3ZMvT13YyVgdloGUajC+aiOjuYYXHVECA8JmFXCP1MDqIg9f7NLdsITYdp00AQKUMo
         SN8g==
X-Forwarded-Encrypted: i=1; AJvYcCUfip/spYyBZ8rR1qvaCYxhoepbCbAMYm7Ocg9NOA0osVTz29pSlmNFvtEB6YBfFUbUMiXEWkhXkKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwFAml61DtP0iMcJfqAeOBgCpqgnPiv5LlmfGwNLdWqBQcNgE
	QPom/ERRvertPffXI3nLlK+QWatVCt25Qpp3DziuZn9PLUiMTqSvAK6K
X-Gm-Gg: ASbGncuy2+JVTs2T23ND+VgP74AnRdxiiyEvZbesDIs/D+nF7oh7/nSzImxlxqREfvm
	Clij4QGqxFrXZiJMxndwHeigcjQhvjlggwHXzBIksdLtHoq6TN+kXDsu3DTJW6plChhLU6/JHQz
	CzcEyYNAIiMhO9zYkShTLoIfcH50k/jutwfJv/efUsNcCW2OLdrRtc9IWvzcNztYSVnPIGUJUv6
	85wzy9kNCFL3MAs+7i17jWcioqCUppEQz8QzKIXFQzXWATzoMHB2oMfvzd7gzK12yHlnTUq4S/B
	4NGNYPiOwwxQs2b5EloDOwF8gDacOKS2Rb4/PkGYMUDTBCeiv0pkGk7KwzP8ZU1vlzOEO91iU40
	rrRxWfZkVtfhkYeQJiEGbbLj/y0snCeaEO2rQsZfasLeGALPm7HLqiXvpnUh2/Jr5ESQ8ExfQby
	wsMSJXNn6tEYV7AaDlB36ScdQPM0JQ/P5pTgXv0vu4tXcgToWKGo2quHdrhFY+wilGdYlHuYsJl
	BGHx+wktFvtuxfWGnXqWUylVWP0i03qvaBgNZX1eT0=
X-Google-Smtp-Source: AGHT+IFGoyUr3fFUDtjdAJDaQ9diGHZMiMCjyMWKaOhYx4Nyqo8YNV94OzI3uycOIQUa86kK/iszdg==
X-Received: by 2002:a05:6402:354b:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6415e822920mr2630715a12.24.1762643597799;
        Sat, 08 Nov 2025 15:13:17 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a9b3-6600-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a9b3:6600:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-6411f814164sm7642807a12.13.2025.11.08.15.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 15:13:16 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 1/7] mmc: meson-mx-sdio: Switch to regmap for register access
Date: Sun,  9 Nov 2025 00:12:47 +0100
Message-ID: <20251108231253.1641927-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
References: <20251108231253.1641927-1-martin.blumenstingl@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch the driver over to use regmap to access the registers. This makes
it consistent with the other Amlogic MMC drivers. No functional changes
intended.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/mmc/host/Kconfig         |   1 +
 drivers/mmc/host/meson-mx-sdio.c | 125 ++++++++++++++++---------------
 2 files changed, 64 insertions(+), 62 deletions(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 2c963cb6724b..027ef2540913 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -504,6 +504,7 @@ config MMC_MESON_MX_SDIO
 	depends on ARCH_MESON || COMPILE_TEST
 	depends on COMMON_CLK
 	depends on OF_ADDRESS
+	select REGMAP_MMIO
 	help
 	  This selects support for the SD/MMC Host Controller on
 	  Amlogic Meson6, Meson8 and Meson8b SoCs.
diff --git a/drivers/mmc/host/meson-mx-sdio.c b/drivers/mmc/host/meson-mx-sdio.c
index 8a49c32fd3f9..2448f21bd683 100644
--- a/drivers/mmc/host/meson-mx-sdio.c
+++ b/drivers/mmc/host/meson-mx-sdio.c
@@ -19,6 +19,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/of_platform.h>
+#include <linux/regmap.h>
 #include <linux/timer.h>
 #include <linux/types.h>
 
@@ -108,7 +109,7 @@ struct meson_mx_mmc_host {
 	struct clk_fixed_factor		fixed_factor;
 	struct clk			*fixed_factor_clk;
 
-	void __iomem			*base;
+	struct regmap			*regmap;
 	int				irq;
 	spinlock_t			irq_lock;
 
@@ -122,22 +123,10 @@ struct meson_mx_mmc_host {
 	int				error;
 };
 
-static void meson_mx_mmc_mask_bits(struct mmc_host *mmc, char reg, u32 mask,
-				   u32 val)
-{
-	struct meson_mx_mmc_host *host = mmc_priv(mmc);
-	u32 regval;
-
-	regval = readl(host->base + reg);
-	regval &= ~mask;
-	regval |= (val & mask);
-
-	writel(regval, host->base + reg);
-}
-
 static void meson_mx_mmc_soft_reset(struct meson_mx_mmc_host *host)
 {
-	writel(MESON_MX_SDIO_IRQC_SOFT_RESET, host->base + MESON_MX_SDIO_IRQC);
+	regmap_write(host->regmap, MESON_MX_SDIO_IRQC,
+		     MESON_MX_SDIO_IRQC_SOFT_RESET);
 	udelay(2);
 }
 
@@ -158,7 +147,7 @@ static void meson_mx_mmc_start_cmd(struct mmc_host *mmc,
 	struct meson_mx_mmc_host *host = mmc_priv(mmc);
 	unsigned int pack_size;
 	unsigned long irqflags, timeout;
-	u32 mult, send = 0, ext = 0;
+	u32 send = 0, ext = 0;
 
 	host->cmd = cmd;
 
@@ -215,25 +204,22 @@ static void meson_mx_mmc_start_cmd(struct mmc_host *mmc,
 
 	spin_lock_irqsave(&host->irq_lock, irqflags);
 
-	mult = readl(host->base + MESON_MX_SDIO_MULT);
-	mult &= ~MESON_MX_SDIO_MULT_PORT_SEL_MASK;
-	mult |= FIELD_PREP(MESON_MX_SDIO_MULT_PORT_SEL_MASK, host->slot_id);
-	mult |= BIT(31);
-	writel(mult, host->base + MESON_MX_SDIO_MULT);
+	regmap_update_bits(host->regmap, MESON_MX_SDIO_MULT,
+			   MESON_MX_SDIO_MULT_PORT_SEL_MASK | BIT(31),
+			   FIELD_PREP(MESON_MX_SDIO_MULT_PORT_SEL_MASK,
+				      host->slot_id) | BIT(31));
 
 	/* enable the CMD done interrupt */
-	meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQC,
-			       MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN,
-			       MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN);
+	regmap_set_bits(host->regmap, MESON_MX_SDIO_IRQC,
+			MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN);
 
 	/* clear pending interrupts */
-	meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_IRQS,
-			       MESON_MX_SDIO_IRQS_CMD_INT,
-			       MESON_MX_SDIO_IRQS_CMD_INT);
+	regmap_set_bits(host->regmap, MESON_MX_SDIO_IRQS,
+			MESON_MX_SDIO_IRQS_CMD_INT);
 
-	writel(cmd->arg, host->base + MESON_MX_SDIO_ARGU);
-	writel(ext, host->base + MESON_MX_SDIO_EXT);
-	writel(send, host->base + MESON_MX_SDIO_SEND);
+	regmap_write(host->regmap, MESON_MX_SDIO_ARGU, cmd->arg);
+	regmap_write(host->regmap, MESON_MX_SDIO_EXT, ext);
+	regmap_write(host->regmap, MESON_MX_SDIO_SEND, send);
 
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
@@ -263,14 +249,13 @@ static void meson_mx_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	switch (ios->bus_width) {
 	case MMC_BUS_WIDTH_1:
-		meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
-				       MESON_MX_SDIO_CONF_BUS_WIDTH, 0);
+		regmap_clear_bits(host->regmap, MESON_MX_SDIO_CONF,
+				  MESON_MX_SDIO_CONF_BUS_WIDTH);
 		break;
 
 	case MMC_BUS_WIDTH_4:
-		meson_mx_mmc_mask_bits(mmc, MESON_MX_SDIO_CONF,
-				       MESON_MX_SDIO_CONF_BUS_WIDTH,
-				       MESON_MX_SDIO_CONF_BUS_WIDTH);
+		regmap_set_bits(host->regmap, MESON_MX_SDIO_CONF,
+				MESON_MX_SDIO_CONF_BUS_WIDTH);
 		break;
 
 	case MMC_BUS_WIDTH_8:
@@ -351,8 +336,8 @@ static void meson_mx_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	host->mrq = mrq;
 
 	if (mrq->data)
-		writel(sg_dma_address(mrq->data->sg),
-		       host->base + MESON_MX_SDIO_ADDR);
+		regmap_write(host->regmap, MESON_MX_SDIO_ADDR,
+			     sg_dma_address(mrq->data->sg));
 
 	if (mrq->sbc)
 		meson_mx_mmc_start_cmd(mmc, mrq->sbc);
@@ -364,24 +349,26 @@ static void meson_mx_mmc_read_response(struct mmc_host *mmc,
 				       struct mmc_command *cmd)
 {
 	struct meson_mx_mmc_host *host = mmc_priv(mmc);
-	u32 mult;
-	int i, resp[4];
+	unsigned int i, resp[4];
 
-	mult = readl(host->base + MESON_MX_SDIO_MULT);
-	mult |= MESON_MX_SDIO_MULT_WR_RD_OUT_INDEX;
-	mult &= ~MESON_MX_SDIO_MULT_RESP_READ_INDEX_MASK;
-	mult |= FIELD_PREP(MESON_MX_SDIO_MULT_RESP_READ_INDEX_MASK, 0);
-	writel(mult, host->base + MESON_MX_SDIO_MULT);
+	regmap_update_bits(host->regmap, MESON_MX_SDIO_MULT,
+			   MESON_MX_SDIO_MULT_WR_RD_OUT_INDEX |
+			   MESON_MX_SDIO_MULT_RESP_READ_INDEX_MASK,
+			   MESON_MX_SDIO_MULT_WR_RD_OUT_INDEX |
+			   FIELD_PREP(MESON_MX_SDIO_MULT_RESP_READ_INDEX_MASK,
+				      0));
 
 	if (cmd->flags & MMC_RSP_136) {
 		for (i = 0; i <= 3; i++)
-			resp[3 - i] = readl(host->base + MESON_MX_SDIO_ARGU);
+			regmap_read(host->regmap, MESON_MX_SDIO_ARGU,
+				    &resp[3 - i]);
+
 		cmd->resp[0] = (resp[0] << 8) | ((resp[1] >> 24) & 0xff);
 		cmd->resp[1] = (resp[1] << 8) | ((resp[2] >> 24) & 0xff);
 		cmd->resp[2] = (resp[2] << 8) | ((resp[3] >> 24) & 0xff);
 		cmd->resp[3] = (resp[3] << 8);
 	} else if (cmd->flags & MMC_RSP_PRESENT) {
-		cmd->resp[0] = readl(host->base + MESON_MX_SDIO_ARGU);
+		regmap_read(host->regmap, MESON_MX_SDIO_ARGU, &cmd->resp[0]);
 	}
 }
 
@@ -422,8 +409,8 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
 
 	spin_lock(&host->irq_lock);
 
-	irqs = readl(host->base + MESON_MX_SDIO_IRQS);
-	send = readl(host->base + MESON_MX_SDIO_SEND);
+	regmap_read(host->regmap, MESON_MX_SDIO_IRQS, &irqs);
+	regmap_read(host->regmap, MESON_MX_SDIO_SEND, &send);
 
 	if (irqs & MESON_MX_SDIO_IRQS_CMD_INT)
 		ret = meson_mx_mmc_process_cmd_irq(host, irqs, send);
@@ -431,7 +418,7 @@ static irqreturn_t meson_mx_mmc_irq(int irq, void *data)
 		ret = IRQ_HANDLED;
 
 	/* finally ACK all pending interrupts */
-	writel(irqs, host->base + MESON_MX_SDIO_IRQS);
+	regmap_write(host->regmap, MESON_MX_SDIO_IRQS, irqs);
 
 	spin_unlock(&host->irq_lock);
 
@@ -470,14 +457,13 @@ static void meson_mx_mmc_timeout(struct timer_list *t)
 	struct meson_mx_mmc_host *host = timer_container_of(host, t,
 							    cmd_timeout);
 	unsigned long irqflags;
-	u32 irqc;
+	u32 irqs, argu;
 
 	spin_lock_irqsave(&host->irq_lock, irqflags);
 
 	/* disable the CMD interrupt */
-	irqc = readl(host->base + MESON_MX_SDIO_IRQC);
-	irqc &= ~MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN;
-	writel(irqc, host->base + MESON_MX_SDIO_IRQC);
+	regmap_clear_bits(host->regmap, MESON_MX_SDIO_IRQC,
+			  MESON_MX_SDIO_IRQC_ARC_CMD_INT_EN);
 
 	spin_unlock_irqrestore(&host->irq_lock, irqflags);
 
@@ -488,10 +474,12 @@ static void meson_mx_mmc_timeout(struct timer_list *t)
 	if (!host->cmd)
 		return;
 
+	regmap_read(host->regmap, MESON_MX_SDIO_IRQS, &irqs);
+	regmap_read(host->regmap, MESON_MX_SDIO_ARGU, &argu);
+
 	dev_dbg(mmc_dev(host->mmc),
 		"Timeout on CMD%u (IRQS = 0x%08x, ARGU = 0x%08x)\n",
-		host->cmd->opcode, readl(host->base + MESON_MX_SDIO_IRQS),
-		readl(host->base + MESON_MX_SDIO_ARGU));
+		host->cmd->opcode, irqs, argu);
 
 	host->cmd->error = -ETIMEDOUT;
 
@@ -578,7 +566,8 @@ static int meson_mx_mmc_add_host(struct meson_mx_mmc_host *host)
 	return 0;
 }
 
-static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
+static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host,
+				      void __iomem *base)
 {
 	struct clk_init_data init;
 	const char *clk_div_parent, *clk_fixed_factor_parent;
@@ -613,7 +602,7 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 	init.flags = CLK_SET_RATE_PARENT;
 	init.parent_names = &clk_div_parent;
 	init.num_parents = 1;
-	host->cfg_div.reg = host->base + MESON_MX_SDIO_CONF;
+	host->cfg_div.reg = base + MESON_MX_SDIO_CONF;
 	host->cfg_div.shift = MESON_MX_SDIO_CONF_CMD_CLK_DIV_SHIFT;
 	host->cfg_div.width = MESON_MX_SDIO_CONF_CMD_CLK_DIV_WIDTH;
 	host->cfg_div.hw.init = &init;
@@ -629,12 +618,23 @@ static int meson_mx_mmc_register_clks(struct meson_mx_mmc_host *host)
 
 static int meson_mx_mmc_probe(struct platform_device *pdev)
 {
+	const struct regmap_config meson_mx_sdio_regmap_config = {
+		.reg_bits = 8,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = MESON_MX_SDIO_EXT,
+	};
 	struct platform_device *slot_pdev;
 	struct mmc_host *mmc;
 	struct meson_mx_mmc_host *host;
+	void __iomem *base;
 	int ret, irq;
 	u32 conf;
 
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
 	slot_pdev = meson_mx_mmc_slot_pdev(&pdev->dev);
 	if (!slot_pdev)
 		return -ENODEV;
@@ -656,9 +656,10 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, host);
 
-	host->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host->base)) {
-		ret = PTR_ERR(host->base);
+	host->regmap = devm_regmap_init_mmio(&pdev->dev, base,
+					     &meson_mx_sdio_regmap_config);
+	if (IS_ERR(host->regmap)) {
+		ret = PTR_ERR(host->regmap);
 		goto error_free_mmc;
 	}
 
@@ -687,7 +688,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 		goto error_free_mmc;
 	}
 
-	ret = meson_mx_mmc_register_clks(host);
+	ret = meson_mx_mmc_register_clks(host, base);
 	if (ret)
 		goto error_free_mmc;
 
@@ -708,7 +709,7 @@ static int meson_mx_mmc_probe(struct platform_device *pdev)
 	conf |= FIELD_PREP(MESON_MX_SDIO_CONF_M_ENDIAN_MASK, 0x3);
 	conf |= FIELD_PREP(MESON_MX_SDIO_CONF_WRITE_NWR_MASK, 0x2);
 	conf |= FIELD_PREP(MESON_MX_SDIO_CONF_WRITE_CRC_OK_STATUS_MASK, 0x2);
-	writel(conf, host->base + MESON_MX_SDIO_CONF);
+	regmap_write(host->regmap, MESON_MX_SDIO_CONF, conf);
 
 	meson_mx_mmc_soft_reset(host);
 
-- 
2.51.2

