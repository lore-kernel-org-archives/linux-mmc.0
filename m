Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D2D16CD1F;
	Wed, 26 Jun 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719395374; cv=none; b=m9V2B6oYULg520KDmMlXTeaq1Tf/XusypA1JX6NKEED0UbUDyw0c09ZerJdqvWXZPo4/UD3qNVaVUr8rTkcKg/lpyrY+BrBf+GPyiXK75LB24C1a7kjD89Hy6FT5R2hDcrpndu0edFQofEcWu50jchjUOTb7pct4NFge7R/mXKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719395374; c=relaxed/simple;
	bh=nyAn45UkdIMYYwIw68km3YLgE4LN981adMgW+jtRcjY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lNSlxtUMMGWWniLZtDKpJk387+Av/HRFHSMgmyp6HFMpDcbemSoRbEV2QZWaS8Cl12O+y6oDED6bPOPItRLiK/zgWm0QoiAHj8VpOuMzsVnPY24ABu4p3NHIIea/h6Rea3vaOdsrmlUsXx4V1ahIkOVtoTYbCRRD6WPatwgo4vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSnujuR1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSnujuR1"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f9b523a15cso2954705ad.0;
        Wed, 26 Jun 2024 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719395372; x=1720000172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cNU1a60CfCiX6Hw5x2IZFVQSkvoOIUiLn4EitVdi3Pw=;
        b=fSnujuR1ZJy+E2XQZwMsyK5xpxLpI+om3y6IhHLotfeO73x3zf+F/A94mshgIbFS5A
         FlFXUW+fThFg6y0XuN0+0YiOeej3iN2p4iIMCU9W4Ybn/ejejrDuu5wGW2SeNdPvjE3I
         oE2kU7hAPYnuoqKmIuKFzoMqs8mWPu7s98jOxMUyqzyjhx++8Zbbf0uC7k0CAs2QVOFB
         dBVtSqD0dWmL7qY/D2nu5dYeBLDi2d08tHzHsMo3kKbYv6kJL7LgJ74nUkqXKWz3yfTV
         sMIXo/PydqbiMWd0v3Tun27oREcZ9kR2mklycSok+rqiYptqkgVoOZa5J8seqIam0NVP
         e93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719395372; x=1720000172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cNU1a60CfCiX6Hw5x2IZFVQSkvoOIUiLn4EitVdi3Pw=;
        b=L69jOKExbDegvWYU1kMuhxiWS4tBhPbGDhrSv95IyONHCwLugPMP8F0RfROtOAreKg
         XvCVc+2dMepfEMyjosj0V3dVfmmFAqKn3dZYNoe1U/F1xVqP83aKW0qHY+1I5eZi69IO
         bWcj92KT2R/jz/YAXKcwZ4oerD8nuBzdVZsbocFxTMm3xg9UFeIWs1DT0yYhL9QOaJSd
         Ae0vmJE0BXU9JbMRV85DREMtPdcPQytlUInPzGNhawRSxC5u/q9QEpBuCWAZ+AVldbGb
         94EuQ+Tk2fqxndMHfhaKmhbbsg6FXUWFwmAXuEtVEOD+EVtlMj8nuyHMOTRr2sVs5e9W
         dZ+g==
X-Forwarded-Encrypted: i=1; AJvYcCX8KMhw2z4BAG8lAYhqcFw5cpRXgnmFoTtvcE6lXx69ocfawcHGe0zQqMnVhIq3gcgzMaK7pszlajwibkFMozWErAOvXCDEJmDgpBXX37PGmbdT23bNH0DtoWdOuIuZAzRw+mMPiJr2bNtm3oskUruX0+zmkVG/A8qrU50Id89GiLnDQQ==
X-Gm-Message-State: AOJu0Yw4wGPr/NBsxajN4/SCwz0eKNe+V1dxbk7MTcUnix7zG9Wb4HDo
	WTMhSBWYxR0ANa6xXuz3u9UXhfxtSmWHF8TK4iY/25N4hRHl2HH4
X-Google-Smtp-Source: AGHT+IH4SzOk1LTjzFzMAd6+TVYhUdE3VY0zp+6xlqS3ft2PXUhtbCcuzFHhh/gA+6swVpDF1lH22A==
X-Received: by 2002:a17:902:9346:b0:1f9:e97d:9460 with SMTP id d9443c01a7336-1fa0f8cd9f2mr114953025ad.16.1719395371897;
        Wed, 26 Jun 2024 02:49:31 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fa6aa7030bsm29726665ad.288.2024.06.26.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 02:49:31 -0700 (PDT)
From: Shan-Chun Hung <shanchun1218@gmail.com>
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	pbrobinson@gmail.com,
	serghox@gmail.com,
	mcgrof@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	forbidden405@outlook.com,
	tmaimon77@gmail.com,
	andy.shevchenko@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ychuang3@nuvoton.com,
	schung@nuvoton.com,
	Shan-Chun Hung <shanchun1218@gmail.com>
Subject: [PATCH v2 0/2] Add support for Nuvoton MA35D1 SDHCI
Date: Wed, 26 Jun 2024 17:48:58 +0800
Message-Id: <20240626094900.581552-1-shanchun1218@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds the SDHCI driver and DT binding documentation
for the Nuvoton MA35D1 platform.

This MA35D1 SDHCI driver has been tested on the MA35D1 SOM board with
Linux 6.10

v2:
  - Update to nuvoton,ma35d1-sdhci.yaml
    - Remove some redundant descriptions.
    - Replace 'minitem' with 'maxitem' in the clock settings.
    - Make corrections to nuvoton,sys description.
    - Add sdhci-common.yaml.
    - Remove '|' except where neccessary to be preserved.
    - Keeping one example is sufficient.
    - Add regulators in the example.
  - Update ma35d1 sdhci driver
    - Refer to 'include what you use' to modify included header files.
    - Replace the number 8 with sizeof(u8), and similarly for others.
    - Use "dev" instead of "&pdev->dev".
    - Use the min() macro to improve the code.
    - Use dev_err_probe() instead of dev_err().
    - Implement an error reset check mechanism.
    - Add devm_add_action_or_reset() to help with sdhci_pltfm_free().
    - Use devm_reset_control_get_exclusive() instead of devm_reset_control_get().

Shan-Chun Hung (2):
  dt-bindings: mmc: nuvoton,ma35d1-sdhci: Document MA35D1 SDHCI
    controller
  mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver

 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    |  88 ++++++
 drivers/mmc/host/Kconfig                      |  14 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c            | 291 ++++++++++++++++++
 4 files changed, 394 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

--
2.25.1
