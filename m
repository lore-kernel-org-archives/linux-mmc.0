Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208F43932E4
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669867; cv=none; b=bysR7v004UwqjR7q5H0mXLp4stzDuRfKVMPxNYDTceyiAKahBD476I+iMBblE897EQSdxmrIYlZiUFx9Z9QQMRxzI4TQu8wnSVOefvgo4s6eWQUZ/RAMmVMNoESoZSL2sFVfpFoY+Mh5I9u9EnoSenKgxbiEjvysLFK2xHZefaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669867; c=relaxed/simple;
	bh=bBmnapbFZhNl1hExaX6Y6v+emhhgEDggwTauM/OowSQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=leNBP6h/BsGCsGRDqk7NJh5qVRGDuES6gZmkze+8hI3PEo+l3y4PtIsl8N/izqr/QVwM5FgTySBK646acRdcdjDpM/fEXdwyLRxU3d9tOB794/C/GrWxJjokfPuq9OqnWmV8QFdYRJt3ZrSlgAs8TaR801/arSOy7+6J8EcYP80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RIPsEEa2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RIPsEEa2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so40811045e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 07:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773669863; x=1774274663; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdoEqGGjgbvJGV3XvDqNqAu8aItRm8RFqY326SKUvHs=;
        b=RIPsEEa23RUR/jUqpEqzIp2rrpfYkHzeVKCy0H4SfIBUNgrRa/qyXHZsUhssbM2ITS
         8+CSLW5fSevJweiV31/nfBZ+xhCLR9NngntV1mvPZJnReF7SXNNtOfBMC8dXbnflXSDO
         b2fHJF58iqaYOhVrajoocuss2kPEduzgmk8Iy42v5j3V4FrXwJJRobnah76xCWCSR+XY
         56qRBDaffa3lBvr22AIfOX2kGuoIpn8mUCq6dAXS2qvx+nBXnTlE45uhI2G3LD/x272v
         K8qfp+TEKNBv1pRm/rMtr8VWnDWj+p5bucHMVG1zpVq6bldt5QoFkQKp0QRv08b5EWeb
         NxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773669863; x=1774274663;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdoEqGGjgbvJGV3XvDqNqAu8aItRm8RFqY326SKUvHs=;
        b=mMW/IP0MitrtmDPCpNXCwKG8rvmUJX7VTZzrMKIaJvEuuZyySlE0by7ZYCeewlR0mJ
         NMmq7OS0WARcGDyQnSkT7ttNoOD7E/7awFR/6SyjbOc5F3YG6v8vY5d6+zWxBUKD3d2K
         ibui3fY/EGivlm5DAnYlajsO72uO/vWdENBysJcP7ltd67qYlMEyK8T9IA7HRTAFSFMX
         zYYivoCMiu4T0AbHmjqnz806O+N7bW0HPytFshlri2QiOWdUPxx8pr3jIMe31cJJeKeV
         qVmHpv2GjzRpkU2ODm6pyVWkAfPfE3cQeoQrcnaeFnplDDWQLtP5TQO0v12KcP1hD+sr
         RaIA==
X-Forwarded-Encrypted: i=1; AJvYcCWVEZbz7xhsccE0V44kBZBjAleKj7DIlO3GePEL1b+L+JAXJB5xdDr9oJD7riOwDNC7NJzQeErBGlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjSceuTDCGXJIQa5CiLwG8O+ZWHT0IE8G0HqDIA8z8TjcQ7Ej6
	CKDcsDrsZhPTAwkR7CADWrA5BNXbPZmRTpsdsTMwT0jX2IXIcn1xhunG
X-Gm-Gg: ATEYQzxAq1V9c4Q44lfkxo6Taa5ZBYm/vKQU2hBy2xWbtjGckv5Z7Zshd4pwZlYMdxY
	pjSJqKY0jW8M/EOxJtS1rWbgYB7tf2atdaUDaSYWqo0A7WT7I/QGdRCvMJTHiseCXSVbDdG60GE
	l4iSGwZBWSu1g7B3S7e0v28NOicxLvF9bnEHmH8RpOER3K9bVSuglCh4CCip/bHqiZEWOPkqQ4+
	uGf1r1sZSlM1fBDNow9jSdIwrXfPXv2XXc5X9FLaDue0YPezUq/wIS67XF4gz5o3MgMd84eQPxL
	LTWmSOae3auyYzBLwcqdcfpJThAqKmN4LccRMGBUJmNmd/wFjyaJ63VnIfhFgzf+pFj5NaQA8u5
	4ZSBDVEsBqlvc/0Gw7UrkOuIZDQQkyEZtznqRL543yL+6hZILwxTcjRpVZ0yLcFQnsCdnbfmBji
	/rsFQ9cqzveolepe+gsJz5kZFWfvY0E/1xGrV+zoGI/XNLMJdw7gedJjB/abdVPbtc
X-Received: by 2002:a05:600c:1988:b0:485:3f58:d84 with SMTP id 5b1f17b1804b1-4855a8d6fd7mr204197625e9.32.1773669863067;
        Mon, 16 Mar 2026 07:04:23 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.234.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b3a09e453sm20698725f8f.0.2026.03.16.07.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 07:04:21 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v3 0/7] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 16 Mar 2026 15:03:28 +0100
Message-Id: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNyw6CMBCF4VchXVszTOVSV76HcUEvwCRCSauNh
 vDuFtyw0OV/kvlmZsF6soGds5l5GymQG1OIQ8Z034yd5WRSMwQsAbHkzq/rRDwYrhtv+LMPHKx
 WUNRCKtAsnU7etvTa2OstdU/h4fx7+xLzdf2CAvA3GHMOvJYacykroUFfuqGh+1G7ga1gxD0i/
 yCYkEIpVEV1Mm1h9siyLB/zujKG/QAAAA==
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
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>
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
Changes in v3:
- Rebase on mmc.git/next to resolve conflicts with "mmc: sdhci-of-k1:
  add reset support" patch.
- Squash tuning infrastructure and implementation patches (3 and 4)      
  together to form complete functionality and avoid unused function      
  warnings.
- Reduce code nesting: implemented an early return sanity check in
  spacemit_sdhci_voltage_switch() to reduce indentation and improve
  logic flow.
- Refactor pinctrl initialization: moved pinctrl resource acquisition    
  and state lookup into a dedicated helper function,                     
  spacemit_sdhci_get_pins().
- Use generic regulator node names (buck4, aldo1) instead of             
  device-specific aliases (sd_vmmc, sd_vqmmc) to better reflect that     
  these PMIC outputs serve multiple devices.
- Remove dead code handling 3.3V voltage switching from
  spacemit_sdhci_voltage_switch().
- Optimize tuning algorithm to use single-pass window detection instead
  of storing results in array, reducing memory usage and complexity.
- Remove unnecessary card detect check in execute_tuning() - rely on MMC
  core.
- Clarify commit message to mention both SD (UHS-I) and eMMC (HS200)
  tuning support.
- Add SD card support for Banana Pi BPI-F3 board with UHS-I capabilities
  following the same pattern as OrangePi RV2.
- Link to v2: https://lore.kernel.org/r/20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com

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
      mmc: sdhci-of-k1: add comprehensive SDR tuning support
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
      riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes

 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts  |  23 ++-
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts |  67 +++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi     |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi             |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                   | 243 +++++++++++++++++++++++
 5 files changed, 384 insertions(+), 2 deletions(-)
---
base-commit: f38f518dda1f1decc7a39556fe3231b0d1b84e1e
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

