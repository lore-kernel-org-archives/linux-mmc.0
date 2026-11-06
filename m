Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957539;
	b=JhOFwiExUtF3cOPWMqj0Kz3v5uWAN4rqlaxn+4bRlAMlN2DS6LZzOooj1fxwlChB1T+K
	 2e1UNAxDeCgxaI7/djOpfjiyU6g+u6wmOaZ7Dtzx/psX/NT5linyEWelx7+BHb1TTHiQX
	 x8Ns13MKk09iuvKA1tNuWtqea+yaf53gu4ZEpnLAnLggDA4/FFkB0Tf2nfbSw56Ib0k4T
	 yyHjkzJGUbVQ3+2WiWcz1MYB+leZcW2HAaO4Gi6Q9y0XqIuZhFB6EpSxuXoZ8gqIFrECe
	 ohzWBJFDbEwL1xRj4LEDSXXGH+ljOlMaNhDvmcSb4ChI4s2TewFOPNsqgsbGzKDYmgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957539;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=YwyvrU3jJiDTxDxbsC0TfxtCg10y3nSj2oVv4WB1cAw=;
	b=UKFqm779Vg7QB9MjNTyZurZnaz9299wooLSOS4xc+FCzsnwb6nn+v1JaLWpZUPlkgu4U
	 /AqBcyThY9EaMWBkm/0h5Ym5klI6PrGDv0A6exHv2KdY+O+bjGKzDdHWNC0fzPRyEMvBX
	 jQnVEijWXJEQUONJgAY9iGnEOWqsHkGSDX3rcDfXQmikGaawvo1zN2HHqhCMOJbw9Cn3G
	 UO9EU1xeKd0FE3qNo0eOGq5W6VY1LH9wvm7Kd7moR2LTZpEs8PGag25O1KWM86mDfawMN
	 1QawkDwG370uofzyswbshJ+0xJpOO2jz71kzd8PsVUcZCGc72cAV8L2nihNtynw8Nxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h2PElyJB;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5356082BD9;
	Fri,  6 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED5356082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=h2PElyJB
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 28C63C69166;
	Fri,  6 Nov 2026 09:32:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A17525FFBC;
	Fri,  6 Nov 2026 09:32:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3865A103292D3;
	Fri,  6 Nov 2026 10:32:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957534; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YwyvrU3jJiDTxDxbsC0TfxtCg10y3nSj2oVv4WB1cAw=;
	b=h2PElyJBpGZNfSeGD85T77QnJ1LDeNgFwvr2DbU74Wx6hQ61H/+f2yV2iurSqdYcCgjPdM
	NDySdw9dTb58cK88zriCRpiN63aIccjGh6v7d7NN/Nsg92hvnamiH0feBaM9tw6JtuNWno
	V4DIzduZlKWoORHQjfBZDyC+xaCVrktUzRuusKcdvO+Hp0pwAYSaPxsBpF0k5G9ix1+qUg
	X4CJrOi6hbN4RN5w9I4xr9T5BgDFDOVPvat0w+BU2q3Mob5pUOkcRUNw+eJEjbI95WO+6F
	klr8R/fYW7DhchjG6CGUyNasvxIZ2g8pJ8H43JFP59laMxWN4aCMiTwn+g+GgQ==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:11 +0100
Subject: [PATCH 14/25] dt-bindings: watchdog: andestech,ae350-wdt: add
 Metanoia MT2824
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
Message-Id: <20261106-mt2824-v1-14-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 SoC integrates the Andes ATCWDT200 watchdog. Add its
compatible string, with andestech,ae350-wdt as a fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml b/Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
index f1107c552788..d8c6f38e1035 100644
--- a/Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/andestech,ae350-wdt.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - andestech,qilai-wdt
+              - metanoia,mt2824-wdt
           - const: andestech,ae350-wdt
       - const: andestech,ae350-wdt
 

-- 
2.56.0

