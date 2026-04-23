Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370ED3EDAAF
	for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776948155; cv=pass; b=VG5NDrgnYsgJSU35wIVZKXExnmR15eyzlX4KxACNAk0onvzSW0o88/3+bFoZ+GjkAvIEJTgN0rmrCD0iqdrG2WcgUDntJS6XMSfXfwiZvaXeoGn9wDEd1y3qHItCc3E+aYHuLw0ve/S+2ffrjfXmRq4dewa0oqpCTlz5Bhf7FjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776948155; c=relaxed/simple;
	bh=v+VGR/iK5jA4ejAKficHqezigv0RSfnswFIGn1ixQEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kCd657U73N/jlR0Hs7b7Gz00eGkc33UP9MS2sqcEJZ9E3b+vIafgMg90rkOwTWGDIpP8UN0H58QIWPHY/pma8zopvHiBYOsWtY8Z95nhIvv7uIkGMj9eAeaYdmWNWbDC/XngACdAasxe9tFBgi3DcjiwwSy03P0bPsxxNqyVEN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oTaiHZKi; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oTaiHZKi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so941778266b.2
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 05:42:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776948152; cv=none;
        d=google.com; s=arc-20240605;
        b=N+BZk+RQY88VMIEW5oBL2/qPqFQBRbv4D7vMmNBbL6BXTjLNB6ZwDS5JA9+zuMk7ZX
         1YDezDUDyGPv+9wU2aTffPkO6OH1J3ZljcHeXeeHq0jf8Fbnjv+TlG+4/mxwMyz+dpm8
         sif+kRqpap2euq7CwB+G+7VuK/F5hE0pLm0I0PRXAlHpnI8ou+huG62VYyzxxzi41dp3
         AJRHQwT1H/kJVUgSL/jdXWjBZaJfY9O4ny55A476GJLM8ozWxUoq1i5m02LUzewGL4nt
         Lv7XkJoZUElWt6JfRd3RNhs21UTSx2mw1PpNUJ6a3r3S3ZajRb5nTRCWXmmUQwLdODsH
         fRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8zSRHjean7w9zY7KbU/JVuqpAg0+41GC7JxwHHVZ1ls=;
        fh=vLofs1cyBbo84T2Pz5Bz6meYuB4h2WGGY7IPkji5bCU=;
        b=jFgFqZk5IIXyo+v7IvS1Ighkrmy+4EuPnWoQPiKnii/cYMiOoeP03k1vukynciHUQr
         kYGeWhdXKQzjASqWFd0ct+mwNLOm1UMEEv7mIolWuxxRqzXpIQeZ45Hb12AunWnNhFOq
         jSWuwOT8VPpgE9rQ9+cpxR7dBWabLWF9DF9PUuVIfhHXHES/T86kcHqNjwaiqBhQz3OR
         rREnS/wKQYKjbn9g++e2R/ZhHU5/92gWRu1HNThyG0XUc1H01E9N294RyhxjTsNEE61e
         LRmBbsnJu0zAmZFUr0PDwFKrqk0LFOMGZp88srrWt9O1WewhQOWKeyqPsSouYXh3u+s0
         WbZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776948152; x=1777552952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8zSRHjean7w9zY7KbU/JVuqpAg0+41GC7JxwHHVZ1ls=;
        b=oTaiHZKiKZULUfwmcQVYwJwM9j/VBospE8sj5zd4WaInqW4dXJkpwg6VmoVsTghZae
         dwWEHf+k+Xsc5hKhv6ja74mM26fEN0qluy27eEOKyeHlVDM7zS8KTfqL6OArOVBBrqiW
         sn4T7iHH30W8IPMi9qZakCRF/cyrlbyuL8ZeGUXMXYBBnLOrqU+/EL/WVd74hl23C84+
         BeI/QSJIUi4fNHW3AzjZFbJfy8CS1ZkpB6VseDeutfQPm/2BGWrDlNye2HAbyPTJvV8/
         XTc97dK5WoTlj1Tjp5zdTcwoipa1fqcEiSQfMowVFfodOX1WlRMOM2i6bRhhFrp3YOur
         KIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776948152; x=1777552952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zSRHjean7w9zY7KbU/JVuqpAg0+41GC7JxwHHVZ1ls=;
        b=MQvX1EN69nS43VyFcWB+NfYt9mjvz35Tno/UI5EnHOdMAEpKI3Jdw7EBuSB0YPBCeK
         jDxSYghaPRrG1H7xHcxZr8I+cmqDEePRd9CvzDQRSIVaysI09WeC0tMna1XFc3QGXl1L
         hks38ekD98ejuW8XixGct1ggui4xv2oyNNYKbSbQSmCav7RLB1P/VvnequaY3UEJ5+GC
         pk+HMrrHdPoKOymLN6Q4fS8GqDLHAIY3FPP8ot9/C4igiUQffxBmd8aHvWBvacWgdGLA
         vqI1ikJsjCkfcRi2X98upmXRXIuMZqQg4CYyUflwO9cOjkQFUhwAxhJ/R2yfoTaExCBY
         Nd1A==
X-Forwarded-Encrypted: i=1; AFNElJ+w5dJ7bOWsZ41oqUaCDUd9FDkCOtgBGJsG4YxSGrBrGjf0vQH9B0Q7I7ZPlg+QnkZtDtknPcGdtNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXEibIoqKOsUmG4TJWOx1ytN/HliP7PiXprfJy+D0G8nLHZfK
	mM4gk5Axl/HqegljIpRb0OMbTHnn7gcN3EOvDk9Azh9SkXgzLImtoRsABkF8QrdHARlA+BBPUt4
	ZLM/B8oLkcssROMQjxgGp9tAMeNqV5NE=
X-Gm-Gg: AeBDiev0NEgRWBiSzpYAC08m1Ok54rzNIZA2mw+frdqabDJK41UsQ78unmUrXXEVyf4
	JZG+BC5f3D3MTlS2/y616iikayrvcxnU0ZoaZ9kB7ucJuYh+IJ/Eh6B8zmiDnmCmRzuS0m7beq/
	vm4JB/0FqklACVu5pwqiAVzSJYXxWxDZBafXxyxCTyzihCKLuGIIRAraCfmfFQLQR8NK1R8XuAT
	4Z+tZWhC+dcz4M4yMVht6NkzDa47OJtR7419s17RnKyxwUVw3K3fdmJh7MQUoahxOOrK9RKO78b
	EqYY6fi1TFULIpc=
X-Received: by 2002:a17:907:d87:b0:ba6:cb4c:bd3 with SMTP id
 a640c23a62f3a-ba6cb4c0f80mr1032293366b.11.1776948152083; Thu, 23 Apr 2026
 05:42:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Thu, 23 Apr 2026 18:12:13 +0530
X-Gm-Features: AQROBzCyFMNMbhu9CwDqInG8KR7Q7ZUH7V-_WWXTlBN010HAPlnlXUXgzpznGME
Message-ID: <CANAwSgRNrs4C4B2o5KBpr29QWowTzpqVcQktAbFigiagxaFZAA@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Trevor Gamblin <tgamblin@baylibre.com>, 
	Vincent Legoll <legoll@online.fr>
Content-Type: text/plain; charset="UTF-8"

Hi All,

On Mon, 13 Apr 2026 at 13:32, Iker Pedrosa <ikerpedrosam@gmail.com> wrote:
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

I'm just checking the status of this series. Since it hasn't been
applied to linux-next,
Will it be included in the next kernel release cycle?

Thanks
-Anand
> ---
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
> Iker Pedrosa (8):
>       dt-bindings: mmc: spacemit,sdhci: add pinctrl support for voltage switching
>       mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
>       mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
>       mmc: sdhci-of-k1: add comprehensive SDR tuning support
>       riscv: dts: spacemit: k1: add SD card controller and pinctrl support
>       riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
>       riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
>       riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
>
> Trevor Gamblin (1):
>       riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS modes
>
>  .../devicetree/bindings/mmc/spacemit,sdhci.yaml    |  15 ++
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts    |  24 +-
>  arch/riscv/boot/dts/spacemit/k1-musepi-pro.dts     |  66 ++++++
>  arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts   |  67 ++++++
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi       |  40 ++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi               |  13 ++
>  drivers/mmc/host/sdhci-of-k1.c                     | 257 +++++++++++++++++++++
>  7 files changed, 480 insertions(+), 2 deletions(-)
> ---
> base-commit: 4c3b07bf68391122266dfb01126484daf352cf70
> change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
>
> Best regards,
> --
> Iker Pedrosa <ikerpedrosam@gmail.com>
>
