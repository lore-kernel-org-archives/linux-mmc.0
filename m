Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66B20311;
	Sat,  4 Jan 2025 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736009009; cv=none; b=YXE/MSWBSMwd4fcwZBrSydDAzV2QkPZdRUhD/dfciPx092dZb1rHseQNK24BYOoS8E64CENkcU2fj/phllaPlBGYPUQzkRmA437SusalaBW6hgRondj1Y7pJRPNz1UIilEWLCs2KWui15iJuIWo5dLRFSwKy+DISG2grBhyw7S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736009009; c=relaxed/simple;
	bh=mp5f3GluxxSGVLKmrhOfZsLf5dflolGGdTe071OeWsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XGg8GMunRp3iLi04v+ArdnWdzbt4otnZAcPyGjXi/s+nrZsxgmFBoY3Id1jgbEGzkDxKGm+JcHoLQEcGogmQCZfUjsdrrC3ks/e5gDmrpDiEbtai+fOBnHY5e2LXmzhElhR9akiKPSYcaKOP7cctwxT0rAswno9XT214OqJEcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFUII2jZ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFUII2jZ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43623f0c574so89624575e9.2;
        Sat, 04 Jan 2025 08:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736009006; x=1736613806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T64IvUv2v2ctLBX091YAC+zdH2GYdiIMlzETmbUeq5o=;
        b=FFUII2jZtfTpAnF4KssWOlOyU7GqzGo41SfKpWqZVBiTaY61JcaJL+31Owq+fAWNUH
         nn8GBDltstX5Q6kf+RyfyjGTcK0iJTCNXyebGvoE5YnRDLL0ZAxPwqrqQNIMUAR5xyk4
         EbMzUWJb1BADogAcU/54rtRfK8xVLZJX7V0v+jTH9WH5/8azKWrrs6RGEJ3t+ssx5xSK
         vRMPrFRyE7EXSedHSDZbW82r1QAPaZgiiQygvP82Zcm7wLxUYf95OzFMHnIriBUq78Xm
         McqpXjjVc972pEKt99TdaEq8OuL50loqwWoCtlydtoEC2GncAKUmvoy0cvXaLHdFUgmX
         snAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736009006; x=1736613806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T64IvUv2v2ctLBX091YAC+zdH2GYdiIMlzETmbUeq5o=;
        b=O7Gd8V9hOW2b/yQkwjMrGfsRuxotMdguCMQEJKCW55J8N34nO2tywbVZTqsprnuBCl
         H4m4hdnAUbOZEe/lA/Yf+EsrACxS3XEzfCYif9sl/rYYrqswFiWNJwo24a92u6v3kz0M
         bUOPDokXe2J8sUhKS1fwTdphJL2Owgh8Et8+AgoPfnqospftHoH/rZ/1ZXyyNR/UAKyJ
         n3TOnmYWML9ACSAU9Gm6rUYyRGnCHbtjofg/teS3FGf5OnsoZHXCQliIClGTv9Nl2hdf
         okT8sFeYSqddWH8ZmeeYWsGwP5KgUrlKDKgbQMp3nLIyFGLDFo2oxxQ1Ol69VbswqY35
         PBCQ==
X-Forwarded-Encrypted: i=1; AJvYcCUMFZV7Wcgi6m2p4BBDRqVOI83EDixqAuBo366OxxgtjqD7HUb6yY22HNX8MqfUifdh0LZxuAjVE26V@vger.kernel.org, AJvYcCUW87Rt+IRytsJlu5JJzeHo+4qnpxpIQ30z0gKk+9DcHS7QrMRuS96xsrhGX8iU2c/Sw2aE6B9Zw2a2xPd8G0jHlew=@vger.kernel.org, AJvYcCVGsJ17W7xzjjbSCw/ftLMlw0PG0WO/9Su9xwiAH2zmtxrz6PlCFewcdppFL19M4pUkDirHk1VjG1CZFEKJ@vger.kernel.org
X-Gm-Message-State: AOJu0YwnAIbD2NODFZBRdTov7KM45Ij30dSvKaG1Zj2IOqqRBpcVSHOO
	eAcmwHGaODoyGPTBkAHhY4bB5Srr6B84oRwFjIlwkzGjclkrc3Fe3sT05Q==
X-Gm-Gg: ASbGncthK/MMK/AWZOIZHlLsoGFYtwo821hFOTZJ+I3y/qPPGvNTEvfg5yDaeq4A0Pv
	bdhLOXA5NzkQ9S0Ydf3h7GqESaNCDWWwzlERsgPBdbQjgNuaoaTgS/SzS+l4IOUJ+yr8csUHHAi
	0WQdOAH5jMS/g3IY934rxb0bV7a665hihM2+mdGU9rFUn+xEu49+gDn4KfEyXB6PaCCukYGBiqV
	932F3ata2QoaJ10cns5u3BHHr1jiuhAq18+H/uR1zApz1rFLayN5JlV+sti7LU+Q3hUqBg=
X-Google-Smtp-Source: AGHT+IGNe3+mHP1LxgFUUCsd51sywF6ztvk2U7DFVGXzDM7T3XZT/xcmNAAdPmEOgQ2IwjhCdUOS6g==
X-Received: by 2002:a05:600c:450f:b0:434:f5c0:32b1 with SMTP id 5b1f17b1804b1-436686461f0mr493936935e9.15.1736009006271;
        Sat, 04 Jan 2025 08:43:26 -0800 (PST)
Received: from ivaylo-T580.. ([94.131.202.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661219a7csm513321455e9.24.2025.01.04.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2025 08:43:25 -0800 (PST)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatible for exynos8895
Date: Sat,  4 Jan 2025 18:43:16 +0200
Message-ID: <20250104164321.333669-2-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250104164321.333669-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8895-dw-mshc-smu specific compatible to the bindings
documentation. Since Samsung, as usual, likes reusing devices from older
designs, use the samsung,exynos7-dw-mshc-smu compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
index 5fe65795f..ef2d1d7c9 100644
--- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
@@ -29,6 +29,7 @@ properties:
               - samsung,exynos5433-dw-mshc-smu
               - samsung,exynos7885-dw-mshc-smu
               - samsung,exynos850-dw-mshc-smu
+              - samsung,exynos8895-dw-mshc-smu
           - const: samsung,exynos7-dw-mshc-smu
 
   reg:
-- 
2.43.0

