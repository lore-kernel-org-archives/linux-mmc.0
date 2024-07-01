Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0353A3D7A;
	Mon,  1 Jul 2024 00:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719794386; cv=none; b=QI+Vm07xYKwgE2CDURLrFeCtqig/irujEVkL2FWAg6y9LBA99QBNwKTwNSn4CIscnuM2YYKccWB2jVbtTR+iLB0TirrjCfi30aKG1nILKoTuyFk94OlAahIxKVIcFcBOF1IBNbeuPHKzH9u2on7Ug5EyTxSywNsJsJUcxFWO+uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719794386; c=relaxed/simple;
	bh=hO4sfUS3CwkHNECDhfCyBYKBZxgPFN1/diebXm/FPAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cwzf4updn8dMXIdBQjnC6n3CAENsDU8vKrvWuXYMzW3tHQkiyvkxXhabhNzLK4wk73G6mpM+btK228PAhAKbT/bBdk4+vRnhb0EzB+8POYLWM1tEQ5xTbCOAiNX1kuCKjoceYW6ZTT69sJvCItkH+04mvk+ODTOy0OzEJ022nh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MpEFm5ea; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpEFm5ea"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-702041ba5aaso1146448a34.1;
        Sun, 30 Jun 2024 17:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719794384; x=1720399184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S3dntM8QcCQKAFsfsjnIQTFcpVozkZ1R9I8XEKBnf0Q=;
        b=MpEFm5eaDWYtrjnFDlRU7fg1HuW8fOgRmyXrdMTe95Lvx7JATzCdE6rVPIun0GqF7s
         L3//42+DCMMMLgzjooJOQHIZ1EJSrE7PskjcrE6gbnkiO8oBfSYamMLGJFULGg02hggc
         L8+JGJDZsl2mLO/eGrIp+dUCxl+riOzt9eFJUe5Q2+FFBXQ7mMhnboqAj7EcKylayYEd
         nmwN86gAWiAH18jV66KmZEjIJzKMF2TQyfEu3qianEqmq+kuGDP2eHEcPxORZW5kN+4u
         B7aoAizW3mS0lnPE2RDTr4TcW6RVhGrizaYh9KsEwPtIxXR3fv/A5HF9MQ602dCm/Kks
         PlfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719794384; x=1720399184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S3dntM8QcCQKAFsfsjnIQTFcpVozkZ1R9I8XEKBnf0Q=;
        b=L6PSd3SK9JvNeALPtml6SNdVOCBkRrXNyFuwdka/3J/dSrMYNGw1TPVT7Rdy2sVJok
         gz5mRKmbrOtTZXpDLgECxdmoWNlt9iLatAXauWdD4SZ5vs3wRsJi1n3drSZYvvsXBF+c
         CyXdhSFgukCMbwlkzeYGomPgyegpAJQ9dzw1zTBDzlmwVPASQo+oDwPSJnyyjqL+1toa
         A4QeBGrxAhkY3ue8GevYpWvpF/6eJtQMQS+31IcVdvThBQSrlEFz95tEkcQUS/OsSrrl
         tQ06sl20ykLd1Gb1Sc+npBCXAr4o2u+wHt0/y2HaT9bXqbXj+nKzG77inP+tFqvXJ1dG
         hi0g==
X-Forwarded-Encrypted: i=1; AJvYcCVmzSq7+6RUlc/ICqMqxYmZcfOLNzV7u7S3toTRXBl2WYLBojUJwXz80HrbQVruV0fFZGJAtJN6zcsneplbQ2FzTDwCRQbGQQ8EOuWwbk0dXFHRTua7bTJ2bsVZLLAK7NHyGy4d/xl4R7puqYQ2X7wr8ccVFIAqf0KnRFloY9QFjbzO7Q==
X-Gm-Message-State: AOJu0YyT4rtNgGFjFZDS2oSq/iSLdZ7EkHUy+lLSt/ffS+rHEUbwZMwX
	j3cOueHLiOULYhQK2ezR6zc6IjAHcpMAd03vXSsI2VGHAoEJaKY1
X-Google-Smtp-Source: AGHT+IFyXgvceWGtOVGB1Z3t87Q/Y6iMoNOtb9HBnheZHY0WfpsGEL6Gf5mj/XgFOgoX9/PK+9BQIA==
X-Received: by 2002:a05:6870:d290:b0:254:c842:46f0 with SMTP id 586e51a60fabf-25db3624640mr3987580fac.59.1719794383883;
        Sun, 30 Jun 2024 17:39:43 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801e53b47sm5232022b3a.37.2024.06.30.17.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 17:39:43 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add support for Nuvoton MA35D1 SDHCI
Date: Mon,  1 Jul 2024 08:39:11 +0800
Message-Id: <20240701003913.729428-1-shanchun1218@gmail.com>
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

v3:
  - Update ma35d1 sdhci driver
    - Fixing "Alignment" and "spaces preferred around"
    - Fixing style for multi-line comments
    - Fixing double call to sdhci_pltfm_free()

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

 .../bindings/mmc/nuvoton,ma35d1-sdhci.yaml    |  88 ++++++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-ma35d1.c            | 297 ++++++++++++++++++
 4 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/nuvoton,ma35d1-sdhci.yaml
 create mode 100644 drivers/mmc/host/sdhci-of-ma35d1.c

--
2.25.1

