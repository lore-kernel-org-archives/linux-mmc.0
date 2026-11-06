Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957470;
	b=pBlYGEf/KPH75phoAdNMbAxnVclMSpq9eAkmVk96lMo85tbfz2ZfxTSr4JkZQixrrFWe
	 lP6Pz+LfeJVddfeV+bLyvpZf6qbM3eTVomzplP4dEudP38j34mEwLEAsdRq7PwB+B9CuL
	 OU2KNR0Dk4yPAOGEuHTCg1bDUJnTz8i22XY7LE+sGkZ6AEIAA91nm3P/Ynytdtdzgc9LB
	 ulsHaOo9Q7l3qptLLwB99jLLgyw5wSUOcfPc0d3s9S+OPb+PvnVSpqFyBqJc1xGuOqA1E
	 eMNPSj0BO3vL8zvnjnPXLuIpWkqK6piLkyirvmJq+H/KDWGwOfC0pJDVaQVES2IyWKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957470;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=FEY+pNQv3raFD6ItQ5TruQMpIhIehZiBlMa2MptY0Ko=;
	b=3daOpQpibxTj6V2op/hyfYxfcfsCxmzpIHvmEUQF7f7KOShV5xpkYERwhgtID4u2u2uE
	 ILgKW8fWzYjZxH6OTKLSjOh/dtqNyMetiCdyMGuhaZZK3INo1B2s5wh4G0XyIAJszeP/8
	 EpsZ6SJfkxrAxup6OW/51ZzdcjL6W2UYb87xJD3V9eMaUakh9TOqsuqHhyfVnZ8MRjYaR
	 W3hITGcTC1NgaBGv9jrmdBjcBqfhZm7gGZs8nUDnUbJlke9h17nS+YFF5jxZk8qMNHYFE
	 Fh3/9ThqsnTD8zEI0Z/zhkYa88enqI5oVSh5BfkV5Sgy1Y7RAiwHBRCtOnkZtvqgP4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IL80sULf;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D37606EE8F;
	Fri,  6 Nov 2026 09:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88D37606EE8F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IL80sULf
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DA2C34E413F4;
	Fri,  6 Nov 2026 09:31:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A565E5FFBC;
	Fri,  6 Nov 2026 09:31:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BEC47103292D3;
	Fri,  6 Nov 2026 10:30:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957463; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=FEY+pNQv3raFD6ItQ5TruQMpIhIehZiBlMa2MptY0Ko=;
	b=IL80sULffVhHJjUPB6lq/meZSVUj5X67ZG4gALd59IoF1PC+QcnS+ZtkR41hdmJaMtm+E5
	DgOFn5AYSlbgiiercLioIm6i38rNtfjIKd/icYFG85nDE7/Nf0/t0FD4hjG5jv+CEKh4m9
	r1HoesTUtas6qvAbxoRtPS+7mivpPruzXbIMxstzFue5GFKHwYX1HiKcKLZVh4YOs3J3Xb
	iYJDxrPYo1r2EOllL694SVGgrxYw2gQHpgIDloPEfR8G/UVTFpPl418WOI91Wb8HddFiH9
	pqNCxMwN7mTFZjyS1p+hSAYTIOPu0ZtKl6DfoNTL52GoCbGBR+BEgXR/YoCD1Q==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:01 +0100
Subject: [PATCH 04/25] dt-bindings: power: reset: add Metanoia MT2824
 reboot
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
Message-Id: <20261106-mt2824-v1-4-86087eaf5af4@bootlin.com>
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

Document the Metanoia MT2824 reboot register, which the firmware writes
in machine mode to perform a warm system reboot. OpenSBI has a system
reset driver for it.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 .../bindings/power/reset/metanoia,reboot.yaml      | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml b/Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml
new file mode 100644
index 000000000000..2670fe7ab93f
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/reset/metanoia,reboot.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Metanoia MT2824 Reboot Controller
+
+maintainers:
+  - Jun Chang <jun.chang@metanoia-comm.com>
+
+description:
+  The Metanoia MT2824 reboot controller provides a system warm reboot through
+  a memory-mapped register. It is used by the firmware in machine mode.
+
+properties:
+  compatible:
+    const: metanoia,mt2824-reboot
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    reboot: reboot@10000004 {
+      compatible = "metanoia,mt2824-reboot";
+      reg = <0x10000004 0x8>;
+    };

-- 
2.56.0

