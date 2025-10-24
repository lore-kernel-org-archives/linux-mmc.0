Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6C2F747C
	for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 07:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761292643; cv=none; b=hL6SOmHu3vQ7zZD9ldfJtF2etD696e9fFvNZ4iDwaWwpD4Xwtu/ckh1sJhQ68DBQYGMFSb9U3ddtF3P6szzcElKunkvCO40c9+Lyt4Yg4FLxzBZcgTMBAdSwGCYogN0zRJ41f6QYq35TYPZrkCijOjiMfaZrFU/AL4aViqMQt5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761292643; c=relaxed/simple;
	bh=TJaSEjKE+CKYl2acjXXkTcFRDFXy50ypbA4mzY0NH34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kJFK7gFTYn/4/8ehPSK8gISeaX+ymrBEv/TiEh0XkVuooJV9/3PuKIGlpU8U9oSA1TlXCVTeKkToB5X4VUI8kiI1gWuKwx0aTRIjGdAeqDdDq9cnwltnBQVnZvTTGhBhWamoLVimKbrQhOnDiWosHoEkY8FOMIP+HyED4HpM31Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZP5q4gcC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZP5q4gcC"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf07258e8so1243214a12.1
        for <linux-mmc@vger.kernel.org>; Fri, 24 Oct 2025 00:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761292640; x=1761897440; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s87dYxMf5XJtMF4s03dPIhXUNwiwE7LkdwCFsT1npMU=;
        b=ZP5q4gcC3LSh6fJQQ85cMsl7bxppXPLHfNYddjsG0af6n4jP0Dc3q8Nfl/2viNFiYa
         O+Etl9RqCFto7gkF1eTpD/hgIsgqVghg5vevZWX991MuDhDI760Si2hxkDfwtUgJvaK3
         BqQsn/4/RY9bEcHl9aM9zaU8Po00rhKhus8ElAV06Dqu1tWePZdrCFbbSf4TBJMvT2Nj
         Rzo0IonbvFZQ/hzSXDXJmCU5aZSm/ZEcikjzIEQaELergGpW/b4LeODvZ+K7U+bLDHiw
         K+y61wf+q1UyHyfySZY4r3mKrKv3dKDm1FxVGkx1+ogDVLH7zsaP5ivJnncNCllelIO7
         2bIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761292640; x=1761897440;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s87dYxMf5XJtMF4s03dPIhXUNwiwE7LkdwCFsT1npMU=;
        b=EDUdW9Aswz2kQp8nzGBdyreEdu7nTeEq5gMzsFedaYffEuBuqFYJvniDJrQZJerDE+
         XWzLZ+C5d+eL5EK+Ip/wbdkFthzndzkdOhvuQAnR33jjeYY2HSAid5enp+/SQe5yOCId
         bMY8XytO0ESRrXaWDX4Lvk1McOUMtRmnIkUdkNYMwYFiPz1gkPBazPvpzXPOnDq3m5Db
         XO1souzgOhf8fjukzoo0xjQn6XA9jo3sfO1ts5M3JestCLm5CcqhTlX1MUiw7B0OJX1x
         DFHQHMLugxxPtV/ZonU7h28b4TjNwRXGGkywNRg+3mYQmR+IP1UOVaICOXOWz4HBdNbw
         lFTQ==
X-Gm-Message-State: AOJu0YxKQNgyNnRqQFMFi7Q+V02+L1G1u5r4dRYvPG08TYoMwbSSNeU3
	lM/W1UWnn9EE78MA7jjrZz2ogk44uGTK49QmN+hQZRR8I8s6Ij6jMIsX
X-Gm-Gg: ASbGnctkKXi8ykTPZHrpZTwRmXTZM/drtbtpW8YTyVQ0YomBljD3QPbhaQ8u7dFqTMq
	65y+IUpENFAyKvHGxB9HU/y4wisDaDoeHQajXQDXXD4Elp34CTYqnxuC1Q6qiIqWRpV3lUZm9h3
	xXOsCU3mTkFr99jZGtqNlcBryiJ3lhuSmdl1Va/TFgELqbf8a7yOg+OTs6GeT6nxnAbLLVUb24s
	Nj2DkdsgZF563FLXAUcIuYEcT5rIywrtlRE/OfjdCsElOrwe9fX4ZQLPs0mMC/qH+7SN/cpywV8
	8609x2zqRjkB9lH2VBOxB0yOT6IPkNE/DnSAwzE6vqm+XwQWJrUae15rwbo0eH0ewFcLQG886Ib
	wWzo63UK8vl3Dn9bQLHJ5N9IBb98NXu3SkVFayfPdKK94AegC4ECgNDM0RFymW7tmbfgJrz2WPS
	lyx6HfE5VxJHhDqiJsWvuA4LdG+zSLzFc=
X-Google-Smtp-Source: AGHT+IEdrf9PFaVdu2IVtpCx1gbcOMrajzzsslPU/SnB8ZKTCBPtAF+KqI/4qBnjQdn1ghA3PMmmeA==
X-Received: by 2002:a17:903:8c7:b0:26b:3aab:f6bf with SMTP id d9443c01a7336-290cc2f83fcmr355173915ad.42.1761292640576;
        Fri, 24 Oct 2025 00:57:20 -0700 (PDT)
Received: from Black-Pearl.localdomain ([27.7.191.116])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2946dfd045esm46608205ad.64.2025.10.24.00.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 00:57:20 -0700 (PDT)
From: Charan Pedumuru <charan.pedumuru@gmail.com>
Subject: [PATCH v5 0/3] dt-bindings: mmc: ti,omap2430-sdhci: Add json
 schema for the text binding
Date: Fri, 24 Oct 2025 07:57:07 +0000
Message-Id: <20251024-ti-sdhci-omap-v5-0-df5f6f033a38@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFQx+2gC/13QwWoDIRDG8VcJnjtBR121p75H6MG6Y3agmw1rk
 JSw714TShM8fgO//2FuotDKVMT77iZWqlx4ObVh33YiTfF0JOCxbYESrbQqwIWhjFNiWOZ4hiB
 d9sZlZ7UUzZxXynx99A6fbU9cLsv688hXdb/+lVB3papAwRBsGohics5/HOfI3/u0zOJeqvjUQ
 fpeI0hwGND5II3H3Gv9r5VUqte66WC8o4wjWRt6bV51/4Nqms5jGnSM9CW9ftXbtv0CjbTk9mQ
 BAAA=
X-Change-ID: 20250519-ti-sdhci-omap-907f847f7530
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>, 
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Charan Pedumuru <charan.pedumuru@gmail.com>
X-Mailer: b4 0.14.3

Create a YAML binding for ti,omap2430-sdhci and fix vmmc-supply
property typo for a DTS file.

Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
---
Changes in v5:
- Removed "ti,needs-special-reset", "ti,needs-special-hs-handling" and
  "cap-mmc-dual-data-rate" properties from sdhci node and YAML.
- Removed if conditon for the property "ti,needs-special-reset" from YAML.
- Link to v4: https://lore.kernel.org/r/20251019-ti-sdhci-omap-v4-0-fdc63aaeb083@gmail.com

Changes in v4:
- Removed type for the property pinctrl-names.
- Link to v3: https://lore.kernel.org/r/20251011-ti-sdhci-omap-v3-0-9487ef2de559@gmail.com

Changes in v3:
- Reverted the changes on removing ti,needs-special-reset, ti,needs-special-hs-handling
  cap-mmc-dual-data-rate from the DTS.
- Fixed a typo to resolve the errors identified by dtb_check.
- Changed commit message to justify the modified changes.
- Defined if-then statements for compatibles to add required properties.
- Removed "ti-hwmods" property from the YAML.
- Link to v2: https://lore.kernel.org/r/20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com

Changes in v2:
- Changed MAINTAINERS to "Kishon Vijay Abraham".
- Renamed the YAML file name to "ti,omap2430-sdhci.yaml" from
  "sdhci-omap.yaml".
- Dropped unnecessary or unused properties from DTS and made these
  changes as a seperate commit as there is no user of it.
- Removed previously defined properties like ti,needs-special-reset,
  ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the YAML.
- Changed the commit message to elaborate the reasons for modifications.
- Removed the pattern property for pinctrl and redefined it in a regular format.
- Modified the description of the property "clock-frequency".
- Changed the subject line for the binding patch.
- Link to v1: https://lore.kernel.org/r/20250523-ti-sdhci-omap-v1-1-695c6eeac778@gmail.com

---
Charan Pedumuru (3):
      arm: dts: ti: omap: am335x-pepper: Fix vmmc-supply property typo
      arm: dts: ti: omap: Drop unnecessary properties for SDHCI node
      dt-bindings: mmc: ti,omap2430-sdhci: convert to DT schema

 .../devicetree/bindings/mmc/sdhci-omap.txt         |  43 ------
 .../devicetree/bindings/mmc/ti,omap2430-sdhci.yaml | 169 +++++++++++++++++++++
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts        |   2 +-
 .../ti/omap/am335x-sancloud-bbe-extended-wifi.dts  |   1 -
 arch/arm/boot/dts/ti/omap/am33xx-l4.dtsi           |   2 -
 arch/arm/boot/dts/ti/omap/am33xx.dtsi              |   1 -
 arch/arm/boot/dts/ti/omap/am4372.dtsi              |   1 -
 arch/arm/boot/dts/ti/omap/am437x-l4.dtsi           |   2 -
 arch/arm/boot/dts/ti/omap/am5729-beagleboneai.dts  |   2 -
 arch/arm/boot/dts/ti/omap/am57xx-cl-som-am57x.dts  |   1 -
 10 files changed, 170 insertions(+), 54 deletions(-)
---
base-commit: ed61cb3d78d585209ec775933078e268544fe9a4
change-id: 20250519-ti-sdhci-omap-907f847f7530

Best regards,
-- 
Charan Pedumuru <charan.pedumuru@gmail.com>

