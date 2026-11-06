Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957546;
	b=djUg2oQr+ZsSF9wxoxWhRLnAJCu0tUXePJpzz0uqiJhIPuBuQ/0GYCclxuqOuaFJFG4G
	 Mn2F6qgVqVxO8ZYL6AbvktffiTkLcPgfRTcOeYkSnZjseexzf9seynME9EBJ3W+KujuYp
	 lHkUY1uR3nKE5uqAHYNxqa/5HX3C4qJ3r6ceniuya5LT3O/pVWfhvQozLk0qltJOe+QAx
	 yAF/bYsilGWORi9iwkqb661q796+G7DHaYzbwwnjoFtNOvCvSpbmRYe/bN5RJXRpbVMx/
	 uvqpNDa3RKkDLcpjDO9eP/EI+RhYZshnleDZoFN4oz/pbFGDeEAnmunH2T5AR/WnNHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957546;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=5QZ6o6JjR9MBHdZ2umi91SU/jrU4YivF8J5ejKsH45w=;
	b=1NucldzwTf+vfGXYPylM9KRTplhO49Wee/lGC0+k0vDdu9tXgyfalkdGYKIRKD2KO0pk
	 58dGmN3ZndHM/z7qzscPyO6DubKpq/v12fvLlplvOG3wdUcPSfslCKi4R/Cqb4pACNjUY
	 Jf9+HnbZiRV69TW23o92Q2BpsKe8++9RXWyGq5pPxgMxo6t0HRqGUwaxsV8ny2BO1QMGp
	 yGfTQQDp67iuLFeUg39WD9EVfvC/M/7vhae4ykD/ox9gh/POtGufpRdSiQKXl2mNCSnTk
	 EfBUflYSg8qGmEOo0KslfSsXCcA0VsGOToWftb4PWUH2z5nbIQgG9bdpPdA6R6oZ3+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IyJLimh8;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB86082BE9
	for <linux-mmc@vger.kernel.org>; Fri,  6 Nov 2026 09:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7FB86082BE9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=IyJLimh8
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9B52C4E413F4;
	Fri,  6 Nov 2026 09:32:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 67EDE5FFBC;
	Fri,  6 Nov 2026 09:32:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9C438103292CA;
	Fri,  6 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957540; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5QZ6o6JjR9MBHdZ2umi91SU/jrU4YivF8J5ejKsH45w=;
	b=IyJLimh8+SZ5sqvGUtTtXYTsCrpfgNc4dWN6JZQiJzzpRvgbbD0Nup/ckVV9Rcly44soUO
	sR5E4Z8zF+hM+ifrUztJUoZgZWKaB2m+9wOB8Sog3Wcuy67+yS4G4tsX4GnHXNkYJAUUM5
	EiWnGp14xQ1tTa6iG1jPcC52sqDl7Y1RN8rgMvHB5WByDmJ3g6RrbFk5DyHjtfNevmr36c
	PdXR/nVzmrVhr0wds8GNIhXz5ag/a6cppMFAOUXa073e7uCHBW7oQkyzkiT7FjnFI/EzvE
	IIDGJQgklNcxSbfqPZTEmdpzT4jeppEBjjkUbVzkf57JQMBfmobNpd98/UGj4w==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:12 +0100
Subject: [PATCH 15/25] riscv: add ARCH_METANOIA Kconfig entry
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
Message-Id: <20261106-mt2824-v1-15-86087eaf5af4@bootlin.com>
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

Add support for Metanoia RISC-V SoCs such as the MT2824. The Metanoia
MT2824 is built around Andes AX45MP cores, so select the Andes errata
workarounds.

Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 arch/riscv/Kconfig.socs | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
index cecbce0c4983..adcb10bca966 100644
--- a/arch/riscv/Kconfig.socs
+++ b/arch/riscv/Kconfig.socs
@@ -18,6 +18,14 @@ config ARCH_ESWIN
 	  This enables support for ESWIN SoC platform hardware,
 	  including the ESWIN EIC7700 SoC.
 
+config ARCH_METANOIA
+	bool "Metanoia SoCs"
+	depends on MMU
+	select ARCH_HAS_RESET_CONTROLLER
+	select ERRATA_ANDES
+	help
+	  This enables support for Metanoia SoC platforms.
+
 config ARCH_MICROCHIP_POLARFIRE
 	def_bool ARCH_MICROCHIP
 

-- 
2.56.0

