Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957620;
	b=tWqUeF/YAXDtQ+rvH2FhW2WjqHZP6nGIAZ1524rtUcKv1BankbSOvLkIJNPFDpQgmMlz
	 woMWaCijOYiHU3S4TxtwYraAmlNEI0DAXv2ctOF5ift7FIvF0WVzTxQZLwZvaCpXocKEe
	 WERrrv5nC0owbJ2lpn5kcuUYXdSA6CyQt+U0cwkCrC2sn8nKICwsdCkvkYQuIeW6OlOR1
	 CqaHMhsPNaMF+VfywDiNORSRQojWD+q+xNts/cwzMT/rj915YfBUIegt7A+CYSjtRK2bW
	 rS7YGRaLDBbKve1U+ORgI5391d0NFcgP3KjGXsQdYgT2dWsLoi01jzlFeEbM/EZwzqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957620;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=2gcBpW7vt5OU8YXQJfbV4bUtzoSw7Q3bqHQ5l79lfms=;
	b=Ff+qIAsXzYL64QGYUL0qHtRJByMAdMw9m9rfTEs3kE4CShKlMjBbAMRTWOuu3mFIaH3M
	 1stSyiSkjPd+7l+bOIdcIr+DIYHLmN6KEE6VFbbTE8z3G8slNZV/fvmm+cu+E61Vc8CVu
	 iX1Dqw9DeSmSIK+a0w+OIUbr8VRIL/x8SBFiJfXFJJpfGp29zjyzOko/fvBM/zss4bmlM
	 IX36IcVzR3RJApyPpp/Q1TqbcrjsYnRlojVmgDL5svBtRa6tGK/1oLRcEGwBUq/RKYtA4
	 4lDqevFkeaig7GYQ5esK5LCGscqYeji84d56ndk1qKcB2JFfJgHy3kvYBBOzsz62ltw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sH96Assb;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D9E6082BE1;
	Fri,  6 Nov 2026 09:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D9E6082BE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=sH96Assb
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9C82C69166;
	Fri,  6 Nov 2026 09:33:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3BFDE5FFBC;
	Fri,  6 Nov 2026 09:33:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F04BE1032927D;
	Fri,  6 Nov 2026 10:33:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2gcBpW7vt5OU8YXQJfbV4bUtzoSw7Q3bqHQ5l79lfms=;
	b=sH96AssbUxB5aG/0XowfvzW81VpMWUOUXskSM+Myci6Mv5duQJ2M/gJwgOdye6cvLnfXU1
	bPloJLcbbdlsWtyQincx+DOIAluXS++kapk/UJvEWrnn3eUn3WQehGFNkTsuKnv/oLw9sg
	XL5Mot8T6LgVz+zS8ZARf3QfuY4xaX4/uaJzgSg/373UQNqh92H2/6ryqQyRSMQbcllAag
	c2t1CnEBl64wJ+lTMrJxYrkJ7Rak6tfLkI8wRPzeXO5b8EtDUqkbmt4173KWUNKKXJDLHy
	P3QaSbD1onMmbw9VY1as9+9dbE3VE7B+xTib6f6LIUSdzcnZTFnGLM4RJxmumw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:22 +0100
Subject: [PATCH 25/25] MAINTAINERS: add RISC-V Metanoia SoC support
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
Message-Id: <20261106-mt2824-v1-25-86087eaf5af4@bootlin.com>
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

Add a maintainer entry for the Metanoia MT2824 SoC, covering the
SoC-specific DT bindings, the SoC and the evaluation board device trees,
and the phy driver.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..310544f96204 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24072,6 +24072,17 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
 F:	Documentation/devicetree/bindings/iommu/riscv,iommu.yaml
 F:	drivers/iommu/riscv/
 
+RISC-V METANOIA SoC SUPPORT
+M:	Jun Chang <jun.chang@metanoia-comm.com>
+L:	linux-riscv@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/phy/metanoia,usb2-phy.yaml
+F:	Documentation/devicetree/bindings/power/reset/metanoia,reboot.yaml
+F:	Documentation/devicetree/bindings/reset/metanoia,reset.yaml
+F:	Documentation/devicetree/bindings/riscv/metanoia.yaml
+F:	arch/riscv/boot/dts/metanoia/
+F:	drivers/phy/metanoia/
+
 RISC-V MICROCHIP SUPPORT
 M:	Conor Dooley <conor.dooley@microchip.com>
 R:	Valentina Fernandez <valentina.fernandezalanis@microchip.com>

-- 
2.56.0

