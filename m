Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957496;
	b=1DPQcn3KNDrGOcEVyfzjJCh49Vyhx9uLxSt5HlF8kLxVt1Gl7W2pEr4HlJD5apKR6zWs
	 ci01wo7caRFsADooYcgVPDKIut9QA/PGAsMnulh0cyFTX1V7u2gW6RHCVgRV44FrI3VxP
	 aiKKWQKMNNkETL4DWuXEh6lPWZ/dGwdKGZKmzErRr17AVtcLOiw4iRHAMEWf/EkPghQUH
	 xL4hd9BoSJkphO0GZZzRlr2mVX3m5hVh4NZk5aZvJyIjMy9jXHZF9ae6tDH39cYwlc5C0
	 yS9aIxt2oiqopq9rcLTMgt2m9y6jWDuECeB210m8VdWJ7MKkeQykx8lUSUbADwpBEtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957496;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=dGYVs8TEgGGOAbRpdMbC6rjsIyrgh7PeAJahuuixs7Y=;
	b=l4JS6JFSQZ7o90OyAmWnPPF0epAT8J1VAFYf1fEn67hlxDPyKSVV8JuJMh/0XdZPQAz0
	 XHHom/hGGUP5xK6BB4pOiECxtX1DkBiwj0B3ExfvXBL7ygWjlE9IsD85BpKhXKd3RVQfW
	 +2hIdJEYbyLBwhSS4z3WNd45Mar1sDfhjVG0wzb0ypTvJAs7Inhf+FaDZEHU8F9nAbMsE
	 Dvx81H/UxtfjXx+f6o/6+5JMZ9c/Ls/y/G1JKxmFtxtw1W1ICY8ZDL7C0tgl2rfdoZZED
	 nU0rkwTJ+eDWS4PlXlZHjikYMyKP+vzoSZUAM6cqutZggowQd7WH1JLWvL7pcyR39YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=afgbf5zi;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFA7606EE8E;
	Fri,  6 Nov 2026 09:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DFA7606EE8E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=afgbf5zi
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 468EFC69166;
	Fri,  6 Nov 2026 09:31:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BEC8C5FFBC;
	Fri,  6 Nov 2026 09:31:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D770103292CA;
	Fri,  6 Nov 2026 10:31:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957491; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=dGYVs8TEgGGOAbRpdMbC6rjsIyrgh7PeAJahuuixs7Y=;
	b=afgbf5ziCJaaBa6xX8Lhcriicf+ABvhzX1xI/3iuH1iI3bEnyB49sarXE2LXNlcaLL92pd
	IJ1hHRgtEDuTrTvdIBWMEOoLIvG+5ZsdzDYtUqxdPAQDIqYXFZ43DdC3zfOojqugJd9sCx
	ZgxroG8raOwWge2Jn+Sa0gyXkjTCWizM1G5OojdlmmmbowfI0A1UPnt0UNAuTbCMX2v8Oy
	vvwxRfy6Y0oCTcdBvw0VVZqQgQlBXOIlzDeiOmw2rpeiUxHlw6lgVgTf5BqDOGB0lHV/xR
	YgaO4Q1ns/9XXTaoHAJHJkmjxCbykJd9o8qyjjQ4Fy5IMl5LiLNk4j02Artfxg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:05 +0100
Subject: [PATCH 08/25] dt-bindings: interrupt-controller: andestech,plicsw:
 add Metanoia MT2824
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
Message-Id: <20261106-mt2824-v1-8-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes PLICSW software interrupt
controller. Add its compatible string, with andestech,plicsw as a
fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/andestech,plicsw.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml b/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
index eb2eb611ac09..a61fe7ca9023 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/andestech,plicsw.yaml
@@ -23,6 +23,7 @@ properties:
     items:
       - enum:
           - andestech,qilai-plicsw
+          - metanoia,mt2824-plicsw
       - const: andestech,plicsw
 
   reg:

-- 
2.56.0

