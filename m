Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A432191;
	Tue, 16 Jul 2024 00:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721090738; cv=none; b=GOlbmSDR/lkDP4GZPgj5EZ5u4f8MYit1+jyUprb974FIWQeqF71wrkD//d3Fn9mtYB5FGKi9X7eQkXeBNDnHVe3lvacaDLQL5/YBIuDPbDJ5o3KiYLoUS5IkL8fksfX29Ui3GGhSGJ8PbwiHZloY4Sy8i2ggEKTFklu94RmDJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721090738; c=relaxed/simple;
	bh=xmVWODUyxNQoM7cdwnSoUDFS3lg0SBkGXihzRMl/Yeg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/stl5KplMmi6dXZXyGmqkV3haai2ekDzhZklIBlPGGPsNUJhKlQ+7yG6LS2LIn1u8RhdC6zD1XqqEriInZhd/zGzrRnvQDYz/Jh2u3XXWr6IjDAY3YjgU+kQo3tDHmuy9bsLI6H7cQBppZRnw2BRASb9X1l5rBGkSJlWc99lXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mc53gINu; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc53gINu"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-25e150603a6so2451884fac.3;
        Mon, 15 Jul 2024 17:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721090735; x=1721695535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnXr0eXuAv0hZrIz9mCHMK0FQq9j8VZolcsUM4NL5QA=;
        b=mc53gINuCn000kv6jnW3Ymzvu5Gb7p70ypVEVUlPBB3rWl/prXi8BAWNRdzGLy/Rap
         EEbIJZQvy3ogfpWXc2J+w9qMeDQbwicbKxePXmdRHHrONQG1i3fpmg3tgUTflhjVs7Jt
         GtaqvQJ5q1q8m+wzjNu3eAxK0CRk3GNDYK7gVaH29ZqxqrzXA0ZrM7MVgPIlHOUwvujZ
         zzSvEzYLKH23B6TUFOVVEpj1cz12Cgf3rgnAoSg/mfYe7BEexT67474l4UWxzKrZGv6Z
         GGA3FDjBMuxfvYaGDGCzk8JyVLjJPR0WJHe9LU3lkPbUQ37OKU5SSGQA/htIig0ecw9K
         HpTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721090735; x=1721695535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnXr0eXuAv0hZrIz9mCHMK0FQq9j8VZolcsUM4NL5QA=;
        b=mOTMm1Lp/LE+VvgM9vWPEhEX2iiczCYML2iTESg3/i4r4W+jRcGx88Cwj2XxbCGflG
         YJVsvdm0ioLaKrUHGwBJEnbKkcEsc0/TuEsRqKM2VQ6ru7rzRIXylEAe8VpYDuK7ofT1
         GEKLl5I6MnVu87oxr6AHec/fAxtfIZs3yEhub4SlSyUqdo/+/1FDF9//kQLc4cV8wfar
         oDDu14L8N7OG5qQvxNwEOm6l+tb27qTZYA9CDGWF5y8tnGWJo6qYlhU45dGQDkEhs+BG
         0GdqKWlWnSEMGXvMS0mYUnnWY5j/RHcb1ORa9+t0Pp4ESWuLvS46aLbNWPayfmycJ380
         fXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVESk459zjwW8zpEZq3jgJu0Ykx8dPbOlt1TGKNqCGNI5mVH9U5vIKtIu3HNIPv5r7euQFQ2lZ5xAGNJPfr3DN4tu9L1/N3YlZK9oxPQ3zAIGSOqBOMhs3M2AhWdBV09/cDgmwq9rVGuwJZod1Y1mw5Y90cSmVsUxa5DWkqK9IxRzgCXQ==
X-Gm-Message-State: AOJu0YzneNkT4+iZYLaQmV63L5usbZkZysIkFE/m9UAwq9pSDvTjQXUq
	XrAxM6U6xJuzcu128qThnLWhERXoDZJEHofC8CUsK8kiNgGn05CVJjILA1DxFQM=
X-Google-Smtp-Source: AGHT+IHhID7gzwliNwSDimSOwWCZnoturptY/gWrbZpRJF5QjxmXeZcq2t1YrqRjdEUztNfviDcFRA==
X-Received: by 2002:a05:6870:64ab:b0:25d:f1f6:8a2c with SMTP id 586e51a60fabf-260bdfbed6bmr400179fac.39.1721090735456;
        Mon, 15 Jul 2024 17:45:35 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7eca758fsm5000949b3a.162.2024.07.15.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 17:45:34 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Add support for Nuvoton MA35D1 SDHCI
Date: Tue, 16 Jul 2024 08:45:25 +0800
Message-Id: <20240716004527.20378-1-shanchun1218@gmail.com>
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

v5:
  - Update to nuvoton,ma35d1-sdhci.yaml
    - Fixing the same orders as in the list of properties.
  - Update ma35d1 sdhci driver
    - Fixing the error path syntax to err = dev_err_probe().

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
 drivers/mmc/host/sdhci-of-ma35d1.c            | 314 ++++++++++++++++++
 4 files changed, 414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

--
2.25.1

