Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F040B6F2
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 15:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514057; cv=pass; b=KSD8IrxwL25rxtS0WGWQFqLqF/m/ribY5jsMhESST+iJnuhqwJoCM/qV1MwAKN1WyG7p0p4Vt2VDAWc0DLwxhW/IgQo8yzVoJnHHv2hoU6iHLCnykgzo+qOqs19AhMznx4RFVEEvwe/cymrT4iKof20Et7h4ioJ+6dJtRtMlUxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514057; c=relaxed/simple;
	bh=4pIi1AHFoV7bGajpZ/64rcrmUHojGu4W93E9mmQQP98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opXiAWU9VKcYQj/VJWQHe0eK+tM0gB1thnKHZhHRaWr8OzkEAPsQrLRUVDgRmlfVipFhFUNiFUQ9e6eAWlbJZnNhEJ6fleV2B3LWY2ZU1AZMp9yU5BnrcXf1nIPZYFl/Mn0A9QNjmiQIAMEUeZqAiu9bNZ+7W2F0YV47CNAq2wM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STsc5pCE; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STsc5pCE"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a8d648466bso947992e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:40:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778514054; cv=none;
        d=google.com; s=arc-20240605;
        b=Igvi6nrij09yIPmHMpukUwFF92YVRbfcsUppSjpTANv36s3n+VIpaKCl2IORHY//S1
         B3PIAgm6QKWeE+zRRa+xFrov9NcLiJM1ggJiSx1teTt4Ez4/Ejq+KsAjZaNy9nds9cpf
         OfTNGMsTCE9VBoLHzBgv/h6/nOoMMeNPWT4L7J3Tdb/iy1Qnkz3iHOwqFBStIcasP+nr
         wYk7+o0mYXhAyNhkkc1plnvxVl+Aj2Mf0PMPPcZpR2gDqPNHzZC9dHDQ9aJbNWOYlxH1
         yIJ7Nwdzy4JzUslJGBkJ3l/JnU0t/5eZLDm8FBL2k5Gbg0QdVa6B8jXjSRLPjT1mNYc+
         AboQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MfNDGrLKAbOadiJhwqdumLos0Y85vald79tk/V4cH8c=;
        fh=n6aimU9VgUiVC6lrzgm0zfVLG9LvWWl6TgVaqFxlPS8=;
        b=Yv2QToPBb3NkE3wd+R/UABognCuGLgOXyyVF+8WYw1EBr0DeiKqtQP8pynq08iE5+X
         T0JE8UB4IknhE66Wjlu8At0oP1M0hlMDaoB3N9DDLxnECvZP8aqeQJDZmiKJFXE1/vcG
         TPRkULChyi7IJbrywRREHU93CQOL3AUAEc4W6Jew0+Tx4de2KXJ+nobztW5Y5W/A03Dx
         vdNB4RwAr6BQ5JiNNtYWwvbIPlDhEPF2B3tnca3OQGlhM0n691xrZlyotoqvA7z7vgyE
         PAjDBH5Wjs8Itq6RjkPbnnxyJ+8VaaPq6MaFHbdwrg94+kIsUBuT8TWY0CWoKpBN00E2
         +nAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778514054; x=1779118854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MfNDGrLKAbOadiJhwqdumLos0Y85vald79tk/V4cH8c=;
        b=STsc5pCEj2u6AXKU4ZgZLCTl8SBoQdmzCzKN1zRQGYjPVuCmbRdYstvryCqA1ORzK6
         bEIdGaWRscFm2GdmefCJOQ2FK9HG0RSB1vhwUn/NTaD0XBBIIyBhxEAeMtlvYYKXiRil
         YoDK7wwaO46KRa9XkL7XAI2faVYf9MywjA4UfzotvC8PiyKGfgX3vCmCkit48fVGbPk1
         8yCDJhjBRafrVoymobUnudTXJ1iFKjHvnYehwbIZFpnSqdlCh9b9ZQKoRhSKtJ3gZOmQ
         hH1AKQbuRHRzv+7ZecyE0wpzWD1pnAQGJTtBYnNAILMPstKkajhfEce1CRCUbQf5NOXd
         p7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778514054; x=1779118854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfNDGrLKAbOadiJhwqdumLos0Y85vald79tk/V4cH8c=;
        b=fg+hJHMxOaI7bDF62HVdr12vIip5YAzLNY9fwtfTsMnnUL0mO1PQbH1kQp5q2jV7lC
         UFDd/KhFXdZjuo+v76ecGsO388UD1F5ne0uVQ8e/uq2tgwBkfXyG9z4oqZNKuFzuGJhk
         W9f29/R3R2F8scdiVZIu6u92LZe6CFrnQ7OkoNH8r76SrKy2hPdXN+PIr7Pc+j4GgJVa
         PZ50lQgyCXjuHOZjMwFcNpUPmeOur0FoIrLi508Njz46U6xoI6OceLYnK7/w8rTu/CcV
         4sStzYjgq49LdLRzTxVGvJSKMmb2WYelFKd81kI8hcJp5pIxh6syYFedT7nz/ILYayUG
         nakA==
X-Forwarded-Encrypted: i=1; AFNElJ9ym7NEoWScs/1cv6yrJ9G/sJXN86U/imMwwtaA4lIZIU8HL8n6udd3MNs6lbIJmsyaM3kgvuecj4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IY9x3cHTzbV8iIZXgEmBntsEfS8mJUq9EmXLWzSAV+Izs1nK
	J/yGc3ZyoiBRVuevAJUljT/y+H/eS57e2J3wVdEG98xoqhOC0qMUWRs50Z8syd3aqzZa9ROfqpq
	X8kNl5NVrJ+blky/U2j9Hm9Ji+FreEk4d233d9On6AA==
X-Gm-Gg: Acq92OGQLXpxuNZBzU8Wpj9AdA6eC+4tFvyjKcWqnHEY4YixN1nqvKT543/mTAD4cHz
	Th+bZM5mt8ecuV7LzBSXdF+nU4v+JKSv17u7B/LRVCs0YDclX6wsGAD1aEGY4CrQD245Em8OAO3
	6uhcOu/59z54R3Zoqnqamnabd0MToSscRFV9+wnXUuo1dKD9hEVDkky+GZV48BGuGe3h7QbMb1B
	EMgcsoK3eHLj7Sq+QCTYiltfxPCOZM0ZMKPGUtXuA5liygGaxWr2aTOcI8D2rg4ia7rJNiV5Sio
	RsbWVWwL
X-Received: by 2002:a05:6512:3f23:b0:5a8:638d:6f53 with SMTP id
 2adb3069b0e04-5a887adaa88mr8185426e87.6.1778514053531; Mon, 11 May 2026
 08:40:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
In-Reply-To: <20260511-orangepi-sd-card-uhs-v9-0-ae48c0b2b2cf@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 17:40:08 +0200
X-Gm-Features: AVHnY4JG6GcAfGL3v7qotS87Q75eVy2s5uXmoBdyZ6OB2U_NOcV2oCmKoBt3Rb8
Message-ID: <CAPDyKFruD93LdDp3yuttXgzSjJKSrswRxMOqD6KP0UO3VzvZBQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/8] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
	Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, 
	Vincent Legoll <legoll@online.fr>, 
	Margherita Milani <margherita.milani@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 10:54, Iker Pedrosa <ikerpedrosam@gmail.com> wrote:
>
> This series enables complete SD card support for the Spacemit K1-based
> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> high-performance SD card operation.
>
> Background
>
> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> currently lacks basic SD controller configuration, SDHCI driver
> enhancements for voltage switching and tuning, and power management
> infrastructure.
>
> Implementation
>
> The series enables SD card support through coordinated layers:
>
> - Hardware infrastructure (patches 1-2): Device tree bindings for voltage
> switching hardware and essential clock infrastructure.
> - SDHCI driver enhancements (patches 3-7): Regulator framework
> integration, pinctrl state switching for voltage domains, AIB register
> programming, and comprehensive SDR tuning support for reliable UHS
> operation.
> - SoC and board integration (patches 8-10): Complete K1 SoC controller
> definitions, PMIC power infrastructure, and OrangePi RV2 board enablement
> with full UHS support.
>
> This transforms the OrangePi RV2 from having no SD card support to full
> UHS-I capability, enabling high-performance storage up to 208MHz.
>
> Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> Changes in v9:
> - Rebased on top of "for-next" to include required infrastructure:
>   * P1 PMIC regulator definitions (commit c02c047b925c).
>   * GPIO pull-up/pull-down configuration support.
> - Updated BananaPi F3 SD card detect configuration to use GPIO pull-up
>   instead of "broken-cd" workaround:
>   * cd-gpios = <&gpio K1_GPIO(80) (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
> - Link to v8: https://lore.kernel.org/r/20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com

Patch 1 to 4 applied for next, thanks!

Kind regards
Uffe


>
> Changes in v8:
> - Resending the series as v8. The v7 submission failed due to an SMTP
>   error during transit, which resulted in a broken thread on the mailing
>   list.
> - No functional changes from v7.
> - Link to v7: https://lore.kernel.org/r/20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com
>
> Changes in v7:
> - Remove sdhci-common.yaml reference from DT binding.
> - Link to v6: https://lore.kernel.org/r/20260407-orangepi-sd-card-uhs-v6-0-b5b8a1b2bfc8@gmail.com
>
> Changes in v6:
> - Add pinctrl support for voltage switching. Document optional
>   pinctrl-names property supporting "default" and "uhs" pinctrl states
>   for coordinating pin configuration changes during UHS-I voltage
>   switching.
> - Update pinctrl state naming from "state_uhs" to "uhs" to match DT
>   binding naming convention.
> - Fix MMC drive strength values based on vendor kernel investigation.
>   Correct 3.3V operation from 7mA to 19mA and 1.8V UHS operation from
>   13mA to 42mA to match proven vendor implementation.
> - Link to v5: https://lore.kernel.org/r/20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com
>
> Changes in v5:
> - Document optional pinctrl-names property supporting "default" and
>   "state_uhs" pinctrl states for coordinating pin configuration changes
>   during UHS-I voltage switching.
> - Link to v4: https://lore.kernel.org/r/20260323-orangepi-sd-card-uhs-v4-0-567c9775fd0e@gmail.com
>
> Changes in v4:
> - Revert to start_signal_voltage_switch() approach for bidirectional
>   voltage switching: replace voltage_switch() callback with
>   start_signal_voltage_switch() to properly handle both 3.3V and 1.8V
>   signal voltage directions.
> - Fix DC input voltage specification: corrected the main power supply
>   from 12V to 5V to match the OrangePi RV2 board specifications. The
>   board uses a 5V USB-C input connector, not a 12V rail as previously
>   specified in the device tree.
> - k1-bananapi-f3.dts: add `broken-cd` property to work around card
>   detection. Using `broken-cd` disables hotplug detection but keeps SD
>   card functionality working without additional dependencies.
> - Add SD card support for Muse Pi Pro board (contributed by Trevor
>   Gamblin): enable SD card support with UHS-I capabilities following the
>   same pattern as OrangePi RV2, including dual pinctrl states, PMIC
>   power supplies, and card detection.
> - Link to v3: https://lore.kernel.org/r/20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com
>
> Changes in v3:
> - Rebase on mmc.git/next to resolve conflicts with "mmc: sdhci-of-k1:
>   add reset support" patch.
> - Squash tuning infrastructure and implementation patches (3 and 4)
>   together to form complete functionality and avoid unused function
>   warnings.
> - Reduce code nesting: implemented an early return sanity check in
>   spacemit_sdhci_voltage_switch() to reduce indentation and improve
>   logic flow.
> - Refactor pinctrl initialization: moved pinctrl resource acquisition
>   and state lookup into a dedicated helper function,
>   spacemit_sdhci_get_pins().
> - Use generic regulator node names (buck4, aldo1) instead of
>   device-specific aliases (sd_vmmc, sd_vqmmc) to better reflect that
>   these PMIC outputs serve multiple devices.
> - Remove dead code handling 3.3V voltage switching from
>   spacemit_sdhci_voltage_switch().
> - Optimize tuning algorithm to use single-pass window detection instead
>   of storing results in array, reducing memory usage and complexity.
> - Remove unnecessary card detect check in execute_tuning() - rely on MMC
>   core.
> - Clarify commit message to mention both SD (UHS-I) and eMMC (HS200)
>   tuning support.
> - Add SD card support for Banana Pi BPI-F3 board with UHS-I capabilities
>   following the same pattern as OrangePi RV2.
> - Link to v2: https://lore.kernel.org/r/20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com
>
> Changes in v2:
> - Removed custom AIB voltage switching code per maintainer feedback. The
>   existing pinctrl driver already handles AIB voltage switching
>   automatically via power-source property changes during UHS mode
>   transitions. This eliminates code duplication.
> - Squashed regulator and pinctrl commits into single voltage switching
>   implementation.
> - Moved voltage switching callback from dynamic probe assignment to
>   static sdhci_ops declaration. Removed redundant SDHCI core call since
>   the framework handles standard voltage switching automatically.
> - Made clock override (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON)
>   conditional for SD/SDIO cards only. This follows vendor driver pattern
>   of differentiating SD and eMMC card handling.
> - Include no-mmc property for SD card.
> - Link to v1: https://lore.kernel.org/r/20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com
>
> ---
> Iker Pedrosa (7):
>       dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
>       mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
>       mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
>       mmc: sdhci-of-k1: add comprehensive SDR tuning support
>       riscv: dts: spacemit: k1: add SD card controller and pinctrl support
>       riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
>       riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
>
> Trevor Gamblin (1):
>       riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes
>
>  .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 ++
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  22 +-
>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
>  arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  21 +-
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
>  drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
>  7 files changed, 431 insertions(+), 3 deletions(-)
> ---
> base-commit: f068b204555ad62d6a841a49feb4ea8c4f45b25c
> change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
>
> Best regards,
> --
> Iker Pedrosa <ikerpedrosam@gmail.com>
>
