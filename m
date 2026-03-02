Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD72798F3
	for <linux-mmc@vger.kernel.org>; Mon,  2 Mar 2026 15:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464431; cv=none; b=rfCTLp+3qIw7hLuSwHclEhmIWAKZV2SNGaev/Oqf3w+H03hSZjSn3jaXggpBPbLtFi83lwWa5YtzCUFtEhJjnZynIrIwDvZAzBgFdOY1AKJIN8CRRKNRj4lctkNzEYfjGYT9R7fkZGL0a1S1H+YBvvfuNaryzY4GNXJgxoNYRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464431; c=relaxed/simple;
	bh=xoKFcRodsjBoNZCfcW1z1LG/a1f1H2smS58YjpeC2eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mkMAviDxh+dsQj8st0153FS7DwFU+kW88RSvLgweKw8XUOs4vXWYlYDziHF/xu1Zf6IfLTcZvAl0hw0OpYPCRgZrZN7mCkRXrTriofXWp09mO3kCf25420bFSqZfL9q5YlCHNLah091TO4DbBZS3y7l/JVMl6hCnqjnf10oCcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3DLHmdb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3DLHmdb"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4833115090dso47403065e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2026 07:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772464428; x=1773069228; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4bjNDBX+/PFOXtqF8zgz+Y2Tzpl7yAa/Q3C6j5YXCMg=;
        b=X3DLHmdb48SvM76Wox5pvGsurm+1pb+VwgKKFDIN/mZFm5QtJg736khlePB53u9DTl
         1JF3yi0412ALakQHF4SxJFGLD+wMn0hoBTVAlTknbPBip/fSkUFItRLyQfAVbbYXi97Q
         IX4hp785VaYEMGXfWCzBNCfiavTVMMkqfXZDEk0dbtDmffT9zCOLlG2zXgb5lnjepF67
         Nd5FGt63diUqZMlpKuma/1Ela/sB4m9pYDx0m6vJoHI7eKzcGOj2Mll1q83ym0LoJuzE
         /opxcWI+9P2BSMYFiojwB0NKeIrY/Hi+JdJe0WQsRO7pL6d6zpwnCxorQZlHiLtE6VDv
         mBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772464428; x=1773069228;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4bjNDBX+/PFOXtqF8zgz+Y2Tzpl7yAa/Q3C6j5YXCMg=;
        b=fLGQx5jsAiOWdGpfZzH0iM/b45zpjLxuSyKeb2wup1D1Y7boSyR558g1L0CwVt1xWR
         E8fckv7Gj+XJVmBuCPazmMbrDCinGgGXA5LaJRRYej1ntcqjV+UBXCPIFFjaafnBb5Eh
         0miBe3LxNqhwXI+z+LeqMn0T087i9polGZsZ56IGYUOotPvbtS2ohEyvdQYxLkUnRR/t
         lHbey+Tpb3MjcpmD1NO54JvAOawsC+iProweWU81p5rqHb/0Tg4LGA1ZiaWTVv8nlmeX
         z350v/V2ayD4qAteLhmV+LUjTlYBCx/npV5xQ4vtV5ISf4MxRwCBNIchZMAa0GBtx67A
         8KRw==
X-Forwarded-Encrypted: i=1; AJvYcCU5gFSpSWYcKcMEG+N94ene5ph+cc4tvTY0S3vEJMHb1FW3HQMazygtfEAXdtQjckV4e/MWSJJCD0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SLRqi72uuopL7dvHngxbZnIJCEhe1keynfOwzFNPispaz2Zq
	Sx2h0z8dNzzzXWowzo4UsHvUI6lZgGRDu4l+Vmt4BhU1F5KJ4eBeK3Ig
X-Gm-Gg: ATEYQzwbsVsH2mofuv3yjYLBqdt1iHI33Uei+ptRY+6K9BDX6cNyiyFY3EvL96TVu+M
	1T4ph9kyL1WuqDRBqcCpCy5InIfKt3IUA/OcHX3JwxBk+tm3BUOtiZpJDCKPvatjabvZmaxB8Ch
	wn1DsDzS7BMmqfA9A6vt9jEAjPKPC0xDE5mcrkRK839iKrOAmKRM3Mod0ZVON2ilc7LxMHtpyT5
	EfmT0G3d03/v3hYrELK5f+OiErGv1MzGSInystaowWwss0sximHaR6E61eJ3xutdzsc/36bSDB0
	Tr9B1SS7ORGjiZ1TlfS7V2kYZ4WaFXSlPYm0Lto4iyWQyRTQqevGReDd/fiYkImuvc3cOpPLRDE
	00jnEZ8FwNzQpjIVnNmkufTLxyWfppFP35RP8ZPJAbjYQmPxMAtK/m/JU6FVfRaf0NeE2MJU2OZ
	+J6LiyEosdIWc2Si7N+dLMqJbefsbM6oMgLraN06VXp1Jvx3c1Q9GJhWgFRfQ7zAOPKQ==
X-Received: by 2002:a05:600c:3486:b0:480:20f1:7aa6 with SMTP id 5b1f17b1804b1-483c9bed9e2mr214730135e9.21.1772464428106;
        Mon, 02 Mar 2026 07:13:48 -0800 (PST)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.235.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e692sm437240265e9.7.2026.03.02.07.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:13:47 -0800 (PST)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH 00/10] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 02 Mar 2026 16:13:21 +0100
Message-Id: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQ5AQAwAvyI9a1IrBF8Rh7Vb9IK0IRLxd8txJ
 pm5wViFDbrsBuVTTLY1QZFnEBa/zowSE4MjV5NzNW762V3QIgavEY/FkDiMVDVlO1KAlO7Kk1z
 /th+e5wV2nN/1ZgAAAA==
X-Change-ID: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
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
Iker Pedrosa (10):
      dt-bindings: mmc: spacemit,sdhci: add AIB voltage switching registers
      mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
      mmc: sdhci-of-k1: add regulator framework support
      mmc: sdhci-of-k1: add pinctrl state switching for voltage changes
      mmc: sdhci-of-k1: add AIB register support for voltage switching
      mmc: sdhci-of-k1: add SDR tuning infrastructure
      mmc: sdhci-of-k1: add comprehensive SDR tuning support
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 +
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  69 +++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 +++
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 +
 drivers/mmc/host/sdhci-of-k1.c                     | 320 +++++++++++++++++++++
 5 files changed, 457 insertions(+)
---
base-commit: 5f499bb7a07fcdcf8877acaa8f413a5dc1fcfacc
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

