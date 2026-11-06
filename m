Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957451;
	b=YVzhCuPNojoEL6qCGsgLMuKYDzZO0nm7mY9LxffU1+ZR92xl9ad2GE8zPgfgkHM3ImXX
	 eHi0llH0jb1tUrZG4QS3qPK2As5odSlqFOf2JkUleOlr4LBjM9u00/dBgUIlvcE0J/sig
	 c2KqIlMfGWgCHgitK1pXWlpzFNwSulCBqexVy13LawR2N9m+9DU9B81k7irpsl44xLYBz
	 LZ+VJj6PRcaDF1HIyd+CSHKXRNYSXy/Py4yV2Mr+y5Z/chUysMNNDMbnLaH3tRBEkc7+f
	 aaiVH5DQo7PtbOEZGdN+3cFGmrwRQ9g/F5Lzygz7YqtEH6y/J8Kbwb/r49sVhZVNg8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957451;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=SHm0AteFxuKOwxOjlVILodPtETBXP7hD3plfwEFTqSQ=;
	b=cXasqC+rn8e8Yx6kruQcHj+xJ5iPUwmxNPJcR5CUq2ICjj+R//oNLx6TFVm4bQhOyydA
	 3U7ICKJpfeW5fdFnY8LJPuUcEPuDZM5nqhcrRb7ULVdnoTHHHWzcTxKCt/blB1deoWuha
	 LIb/WUueVKXgC87QplyuWJ0dI2f+I0qDKmpul0O/3LPX9+4a6iKgg7r07c59672STWo0g
	 53+SF29Rwp/WaZsT1EceNP9mzXU+1NYaowv0d3gJPDo2RQvvSC/10URh/IyBwn9wspcwO
	 8kO6/oYoPS+Ymnt6KaP05nWhpYTIo9pW7NywbOetmDvbaFBon5B80GSOpMJoBngYWpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S2GzPxSj;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614C606A32D;
	Fri,  6 Nov 2026 09:30:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9614C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=S2GzPxSj
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A78EAC69168;
	Fri,  6 Nov 2026 09:30:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1CC8B5FFBC;
	Fri,  6 Nov 2026 09:30:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D258E1032927D;
	Fri,  6 Nov 2026 10:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957444; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SHm0AteFxuKOwxOjlVILodPtETBXP7hD3plfwEFTqSQ=;
	b=S2GzPxSjpvUeXv9HhBo+yI8ELQmXQ1gLJRsLtHsc1gB4qMc2Cg/yer5MpNZINHYd6b9zmX
	nq7LBhAvb2FeUUyUMweM3e69TEuOPH+PSjpqKP8iIBmmnTWtgmZWBLTQKaegy8Dvv3N+rl
	I09tiujlzMrDJcp/I3frt3C8KJ7QmCnR1ULbnEnsF+SgF3g8BFvNWwSifnCe01AGTUaUky
	hMAbU4DWJDyh6+CW5OHyxCAFIocJqTi6rSrx9SnrlMScKXNji3+G8d3dnG6Ha78Gt4fZs6
	iDReX4aecjwx6eI576V4QcUYA9YgMNZ2qUDDnd4ILBtpiIRIgPODLAdE08gwUw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:29:58 +0100
Subject: [PATCH 01/25] dt-bindings: vendor-prefixes: add Metanoia
 Communications
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
Message-Id: <20261106-mt2824-v1-1-86087eaf5af4@bootlin.com>
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

Add the vendor prefix for Metanoia Communications Inc., a fabless
semiconductor company specializing in wireline and 5G radio access
networking chips.

Link: https://metanoia-comm.com/about-us/company-overview/

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 5471a06f93f1..085749fb8a72 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1087,6 +1087,8 @@ patternProperties:
     description: Cisco Meraki, LLC
   "^merrii,.*":
     description: Merrii Technology Co., Ltd.
+  "^metanoia,.*":
+    description: Metanoia Communications Inc.
   "^methode,.*":
     description: Methode Electronics, Inc.
   "^micrel,.*":

-- 
2.56.0

