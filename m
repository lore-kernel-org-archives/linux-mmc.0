Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957482;
	b=eyUlPwt2zftmyqpY3nfZWL77zyVfaTWWDbyyGZQT0roa/Zs/P4kkIWxhz+J9/Oo0purb
	 wr55NYPWA9FmDxls/tcl9IM+d7gtyYwEW0k/2c3oFFNiGmbZlsX8IQS/BDwnlb4vEZ3Uh
	 lrG4VqpQA5cioVFtoq9xEWTAqOX/96SRgbnDK84iPJMNkOCuTKLsqY+bn41NB07XQBZ5B
	 slO3t9ZcBpOclMcjJjtZZ61xSGDsPlGRs9PtAf4+v71u0ZdmhTlubZFz2DDHXXqV4sTZD
	 NaEPgxRRKcNT55X/UpPu7iHMV/zkUCgXuVJb73MU5+nW/OJ9WV0FbUP9TjPG+zwq5aQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957482;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=QLYkWtEN7WalqBEHRAOhsQQEXGo0FNnoMfBxTpC6uGY=;
	b=BatfdbiyUP6DB3vQULkzHta0slV8JY+KCo6OQ8iOMEwhKgvXm4e1Xxl6n65qky5Ev7Vp
	 l8rF+qDi3R8C7llp8bXjliWOppG2vgIgkAJDHsTN4wNh+6SmqikxkvkhwrfOfHUUg4GTO
	 Oc7pYRDzND6HI/sLV1awZTvMr563gnXHSo2RoxhiutXib4rLlPEQ4TMgMx7PNl21DQpH/
	 Sf3ZOJzHqHp0Fl2npzPXWVNP1pF+ATpbN/xRufZjVRy/hJXO9v5HHqu4Na5tU4ViaEUYV
	 7gKFhX8zyAEk4lfNj1mUtgdMIoMn73LJVcbMgWF6qvotTGwoldmpqbG7S7Of8cVmgKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fhPaivNp;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6D606D810;
	Fri,  6 Nov 2026 09:31:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99B6D606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=fhPaivNp
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6CC944E413F4;
	Fri,  6 Nov 2026 09:31:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39F6A5FFBC;
	Fri,  6 Nov 2026 09:31:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 30FA710329258;
	Fri,  6 Nov 2026 10:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957476; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=QLYkWtEN7WalqBEHRAOhsQQEXGo0FNnoMfBxTpC6uGY=;
	b=fhPaivNp/k0cCUWJfGKo8HFcZ2WHJAFR+CTRjfbiGfLQeZ4kwRAKx33IOsgm/CqXJFtJ5w
	sJr27DBLIQ/hLOd3HYo0MDZAPDgEz3b+bweWVoxCHjR7ChTrUZOX1Aaj+tzaZ2IrUAMCvI
	HPrqljvEQsNy3eku/1UFusY7pPLusv2wXDKsUveU3Q2+Mf2E8N66LRRw+9vwyfIx1kcqCS
	OWLMe7hEH8DGDchj/na0s7ySL0JF8dgLW2yCik+0XplHYtJSogsREUrEN8iIzmC9/I/NIA
	DElf9Yhie34muUDWk6bdzy6S94MxnTn2p8i1x9SjCfk8iKOEeKrBI45lexXPEg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:03 +0100
Subject: [PATCH 06/25] dt-bindings: cache: andestech,ax45mp-cache: add
 MT2824 compatible
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
Message-Id: <20261106-mt2824-v1-6-86087eaf5af4@bootlin.com>
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

The MT2824 reuses the AX45MP L2 cache controller with its own cache
configuration. Add a SoC-specific compatible in case there are additional
differences between the two implementations.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
index b135ffa4ab6b..c94044a049b2 100644
--- a/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
+++ b/Documentation/devicetree/bindings/cache/andestech,ax45mp-cache.yaml
@@ -30,6 +30,7 @@ properties:
     items:
       - enum:
           - andestech,qilai-ax45mp-cache
+          - metanoia,mt2824-ax45mp-cache
           - renesas,r9a07g043f-ax45mp-cache
       - const: andestech,ax45mp-cache
       - const: cache

-- 
2.56.0

