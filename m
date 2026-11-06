Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957489;
	b=bOqbEk+Hs/pgekQEeGDqO2EZ0D6QaQam94tggvg5SnbqJCwBfblgeq7g1BfWo0Y7Wa45
	 k6n4AVDSofm6klRH+qSwZ6yapdUakU1Y0PGjHtWFlJGEoogogZJ6OkEefJwpS+wLH/nHa
	 ufrIfU0JfBfF03GhzZKFoXXyPa9+FI0BV+12nsPoiPLhWvspVHeJ6Zs7k7SNKtYJpm6+U
	 PvaPuRtplSPMLkQMfNT2rqydEjKNkQylNrL0loCb7ZpQpjpACVF4s4DzYz5mo/XwxETs9
	 hRKvXZKwfTRtt2hgqgmrMyVuResrUkVsuDSZB9y+2hD0NqMLF0rXrs/wsFzGAq65Urg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957489;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=3Nu3XMIEg/cqml8i7yqfb1ECUIOMCmZ+Oaq/WIoYvAA=;
	b=JlsoyqDr2XQpN6rx5opscmlDR30Si6vUztRjE+LS0JEUc22tRfRVlzjgHEyiI+f77qo0
	 Vm1Ub/FAOr4diJfYFgDuvC9ovwUycDaLfxaVY6Ufy4lA3rJZKLpc9AQ3UTRTZD7F+A6ej
	 SvaKCp/kp+mqeBrtmHReJCLpu9b8lofoLC0OYNQy1xZDGsPaW5gWlG3r2ZfDBiP9LDLi4
	 fMYn9F1sWjqUj1UWOXM/gCw+PQ+Gia1DlGNaKZJjI7DK1aAAJc6q9n3yvZ7WG/HnUCjJz
	 QHXgWbaHiChaGJe6Um88Lr05KBLURj1J7HUmIXJAiYHJ8PRqSYvzutHim4D1QY4cf7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b="Ck/X1cu3";
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EF5606A331;
	Fri,  6 Nov 2026 09:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6EF5606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Ck/X1cu3
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8017C1A1350;
	Fri,  6 Nov 2026 09:31:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39EAF5FFBC;
	Fri,  6 Nov 2026 09:31:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 686F91032927D;
	Fri,  6 Nov 2026 10:31:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793957483; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3Nu3XMIEg/cqml8i7yqfb1ECUIOMCmZ+Oaq/WIoYvAA=;
	b=Ck/X1cu3CujjL339giAfni+c0D/WjBlDkh9RFU+2NwqCv6VpS8Ac1RQkroUyatj+1acT5u
	2RP0rlnu75p67mCrwylxlvTg5TfoSv08okFYHueFJ0A7X4tCU61dZiK81C+QPDNSaHH+1M
	GsmdxFtSfSEabf8uq/p9M1Kly0PiGxCzW2PBfGFBxT30MaSeM+CqZjFqeGgfp/52eE9an6
	Rs589G4aZug0RjAmrUehh3ebYuegh6wVyjvdfV8C5m4VcaepH+pH2272YtdxwtvkgVzPzl
	blozOSwzNRGlNvJN5JF1EdxgcGkrDQyRsTlSadh/D+gqmgsMcMPq1VvDMwakjw==
From: =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>
Date: Fri, 06 Nov 2026 10:30:04 +0100
Subject: [PATCH 07/25] dt-bindings: interrupt-controller:
 sifive,plic-1.0.0: add Metanoia MT2824
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
Message-Id: <20261106-mt2824-v1-7-86087eaf5af4@bootlin.com>
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

The Metanoia MT2824 integrates the Andes NCEPLIC100 platform-level
interrupt controller. Add its compatible string, with andestech,nceplic100
as a fallback.

Originally-by: Jun Chang <jun.chang@metanoia-comm.com>
Signed-off-by: Benoît Monin <benoit.monin@bootlin.com>
---
 .../devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index cde4bb691897..b76e2fc4cc88 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -54,6 +54,7 @@ properties:
       - items:
           - enum:
               - andestech,qilai-plic
+              - metanoia,mt2824-plic
               - renesas,r9a07g043-plic
           - const: andestech,nceplic100
       - items:

-- 
2.56.0

