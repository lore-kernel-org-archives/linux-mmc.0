Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DAF3A4F33
	for <linux-mmc@vger.kernel.org>; Tue,  7 Apr 2026 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550364; cv=none; b=HSNHRzQ07iNKcDQs1MbBfcenpKMMkPe62kqOFXBLnjfAKUG++NyWUUkLjC9v55h3zRkjo7R76SC427o94lgiweuw48aQ2qBzF4dWbq2DaHnxzJs83NYzk2IN88G4ZE5GCITOZWEV/l9+Ko0F6nrVpSo+fUS4FrtU1FgfhVjIwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550364; c=relaxed/simple;
	bh=DwLYbIictU4QiNn/8H14cThUzWyobPK0/4M9rLkwxwY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U3TxnN+hEhM12SRGpJAg8oBDfHnwc8vXpLUjVkN+unn2iQG6vidPKS/kmDSIhK3tDkYJv27DxDhSg2WUduM5+lPvCluzG3IAr2nJzwljLfZgJkoyCmu1Q6/+mbJ5xW219Y8UHEMKvEQGnZ2T0MXXW4c7uzkgOWpgu+3a+yUN+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnU+OmUu; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnU+OmUu"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4888375f735so42717355e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 07 Apr 2026 01:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775550361; x=1776155161; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=La+U2Bbn/ahJ6bPuRDlCHq4x3+i/91yoVAN+8mU+FaY=;
        b=fnU+OmUuasI0EftGHZU4L6WLGotCldcruTROF9+WHw8FQsJ1So6GUblrSIQJDF9AC8
         3b80bRSgOhoxnLXCUxeZgHCz/hIQSwyD9K6UXlTMIQVLfkwzH79NMjXF16LUThEEywv3
         0wxbNH9MsjJgY2vJpZMfkhIs0x1r6RIz8wv7IcGp612tA9M2rl/SekRgHUieRoJ5dYd8
         GM4/B9y8g2lwyAw9EMDufcW48Tv6Tm1XxXOAp/BbeD6OJ3jxcSR1v+tmcQEz9170nEi5
         X7AsGNnF4TKf5jQDfZt9VPeqgzsHvMaXDz6zt3jzmEZfNNTXP0T5Lpj4N0NHKvSIB+1E
         8qlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775550361; x=1776155161;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=La+U2Bbn/ahJ6bPuRDlCHq4x3+i/91yoVAN+8mU+FaY=;
        b=jc5rfBmcO5BZpfgezfXJYmzzLxE7mOdXWDCnpofcsNNRoCgOGv3VLTbbhDGaoDNN/M
         viQGbd7m8wx77Da8x5TgvQncrmFq8LZkzalY3y7q0TcFeuCMokiajt4/Iv4DKvJXFr3L
         0k7uhLsdTCYTxgUsspJgKE1akPZMiPTZEYdqaqJ21SeS5IIyKtATUlRNUNyrSooPlH1s
         XAyatRcrzZMDE0/SwGde6XekCFct63PknW25hbpQY8IG9uOhYwx9Z4Nuhn4aG0Pt8f+X
         exT3ecJQP7mfd9GbA1gYD/9PXPxJhb8CYxDZIehtvZ5ED/6DrCCSeC5zqtGWSThrUQHa
         LBQg==
X-Forwarded-Encrypted: i=1; AJvYcCXtLHXtsXpp4moN0mp4ax8etmo2tAgwXdGwGHxJwCBLo2tJ+hfATWPnVTNSDDIvmyqrwb0Nu/qvDT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwBZqe5tAu09z/r0w4X8FqGupqXty9pXogD+3Fb0RZe5YQHhYf
	jtKy1qg77PGgnhOxlZutkAPFA0wuv57vTOkldMkCHc5CVf4CzPPK8LrA
X-Gm-Gg: AeBDieuANXtHQZh2iSQ/cxOV8sRrdMYBY8RZMBlzVbgWxHOY1q12YS5mEut7dMNBx3/
	GLQcKEtSnzKb7nwv7wHDZPANIEVi/cilpEy9HUXjroEUy5evFeaYLkyRA+WJnBEmloaWGV3uWU4
	m9pme/1ffg9Kh8yeeDPBx4uFh4w8qURHW5XZQGuS5VUx/aCymZo5BvXh4UU2278n1rr5cs8L47y
	Iue/zEpahMh9xiM7cqis3wDeKOpgEPtdlz80QZNUTSpDYGwutXlueqvL2MwqcqekuvYavSZAhbK
	xHGZG3rNgENvcMrINd6kxGwlgFTm/k55nPIPb96peqicxC9nhd+qk1twV7J4+Rl8gDAfUbu87O4
	VyceB73aUliOFCjcFtIR2Z1nCjDJlCq1c7LH82p8btrYAl/JXk4Uhb4lqUNGEgdgz4TYJWsRqJz
	fBvjm0ndWvokIORjq3fTQYMyXg8/4i2wvPxvPC9Cmv9l8sCO5vAtwx3aEsONkwndFL
X-Received: by 2002:a05:600c:630a:b0:485:2fe9:336f with SMTP id 5b1f17b1804b1-488998e3cbemr227485015e9.30.1775550360419;
        Tue, 07 Apr 2026 01:26:00 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.239.37])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4d29bbsm48669958f8f.21.2026.04.07.01.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 01:26:00 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v6 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Tue, 07 Apr 2026 10:25:20 +0200
Message-Id: <20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPTW7CMBAF4Ksgr+tqMhPbMSvugbqI/4ilQpANV
 iuUu9ehmxCR5XvSfDPzYNmn6DPb7x4s+RJzHC81yI8ds0N/OXkeXc0MASUgSj6mub1Gnh23fXL
 8PmQO3hoQHWkDltXRa/Ih/jzZ41fNQ8y3Mf0+t5Rmbv9BAnwPloYD77TFRmtFFuzhdO7j96cdz
 2wGCy4RvYFgRYQxaIRqXRBujdACaTZeK1SR3gdHRnWELqyRdoEgbSDtfIlUVislggO/RsQCIdh
 AREWM6wRJaAnx5Z1pmv4AcuDISswBAAA=
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

Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
---
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

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  16 ++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  24 +-
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  67 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
 7 files changed, 481 insertions(+), 2 deletions(-)
---
base-commit: 4c3b07bf68391122266dfb01126484daf352cf70
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

