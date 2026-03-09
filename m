Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351E43ED119
	for <linux-mmc@vger.kernel.org>; Mon,  9 Mar 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773082219; cv=pass; b=lcO/vcSO9CckQbPtGZCXrOw8qFjDk5Sfrd45NM6QAgJbjxIg1wjoKl/QBbI9D8/NFOGoR/nxuMZ02xy8RW0S+1EksfazBCzFRBmDXEzrigm0BKTPiiwcLz9+N7w1iNH0TaDQklZ190IW7svi6BwsqmF/6EpsNNnYCTq4hGZMEfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773082219; c=relaxed/simple;
	bh=fOVP/fNnR8syWhjc4RBhgcfX6wYbCNnDL9RyXcatRsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fa9310FHCcFJYC3G3qutqs0oybNSlrjexM2vcuPrFVpd4HVlLK3o31dMZWU77xVLEHPx0fqiS5meZ+P8/FAdlFPzxxWGRtHW7l18llsZiawsP5/MzbqNo3rHqhxO6AVbkb1vs7IcqvcskqptYRyLdWABoYM4GGWATPU7AGyNBHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXNKEHFm; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXNKEHFm"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-660fc3f30c1so8136774a12.1
        for <linux-mmc@vger.kernel.org>; Mon, 09 Mar 2026 11:50:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773082216; cv=none;
        d=google.com; s=arc-20240605;
        b=ZozNdI8qhXKDcLgyfW91LI+kvg/9oiHjwCIvvarwltXb33rTNi6FpL+22uZ9ZU5cVL
         XOirabgWrppFZ+h94uQobGK8Ppkps0U4hS2C+TyxXay0xEfahYvQosvmyJJCC38oBK5L
         xjQoF7VLDg6Bi94dWBd/zemAn/6U0cmFVKM8WbTZOCw74XdrwmpRr8MwqZ3i2CMM9fQw
         TqqyousvcAFJaWkfsNttg+gDqV2KPnkGvyqKM0WMQxpK7ltQaIHVG3pBN3dBRV97Vg4Z
         G+WYQXsKc2sDtPSKOFcYz4Dv62vadYT6kPPuk+PeaImpAUbchTEW7qbPZjvyNHzl4MiY
         PdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bowSy7YAPucdHblTmCmhKZ/mGr5O8DBdosAVAbymDGo=;
        fh=TUiSNWf+9ToS9fmj7yx4eqoLlAm2dZCLfO1rEGrkKtg=;
        b=aXoSGivJyUfTx46uAg/y+iR2qsL+Gxu3T1LpYgiwzO8MWSZufHbKULXzX6VJInCaHk
         a6i+Zg4/YSwOR/dQviaE9JHxwmuBSGSQIKSFxndkiciPekHrnTZq44/J+UnmXSizMrqK
         LT1TalIHMy5QqRIkpVW0e0umz9fia1T2YIj3FXJdadCDF2iznbINGnU6MXC9TLtPWv6s
         t343V6HePhC4+pJmZYNBhtYk0dDy9QCQJtYdN6dpGzkE3eL3L3m1CdrTc+4FI+5vSzN4
         SY2Aw1MSRGmtFbIVA4dL/9qyJM9YOfohxOI7dWr8HU/dUjaa4Rn9BuRJnTQbxXIeYqif
         4Dow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773082216; x=1773687016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bowSy7YAPucdHblTmCmhKZ/mGr5O8DBdosAVAbymDGo=;
        b=BXNKEHFmvjP6TyU0cDYnSlBi112tDEtumaT6+ADNlqXKvKa32uP8lJb1TpahoIhHnr
         X+fMlI6CI9Ts56LD/Ln5WG0JC6m+5z8WJzYtABdlQi4twMb/7r+jCqoqq13zfoKRicSo
         x2hTO73qOP9+kZ9GvzWtdDq5EdmbipsHjIFjyYuPGCbhVMy+1fx2A5p0ktWGZtm/RyS2
         AEnc5NIRsBlgelELw4lZilQP/1rAtsqovLLkVVfEk4AMMnvUNIwF8TU5z5NhSPaCBywn
         bn8BfdhpWy71wIyWbeMGCSWfVte4N/mDubVmH7BATnkXaqE5GSjXd5Pl7mJeI91fpnTS
         tEBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773082216; x=1773687016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bowSy7YAPucdHblTmCmhKZ/mGr5O8DBdosAVAbymDGo=;
        b=W1sdK3/SWhsnUk01CAG396rJs8tOajSgZv7pG71yFxJ3nxuUapInpfiiA4T2fjBya4
         nXVjhjcdob04GES0XHtn0yq91vvgfrXEsoHfRbmwtfV/aSZAS8LXPlslR3ee7GTtFW7L
         +zkuvz62iwufdY9yA6hbkfa9RnwY1FDJojuepPdTAPO4fcle0ToLAHQ84ykaNE2850Gx
         KuP98jt2Zs31B0abpcNTD5PLRaLSX4cu+/7xawFu01Syx3UrETIZ3F+PmhBb80RpgfqV
         rErPBEOu8EFyky/cJWEQM8PQ/sQ6KAddIOkxGb5L5YLfRsl1AHvWXI/bYrre7RXOnh4I
         P/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXho6T8Ti/t84MtBfDgZg57fG3kP/WQAO/sOOFcYKTb9fuRlDPuiI/Hj33l6w4zFthxwkVz+micKN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3Kj9VDAZBeDoUdLKfg1YwSnOXLHGZM2n7Ak4Tm6X6DIxdtyg
	Lqr3+i8uHmjwOTUKwK7iWApFDLUZkIghCVCyXERbytYtFyeOlCHhN1wOYtFuYuguLhxo2Ii9T/x
	aCCWjETMSi/Tm5Axj5i+oxJdimAjw/yc=
X-Gm-Gg: ATEYQzxs2rpjtYjCSB/c/BTFrz4q5hF9hkUTfG7EaIPlhQLbWog/d/PB5DsGQQ3FGbR
	UzfK8ZP7tLiQCQZY67M8LmVKfT3GZsUEX6wlxXH7jHux9a97pf0jXQDoC9cvZNGIRhZuoljvqNp
	JgD7VkDdBf4ebhS+ZPhpwVxbyNsIfin39wXzKIxV4HBkEOcyJQqjL4taGd/LVj6eWiObrCp4Zk/
	tPRDpEJGV2z2Of099lfG06NKKnW6/BrTWLlT8f2BN1oZmw1UI2NVXRG+m+7BjuSdJJTHRqGrze0
	c+B7oQ==
X-Received: by 2002:a17:907:6ea6:b0:b93:c5a9:a5e9 with SMTP id
 a640c23a62f3a-b942db854e8mr585699366b.4.1773082216119; Mon, 09 Mar 2026
 11:50:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
In-Reply-To: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 10 Mar 2026 00:19:58 +0530
X-Gm-Features: AaiRm51K4xV8rPWNxLGo_P3SgtaWeN6UkUVkJtFc0B8zhHQGEqIMu2rC6apEjTo
Message-ID: <CANAwSgRcatU3BQrsd11kA-nj_xos_Oa_47p0P_K+RYrB6QtfXA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Iker,

On Mon, 9 Mar 2026 at 17:11, Iker Pedrosa <ikerpedrosam@gmail.com> wrote:
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
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
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

Thanks. Please include my tested with the SpacemiT Banna F3

Tested-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

> ---
> Iker Pedrosa (7):
>       mmc: sdhci-of-k1: enable essential clock infrastructure for SD operation
>       mmc: sdhci-of-k1: add regulator and pinctrl voltage switching support
>       mmc: sdhci-of-k1: add SDR tuning infrastructure
>       mmc: sdhci-of-k1: add comprehensive SDR tuning support
>       riscv: dts: spacemit: k1: add SD card controller and pinctrl support
>       riscv: dts: spacemit: k1-orangepi-rv2: add PMIC and power infrastructure
>       riscv: dts: spacemit: k1-orangepi-rv2: add SD card support with UHS modes
>
>  arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts |  67 ++++++
>  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi     |  40 ++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi             |  13 ++
>  drivers/mmc/host/sdhci-of-k1.c                   | 252 +++++++++++++++++++++++
>  4 files changed, 372 insertions(+)
> ---
> base-commit: ec1fb4e55df47ed043ab2ccc6787e39b9d67e49b
> change-id: 20260226-orangepi-sd-card-uhs-0ecb05839b0c
>
> Best regards,
> --
> Iker Pedrosa <ikerpedrosam@gmail.com>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
