Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA73332EBD
	for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776067353; cv=none; b=CNK9TIi537WjcX76iibIrC7p0qLGHVMXmZN6wCYBUWsnUT+4tDNBfzouKZvuji+j8rEblaQfRLFaFIRmZdolmcLudE0iIribMdLeSJTKaDMp22uibHMHdgiKq0VHVQFsWYTxB5yn3TKRGSVFuLy94KqFHUx09pcd+U6xIx1dUsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776067353; c=relaxed/simple;
	bh=areCk+pufufOHecleSpHpQiunTBw27QESwZwZmuek8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ik04+nwZFCDVPiwFY+TZYfSBg/68tIdSqtuyGTe09qSn/BZ9ZBrqRveojDB4XuQCCz4TXY9HpbZjBoaEUeSoMyA56D8rLPgcfstAMlrHFwCSDZ+V1tvwih/glX9+TWk/VxKFEObX6n4bKNkqXM6zTW5oCgLKEBaqv0zwARsKbPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddD4Ixiq; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddD4Ixiq"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfde3c3f3so4100515f8f.3
        for <linux-mmc@vger.kernel.org>; Mon, 13 Apr 2026 01:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776067350; x=1776672150; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KZ6ks+ZM//g0uQWaPIrHlZ6PlfCAj6VR7r1dFpKyen0=;
        b=ddD4Ixiqgt9Bu2+Qtact3ql/PkhCNvAwPsVRsUv0FFsd/5ExflViOhrv5a6652lHYD
         daO4kbBNNOHznptqc6PF+zaQR+Xrp+j6GW0CTTdxXbfzgAi2nTVJwzfAqL5UWam1gNtC
         dt3PhMr6vyWEDduqtWPZJHlr7Mh9wff+eHRz95iFB7hHLcVr5KIj+WKeZocHPfkMGSTC
         DCB8Io3UBYHTuEInEkJlKmTVfDzgXmdM2qo0tx0/tP8jm7Xp75IVhQkMaL2JLMkNfG6X
         v11EsFvvRbEFplNAqzcupDb81irv8GGLJK7q/13BJQiLKjWZu8AcUBPTRDxC1oayt+hG
         SgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776067350; x=1776672150;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KZ6ks+ZM//g0uQWaPIrHlZ6PlfCAj6VR7r1dFpKyen0=;
        b=cY4MxbbtyJ7pO7mTsnLGMplUKhcH/oOxuMDTKOHcV1OpMGfS5eV+g96KbXCREVDbf+
         KxXL7sa7+OFrU3sFs7tDqDOCpYKVwxfq7z+lBZ6Aj6v9lXIW8V0jl+DMmyB5P7WNyd5e
         /qJiTACih0o5tjBRNeIMHukadS8um/EGyYes2L87+Bq/P9TADQi2VwahPKKu4HJsGK4W
         gHPLii3jyI/XJONtTGdacGt/N/lfY9mxa6SbtvA2BvILu/1IHFftiBbuU7y3z4OLlMoS
         UX+Uv+tJjuwT2bG+wizPXCmpqU4ahSfbeoNnqOFrsljJJHy3glpyRHgJES+x3dls+ZX4
         gt8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8U6M6Jq2ImROwvXfpcYveORSsSl37CCwNT84KTRH+mjVCM1W2VhdrG+Z3UXwKr02OQ+ZkhxhhG2QI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3eLI2NfzfqgkUIcFkQruDmqG8MzTasTEEsoK1YKu5YJrpbJRJ
	weLtQm/DT2FhUuaxvE2sAHfAzaffY4+7WUac9l6Qi5ziKEXNq/kl9HoP
X-Gm-Gg: AeBDievMzwcs1wsSTHR4Zbkp4qzlpTa0FM8qb+OzzFqk7S4xUB9RrZcQFuv+s15uP96
	hsmji/MuyfuA9PVEWy78LXx7n+jbRhSQKddapCtaSgZWzehTv+1y9JqsOxY1dchXNBNQzYBiJ4K
	lEIZwrnlfGJ5TXDOMTxCAeXGJD457NiYxPwia3qifAuOZrpZ7Ccosu9w0/XXxePph8l8shG8o80
	UMD4rNjWkp9NEk4h7zZcH2bZ1v6882QRP7TEBI/UEnxJ74Z0ANlL2GUBzOMra/VrXiJpVbEilBC
	Ur9MGeTsSCv3TEtkmlw3ghNH+CB2JY7V2B1aUB/KiGJNuMzqzLTgdKkqUK/2XyltVKafoRVz41f
	DdQi86biuZS+BXyDTR+JqIfs2wj4wiM0kldkeXty7WT1I604qDZm018UzE3mi3UbiGzm4aOWtSH
	gPlLnl0Ew7s4nMVD1kxKpRBneaOqALTLfGA6Fzd9WgOhaRjJsQ2mKigzkZ2rGFO51NzQJHpgPMN
	pE=
X-Received: by 2002:a05:6000:1786:b0:43d:7722:ec05 with SMTP id ffacd0b85a97d-43d7722f1bdmr5554533f8f.8.1776067349674;
        Mon, 13 Apr 2026 01:02:29 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e5c981sm32155932f8f.33.2026.04.13.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:02:28 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 13 Apr 2026 10:02:09 +0200
Message-Id: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQyU7DMBAG4FepfMZoMhNvnHiPikO8NZZoU9lgF
 VV5d5xyIArk+I803yx3VkJOobCXw53lUFNJ06UF/XRgbhwup8CTb5khoAREyae8VK+JF8/dkD3
 /HAuH4CwITcaCY631mkNMtwd7fGt5TOVjyl+PKbVbqj8gAf4P1o4D18ZhZ4wiB+71dB7S+7Obz
 mwBK64Rs4NgQ4S1aIXqfRR+i9AK6XZOq9SQIURPVmlCH7dIv0KQdpB+2UQqZ5QS0UPYImKFEOw
 goiHWa0ESekL8c478RXpQO4hcEGH10LW/RKfXyDzP3znTItsRAgAA
X-Change-ID: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
X-Mailer: b4 0.14.3

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

Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
Changes in v8:
- Resending the series as v8. The v7 submission failed due to an SMTP
  error during transit, which resulted in a broken thread on the mailing 
  list.
- No functional changes from v7.
- Link to v7: https://lore.kernel.org/r/20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com

Changes in v7:
- Remove sdhci-common.yaml reference from DT binding.
- Link to v6: https://lore.kernel.org/r/20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com

Changes in v6:
- Add pinctrl support for voltage switching. Document optional
  pinctrl-names property supporting "default" and "uhs" pinctrl states
  for coordinating pin configuration changes during UHS-I voltage
  switching.
- Update pinctrl state naming from "state_uhs" to "uhs" to match DT
  binding naming convention.
- Fix MMC drive strength values based on vendor kernel investigation.
  Correct 3.3V operation from 7mA to 19mA and 1.8V UHS operation from
  13mA to 42mA to match proven vendor implementation.
- Link to v5: https://lore.kernel.org/r/20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com

Changes in v5:
- Document optional pinctrl-names property supporting "default" and
  "state_uhs" pinctrl states for coordinating pin configuration changes
  during UHS-I voltage switching.
- Link to v4: https://lore.kernel.org/r/20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com

Changes in v4:
- Revert to start_signal_voltage_switch() approach for bidirectional
  voltage switching: replace voltage_switch() callback with 
  start_signal_voltage_switch() to properly handle both 3.3V and 1.8V
  signal voltage directions.   
- Fix DC input voltage specification: corrected the main power supply
  from 12V to 5V to match the OrangePi RV2 board specifications. The
  board uses a 5V USB-C input connector, not a 12V rail as previously
  specified in the device tree.
- k1-bananapi-f3.dts: add `broken-cd` property to work around card
  detection. Using `broken-cd` disables hotplug detection but keeps SD
  card functionality working without additional dependencies.
- Add SD card support for Muse Pi Pro board (contributed by Trevor
  Gamblin): enable SD card support with UHS-I capabilities following the
  same pattern as OrangePi RV2, including dual pinctrl states, PMIC
  power supplies, and card detection.
- Link to v3: https://lore.kernel.org/r/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com

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
Iker Pedrosa (8):
      dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
      mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
      mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
      mmc: sdhci-of-k1: add comprehensive SDR tuning support
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
      riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
      riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes

Trevor Gamblin (1):
      riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 ++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  24 +-
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  67 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
 7 files changed, 480 insertions(+), 2 deletions(-)
---
base-commit: 4c3b07bf68391122266dfb01126484daf352cf70
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

