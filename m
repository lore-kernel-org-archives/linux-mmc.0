Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957532;
	b=4SiABBSVILG9xjWCR15qZCQpuKiCPTYPJL1i94maBPhC98CaLiYC6nN6AXOZShEu6Hkl
	 +KF1gQXBp4Zwa2QpbvnRbKOFrveVaRLZOTqNBDgsmQnPmGsJiini5ziWur5jGzJPPsmmO
	 fpoq6btsHwoTnR95VHKZRif0wYFeAq/UEn/5ZyUA3grRJukBnFOjzP+vBtMWI7atrs1CQ
	 nf0tdRAutoufJUolxsPUSXwh+4ojE7+Yc6CVWJjwxOckbTO/x3JwTa4bd5zi/bqfhWQMm
	 AXVDz/WmFWwmrMYp7GAqwAz3nXYj3nkzGv+SPKWPPWb/gPVW7nwCJCrMXme6qGKiQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957532;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=r8to7uUebSCnf0zunQqvwVepFOpmM8Tnf1sXmdneWKU=;
	b=BvcNHCqfv5pZlm94kWPiamDUwTIpNL7OoVXeJGHhchYrLO6fL2rpgPMWLBtJJYpTOVTq
	 6VvybsFFN/xZ+aqI66iW5r917jXO5RtzPdlUR/zHeLURY6XzgLbt8paNjehk4asIMdUT1
	 seEmNUweouWwQwZWnlJ2/6+OGGEemlVgkKugN08Sf/7ZNdCty7XR+/tj0bxJhI5GfE6ny
	 mQ/xQ8Kn+UrUY0Pce7vzp7l0LJsstvSvT7SeEkSHOTk8b0/JSrrxwzF4W0Iq+2V9XuGXi
	 6HpgzxJqKQf4XNxEF8ONexUk0dS9qVb2N/4ZJbSp5jXu/3IUhiCwZ99wHTjHfFxdA3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OQyJWD9x;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCF3608360B;
	Fri,  6 Nov 2026 09:32:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCF3608360B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=OQyJWD9x
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C118AC69168;
	Fri,  6 Nov 2026 09:32:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 42DF65FFBC;
	Fri,  6 Nov 2026 09:32:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9238A10329258;
	Fri,  6 Nov 2026 10:31:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957526; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r8to7uUebSCnf0zunQqvwVepFOpmM8Tnf1sXmdneWKU=;
	b=OQyJWD9xuTkSU5khP8Rf0sWaL1PR/MwXKZba/rv5SX1Fgk6aWj+Dn3G0YZsUOdbGj0XvF4
	3G7C0QycFmCVBYiqPj+hSWTrwhN2Y2qbo74SyO/mIeZQZuohSamG5BIqezzDsnvCOtv2nh
	VpB9uJcJaOTkNmhHRQETLejawaipp/djMPDc+8HO09RJM5z9us6ZSn78ZVDfQ00c6K57cX
	WFhr+4okRFPTsmA/eaj36cyrKNTeLbwOLfFz0V8f0h+/x3Qi1TFNckEw7Z6fvxrxmx2ao7
	xgkLmDitwwhnCORZDtqEPnK7CiyGv8zvUMqQGN3BujwvujCznAQht8uom9kOZg==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:10 +0100
Subject: [PATCH 13/25] dt-bindings: usb: dwc2: add Metanoia MT2824
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
Message-Id: <20261106-mt2824-v1-13-86087eaf5af4@bootlin.com>
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

Document the metanoia,mt2824-usb compatible, which falls back to the
generic snps,dwc2 binding, so that the DWC2 USB controller on the Metanoia
MT2824 SoC can be described in device trees.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 6c3a10991b8b..898c83e57843 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -55,6 +55,7 @@ properties:
               - amlogic,meson-g12a-usb
               - amlogic,meson-a1-usb
               - intel,socfpga-agilex-hsotg
+              - metanoia,mt2824-usb
           - const: snps,dwc2
       - const: amcc,dwc-otg
       - const: apm,apm82181-dwc-otg

-- 
2.56.0

