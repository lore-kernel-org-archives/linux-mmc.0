Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B4032E6BB
	for <linux-mmc@vger.kernel.org>; Thu,  7 May 2026 08:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778142020; cv=pass; b=D508HXWXWBG/6/iewlugBBP2qYtfOA9t18Jjl3/T1NfK1ieZnw9bE31INKgQwZhLYV/Fe11Tpsqip6+nKjpR4AgLxJdH61DBgg0nGb77ZFqMBAx8VbPQBZZMeL6GCiznB1ddeKDaId5N3mThAyDtrNtcHXPsLqEdFniSa01i5QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778142020; c=relaxed/simple;
	bh=wajiAQ3MdgD5qZ4qOwSJHk+gv8ufR8tUJYp4k5ntU6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jFoxuyQsLEyZ+GWJ7mk/HU7uQi1Z5jfh8GOEkuxJAS7RuqRl2UzTfvC8hh68tUD1ngVvhUxhPdNUTHjWoRvcVGhgpoEybYcoViEIXx0eil7ILJGHkpFf1wUq5Y/x78PjCbjrIjLpdKD0yJj4xdTVjqxiFLmE65EhG1zJN4mwVsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=ayDfjjBL; arc=pass smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="ayDfjjBL"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-662efd1bdd4so329672eaf.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2026 01:20:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778142018; cv=none;
        d=google.com; s=arc-20240605;
        b=Cx6mTLzm9xRfdtysklce4kyH7DZftSFF+ID4qDeoQG9ceuv9gjpFu7MQwP9jDJVBNb
         TmOzzGt7Pq+gt9D22GRY0bMZMaEJtWUdkhTvfyPR6/cKz0iSzsA4m/phe19HPfkyierm
         G+5P8ecOVJ9QnCnbHKuwawTLqFdL1/uxfR9Phm1CK6BWWM0cDsox20qNv2YpXm1TUgpE
         fEk/ch0fhTYFaRxYe4OK6lvO1KG/Jdn3vfisjSjcRzNYMJEcrwjY5NcfkoJuWPrZHBVk
         AEkt41dJM85M0anvpfM90u7hF+/YboCqPUKFvmktmchulJHu+3dL3waT8i7L16V6OFSK
         SbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWYx5HG66i84XevwfveNmgHdFOQmLx/UvaTFzQl0TiU=;
        fh=6y9OSN4YaT4YvLcbVlPZMcSc4hFRmOlG3HaYqRRrU+g=;
        b=YIHu04IWAz+PyuHFJTBp45qiIfPw3GjT7Nwhl0A2ihKpw22/+HODuClq5UX0TxN8ps
         iP1tDYiTxibyTiAiZtDjesWNQiWAh6WtKq+hwUBtAb5TGr4+xPxpIOW/rdQCUmfdSTJW
         sIdYDC98zAqdKVB0hjjLR7GkWpWxvyk9PeUasnbfDSF/EE2rfxGpo4MKymV8XQp6lrF+
         vc3cWRqMCZ58LSUTumuPGqzt4t+uxlYhftE0w5C5U76eoMHcSVvMm97swqHB63LJBLnL
         LiBEIrU7Me6gihttMruIev4rUo259rNrw8jtop4L53UrhbdxqngMiKziD+3ZkZeyXBvh
         9P4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1778142018; x=1778746818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWYx5HG66i84XevwfveNmgHdFOQmLx/UvaTFzQl0TiU=;
        b=ayDfjjBLlFqLnlZ0PnS5UgOxLtf0PqVoGoJBhpp/7IRF9Nl80kDbMCQEK6cESOII4J
         t7Jh0oH1qxI9pmhW9AaB31Ak2Oy4I1RTg1fP3y70J7uOTy0UNeyp1XjBjVnlIL0OZ15D
         BcMbzujuM+vLaRpagHbfk0W6mZsQZy9k1HZxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778142018; x=1778746818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWYx5HG66i84XevwfveNmgHdFOQmLx/UvaTFzQl0TiU=;
        b=cfCvgYMyO3bzpiJJVkdz0rhm2041QOuwERlicbdhNJsgIdyV5oWXNq4xwm0WiN/K38
         J4zGU30yJDkCrZj2lU3LfL93xTFYd8Sk/gOktrNxclYh5BK4aLCpuEhYCm91/D6eVaTP
         rQtGs1SCYA61Fv+NFaE0HUHJUrFWMjFpOzBDOTdowPdptomka+CB272a2NCg3NGnFVtD
         d4AZOstaDKbA2kzKsw2hmNU1XTpeVFdTSHdVLHpxCArfRPhhBouQ/UkfFdhEZn4Lldhs
         ud8cXxanJ12TYAov2rsq/MsL03jSvtleRq8aafYdkcDsQVwhQ7ORBeGzcj0nrus8LECH
         WGAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/Z9IwZtV93TBkGcXnCToa8k7P93fhQYFhPznodO2dO5gMjzGOINZkipP57qZki7rok1G+Lmv2esr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyK0ayg2J7509EA99WawVWbi6FjEy2Mnrna6Eb3XTgYjGmbKlRf
	IC3n3X80tKEBsB+XblpKNry8+yzyNaAVgn25DmzgBdwJ17+acpXQllDTRm7DMzor949OqQiyQ1u
	yd1s+n3UoX/m5//JsH1WaaX/fkuutMeaS+lktpvH8Kw==
X-Gm-Gg: AeBDiet2RWmFzZnPm9VmLkW5dsHFt1/ynFmUL4n+vser/VVQJSbxPr/6mE+lLJaftWr
	P4tRUuzg8EuQXGtaIEKqxKv4SVU6qpu4m3cXo01uoiXbcDH9O6aXAfeU0smtHBXxh8zyx5UUbH9
	w1y65/LpeZM4DF7i+9VrTOVVXpgs2OpioEI8KYbUd7pUnRPCqKV85IUfvmLjYIs0lSVkuHM0ywZ
	xOZzIa8QAoY2zSwN35RDaeSxTtqnmigqVqMPILw9Go+jh26BOn6+N0p66BzF0qLOJlo+XCd5RhY
	16lEUMbXx9pMz9upqCXF2hrqLfuUjojQfFbUnoD8aGhKC1DFRiI=
X-Received: by 2002:a4a:e60a:0:b0:684:5e35:6091 with SMTP id
 006d021491bc7-699ab62b9fbmr808519eaf.26.1778142017994; Thu, 07 May 2026
 01:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com> <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
In-Reply-To: <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
From: Margherita Milani <margherita.milani@amarulasolutions.com>
Date: Thu, 7 May 2026 10:20:06 +0200
X-Gm-Features: AVHnY4L7xr25tCAps8SxEp-5ZjcE9EGySyy8fEWRsxHZhWT1U2K2LtQjEajPjlU
Message-ID: <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
To: Iker Pedrosa <ikerpedrosam@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, Troy Mitchell <troy.mitchell@linux.dev>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Good morning Iker,

> Add complete SD card controller support with UHS high-speed modes.
>
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes


Tested-by: Margherita Milani <margherita.milani@amarulasolutions.com>

However I noticed it only works when CONFIG_I2C_K1 is enabled.
Michael Opdenacker told me it's necessary to enable the regulators
used by the mmc controller.
Should we add the dependency between CONFIG_MMC_SDHCI_OF_K1 and
CONFIG_I2C_K1? (Unless some boards don't have these dependency?)
Thank you for your patchset which was really nice!

--=20
Margherita Milani
Embedded Software Engineer
M. +39 334 758 9111
margherita.milani@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via le Canevare 30, 31100, Treviso, Veneto, IT
T. +39 (0)42 243 5310
info@amarulasolutions.com
www.amarulasolutions.com

On Mon, Apr 13, 2026 at 10:05=E2=80=AFAM Iker Pedrosa <ikerpedrosam@gmail.c=
om> wrote:
>
> Add complete SD card controller support with UHS high-speed modes.
>
> - Enable sdhci0 controller with 4-bit bus width
> - Configure card detect GPIO with inversion
> - Connect vmmc-supply to buck4 for 3.3V card power
> - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> - Add dual pinctrl states for voltage-dependent pin configuration
> - Support UHS-I SDR25, SDR50, and SDR104 modes
>
> This enables full SD card functionality including high-speed UHS modes
> for improved performance.
>
> Suggested-by: Anand Moon <linux.amoon@gmail.com>
> Tested-by: Anand Moon <linux.amoon@gmail.com>
> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> ---
>  arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 24 +++++++++++++++++++=
+++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv=
/boot/dts/spacemit/k1-bananapi-f3.dts
> index 5790d927b93d..a7d88564630f 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -220,7 +220,7 @@ buck3_1v8: buck3 {
>                                 regulator-always-on;
>                         };
>
> -                       buck4 {
> +                       buck4: buck4 {
>                                 regulator-min-microvolt =3D <500000>;
>                                 regulator-max-microvolt =3D <3300000>;
>                                 regulator-ramp-delay =3D <5000>;
> @@ -241,7 +241,7 @@ buck6 {
>                                 regulator-always-on;
>                         };
>
> -                       aldo1 {
> +                       aldo1: aldo1 {
>                                 regulator-min-microvolt =3D <500000>;
>                                 regulator-max-microvolt =3D <3400000>;
>                                 regulator-boot-on;
> @@ -367,3 +367,23 @@ hub_3_0: hub@2 {
>                 reset-gpios =3D <&gpio K1_GPIO(124) GPIO_ACTIVE_LOW>;
>         };
>  };
> +
> +&sdhci0 {
> +       pinctrl-names =3D "default", "uhs";
> +       pinctrl-0 =3D <&mmc1_cfg>;
> +       pinctrl-1 =3D <&mmc1_uhs_cfg>;
> +       bus-width =3D <4>;
> +       cd-gpios =3D <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> +       cd-inverted;
> +       broken-cd;
> +       no-mmc;
> +       no-sdio;
> +       disable-wp;
> +       cap-sd-highspeed;
> +       vmmc-supply =3D <&buck4>;
> +       vqmmc-supply =3D <&aldo1>;
> +       sd-uhs-sdr25;
> +       sd-uhs-sdr50;
> +       sd-uhs-sdr104;
> +       status =3D "okay";
> +};
>
> --
> 2.53.0
>
>


--=20
Margherita Milani
Embedded Software Engineer
M. +39 334 758 9111
margherita.milani@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via le Canevare 30, 31100, Treviso, Veneto, IT
T. +39 (0)42 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
