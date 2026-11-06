Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957553;
	b=MBt4Gb7/l+9mrk9T/7Lg8rIHbtP42D1VSR5KOzw5vwgn/9pnX/mQjrbb9OqeU8yNJo8d
	 YyYXKwGtrGLhESLikCnUToSHop9eLx+8Ul+n87BBXyrgkwr7hsBOwmJII61zi/QNuOEhV
	 +rN0Miec2E7SjLKvZnrsFraGg+o9qV2AMA/cDAsTf50xGxISeF9T1TVCpK5pdyJniLP+H
	 mb2TwM6rBOfLGiocWu3W0LMlcVXmU9+EyGQuwYi/tsrGdtbWLMIzbFkdX7Kg/cg2V43ub
	 1nxYJW5oW55v8Boap4UHqJzPm9Ahs3iCNBz+AlrD+KeZPkADC1C4vnXXZm2eY9EugBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957553;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=gBhA5ne0HzBSBsjNMeB0b97akpJDk47Q1STTVSn0v1g=;
	b=0sJq407Bc43JhpAHyvyTbLzkuMqSx8kYwgib3Ky52jNoJoKG9Lvh4Oy4p6BoRtvUbHjs
	 Mxm9JG16oXVWsFToA9vGQ44IvQ86eSf8daJc0Tp1VzxQ6THf32MfFDqDCZQ9/3mSG6HFc
	 MnKu5NQPtauEsPCipaJoINwB94yR0Dwoid6AzHLBvan3q9pRDvsoK6BvzfotvgnCCU9KT
	 6hG7lEV3kCJNq8KBzIjzsYRANY76I1f9FW5cJCZ9erHbyfQ4bMmyNb95WQZ5XxPJYjJfs
	 LDIKyPJqHMKXwAz3FE910mTzJxZxaSR9JGh65cJ/jWODrWqq4f66vzVJVg7dY3pvkww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HaixeoNX;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77A06082BE7;
	Fri,  6 Nov 2026 09:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E77A06082BE7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=HaixeoNX
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D7FBFC69168;
	Fri,  6 Nov 2026 09:32:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 586C15FFBC;
	Fri,  6 Nov 2026 09:32:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AFE461032927D;
	Fri,  6 Nov 2026 10:32:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957547; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=gBhA5ne0HzBSBsjNMeB0b97akpJDk47Q1STTVSn0v1g=;
	b=HaixeoNXbLBHSchvJYkZj08DvAcwni449GADLwNQTjY/eTlF+kt5/dEzlSVzXnxh1HCSgN
	WWbP9KCYAEY4VNrrTPCJJmtrUvLb263bmiiry2aOxSbttRDgOv7t6PSAit7uiXW4OpjNSI
	+xEQUj1vtvVNTLsNyJkI1cePniyzcJe6rFWzEyo06tgIDCIYLV05YnsFrvRcoLdore3o6v
	hzQyVRtXML3AwTE8aG+7oE/ab1IBh60uT3aqjpJAUtWGD9r8eHxXmLd4oJzuNHqQVEX0j4
	Rz+NI5WdWP5N7zdVlC9rtnEt5t9phhsb4+3q3+PO0a/mxxhYz96anvjPg5y3Jw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:13 +0100
Subject: [PATCH 16/25] reset: simple: add Metanoia MT2824 support
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
Message-Id: <20261106-mt2824-v1-16-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates a simple reset controller with the same
register layout as the other reset-simple controllers. Add its compatible
string and build reset-simple for ARCH_METANOIA by default.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 drivers/reset/Kconfig        | 2 +-
 drivers/reset/reset-simple.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index eda9c698a95f..b42768d7b88a 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -297,7 +297,7 @@ config RESET_SCMI
 
 config RESET_SIMPLE
 	bool "Simple Reset Controller Driver" if COMPILE_TEST || EXPERT
-	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_REALTEK || ARCH_SOPHGO || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
+	default ARCH_ASPEED || ARCH_BCMBCA || ARCH_BITMAIN || ARCH_METANOIA || ARCH_REALTEK || ARCH_SOPHGO || ARCH_STM32 || (ARCH_INTEL_SOCFPGA && ARM64) || ARCH_SUNXI || ARC
 	depends on HAS_IOMEM
 	help
 	  This enables a simple reset controller driver for reset lines that
diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 79e94ecfe4f5..177df36235a5 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -148,6 +148,7 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "brcm,bcm4908-misc-pcie-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "metanoia,mt2824-reset" },
 	{ .compatible = "snps,dw-high-reset" },
 	{ .compatible = "snps,dw-low-reset",
 		.data = &reset_simple_active_low },

-- 
2.56.0

