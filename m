Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB8839BFF5
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669881; cv=none; b=gcpyZdPlFH0b5blSTIRLfpWkiCwYx207XzrfdyaWIER2mmmeugJIIG7rQfB1DmJ1nuilGJeTGZH3sYLy9mQgO+a35SaIdySzxVJA2rHogCVRThg2nN4ZQWBV1Il/RV7MnlTcF/6ykWPjKDZbydHsziJltcRdMc9wOuhf4gtw/w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669881; c=relaxed/simple;
	bh=h2D5WHgrxz43uhMtLfKxOR0sKrVvSVtSEpqCmED+0J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pHzrl3UbZRCzUbNjZAZAkgNIHL3BYGncrrVfflIV9MRjKu8v/XOODQmMMC+ZNzAeU8n4xG0BkDJTn+8SW8rlO8uwoQlv+dkyxDsm/Dq7AhWBtLeof2FzeBk3kjVVUsUofhdVrkkAvLTh3FB9zRAQOm7ixOcWE9+9SHmUwirYjxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtJ4HdJ8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtJ4HdJ8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so1221803f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669879; x=1774274679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H7U0Z6Pq5BNBGUpIipaToeDztdOq53P+XHlRkPRfqt4=;
        b=mtJ4HdJ8QgssEsTbDBqiXgNQLdtNx4vkkURRul7rNcjEGBVTCTQr5hlNt7SjVa/IWJ
         T/XhkmMFUYDVlsWPa92+SMhFlF/THR/qqfzH6asCOYk4staQcNX64sJYa+m0m4Iq2LqA
         PnZxV0pslDEOyy91jhlL5CC9WfAEh9FDSrqbTB6PNI3Z+uu0QA1OwJd8z6lhL4WmhCPQ
         fN2vvhWIB0q1tS7ntep46grP1trnYHKEJOH1ezarmqX9J0+sOXZ0Aq1JiXrd8519L6w8
         3uxpKSPauxUheJWfRWTS9vc4mqtyKOp/cYJVEDAr2GbYwln9IW1WNIL5lJ/4OWbpQdk5
         BLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669879; x=1774274679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H7U0Z6Pq5BNBGUpIipaToeDztdOq53P+XHlRkPRfqt4=;
        b=ctJDAKU7CuVx/rKsoOUi8VQEkstYJy0obOL7+gEPn/solDaND3071jPcVJHS8cNwoq
         LeHOumH9zjay21wCDFQ8GpyyvUWEmSa0aMKGus00JxuKixcj4LhC29e3x9NR3ilSwfbV
         fOEmsEKLdp6VLr55Og0+eurVeeXOLMVjRvg8BvCjRBqRnvH7G7Snit14k+8C5M3seo3X
         52WwGRHWdD8rnec43Mr9J49mx3N9y9SptXuGDA4rRHXfio7tlOO9iSSvZk4nARRJEmbe
         HUEmCFWY8LUOsM+9LOGWVFhxD3Z6En26il6nFx4zZT3ktIcJ1vjURitIyzW62d+ZZny7
         yGOw==
X-Forwarded-Encrypted: i=1; AJvYcCXt9sPMGfY47+u/OvofWmlyH5xB1ZkZpxwYVQShE805AbsG4Pv0IgQyXO4v8AvJZOhYjqkB4g3VUXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCqmHgjHKylRAZWQ2zGO/FaoC32J/Z5Dbgum+T1bTYa/LvopcA
	ZAh4rcQJWzU1ClZU4vmT4hBMGGORQJiisAZRe4Ee4gubMVUVONp5wlcH
X-Gm-Gg: ATEYQzx8BQ6EpzaGAtCIYjTYo0dtFUe1IulBnAj2+37fVQ652NA3niMFH53V74sExL+
	9HFDS58VoXJIn5bVHhUZ9TCNfQriAtmD5lW4wp3F1UCu/1F9p59ZaiLNfQ3QJ29Z2SpsGcOVqVv
	RHQy3WeyvLOYyIbmJaPsexU9p+GN5X594gIjkW0uBtCxphe1e8HwGL51BtybSlmQj1P6iJk5ZIT
	YPygPhoTytlsc9akFkf2ufP/Qagsd0dt2zL/5BWSZQokpxUqI3yh6+rPQfA2JJC6oTlLW+c6YnV
	GCvE5YNex3YI3SX3J3/7MeRhzSOTHqPTnttPYGOoKeH1MTR/dg7xzlVedy3R2cHotUSmD0TT0Op
	LRiuk/eKKkRna7NtRkpDUDZrAIxyGFVaz4cS8q/jA2biH7wBUZa9t0nOv1gvZ8+LSpkQIkIIDIq
	RpJtfTikA78xVTeEXRQZmW4fqRSXXiSAE3tMMtbJXlfULhwqFHhc/uAekaK9Hx+b89
X-Received: by 2002:a05:600c:81c5:b0:485:3812:36da with SMTP id 5b1f17b1804b1-485566cf00bmr199399265e9.9.1773669878422;
        Mon, 16 Mar 2026 07:04:38 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:37 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 16 Mar 2026 15:03:34 +0100
Subject: [PATCH v3 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-orangepi-sd-card-uhs-v3-6-aefd3b7832df@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
X-Mailer: b4 0.14.2

Add complete SD card controller support with UHS high-speed modes.

- Enable sdhci0 controller with 4-bit bus width
- Configure card detect GPIO with inversion
- Connect vmmc-supply to buck4 for 3.3V card power
- Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
- Add dual pinctrl states for voltage-dependent pin configuration
- Support UHS-I SDR25, SDR50, and SDR104 modes

This enables full SD card functionality including high-speed UHS modes
for improved performance.

Tested-by: Anand Moon <linux.amoon@gmail.com>
Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
index f1533c99881dbf38e16cff5e91e33253cfa7a56d..aff23846085d22d1e9cd77434bffd2816ad59e12 100644
--- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
@@ -140,3 +140,22 @@ aldo1: aldo1 {
 		};
 	};
 };
+
+&sdhci0 {
+	pinctrl-names = "default", "state_uhs";
+	pinctrl-0 = <&mmc1_cfg>;
+	pinctrl-1 = <&mmc1_uhs_cfg>;
+	bus-width = <4>;
+	cd-gpios = <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+	cd-inverted;
+	no-mmc;
+	no-sdio;
+	disable-wp;
+	cap-sd-highspeed;
+	vmmc-supply = <&buck4>;
+	vqmmc-supply = <&aldo1>;
+	sd-uhs-sdr25;
+	sd-uhs-sdr50;
+	sd-uhs-sdr104;
+	status = "okay";
+};

-- 
2.53.0

