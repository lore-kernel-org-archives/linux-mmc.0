Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C235DA60
	for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859907; cv=none; b=SVkAnwk6wYWCAprD8MIw4wUgFd/Pc7JTlX8qC5n5tBths1enGRmxwyDtZf9uHL9DNofDrqOpQxsuMFjUiW2H4/bwpwkd8LT2teHQTMC+HJOe7k9I+cLT0yolboJfn9HoD89C10o75bJ9FCSIF+LQfvgLc8mw0NSz5Q2YCzV8Pds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859907; c=relaxed/simple;
	bh=v3MHoqccUPxA0tq5iVjY+T8EHsrduJSx1zg7Gva9WWI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PZ1Em6BBraxjn5WiN/eeIBlF6LlOvt2/NnT+cYJg4bm6nzoYlUajWNHgcAfUfYtxzBowfIK/63aSXPuWlUdam49nHXxih+luyAkjUWp4xae5DyLdQXRlSvDVO/Meyp5aWlC1oFwVmXSFV1q1Q4fgfjPBHi3iT9ufhPXusRALKLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l8jYDLJk; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l8jYDLJk"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48374014a77so50203655e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2026 01:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774859903; x=1775464703; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I6nIVyOeWcmomMrY3iGXmWdAUi6cHEvqetomNgyztdQ=;
        b=l8jYDLJkswewdB8j6Y5qeu0ubzDTdX2GeuCBNc4lJ5mXtBSyF8bZe1NNpQ2ivwILUM
         ++LOQ8vWiW38+CsKNdldeB3Np+f6tNFKAbaCSZGR3V8ucREOaz8TojwulWDJXDIRN1tP
         267aftkAh1Sc8MGuIfceLzTVmVdVEAc+lQaw8T88OrozVbSmmqO81wG8LYv8rY6e9L5Z
         xqk6SfbxoL6SnDeX2wuvMp/GmQZkePMZhmCLBfNOTxQPrd2iEDJgSu/r2bNmntIWpI9x
         8weAY8kR3fVMYwCn/a+21gbeIXwvvwz96GZI6H6uzNKaUNrT/ThUUptrDb8rkKjsKvnG
         9Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774859903; x=1775464703;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6nIVyOeWcmomMrY3iGXmWdAUi6cHEvqetomNgyztdQ=;
        b=q1ENoNzvn7we+kTyDEz+2phM0AIKOYO/c9rqwDdG9PWcYLG8Zygj5QntJ667K39VnW
         CzApTJADW6z65nhtGjbN7ZRjvSOa90iGAzPEU+MbdPEMaf55IkuWWn63gsaqKjtvGUUm
         k1pI1Mw44NF3KmNtF9srh4XH+Q3F/X82GmTrsAAjFusS8qC8UatKZLjAacTrMLsHPlJ2
         Jvqttp6OSxFaSMfeGXBLcvTJrupEWtw8kRyhz9kN9r2xtt7Ad1U/gqEU8E6eWZOOdJBJ
         77wATqeCsVawkkx0elggsyE7elVMWMaxhn3k7AdhCZyGcjrwGm8jxTqHsRvGopq+Sukd
         3hBw==
X-Forwarded-Encrypted: i=1; AJvYcCVzgAzVHfuA9hW228o1WUnTy3mznXxiHe3U2wIwD0ofDiFldsxZnbw0NJDl5jPejI+qpxljhiefeq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8nt5hEPuw6Lbx4hhMeOm0nj1pft7g1fLdE6PIkiJ9wYhG4pQi
	WhxBNu5Fg5BdREVyYhcd1IxtVndhPGm89pPwZuu+Wgh73oIiWq1gvQUz
X-Gm-Gg: ATEYQzyOjSIY/rI4wDqYpRRb7vhiHXzXZ1YESXrbLxe6B1rgmhmFsc6h2P7m5Yt/3Si
	55LL078dMkj7+hPrRGHsixIwi6mAtuQEQOGfs7x3EHWyeP1Eu5AmmUo0zXBogpJmKTxbhKcyxpR
	7UYV2osH+bJftkcXq+rl3oaNsEhewxO9OZGpPpdlQRgPKEUYghUQ4C3f1+z6xq+lHEgLX9AWijl
	UU7etK83dV8vnl0PPCRmaeGG8FrY4GDnuEx00wzHTRTp187mSLKRXhAfFlNsR77tN7fNIE4BJjo
	t9g6tIuIQuPfir6tXlBzOgIU9PUZtFmpni8spaywVJvuwNE3fQLcQe5w7vfqWRW3Z2vjROBqq+H
	pSg+73VL+rn3613GNqyyWKl78jZepPfB4IcZzMpIRM3WtJsdLhOiFmX1ucGDn3Fk+eQ4+wt1v+c
	bBJ0B+e6gE9an3ynjLjAY8Mgor9iVTZOf2ietKd0sj4ZSjangT/+0h8sehscepEVlx67GAFmGbk
	NU=
X-Received: by 2002:a05:600c:1d0e:b0:485:33ad:3c9f with SMTP id 5b1f17b1804b1-48727ef5634mr197591655e9.25.1774859902957;
        Mon, 30 Mar 2026 01:38:22 -0700 (PDT)
Received: from ipedrosa-thinkpadx1carbongen12.rmtes.csb ([67.218.232.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4872712c236sm74063315e9.14.2026.03.30.01.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 01:38:22 -0700 (PDT)
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Subject: [PATCH v5 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
Date: Mon, 30 Mar 2026 10:38:01 +0200
Message-Id: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XPwQ7CIAwG4FcxnMV0ZYzhyfcwHkYBR6LOgBKN2
 bvL9LIYd/z/pF/bF0suBpfYdvVi0eWQwnApQa5XjPrucnQ82JIZAjaA2PAhTu018GQ5ddHye58
 4ODIgW6ENECuj1+h8eHzY/aHkPqTbEJ+fLbma2i8oAP+DueLAW01Yaa0EAe2O5y6cNjSc2QRmn
 CN6AcGCSGPQSFVbL+0vImZItfBaFgXpnLfCqFag9b9IPUNQLCD1dEmjSCslvQU3R8ZxfAOABIR
 ghwEAAA==
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

 .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  17 ++
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  24 +-
 arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
 arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  67 ++++++
 arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
 arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
 drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
 7 files changed, 482 insertions(+), 2 deletions(-)
---
base-commit: 4c3b07bf68391122266dfb01126484daf352cf70
change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c

Best regards,
-- 
Iker Pedrosa <ikerpedrosam@gmail.com>

