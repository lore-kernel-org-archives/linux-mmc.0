Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F6B385534
	for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773778991; cv=none; b=FMxfcQuH814tqRlCV4Wyc/VIOZB+6zVwfiVSRQ/XYdBJrdzs/p9ZYX7ERGcaQioYTjNcGEfGKP3ZOW5laum7XJsmDWSPuTZpaxvOzWycD356uVewWy7FKtqRq3D8BB0NP+ZmqoLue0/tXfBhjMxKdGvyf0BL4gaSJRG52dDnzJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773778991; c=relaxed/simple;
	bh=1Tvow8X4Db0N1osozsscW2uTEW7kegN9/O8TPDZlMdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y8Wwc+OGfYZab9lOX8g2a6gOCAowWcWO3+h9z4/LYKM/9X4waIYlOx1gnmStrt9zbGrYVAScF82gsS/FXdYLagxjgpUp1fIpjZDR0CrYg84o4eswK00A1EvxRt3W+p4nyAhNEyM/3CVvaklzmFSIwO8fadfqNs4GjU3IAPhafb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XpHcv8Cw; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XpHcv8Cw"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd73c4a827so534885a.3
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2026 13:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773778987; x=1774383787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QyiDZ5RSYUOfAeS5ZUUKET2WqUdsSAGFaGllFAZ7XM=;
        b=XpHcv8CwDm19zVbApdbMBEOu8/+J3kUt/ANcqfaFWeKBOGtPBJxf8t5ehGRi9Bhqzb
         DvwoW1t2wud0RH+UyHd175gDqy3RTsvNlWDhS+PkCl1P0gE9Chaugc2lj3hx4nF4WCLY
         CVVfXBrVF9Gr9FDxkn1DxZxs1nTVMk07ypWMjuXBnrWqzx6itdLrfeQuMuSJdlVnLHWA
         hKGsyp1rvsmimpBjGT8TmntLOazP2mcgt/pXs4NohvTHi2U2IWvTE3vexryKuW33MgSm
         Ig5Tg/AkyZg0F6cKcq1EeeuH/FuTTHLzCED+jiiOdfl+MpTaN+MGcBwGeg4Zd2zjqfB4
         573w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773778987; x=1774383787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QyiDZ5RSYUOfAeS5ZUUKET2WqUdsSAGFaGllFAZ7XM=;
        b=Cf932iUeA4yXDHEtV6XZBkP5Rs3YVwGCC++TTk6HBkAGJiufPmIXf67F/Fouhs+4xX
         CQ2b6bJx5whx7nmqOSxnLY9ItWWtt8v2Jq1HFRfwyN/dGYgkz5sgqrs9EUHlBH/q/TdF
         Gu0aTBs8ePzQXeeKPb7Tj5bX2GKERcE7VPOgCdX3dtlIGWuRVAd14SqRDvrFqs9Z/rX7
         4IQXPEa/74ZVYXh9J2fjn/hbB4ncjRf2WYprrJYh2GVnwHtRo6i8aHZX73WGQwCjHpEa
         0ofaueI2bqI61kN8+c1/BATgmpowKrPdjHJv57JlCMlWpUuIh9mf4MIBofPSoEhLaLu8
         XikA==
X-Forwarded-Encrypted: i=1; AJvYcCU4psRCjZZlFM4vgqfiFx2RsPdN7R/Dx6DoXrt0rZYidYk/+5/7NDnMNzFLPUTg+mVBiL1oAIAoSoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+9ULjfugKSpzQVuhmFvgeADQTieL9MrPDsyss0nIVbV3uqFGM
	F7PT1xzzv5BqpzdBOUioroKb9mGFxSTicttN0hWr7xftyTWtnOs3zxm7D+Bjo9OfRIo=
X-Gm-Gg: ATEYQzwD3DDaJucRZieUQ6QlkBSQfu3X8i6JjVoWqJ+c/SlH6PYt3Z4LwQLpVGyFynr
	yU+UxUaKDdYsU/wKPQBzqBl8u4xRtDPiLqUUEBDzCst90cZJOsP5ItzuQVyiocG7oI8XDa5Kszy
	8EPljP93/jPo881njXGL8X/xdeUZ1RWvZjLv+g/13UNUEvGPnkgOdLzBGHA3o88DTYEr2QeGbuv
	+a+ITHIouZx6LZoHO7wAIxJtcpeVhqEDHnqEwFYKpL0fTr1wskEEPMypaQxU9XRZ6PeGJKlOlFB
	7u8HR7vCx1dHTOtIvBFQaExk5SOcMTRkto3XMebhgiynIqCG/zUABoGAGdd+9NW+V+po2IsCWa5
	Ook8fSF+VPInH6YnIKQmhA4X/yT59LZxDeUs3/kDv6uqsAZdYhCjxq7ccYqr5f+sF05EbEphQ6X
	VXg4GuAV1q7M82axHHmBV+yVmIvJSZkfZFU1A1g+U3qySoKF5d8lt3OEagVCh7hPNzU2JxOHRGZ
	6D3
X-Received: by 2002:a05:620a:bc5:b0:8cd:b90f:fc1e with SMTP id af79cd13be357-8cfad3df061mr133791185a.70.1773778987159;
        Tue, 17 Mar 2026 13:23:07 -0700 (PDT)
Received: from ?IPV6:2001:1970:3847:e000:4c82:63a9:39e9:5c17? ([2001:1970:3847:e000:4c82:63a9:39e9:5c17])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfacdeb785sm57993585a.16.2026.03.17.13.23.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 13:23:05 -0700 (PDT)
Message-ID: <b3e1dfe6-b16a-44ed-82c4-b9140c91dd44@baylibre.com>
Date: Tue, 17 Mar 2026 16:23:03 -0400
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>
Cc: Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
Content-Language: en-US
From: Trevor Gamblin <tgamblin@baylibre.com>
In-Reply-To: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2026-03-16 10:03, Iker Pedrosa wrote:
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

Hi,

For all patches except 7/7 (k1-bananapi-f3):

Tested-by: Trevor Gamblin <tgamblin@baylibre.com>

>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
> Changes in v3:
> - Rebase on mmc.git/next to resolve conflicts with "mmc: sdhci-of-k1:
>    add reset support" patch.
> - Squash tuning infrastructure and implementation patches (3 and 4)
>    together to form complete functionality and avoid unused function
>    warnings.
> - Reduce code nesting: implemented an early return sanity check in
>    spacemit_sdhci_voltage_switch() to reduce indentation and improve
>    logic flow.
> - Refactor pinctrl initialization: moved pinctrl resource acquisition
>    and state lookup into a dedicated helper function,
>    spacemit_sdhci_get_pins().
> - Use generic regulator node names (buck4, aldo1) instead of
>    device-specific aliases (sd_vmmc, sd_vqmmc) to better reflect that
>    these PMIC outputs serve multiple devices.
> - Remove dead code handling 3.3V voltage switching from
>    spacemit_sdhci_voltage_switch().
> - Optimize tuning algorithm to use single-pass window detection instead
>    of storing results in array, reducing memory usage and complexity.
> - Remove unnecessary card detect check in execute_tuning() - rely on MMC
>    core.
> - Clarify commit message to mention both SD (UHS-I) and eMMC (HS200)
>    tuning support.
> - Add SD card support for Banana Pi BPI-F3 board with UHS-I capabilities
>    following the same pattern as OrangePi RV2.
> - Link to v2: https://lore.kernel.org/r/20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com
>
> Changes in v2:
> - Removed custom AIB voltage switching code per maintainer feedback. The
>    existing pinctrl driver already handles AIB voltage switching
>    automatically via power-source property changes during UHS mode
>    transitions. This eliminates code duplication.
> - Squashed regulator and pinctrl commits into single voltage switching
>    implementation.
> - Moved voltage switching callback from dynamic probe assignment to
>    static sdhci_ops declaration. Removed redundant SDHCI core call since
>    the framework handles standard voltage switching automatically.
> - Made clock override (SDHC_OVRRD_CLK_OEN | SDHC_FORCE_CLK_ON)
>    conditional for SD/SDIO cards only. This follows vendor driver pattern
>    of differentiating SD and eMMC card handling.
> - Include no-mmc property for SD card.
> - Link to v1: https://lore.kernel.org/r/20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com
>
> ---
> Iker Pedrosa (7):
>        mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
>        mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
>        mmc: sdhci-of-k1: add comprehensive SDR tuning support
>        riscv: dts: spacemit: k1: add SD card controller and pinctrl support
>        riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
>        riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
>        riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS modes
>
>   arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts  |  23 ++-
>   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts |  67 +++++++
>   arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi     |  40 ++++
>   arch/riscv/boot/dts/spacemit/k1.dtsi             |  13 ++
>   drivers/mmc/host/sdhci-of-k1.c                   | 243 +++++++++++++++++++++++
>   5 files changed, 384 insertions(+), 2 deletions(-)
> ---
> base-commit: f38f518dda1f1decc7a39556fe3231b0d1b84e1e
> change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
>
> Best regards,
