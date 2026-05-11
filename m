Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3733CF660
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778489676; cv=none; b=I5JccGZoYiUB7O0zQkRv3k4wyXbJBVgSkpaNoTOCz1U1FMIc8XoJHQldKnW+6oMX7uIAlS9/IhInvlNtQ/F8p7LDtkbowFnwSxQyFwKqibI/VuwrXKkU5KrDuAYFqgQ7IgwXuuUELLB0Hp83VP4NMqUHq2jX/FyL0puLdp+xlXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778489676; c=relaxed/simple;
	bh=pfsjEqUjquWTY+HiYgd8zqRfjs5oLbXjuptgwxiE1lI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U9kLKj8IxXX48mL13+64Y+rVKBVmzoNWD2KVDH5O46wEX9L7r1MVLX3sxjzbPuaTzJ9CcbyGaT3kWdoH1gGUW0EpJgu0icD13K65iES/SGLCScfUJz2u2dEUa3nAlEijT/HUXFCaIr2h218v4/TdGx7caG5szjD4NC86fgDmI1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZUr+QiZG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUr+QiZG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4526a8170ceso2157991f8f.2
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778489673; x=1779094473; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6KTqIc8oUh4mMXyWlg9exQXhlCotoCqVUbKnvoIeh3w=;
        b=ZUr+QiZGJJtgr3CZ5xspbFqIL3TYLusUsPFYZazqrR6Yucr8p7NJ8SeaouTp4tOSlM
         Nyces8a++m+Zs3OPv5JeX0CJRU7pz3zKUvqD+A6SbuNeSSyNUI591LvoaknVCbM5WL/X
         ONh9CPk7yQ5U1RGrQZRBhOR6fJRG1jTMyzQcQ3WoZBYJ43s22cbLbZUMFAaV+x6NoTYi
         oegH2LC9P+HDJWQ42Gfwvuv/jn9oRazLnt7PGJiN71995ziGTcn5XGiczxEOR+w2S6V6
         LI0SUMAnfEBz2wmgN85VzUnpg+Qx1hG5TjaFof/EyFyw7J1TzkB2Wlq5Ihzc2NY9TBzf
         wKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778489673; x=1779094473;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KTqIc8oUh4mMXyWlg9exQXhlCotoCqVUbKnvoIeh3w=;
        b=Wka7WAbrVSoIFCQDNj8BxzxQBGGqR2PACGsqdt0IWN92EEdMnKfnhoKnRniaC8H4rZ
         uSpRfffYIcDbiIz+oMlHWmsHzTTBHsBLfPdnIOxs+3keIYz2z1msxL0kk8UqznTY9NTd
         D0MMw9h/mDtQ/h8QkZ75pZrbMrm4243UiVd3kTH06FCuGWb5CM6hO1xeeOEDnYNDfxoY
         fgXevAq3xgBAQ+csTyQ7bHD/VoFgZoX6yJ6/2i4mzO1FtNms6kG/IzTFSykeXsqArLUi
         IqYUQ43KIQvavnUdLIAB7mPryyqaFYWZ1Z84zZBoP3jpDkYD1ft1gndanT6zHcBltlaV
         rUmg==
X-Forwarded-Encrypted: i=1; AFNElJ8HBquJUct5IHTzH00pdw4a4qMcHhItZ6sDLDkGAExqqLj2K1ptEXupKIB5s3s7KPPaWRG8fAidEAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCkox5k0HTKqDbxPc8Ra2/vMkrmQ9bPrv39qniDpEth4aEomtn
	1gyurDJ49dfEt2pECMvZRCExRWwhaxB6oNUAznCXEdncAQTOVNd04an4
X-Gm-Gg: Acq92OGcnle1gA0T5sREMxjsfas6lIA3HCJENbbSsmhHfZgQYZrDvuS4un1Vh9r16Ia
	K+9MERGG3foHxldxXf1ekoxEToM7btgpbvnbxxR09l5T+x9nubGdmkXKk8rhMyP71uXIhDNIQOD
	JLlxXFVNmgXgZ3k7xjOs4k6VBZsewqj+I8+l4ywG0gWI+YjHD07wZWY4+xv8dhg3SO8JncTt93m
	mKXE4rnKo7ddhcHmElcUcyt4Xy3S2FE9uAGtNQ0Fc+mqudzpZD2R6a1dq0rZPfQH2DhttYj/cPZ
	yMa3++T7e/paRfeitNhdyn7wCT+SsuppBxaihCJ8za/A2WNTurxC9UdPYVpaJBK0ZQjLhMvSLPW
	zrr+AyxfNY6DjtD4ifDw05u5wmddGE5VkKnEXV0dWzyU5fRZ/JNx2FbYBu0lGPRYciTaBQSqLQ6
	AIhMYYbCANwN2MfUtY4jcJpbx7aIkFfpS888i3n61cvHgwMhl2HdM10rUUgwKZhICE8QHwDSCXi
	tbY
X-Received: by 2002:a05:6000:1ace:b0:43d:1c4a:37c with SMTP id ffacd0b85a97d-45689baace9mr12928217f8f.4.1778489666837;
        Mon, 11 May 2026 01:54:26 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.237.202])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca2fd6sm24944189f8f.30.2026.05.11.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 01:54:26 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v9 0/8] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 11 May 2026 10:53:55 +0200
Message-Id: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XRy04DIRQG4FdpWIs5HO6ufA/jYri1JLbTgE40z
 by7TF1IRln+J+GDn3MjNZYcK3k63EiJS655vrRgHw7En6bLMdIcWiYIqABR0bls02umNVA/lUA
 /TpVC9A6k4daBJ+3otcSUP+/sy2vLp1zf5/J1v2Vh2/QH5ID/gwujQI31yKzV3IN/Pp6n/Pbo5
 zPZwAV7xA4QbIh0Dp3UIiQZ9gjvEDaotvCGTDEF7rThGNIeER2CfICI7SVKe6u1TAHiHpEdwmG
 AyIa4YCRXIDjinzrqFxGgB4jaEOnMxNq/JG/2iOkQNqpjGtJ240VbPFMBemRd129uT+BeVgIAA
 A==
X-Change-ID: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Ulf Hansson <ulfh@kernel.org>, Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
 Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Conor Dooley <conor.dooley@microchip.com>, 
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
 Vincent Legoll <legoll@online.fr>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>
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
Changes in v9:
- Rebased on top of "for-next" to include required infrastructure:
  * P1 PMIC regulator definitions (commit c02c047b925c).
  * GPIO pull-up/pull-down configuration support.
- Updated BananaPi F3 SD card detect configuration to use GPIO pull-up
  instead of "broken-cd" workaround:
  * cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
- Link to v8: https://lore.kernel.org/r/20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com

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
Iker Pedrosa (7):
      dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
      mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
      mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
      mmc: sdhci-of-k1: add comprehensive SDR tuning support
      riscv: dts: spacemit: k1: add SD card controller and pinctrl support
      riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
      riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes

Trevor Gamblin (1):
      riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 ++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  22 +-
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  21 +-
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
 7 files changed, 431 insertions(+), 3 deletions(-)
---
base-commit: f068b204555ad62d6a841a49feb4ea8c4f45b25c
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

