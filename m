Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DB31A061
	for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773998263; cv=pass; b=C7KIFW2+z/RAurSxC8njsCdcrdo5N9M/dw4iOsfWL+qdwqyXBr+T1GfAksYMUEQSJ9VTi+lzZFsFmYZ3JqG1bKHNDft+zZBTT/hy1ad11Jhsx/rpA/bTFzcbc35JrlmJHnIRJsrt/foMYm2luHt8JFJW8tBYprenHumkVXSPeWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773998263; c=relaxed/simple;
	bh=WI9ql83NPUaLhZG0631OEKRXHGKSR+sVAGHlOXj1Hf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mpc92o2P8IiLOqCSDNIkesrxIVUJLfNt7A22h71pF1f0561WktdlqTR+nXjtl/EqwTfIbux1MrP38p3zau+UZw3sFevbDB2hevY2M16EwTyERjw/Hfa10qhoFW6f33xSW8gpQ/tdyK55usr+WxLGXXeS0B+43I2jldjet4gf1DU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kJtAyw3z; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kJtAyw3z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79800183233so22540157b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 20 Mar 2026 02:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773998258; cv=none;
        d=google.com; s=arc-20240605;
        b=bQAbSwq+bGVzJBD2Gn3rAJt8h84V2vlWPbdVORsHPwD9MVlQaVW/9FH/a9AnoK2ftm
         s1YxSQ1EAovE5daWz6KuT0tFpHqEhrURGsSZy4N8O9rhKaTIpX7Enw9nMV1el3S5HuXP
         uJsYoGi0gJy27s/6/z/ius6JuYBiGUZBYkWZNIqnDU+FwbgJrgwqvSJTbOYe9PbcTwqO
         6BBaJjdGuRoK0zYbz+neke+mRBgpNESzJerhcO2VoDuuPhzznmWWc7ly/TIGupf1Mx2u
         1hcZ9GUstXKczboZumVSKzWKtuF1eUqHnh0t5ldvIpZsluKoh6y7bKDUqf1f7cZV6vks
         zE+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Dn1DESYfs8Y8xmtlvHAYp+0AU2JDUbwmb+m5abbzaxM=;
        fh=bPcbMrvUPsJJ/IlG9qTIZFtBvKlf7pRmnGAObmy+sXU=;
        b=IgyMbEPkAWeMOAyRZm4cUqEROIZFbVM+jF4XmZUfY0fQ+K5dKmMYOP5yIaErJJOfno
         ZQ3GSH8zV5eoosUXaO1s8ezi4B/TXY/6JdC3dAlD5Uys/nO7+16PudBaqzPPiyMnZ1l7
         0zO8aSASI0kIzygZovHyGVfmhzwNJuv1vaOtNan2licXULOxPg2wHiwB8fj1w7BINf8S
         jrW13MeVC1SpdIywRnHwfBXNlFGEcIf/NGY9uiZqHhDgQJmWB9nvei209s5qCIwLNckx
         ghkYOogeVI9+F/2yYizTZ5yfQyQFhXdliZz5DAEO81V8rwbIKBzczOvFTfB/A34YWc8L
         XGoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773998258; x=1774603058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dn1DESYfs8Y8xmtlvHAYp+0AU2JDUbwmb+m5abbzaxM=;
        b=kJtAyw3zXct7wfrYSzaq81hCnrsZtiUo+X8PgJKZBCyN4wxQ1hGzk95MSH0lXssNoz
         Dop7wEDO7g9yFx4Menkv/BcOLybYXB9QfEbfujJcVoDIigZpqnXj4C6WVm7R/gKGKJ6I
         CuwOsN9pMwrJSCKaUGKN2pZ1EnCIcHwKUmif6GXs/d1uKvytYZ6dWJoQ4ZPP26Vyj9gf
         aUBBa3uHXvykHnST1Gd0kep/3lVr7FwvBsgr93zDvyAOTauZL/L+qEdcFIRBw0rVkX73
         uNaM8hEvEB4wTeZKgoyOHM0H8ouhnpwHG9TlMirq4Z1KtDVQIndGju9EGfcVmSZ1LK22
         XFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773998258; x=1774603058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dn1DESYfs8Y8xmtlvHAYp+0AU2JDUbwmb+m5abbzaxM=;
        b=h7RN9WYAvNCQwc5DawP2Bq/xYqTAltw+v+bCNVw/0iPRa85U278RP0e2ofCgunvtTR
         yPZ7gAecatAo3MWZEbCxztkkcRDQkUpC0GhJjmqpso5JtFxr2hlS5FxRAuFe+pU9nZoF
         UQnLYnpfc1jZKPN+D2LeqCshgslEl8/oPhucWMAyrphv7KF35Xj32dkUBp8lpjlzItI2
         ZoVHIqKvNeht6ksmd29ZvIR79fnF7Nl5IvbMxrb25/rPMgqwsUnFlCzUVt+f4Rjw+TgN
         KFuQKza76gkTDADNjntH5EStavW2KbMnhs2GDG0b5UqVw9FFajLEvF0LKG+Gq9yL8hpK
         AD9w==
X-Forwarded-Encrypted: i=1; AJvYcCVo4mS9Pmo1Cl6N+KBgjGyailB/xDrZjjyRxCwAcfVklPZLdlBxOe6O7z4nPjnGrq9LnTpzFaZ6uTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLc8u1jBmvVkBueyS9gOHAXVtgULfhlv75CxxkpPCUFGZxI/Tz
	HFJChfBNlQEMHcC3FoNtxl4k46Mhlfwa+6VW2HlOOP5KBxhVYz/W26a/7sZERc72Drfm+u2nuCh
	HNSJJ0AnZPYh1Hh9dtNtxIoQA0aISjA0=
X-Gm-Gg: ATEYQzwlUVjLU6IKKW8xit/WVq+UxYrAdXYmrCfDYkOmvLnAb4zSCoDDgCSas3IEsnk
	Rv6SXMN//fobZDfcs/MXtpSJvhqO84Sgy9ZXV1nLpeugpIk9pRTkDYP6ncKynAYsThtt15PHpOW
	LCMuvfOFZ1m80gqjj9hW/XmEdlvzcRAu0Uk5zg8CCZAX0U3nV7NmPGGubAKZi+FmUOepQK/C/DB
	fwb7B3XcwXOer0pxKdLgaFeSdZVzCqNW20lyndQFIzA5uqb1V0QdQXUqJAjoqOXqMkQwSn2OX7P
	jDnWEME=
X-Received: by 2002:a05:690c:498f:b0:79a:43b1:1170 with SMTP id
 00721157ae682-79a81ad7827mr68711887b3.15.1773998258113; Fri, 20 Mar 2026
 02:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-orangepi-sd-card-uhs-v3-0-aefd3b7832df@gmail.com>
 <20260316-orangepi-sd-card-uhs-v3-2-aefd3b7832df@gmail.com> <182321ef-f01e-4bc8-8f23-aa85b4c70860@intel.com>
In-Reply-To: <182321ef-f01e-4bc8-8f23-aa85b4c70860@intel.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 20 Mar 2026 10:17:27 +0100
X-Gm-Features: AaiRm53XBGo7zx5aFlI-GEzkiEKn7jV5Xqx3ftctiokZuyCP--kGRAQhny3pbvQ
Message-ID: <CABdCQ=ODJyeC4Lb_XFxHaxQpem0F3v=tw+5CipCHFU8T5zr8Ww@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] mmc: sdhci-of-k1: add regulator and pinctrl
 voltage switching support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 17 mar 2026 a las 12:28, Adrian Hunter
(<adrian.hunter@intel.com>) escribi=C3=B3:
>
> On 16/03/2026 16:03, Iker Pedrosa wrote:
> > Add voltage switching infrastructure for UHS-I modes by integrating bot=
h
> > regulator framework (for supply voltage control) and pinctrl state
> > switching (for pin drive strength optimization).
> >
> > - Add regulator supply parsing and voltage switching callback
> > - Add optional pinctrl state switching between "default" (3.3V) and
> >   "state_uhs" (1.8V) configurations
> > - Enable coordinated voltage and pin configuration changes for UHS mode=
s
> >
> > This provides complete voltage switching support while maintaining
> > backward compatibility when pinctrl states are not defined.
> >
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  drivers/mmc/host/sdhci-of-k1.c | 58 ++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of=
-k1.c
> > index 0dd06fc19b8574ae1b00f7e5d09b7d4c87d06770..01afdadcf70796704b272ee=
5a31543afd5e01188 100644
> > --- a/drivers/mmc/host/sdhci-of-k1.c
> > +++ b/drivers/mmc/host/sdhci-of-k1.c
> > @@ -16,6 +16,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_device.h>
> >  #include <linux/reset.h>
> > +#include <linux/pinctrl/consumer.h>
> >  #include <linux/platform_device.h>
> >
> >  #include "sdhci.h"
> > @@ -71,6 +72,9 @@
> >  struct spacemit_sdhci_host {
> >       struct clk *clk_core;
> >       struct clk *clk_io;
> > +     struct pinctrl *pinctrl;
> > +     struct pinctrl_state *pinctrl_default;
> > +     struct pinctrl_state *pinctrl_uhs;
> >  };
> >
> >  /* All helper functions will update clr/set while preserve rest bits *=
/
> > @@ -219,6 +223,33 @@ static void spacemit_sdhci_pre_hs400_to_hs200(stru=
ct mmc_host *mmc)
> >                              SPACEMIT_SDHC_PHY_CTRL_REG);
> >  }
> >
> > +static void spacemit_sdhci_voltage_switch(struct sdhci_host *host)
> > +{
> > +     struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> > +     struct spacemit_sdhci_host *sdhst =3D sdhci_pltfm_priv(pltfm_host=
);
> > +     struct mmc_ios *ios =3D &host->mmc->ios;
> > +     int ret;
> > +
> > +     if (!sdhst->pinctrl)
> > +             return;
> > +
> > +     if (ios->signal_voltage !=3D MMC_SIGNAL_VOLTAGE_180) {
> > +             dev_warn(mmc_dev(host->mmc), "unsupported voltage %d\n",
> > +                      ios->signal_voltage);
> > +             return;
> > +     }
>
> In V2, I put "->voltage_switch() is called only for
> ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180" by
> which I meant that it does not allow the driver to
> switch pin state back for 3.3V.
>
> So you probably need an approach similar to the original
> spacemit_sdhci_start_signal_voltage_switch() in:
>
>         https://lore.kernel.org/linux-mmc/20260302-orangepi-sd-card-uhs-v=
1-4-89c219973c0c@gmail.com/

Thank you for the feedback. I want to make sure I understand this
point correctly to avoid going in circles.

In the v2 feedback , you mentioned that "->voltage_switch() is called
only for ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_180", which I
understood to mean that this callback only needs to handle switching
to 1.8V. This meant that the changes I introduced for v3 don't manage
the switching to 3.3V.

Can you clarify if I should I revert to implementing
"->start_signal_voltage_switch()" instead, which would handle both
1.8V and 3.3V cases? Or is there a way to make the
"->voltage_switch()" approach work properly for both directions?

>
> > +
> > +     if (sdhst->pinctrl_uhs) {
> > +             ret =3D pinctrl_select_state(sdhst->pinctrl, sdhst->pinct=
rl_uhs);
> > +             if (ret) {
> > +                     dev_warn(mmc_dev(host->mmc),
> > +                              "failed to select UHS pinctrl state: %d\=
n", ret);
> > +                     return;
> > +             }
> > +             dev_dbg(mmc_dev(host->mmc), "switched to UHS pinctrl stat=
e\n");
> > +     }
> > +}
> > +
> >  static inline int spacemit_sdhci_get_clocks(struct device *dev,
> >                                           struct sdhci_pltfm_host *pltf=
m_host)
> >  {
> > @@ -252,12 +283,37 @@ static inline int spacemit_sdhci_get_resets(struc=
t device *dev)
> >       return 0;
> >  }
> >
> > +static inline void spacemit_sdhci_get_pins(struct device *dev,
> > +                                         struct sdhci_pltfm_host *pltf=
m_host)
> > +{
> > +     struct spacemit_sdhci_host *sdhst =3D sdhci_pltfm_priv(pltfm_host=
);
> > +
> > +     sdhst->pinctrl =3D devm_pinctrl_get(dev);
> > +     if (IS_ERR(sdhst->pinctrl)) {
> > +             sdhst->pinctrl =3D NULL;
> > +             dev_dbg(dev, "pinctrl not available, voltage switching wi=
ll work without it\n");
> > +             return;
> > +     }
> > +
> > +     sdhst->pinctrl_default =3D pinctrl_lookup_state(sdhst->pinctrl, "=
default");
> > +     if (IS_ERR(sdhst->pinctrl_default))
> > +             sdhst->pinctrl_default =3D NULL;
> > +
> > +     sdhst->pinctrl_uhs =3D pinctrl_lookup_state(sdhst->pinctrl, "stat=
e_uhs");
> > +     if (IS_ERR(sdhst->pinctrl_uhs))
> > +             sdhst->pinctrl_uhs =3D NULL;
> > +
> > +     dev_dbg(dev, "pinctrl setup: default=3D%p, uhs=3D%p\n",
> > +             sdhst->pinctrl_default, sdhst->pinctrl_uhs);
> > +}
> > +
> >  static const struct sdhci_ops spacemit_sdhci_ops =3D {
> >       .get_max_clock          =3D spacemit_sdhci_clk_get_max_clock,
> >       .reset                  =3D spacemit_sdhci_reset,
> >       .set_bus_width          =3D sdhci_set_bus_width,
> >       .set_clock              =3D spacemit_sdhci_set_clock,
> >       .set_uhs_signaling      =3D spacemit_sdhci_set_uhs_signaling,
> > +     .voltage_switch         =3D spacemit_sdhci_voltage_switch,
> >  };
> >
> >  static const struct sdhci_pltfm_data spacemit_sdhci_k1_pdata =3D {
> > @@ -324,6 +380,8 @@ static int spacemit_sdhci_probe(struct platform_dev=
ice *pdev)
> >
> >       host->mmc->caps |=3D MMC_CAP_NEED_RSP_BUSY;
> >
> > +     spacemit_sdhci_get_pins(dev, pltfm_host);
> > +
> >       ret =3D spacemit_sdhci_get_clocks(dev, pltfm_host);
> >       if (ret)
> >               goto err_pltfm;
> >
>
