Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521013D5676
	for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782717947; cv=none; b=dKY9Ed/K6kfRFMu/+wN2CNkeMiUXcFD92gsoPhK/XNtizyKWjf/IwNuN7caDqRDrgzaDW4dYo5CDe6x7XMAj3OeUVkXtLLmqbwKZPiGFkFQ+7VeZbSQCxLQCpcKPQx0dk3DZ/kr6bkHpU3h2vT3Yb+FZscCiedqtLsYOgjGuEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782717947; c=relaxed/simple;
	bh=5J+OoO5e9Czz9FhK1bUIIy3sQnMcYa29Jau1iKe+8PA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DA/g2/SHslnU+U3u/mAxKWI1oOeUyrxhUwqscLh2aAEL/HFegTsl1q4m4fyYa0J3Oi866TzQDszoFIW1nhKWCtMjTD64wxP2B1OYwBtLs+gQIq7bJmLYNNkQNshNJHeEFdEKGFyHFDETFR2/IAp2uO6Ym2/wbJIrh4oqdJopA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yhi1mDDj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yhi1mDDj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c6b67d5fa1so15730905ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 29 Jun 2026 00:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782717942; x=1783322742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WR5F6oneftdgP5br5GMJTh3IFu9XEIlaXbs4h24EQwY=;
        b=Yhi1mDDjX2SuV1IrWjxjWf7oM/NT0hHGw2GjRhdZDjqH5BEEn0Jc3Q7Epvy+FdpbQm
         McLJE6s3TZfN6m7A2nObzCfrngsOkHL/GleunfNtYsQEkt/IbeE38zmYGHWYmihl/AlP
         Ldxw4YVudVBb3WhtULYiWFEhe5+dbDLkI0bKvgsfxAIaBGsIFNeuL09U2T6YC/hwEpnm
         sxQ/My8UKA2BSaPDmCi7WwEA+aK9tornvTYpuE0OePRCV7jtyLZX/f+S1fJowHpsniRC
         6pwaBc6Deog1PduUdV0G8frTNDmLPoibkw8wpzphmg/pefcdmP1WJj6nu/DBcwMjQwVw
         oajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782717942; x=1783322742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WR5F6oneftdgP5br5GMJTh3IFu9XEIlaXbs4h24EQwY=;
        b=oo1HYJtNKbNSaNtEVPh/xGla/U3Yp1IGC3aLIiVJOlzt7dqyNY9kZ4d8mViXTTB4m4
         ad5d3ImVpBiVxWBDBb//ukCaqgRgFVgRxNjTP96ueOtnVw9SSpTQUpzc1SKBre3kimeA
         WG4BdjyDH990BfRAxvdh6pMjQtUL+okECgn8ZLr6MqiDqR0LzOf15JqwWcIRvtIf0ye+
         LtKRdlYZY5pAz/l+/P93qo2SRZHe1RyTkdKtEnXxDdIrG9nso7xViRM+H7m5rPHXprfF
         P99nDJ9GSdoHiU6o4hZI9nWLGGDEXqiHqEvykaKZLoEXdnldDOIndyuuSs5xBTwKKJIo
         aP+A==
X-Forwarded-Encrypted: i=1; AHgh+RoaBkbjW6PrrXoLt90TPF1dU4udjNulOwMw7xlHwCvm6DArJpy/AW6KG59+Or6CbKe8XIEtoCf3dWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyotQ3NnyiOtsJDtokxABqROLS9QCuWCbH0E9KRbcgiC4TKia6F
	uACUbnpH9cjajvBaijXF6XAvPRZRajncO9LszcocMn2G42f7YLp5qwoe
X-Gm-Gg: AfdE7cn7eIINL/LFfdMTPoFE3qy+xSdfJd2ZPCRIlj2z358KSINB3gseL3rdIEaFpU9
	Zb/jvuiIyLPuxvc2mxNEMoFzY7HeMTNYLkz39fTyh9UBRoBo+ChSXmFato3mY3rMpKEHCDMV5kz
	1A2RCcWbPdv5MFHosJAQMpH888cBPTDuLxhWEKuJG2NbkoOjh5bBgpsE4rWxpddf7+Z6b3mouWT
	IacM2yanhq8yZB3xWrDdiVvBdJPXb/d7n8IQltfhz9KTIhRiha8RQd8z9zgXc2BjjifJYlKSpP8
	c86KZ2QU9qFO8mLjmuql+7zsfxVUlXwNf9dbsViBY2VglNLTgFBax4EyXRF3Y2HbF+NvBvUZPO3
	w+8JDGwr7VrBFt+4pTdODdbhizstzD4GDhGB7Voh9nPlIfedmTzRHX5X59r3dkiZIg7l4exBQxc
	43Cx1BSK8ricM=
X-Received: by 2002:a17:903:2a90:b0:2ca:feb:303b with SMTP id d9443c01a7336-2ca0feb31c8mr12112425ad.25.1782717942181;
        Mon, 29 Jun 2026 00:25:42 -0700 (PDT)
Received: from localhost ([2001:19f0:8000:3e6e:5400:6ff:fe38:3d01])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c9dbd09695sm26908005ad.81.2026.06.29.00.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 00:25:41 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Karol Gugala <kgugala@antmicro.com>,
	Mateusz Holenko <mholenko@antmicro.com>,
	Gabriel Somlo <gsomlo@gmail.com>,
	Joel Stanley <joel@jms.id.au>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: [PATCH 2/2] mmc: litex_mmc: Remove unused logic for the fixed bus width
Date: Mon, 29 Jun 2026 15:25:08 +0800
Message-ID: <20260629072510.1451480-3-inochiama@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629072510.1451480-1-inochiama@gmail.com>
References: <20260629072510.1451480-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As the set_ios() function in litex_mmc driver does support
setting bus width, it is not necessary to leave the logic
for fixed bus width. Clean up these unneeded code.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
---
 drivers/mmc/host/litex_mmc.c | 95 ++----------------------------------
 1 file changed, 3 insertions(+), 92 deletions(-)

diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index affdff8621bf..1b5ac4b38f4c 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -104,10 +104,6 @@ struct litex_mmc_host {
 	u8 width;
 
 	u32 resp[4];
-	u16 rca;
-
-	bool is_bus_width_set;
-	bool app_cmd;
 };
 
 static int litex_mmc_sdcard_wait_done(void __iomem *reg, struct device *dev)
@@ -172,11 +168,6 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
 			      host->sdcore + LITEX_CORE_CMDRSP, 0x10);
 	}
 
-	if (!host->app_cmd && cmd == SD_SEND_RELATIVE_ADDR)
-		host->rca = (host->resp[3] >> 16);
-
-	host->app_cmd = (cmd == MMC_APP_CMD);
-
 	if (transfer == SD_CTL_DATA_XFER_NONE)
 		return ret; /* OK from prior litex_mmc_sdcard_wait_done() */
 
@@ -198,51 +189,6 @@ static int litex_mmc_send_cmd(struct litex_mmc_host *host,
 	return ret;
 }
 
-static int litex_mmc_send_app_cmd(struct litex_mmc_host *host)
-{
-	return litex_mmc_send_cmd(host, MMC_APP_CMD, host->rca << 16,
-				  SD_CTL_RESP_SHORT, SD_CTL_DATA_XFER_NONE);
-}
-
-static int litex_mmc_send_set_bus_w_cmd(struct litex_mmc_host *host, u32 width)
-{
-	return litex_mmc_send_cmd(host, SD_APP_SET_BUS_WIDTH, width,
-				  SD_CTL_RESP_SHORT, SD_CTL_DATA_XFER_NONE);
-}
-
-static int litex_mmc_set_bus_width(struct litex_mmc_host *host)
-{
-	bool app_cmd_sent;
-	int ret;
-
-	if (host->is_bus_width_set)
-		return 0;
-
-	/* Ensure 'app_cmd' precedes 'app_set_bus_width_cmd' */
-	app_cmd_sent = host->app_cmd; /* was preceding command app_cmd? */
-	if (!app_cmd_sent) {
-		ret = litex_mmc_send_app_cmd(host);
-		if (ret)
-			return ret;
-	}
-
-	/* LiteSDCard only supports 4-bit bus width */
-	ret = litex_mmc_send_set_bus_w_cmd(host, MMC_BUS_WIDTH_4);
-	if (ret)
-		return ret;
-
-	/* Re-send 'app_cmd' if necessary */
-	if (app_cmd_sent) {
-		ret = litex_mmc_send_app_cmd(host);
-		if (ret)
-			return ret;
-	}
-
-	host->is_bus_width_set = true;
-
-	return 0;
-}
-
 static int litex_mmc_get_cd(struct mmc_host *mmc)
 {
 	struct litex_mmc_host *host = mmc_priv(mmc);
@@ -255,9 +201,6 @@ static int litex_mmc_get_cd(struct mmc_host *mmc)
 	if (ret)
 		return ret;
 
-	/* Ensure bus width will be set (again) upon card (re)insertion */
-	host->is_bus_width_set = false;
-
 	return 0;
 }
 
@@ -373,39 +316,19 @@ static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 						litex_mmc_response_len(sbc),
 						SD_CTL_DATA_XFER_NONE);
 		if (sbc->error) {
-			host->is_bus_width_set = false;
 			mmc_request_done(mmc, mrq);
 			return;
 		}
 	}
 
-	if (data) {
-		/*
-		 * LiteSDCard only supports 4-bit bus width; therefore, we MUST
-		 * inject a SET_BUS_WIDTH (acmd6) before the very first data
-		 * transfer, earlier than when the mmc subsystem would normally
-		 * get around to it!
-		 */
-		cmd->error = litex_mmc_set_bus_width(host);
-		if (cmd->error) {
-			dev_err(dev, "Can't set bus width!\n");
-			mmc_request_done(mmc, mrq);
-			return;
-		}
-
+	if (data)
 		litex_mmc_do_dma(host, data, &len, &direct, &transfer);
-	}
 
 	do {
 		cmd->error = litex_mmc_send_cmd(host, cmd->opcode, cmd->arg,
 						response_len, transfer);
 	} while (cmd->error && retries-- > 0);
 
-	if (cmd->error) {
-		/* Card may be gone; don't assume bus width is still set */
-		host->is_bus_width_set = false;
-	}
-
 	if (response_len == SD_CTL_RESP_SHORT) {
 		/* Pull short response fields from appropriate host registers */
 		cmd->resp[0] = host->resp[3];
@@ -418,13 +341,10 @@ static void litex_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	}
 
 	/* Send stop-transmission command if required */
-	if (stop && (cmd->error || !sbc)) {
+	if (stop && (cmd->error || !sbc))
 		stop->error = litex_mmc_send_cmd(host, stop->opcode, stop->arg,
 						 litex_mmc_response_len(stop),
 						 SD_CTL_DATA_XFER_NONE);
-		if (stop->error)
-			host->is_bus_width_set = false;
-	}
 
 	if (data) {
 		dma_unmap_sg(dev, data->sg, data->sg_len,
@@ -565,14 +485,6 @@ static int litex_mmc_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(clk), "can't get clock\n");
 	host->ref_clk = clk_get_rate(clk);
 	host->sd_clk = 0;
-
-	/*
-	 * LiteSDCard only supports 4-bit bus width; therefore, we MUST inject
-	 * a SET_BUS_WIDTH (acmd6) before the very first data transfer, earlier
-	 * than when the mmc subsystem would normally get around to it!
-	 */
-	host->is_bus_width_set = false;
-	host->app_cmd = false;
 	host->width = MMC_BUS_WIDTH_1;
 
 	/* LiteSDCard can support 64-bit DMA addressing */
@@ -633,9 +545,8 @@ static int litex_mmc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Force 4-bit bus_width (only width supported by hardware) */
+	/* Only drop 8-bit bus_width support */
 	mmc->caps &= ~MMC_CAP_8_BIT_DATA;
-	mmc->caps |= MMC_CAP_4_BIT_DATA;
 
 	/* Set default capabilities */
 	mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY |
-- 
2.54.0

