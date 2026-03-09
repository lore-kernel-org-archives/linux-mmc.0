Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA043A4F51
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056431; cv=none; b=qz7lPK79GDMVyz7JlOvovgPCgrUomDUpRwIW8alpbIuow8mFXyvM1q3zsAv9Eh4GzKQEiEgZqAKE6UVdmB96C8wEHJ1JG+TFhqcUvLmBpiDRFdnvpgb2QR7m1/m7ffqkyKLKTA33bJJB8nk2SGsl1B8OrE3qxvqLjB2pceXlTxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056431; c=relaxed/simple;
	bh=sw+Cc+5HCSi0Q2cmwdwnnqsNb62gjuQjguM1odYVI24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LnYqOCxvjpDIFpvPdL74uqEnikHc5xsEV0GJ68HwnK72o1mMw3p3ceGAIYbiDoYkWECEF+O5WoVTNY0qnuAnayS2RHPqMTTSPJLuarjCp1rkUE8Lvito7/BtnD71y6bzyG4mvpJBo+oXTo7OJJRpewl+qb4m4nJ7lakb0In6SF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwRxH/Jp; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwRxH/Jp"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b7c2788dso5773607f8f.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773056428; x=1773661228; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S7AMv4ruvD0WDb3IJGhR9swDRb827tGwwDotiEuQEfU=;
        b=HwRxH/JpsBFfwe+t12fUdPECY2DkbbFg0kOP7ELnCFf+PJuKaWGgSfFnwHzPjco0L8
         7tjaM55zWsLZaufMjl0WeF66azIHuvA/taOKMsisb7aAtediZD+ST6ub4qyqKze+Mzf8
         Y4/g9ECqiad39EXOxzI4Dz/tdcZIxFEVPoLQCjom106P2E4RnChoruzzJxp9nVSCFQF1
         z97/WonLEjgzfbi1eckF+YeArkgHmLQgRW27xS2yBrZo3i84ow+gdfNjkeP9IkZB2SO9
         EEMsD+/+id/xP+7U+C3pHv5ZP5WcmW69LnR0T0VhoPbHEQx0ARe4I2oIPRniTaur8RvW
         tAkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773056428; x=1773661228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7AMv4ruvD0WDb3IJGhR9swDRb827tGwwDotiEuQEfU=;
        b=T95AFbHbLsFr2KK+b20rIiXY31uGdlQQ+Jkrdymv31MYZ1j5yWofCtmhENSWhZlD7N
         tZnRW2OS3IxKNIL7I0HXH/d1JfFRZrz6GEEAKJnloBwWxdZGvPG0UCnt0X/WVrpxMKnk
         iQgJyTssOlv/IUUmJI8qR3nRbLKIcrhcjZcgitx+xP5vfzlZayFkuCsbkCQJRdKOQBHa
         uIFK130dxnlW12duQL3XcpTfgFUGMfnw2N0HMSt536bVH8rMmKLwp1G9UGaqQcTIo1B5
         aqxY7P1lhMY+Zvn1AbTHK5dRkQPpsMqAdTOnPPI/rC+P0/UQEX/1kMpsfKKbffh/953d
         uVxw==
X-Forwarded-Encrypted: i=1; AJvYcCWiMrQFSj2g8QJ51jrhaHhug6TAoeAbum7HGXxfUJl4Fd6W/JcFfbc7ExAwIZqCefPnMAfFLJA9Acg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqts7IY/deF73+/D7Eo65RKrrCV2djeRsb4eqpl0mvxixRJheL
	CtEArN//CFdCHBLrOnllVatWkdpLh85680m7+ZwUco2z8lGlOInUEdz3
X-Gm-Gg: ATEYQzxQC3/m0JX08QcZ6xlnZQO0eb+ZsjEheVak5ecY65DhtZUcDhPfvn27g9nQG3t
	ZN1ekNAjieBSdQ2xJTlgaTl+S20A9JYbLuYZgi0qHMQnDplQySLjPgXRxIFTOdlZdB4K6g2DlC4
	vQphlNSQ2cy8ZdGQ6AQ3hNpUSFgos6h8dB9tUEv94ppQg7bKwVagJGK/QZlnjSrLPTf358OnZ1Q
	ZXjXA1myEN7fcTaiOln17fTILF+4YFhLQpxz0h3wEHucbyK2iMpgCKPAvF3Hehqhax4tylSd53M
	5kSKCP8S7yn3p0X1Hl4JPwzVNX3/o1wZH7eHcNeE4dCpN1VlOQ9QjfswajKriACNIn+GNnzTLlo
	8+jt9UNVDrGRbm73hT1MYc5MysqRq1k6ZuuY4rZWSaZVLdNL1vB0IeXGUeCrc/IPAYcjoX/VNaI
	qTr6wjTCRSTCi9pM+1i3fR8zESQNXZDhOfAdO+0szkpvAIZTFVLYN8xB3WSG3EJLJ71c3SYrTu8
	c4=
X-Received: by 2002:a05:6000:1845:b0:439:c5cf:fc68 with SMTP id ffacd0b85a97d-439da3483b0mr18304868f8f.1.1773056427412;
        Mon, 09 Mar 2026 04:40:27 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.236.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8ec97sm28471699f8f.5.2026.03.09.04.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 04:40:26 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v2 0/7] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 09 Mar 2026 12:40:10 +0100
Message-Id: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NQQ6CMBBFr0Jm7ZhhiEhdeQ/DAoYKkwglrRIN6
 d0tuHX5XvLfXyFYrzbAJVvB20WDuikBHzKQoZl6i9olBiYuiblE5zc7K4YOpfEdvoaAZKWlU1W
 YlgTSdPb2ru89e6sTDxqezn/2lyXf7C9YEP8PLjkSVkY4N+ZcCMm1Hxt9HMWNUMcYv7DDdL64A
 AAA
X-Change-ID: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
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
 Iker Pedrosa <ikerpedrosam@gmail.com>
X-Mailer: b4 0.14.2

This series enables complete SD card support for the Spacemit K1-based
OrangePi RV2 board, including UHS (Ultra High Speed) modes for
high-performance SD card operation.

Background

The Spacemit K1 SoC includes an SDHCI controller capable of supporting
SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
currently lacks basic SD controller configuration, SDHCI driver
enhancements for voltage switching and tuning, and power management
infrastructure.

Implementation

The series enables SD card support through coordinated layers:

- Hardware infrastructure (patches 1-2): Device tree bindings for voltage
switching hardware and essential clock infrastructure.
- SDHCI driver enhancements (patches 3-7): Regulator framework
integration, pinctrl state switching for voltage domains, AIB register
programming, and comprehensive SDR tuning support for reliable UHS
operation.
- SoC and board integration (patches 8-10): Complete K1 SoC controller
definitions, PMIC power infrastructure, and OrangePi RV2 board enablement
with full UHS support.

This transforms the OrangePi RV2 from having no SD card support to full
UHS-I capability, enabling high-performance storage up to 208MHz.

Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Changes in v2:
- Removed custom AIB voltage switching code per maintainer feedback. The
  existing pinctrl driver already handles AIB voltage switching
  automatically via power-source property changes during UHS mode
  transitions. This eliminates code duplication.
- Squashed regulator and pinctrl commits into single voltage switching
  implementation.
- Moved voltage switching callback from dynamic probe assignment to
  static sdhci_ops declaration. Removed redundant SDHCI core call since
  the framework handles standard voltage switching automatically.
- Made clock override (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON)
  conditional for SD/SDIO cards only. This follows vendor driver pattern
  of differentiating SD and eMMC card handling.
- Include no-mmc property for SD card.
- Link to v1: https://lore.kernel.org/r/20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com

---
Iker Pedrosa (7):
      mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
      mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
      mmc: sdhci-of-k1: add SDR tuning infrastructure
      mmc: sdhci-of-k1: add comprehensive SDR tuning support
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes

 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts |  67 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi     |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi             |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                   | 252 +++++++++++++++++++++++
 4 files changed, 372 insertions(+)
---
base-commit: ec1fb4e55df47ed043ab2ccc6787e39b9d67e49b
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

