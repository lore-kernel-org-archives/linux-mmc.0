Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF903242CF;
	Fri, 13 Mar 2026 05:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379691; cv=none; b=mlElkJt1n/YUbBiAAnTrjdMV/AyW8UTaS9oC4SYw5nf2r0c1mUD9YCzl/aVEjXWSrsIb1mbmpU+W2X206U+qabR+MoVgkhv7yo2mDkCTN3rT9pxF0zJY7Yrg4N0E3NP91c2ZKy8f7hN9utiU+kgN24vteB0NnBXgZfG9zjWL+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379691; c=relaxed/simple;
	bh=hRhcm7i6Ipu+U8ypFOSg4nwRS0+xKrmtHEwCMOzK03U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=iMLtdQ39WKJ1zmuWFm/h9O5JQSnsTYnsXjxJmdiucRKcoao7Q/Bo7p5wVrZ00ycpjEieJ0ibcdx2Ntjgd0eAZJnd7SiTgOL5lqjQjWCwldLq4qZfmuXXRKM/RIJbW8zXqdSeYlUwow5GInnUUnPkA6eAOEXD3xj7W95Sc/GE8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 13 Mar 2026 13:27:57 +0800
Subject: [PATCH 2/2] mmc: sdhci-of-aspeed: Add ast2700 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-sdhci-v1-2-91cea19c8a67@aspeedtech.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
In-Reply-To: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=1605;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=hRhcm7i6Ipu+U8ypFOSg4nwRS0+xKrmtHEwCMOzK03U=;
 b=+CWnn9LIycIPd3L9+5pOLuYnU8iouEreNTfMj0wiRQr+N0l2JHaHUTeKm+G/aSNdNmiUtEa/o
 T8y8ZEVTBEqD8KG2ovwz7ONlHR17cotJYowKSXpJxzY+ZQwvUj2CbSq
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add support for the AST2700 SOC in the sd controller driver. AST2700 sd
controller requires an reset line, so hook up the optional reset control
and deassert it during probe.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 drivers/mmc/host/sdhci-of-aspeed.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index ca97b01996b1..91c36245e506 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -520,6 +520,7 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 {
 	struct device_node *parent, *child;
+	struct reset_control *reset;
 	struct aspeed_sdc *sdc;
 	int ret;
 
@@ -529,6 +530,15 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 
 	spin_lock_init(&sdc->lock);
 
+	reset = reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	if (IS_ERR(reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(reset),
+				     "unable to acquire reset\n");
+	ret = reset_control_deassert(sdc->rst);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "reset deassert failed\n");
+
 	sdc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sdc->clk))
 		return PTR_ERR(sdc->clk);
@@ -577,6 +587,7 @@ static const struct of_device_id aspeed_sdc_of_match[] = {
 	{ .compatible = "aspeed,ast2400-sd-controller", },
 	{ .compatible = "aspeed,ast2500-sd-controller", },
 	{ .compatible = "aspeed,ast2600-sd-controller", },
+	{ .compatible = "aspeed,ast2700-sd-controller", },
 	{ }
 };
 

-- 
2.34.1

