Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7650D4C6808
	for <linux-mmc@vger.kernel.org>; Mon,  7 Sep 2026 13:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788787599; cv=none; b=brgJXErAIpSLj63J5RDobiTFZMZXpGxAk8ObeEaKV8DBoYemaOSyfikyUNGvDab0pc/916lTx9KDJG+M/lgNnsxcmHjYfYCtx2mQBR+4zSui6vZJadlJQeYEmcEY+BAdMpZnBlgw77rrA1ilJYMDbRUhcdQ/J2B36suJUTSw5es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788787599; c=relaxed/simple;
	bh=bNTT1MFk41AEn9RggYQGn5+f0aqUw5g1TGoWu75TN+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k8RRlNdt2VkI+MS8ltlYVbBV7wg0DsP+Urj85nZJbMhDidg87CXIgqXaw6olx4eN4gbOIVtimLw7LAkju1iBS57+iMcOjKpYIla8fyItiFJSokJk+XLDYAop+x+ocdo8H3kX25I6iuThNPpv+iw7JBGIv/gN9WYYEPRua3FjQwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=JAgKE5Y3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="JAgKE5Y3"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c250c6a6a9aso573907866b.1
        for <linux-mmc@vger.kernel.org>; Mon, 07 Sep 2026 06:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1788787594; x=1789392394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3wiaJ1NmJWhdrraZpEMlSTMQ/v3zrFTCeXquYFCuY5U=;
        b=JAgKE5Y3TJ6H68yzHS2XnWNLOLt9h/pp0SU8VKgzJ5TB12ija7GQSjYnsF04TebhfG
         f8/lfbu3aNq/2A+qnl1i/pp6jlqLgbIW8sY89rD/0K84CLDiOp3vzRM9gLMhewjGwksk
         JGsxy3FyDFvvq85ZxY+pBCG5QxlrnHA4xpsXXIkW6QavpKLwH2CEufU8OMGdsc2/ukVG
         oyMH/HeZZYlA5SHnuJJtyPKFvHo86OIiWUIP/iZCztMW2qmrU0HklhjwByHL89utxUml
         JblB9xCNQIytMex2LEhWdn8Wk6Pn80LqOQIhHSjmqldHoP/Vz1B6MnenYslBgYlBN52F
         8SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788787594; x=1789392394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3wiaJ1NmJWhdrraZpEMlSTMQ/v3zrFTCeXquYFCuY5U=;
        b=WQ+cKI+QKHMLdWslXPXpMMgkS0SPe/hMKri6tpgFJUsgxtqCwrbyDbZEDUf0et7c5I
         PqMJVQmh1UTFRAtVl4DzzA4OU2jixnYiAX2FLpGfASg4EF/+f+YLQLVDVXf545MyCLRy
         CySdaKU+yKhx3FzpLlk5qOBbiryVTMJRMBpxxOZePanPeCM3FKVS8ehUuRw4lTyA9CXa
         Mc2AJbzCiELyL9hujRnKzaKxmeW4jE8RF33jKcvFT2qhAn8i6xxw2H2eaufME61o5XB7
         8bjC0sta42hyYNbjy410nBgUXRkc4vFp0Y5WYVthjwXE/Yd63SEABL4aY9ixTDUExUAE
         VjUw==
X-Forwarded-Encrypted: i=1; AKwUvBwgiRZimzQrG3toVJWZtxxt35VZLcgJrqSF9fEeDVPSS4EC9pkA5juMchpyixDuKrOeB6qtldNtItg=@vger.kernel.org
X-Gm-Message-State: AFuF++nDLiOMukBEwPwq3QNymFtRgmcDelOzHyBc5D5MyF4Nj7v3X0Wu
	B7PA89rQLFGLfBe4KZZiulttgJuuhVYONnmmXDJaIhSDe0mXa7vs14fTEKNXiPWkzjk=
X-Gm-Gg: AYBFou2KM0FCCmFEfiJzFpXChw5m8/Ynqea7poZeuVpJCwhVNROcVchDOTOKGJJu/uU
	jSFgaKruisa2XgeQUdCDd1H6HgZESVorN3lzBN9w2d0lYLNGhIAZSx1a9znGQJ3/FU/s6HTz46T
	QQhFpC5JAX5MWuq2TIYh8gWSXQYKYls1ZGQTRENgIqtmti99GtxHCCrvVSTsmZByw/baCJ/Y29I
	BcTL+rpwfsmyKH3c/3idwzWjqj5+3VdbKl8xU4hM7HJ0wRAIDvtlJcDVlyYhPPZTD/KDkS4vbRG
	BYQZLKBwkyC1cjORAkUWGK4yv6KUZcobnT14jn9/0qQ+TH3r+SDCsrEqpnZJ4WW7cstIdhX6NRb
	tEmnxn3Qa/WLMo6QWLAj9dRV+lmxFNSUsnRBLg1aqRYfCGI6/nqEcI4kW7g8B8sG2rj2TU0aXqe
	DyXce+tXH4rdD/1Wtgt/sQmf1r+8ytcjjczcsE6Tmxb6AibwltNWnoapl/vPIFd48slKVWKQRJY
	RECzBCB+EjXTZlpdMA9do+1qXTktuQUWoM532E+QxzlLLVXQgWss3tR/kG1lh1uC0UXd345D4Fc
	WMcA9lcCRTcWYojthFyC5zOdholxforkvv6qjwoO81PrBHDI
X-Received: by 2002:a17:907:d87:b0:c25:504a:1e25 with SMTP id a640c23a62f3a-c260cbd2d02mr1532301766b.13.1788787594351;
        Mon, 07 Sep 2026 06:26:34 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-94-253-164-142.zg.cable.xnet.hr. [94.253.164.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2622a7c677sm366362766b.9.2026.09.07.06.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:26:33 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: ulfh@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	adrian.hunter@intel.com,
	aubin.constans@microchip.com,
	ehristev@kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 3/6] mmc: sdhci-of-at91: add LAN969x support
Date: Mon,  7 Sep 2026 15:25:31 +0200
Message-ID: <20260907132617.1198548-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907132617.1198548-1-robert.marko@sartura.hr>
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same internally generated base clock layout as SAM9X60,
but its SDMMC controller stops responding when runtime PM gates its clocks.
Software resets then fail to complete and the internal SDHCI clock never
stabilises, causing subsequent I/O requests to time out.

Add LAN969x-specific SoC data using the SAM9X60 clock layout and select the
option to leave its clocks enabled across runtime suspend.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>

 drivers/mmc/host/sdhci-of-at91.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index b7e2a89da348..e7affca8da25 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -158,9 +158,17 @@ static const struct sdhci_at91_soc_data soc_data_sam9x60 = {
 	.divider_for_baseclk = 2,
 };
 
+static const struct sdhci_at91_soc_data soc_data_lan969x = {
+	.pdata = &sdhci_sama5d2_pdata,
+	.baseclk_is_generated_internally = true,
+	.keep_clks_on = true,
+	.divider_for_baseclk = 2,
+};
+
 static const struct of_device_id sdhci_at91_dt_match[] = {
 	{ .compatible = "atmel,sama5d2-sdhci", .data = &soc_data_sama5d2 },
 	{ .compatible = "microchip,sam9x60-sdhci", .data = &soc_data_sam9x60 },
+	{ .compatible = "microchip,lan9691-sdhci", .data = &soc_data_lan969x },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
-- 
2.55.0
