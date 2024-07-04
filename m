Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF62208E;
	Thu,  4 Jul 2024 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075055; cv=none; b=faYdasGmYYQ12cRsPB2DnbJxOL58FkSA+yFVHBkMOgzjy1seW2BoMo5uW3trL8WYWuygoUgEcbZVr3jaQSmX7e7LsHNBQPasVdjFXLYah76evgUngzt0YXoUhu+DY/1vfmrKFPaN65uktjDZdq7iHbgbJaaZk8+bDt0s+6D/pow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075055; c=relaxed/simple;
	bh=AkZrkSFSx5lc0JtPptkBI5YnorqqqY84dL+IvfE81kM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=raXZ0f+UaWRnCIUS/6ex6YlhXyc6FUr1cD1x7G/1mwBFQOJegQ6fbwvMXEp5KxkbKYyEK6Ti+jPLANCGZDR98Q4NI2rWYieSeV0KqSvyrS2xGRXLcjXBhgvRaXMJVnQVQfrqYtgJyEj/ELr3ydNfNUxHzg7tOjAAAUQMCX+6NVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDFbQCZy; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDFbQCZy"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2bfdae7997aso239371a91.2;
        Wed, 03 Jul 2024 23:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720075053; x=1720679853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9wcD4PWr8YAogAElKHlzCUbgCE7uJ7/yxnZjstIV5o=;
        b=iDFbQCZyxYCnA8fOUJE0zmtTUupmK0kGbnMIHrTJpJ7pk/LbA2ovjXZpeRXki2KOqX
         SKo+LF77ULp6ZTVajY6j+j/SRxOuVwgS2NlnVXxwHc6LkCnIy0welmoG5YdTgI8ib1RM
         zg6AB7c43us8A8b65ikzzLZdTSW8qiVn87WlU7DnJjA3F9mp33jc1mMmZ0z3eJ/qgMkl
         //OHARrCwnmWLqmCovMbfHg0eR0BGFqARin46UrmsOfSfRGTCdj5WVe4uGSq0RzM0ZAM
         UcLePUiAxjBUEH1brYnWdRv9N8b4pn05yKKuhmykDGA4o2A3D3QJTCUVWfKEqPbVKVO6
         chmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720075053; x=1720679853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9wcD4PWr8YAogAElKHlzCUbgCE7uJ7/yxnZjstIV5o=;
        b=emOuzefyP4/4CQMmU5NHiF2ImcTF8OQ+WXqF13OyNEE4b6konJ9oI+n//QBEQghZe1
         x27KtrQjNmQ1F0k7E6sgPzorAHH4mOZQ4uT+hwNmMsQKVH33wFkiz5AeK7yqL0tvM47E
         4JXWqt0SAJb5kdXltRwyhGCC3r9a7foSJkKYdOOijr32TFcbAhX/FxDSC5tFCOTjJHUW
         onjTMhgdQR2NpDAoPvmoxUT+2RGhs8zUxZh2TG5z0aV/CIoFu5cXOH5uUroRn33CwbX3
         zZbncO5twpwtzD6/vmyjcv1ZIiNbL/KJn9zUV9/XeNQfokt4bSASc0V+8q9OPt1XMVG7
         bKdg==
X-Forwarded-Encrypted: i=1; AJvYcCU8834jqVMOf8Tg9ABy365Eur+txf/dzjfenTGvfumEz0jUDikoTNFEYHbXz4+rxGNdwAXWD7a3tOGRGxoWF1NMMCrUp+PDeHEvU7KXoGu+fUEA74xFRMc4m52Yu4qXH9nGFs1uk3qWn8Becauz7uz/YJvbA/2oSQAbQDQk9sMQwajn6g==
X-Gm-Message-State: AOJu0YyOC5U4zSCqxOfXEZ188Gc93XhOtsr5P9uY83iBTEXGUoysi1mV
	LS9J4IrKWdb9Vfb2KYH3qg6dBTq3m/qIRr3l0gZ0kg7SVwAIB2v7
X-Google-Smtp-Source: AGHT+IEXpW7QC6BZPKVS4Pkn43o+XVWNg9bvWBSKIs78gLrv3gqo0RR3sbFIBeXVBHfqY2DiBvHZwQ==
X-Received: by 2002:a17:90b:618:b0:2c9:83f3:128c with SMTP id 98e67ed59e1d1-2c99c86be82mr550963a91.31.1720075053011;
        Wed, 03 Jul 2024 23:37:33 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99aa6fd28sm666835a91.36.2024.07.03.23.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 23:37:32 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add support for Nuvoton MA35D1 SDHCI
Date: Thu,  4 Jul 2024 14:26:21 +0800
Message-Id: <20240704062623.1480062-1-shanchun1218@gmail.com>
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

v4:
  - Update to nuvoton,ma35d1-sdhci.yaml
    - Fixing overlooked issues.

v3:
  - Update ma35d1 sdhci driver
    - Fixing "Alignment" and "spaces preferred around".
    - Fixing style for multi-line comments.
    - Fixing double call to sdhci_pltfm_free().

v2:
  - Update to nuvoton,ma35d1-sdhci.yaml
    - Remove some redundant descriptions.
    - Replace 'minitem' with 'maxitem' in the clock settings.
    - Make corrections to nuvoton,sys description.
    - Add sdhci-common.yaml.
    - Remove '|' except where necessary to be preserved.
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

 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    |  87 +++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c            | 297 ++++++++++++++++++
 4 files changed, 397 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

--
2.25.1

