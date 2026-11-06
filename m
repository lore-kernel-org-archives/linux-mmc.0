Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957518;
	b=tZ/Z321AVWhPUYcgaFgSKhYfXa6bbSmTNoBvGHrwx26WE53NaBrzrSrz0VDrlPnx4U+m
	 rEg7M+bnk5cq4FeNi8+j9+c5HWimj3TTGLMv+RIE4MLIZy1dKIPkT5Vh1LDEQt2x++PQw
	 8XMK4w72FAChUpEy+4UwBBD4x1WAEu8cSynk7Xxwn+Q31C87aFIADBwYocpGCmbWsGkKG
	 4rB1kNElxIEz6l2+thaprbwCMPf1oLgU1MLGwQdKsjXHDWnmElUbHLoZu7oyOY3I48/hJ
	 3tZfjwlmNohzFHq3QcODEt5NHTR0ODYWrdJN4TQ9SRmiiy0cVqDYzTPjCPuiCPV0snA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957518;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=CNZP50BWBrq5SlkS/TLDhwZqggqQ5ahbrtHLdVk2cSQ=;
	b=075hlfq8cEngBhQ1Ycflz6bM1bj60RMEqIuysZk5CehZSRbEjlG7CFCr4SYyXOTNL2c5
	 Ncu6kU6JJhVqiPAh4q02XpAzSqZf6Orn3BdU6IsUTLSjD0/8yN7l8KC1d53tBfmW7hYT9
	 /7OfRp8w6hC7t1G3pwa8raHceKshUKz++F+kNflcRd3QNCaOnP3G0rEjT89H7fbUsU0d5
	 qEmpOx4D4qoXfDW/x25rXuuOmmgvhW9iJ9BVAxgAzlOfrUH+V2BkMzj10pESpXTHfbUUg
	 KbR19IvM/cS6QEuLXm6IbXnvgvyry3WsjZHn24cGkd33t5lRwL18qofwPzy6xwohz7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=R2gRVOsi;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84676082BF3;
	Fri,  6 Nov 2026 09:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B84676082BF3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=R2gRVOsi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A4C34C69166;
	Fri,  6 Nov 2026 09:31:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 266995FFBC;
	Fri,  6 Nov 2026 09:31:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9597B103292D0;
	Fri,  6 Nov 2026 10:31:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957511; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CNZP50BWBrq5SlkS/TLDhwZqggqQ5ahbrtHLdVk2cSQ=;
	b=R2gRVOsiMPmv9CMSij+H31YRu4WRa7A6biLsMzbtMe2ekfOeuaQbidN1f1Pf8cOuGPOB31
	IBwbP9S6vIEqkXmSxU6/Jjx8J7VZcJJUqRZC+2XxgG6RqC+lM/JSS4YmCmOS6BEl/vKk2N
	Gk6T/f5/VwP1YbrUvc5ZdBJ8Q/70J9Qro56xY1tGbA+TaoSRKiJN3Hquuy6FJUszJQEDpe
	lKG5xHA0ua0e5t+6BVnFkZ8T1AJOhaH7rInquLbulFrjCc7hiBBMZ293DhP8Dhd/8yIWV3
	LBT65BpuviBCTuUnp5NTuVRQi0TlMJnIOiJsB3zT/C5eCrSH7zN3sA68V2DpFg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:08 +0100
Subject: [PATCH 11/25] dt-bindings: spi: andestech,ae350-spi: make DMA and
 interrupts optional
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
Message-Id: <20261106-mt2824-v1-11-86087eaf5af4@bootlin.com>
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

The ATCSPI200 controller can be used in PIO mode, without DMA, and PIO
transfers can optionally use the controller's interrupt. Make dmas,
dma-names and interrupts optional, and require dma-names if dmas is
specified.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 381042e07fd0..91e04f5d354a 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -24,6 +24,9 @@ properties:
   clocks:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+
   dmas:
     items:
       - description: Transmit FIFO DMA channel
@@ -34,6 +37,9 @@ properties:
       - const: tx
       - const: rx
 
+dependencies:
+  dmas: [ dma-names ]
+
 patternProperties:
   "@[0-9a-f]+$":
     type: object
@@ -55,8 +61,6 @@ required:
   - compatible
   - reg
   - clocks
-  - dmas
-  - dma-names
 
 unevaluatedProperties: false
 

-- 
2.56.0

