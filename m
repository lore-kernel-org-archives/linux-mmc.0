Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAF155759;
	Wed, 19 Jun 2024 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718824220; cv=none; b=aY5Q1K9fEuKbYsYAU8hyfxp52aOnYR2zI794kciKBzWHDFuPbWL4hNlJBZ8Bs6klVnS89S0uSx+MFqh1d3A5bSIRTV3IZfOTfSV0ZPNiKolp8+aEJtOYweHp939qTUrwaMcnnuSWSgRCmqrtYaaBO+P791958sXrkvicwVbyVzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718824220; c=relaxed/simple;
	bh=WAmFx+ZAhBE6QYFnuAIgPCTyeKlQ0c2u0P1mZZ6eo2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pE58gKPtYolM4LR4gTx1tZoP1ZQFKrKQLiuSHQ6stQO5mdbDCIlyXgTZw0jwTJK8RtYytj0J8lJ9wkl1l5x0dW9fQ2naVmrx5EANIZtduMU4L7sNaeA8okH0Fy5ybNzz4f3Rsygj+orduftSeDGqouL7+kN+MROMdHnp3+dzqJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf1XOlcW; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf1XOlcW"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6fb696d2d8so8958266b.1;
        Wed, 19 Jun 2024 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718824217; x=1719429017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahlND5Zmd1zch0hsIJlAQEvMAiC/XZH76a69+Fwt53Q=;
        b=Wf1XOlcWsbSG9aBaqeoXp3/VT/rXDkYi/ghPnCEP/RH7rgYdV72/nP80pkt1P+vVNf
         +fhDPN6yGX99ZInJKxoWBx/FsEMyW0KiN0HUqOL8JV45LYWcTkcWesYI+JFV7K2/XsVJ
         wKUllft9iIMK9/854hnjW8yxZiK6u95kVmGcAd9uzRTqwO3dDyqiM7FV03Cv0g2Mt0mc
         suXb36ptvec8L1K3+cHN3dMAyemtvN7VHC8rFZFHhygrdUhoCO7btO6aYcWS5AaJPt4v
         VcRFj+CMgo2D8mJMtiVHKmK3VZuBpCc6nYqXjgVvREjx3dSlaKMxrbFUYkwXx1KoG8vP
         B1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718824217; x=1719429017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ahlND5Zmd1zch0hsIJlAQEvMAiC/XZH76a69+Fwt53Q=;
        b=DrkmFZ8kuHuLGyJFtkZLq07KFuFhiOpC0wUWoXgy+ODR1ubT+IdNXjUbFAeVFvmh5Q
         n63g3O3DVgmacdvCY5aeOYiFcKsvwTyjkamuI710b5NP3BPWeCzSN+6vFMVAFKjR4ez7
         8/dUTqQXc0des1qNGd3oJlmkncGHUllLCduHa8qtgDCyXJQSBGXlhPN77dtKODgYwDJK
         Kropz4ILyFUKmHppj2Utb6pS/JXGrx7Pq+zHj6ZtG5N1z+Tltwlo/uIkT92QEgP2p6sU
         0cMOvcu8ldujqh8a4WGhRaLmcQ3LkWlHzNjKzfGtoMMmMRyS5HnFQXKKo3TfEn0FSFSx
         glQA==
X-Forwarded-Encrypted: i=1; AJvYcCXZNkP2B/3RuLwegjtZuvBR7kzdDPZnYzitSQf659HL5C9qD6RxLkwCFwon7cfy5aUdE8iOqqAqDKlKZjnudmYYg2qPDv23UZALYBVGSY5Iiv3rYzwnw9I9NlGVz9YMRs4j8ctKAXzck53MmCaOTBrVWUtkgtCN31C8o3akFj3YBcW0QQ==
X-Gm-Message-State: AOJu0YyyriPeWgtFNsumEUQKigc7apfQ5dy9kk05B0s1qbBgazcWqLly
	gsbvQc538Xgh452r3vG2EYJyoBEgsrn3EJlAatg+kuuAzwzYPQZAtlIbLlwv15Fu0uphe3YVGUY
	fvj0wIZEl2WRaw37+LBnqi2jioXA=
X-Google-Smtp-Source: AGHT+IG4EwmKdtxr3rqPxduBQKlfNFGX/bVsYbwYUwt0xso+kVroPnVAVQiWZQJtFZGOfOIImTMOT+FeU9/N8iQIJas=
X-Received: by 2002:a17:906:3112:b0:a6e:f793:461f with SMTP id
 a640c23a62f3a-a6fab6459b0mr207708666b.38.1718824216746; Wed, 19 Jun 2024
 12:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619054641.277062-1-shanchun1218@gmail.com> <20240619054641.277062-3-shanchun1218@gmail.com>
In-Reply-To: <20240619054641.277062-3-shanchun1218@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 19 Jun 2024 21:09:39 +0200
Message-ID: <CAHp75VcJGoDaAbD7vWin8yTGarrLZbVQqucHs+M9rAAS0BZd9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
To: Shan-Chun Hung <shanchun1218@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de, 
	pbrobinson@gmail.com, serghox@gmail.com, mcgrof@kernel.org, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com, 
	tmaimon77@gmail.com, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 7:47=E2=80=AFAM Shan-Chun Hung <shanchun1218@gmail.=
com> wrote:
>
> This adds the SDHCI driver for the MA35 series SoC. It is based upon the
> SDHCI interface, but requires some extra initialization.
>
> Signed-off-by: schung <schung@nuvoton.com>

Even I agree with Markus' remarks, so please correct your SoB by using
something similar to the From line.

...

> +config MMC_SDHCI_OF_MA35D1
> +       tristate "SDHCI OF support for the MA35D1 SDHCI controller"
> +       depends on ARCH_A35 || COMPILE_TEST
> +       depends on MMC_SDHCI_PLTFM

> +       depends on OF && COMMON_CLK

OF is not compile dependency AFAICS, if you want make it functional, use

  depends on OF || COMPILE_TEST

...

You are missing a lot of header inclusions, please follow IWYU principle.

+ array_size.h
+ bits.h

> +#include <linux/clk.h>

+ device.h

> +#include <linux/dma-mapping.h>

+ err.h

> +#include <linux/mfd/syscon.h>

+ math.h
+ mod_devicetable.h

> +#include <linux/module.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/pinctrl/consumer.h>

+ platform_device.h

> +#include <linux/regmap.h>
> +#include <linux/reset.h>
> +#include <linux/slab.h>

+ types.h

...

> +#define BOUNDARY_OK(addr, len) \
> +       ((addr | (SZ_128M - 1)) =3D=3D ((addr + len - 1) | (SZ_128M - 1))=
)

Besides sizes.h being missed, this can be done with help of ALIGN()
macro (or alike). So, kill this and use the globally defined macro
inline.

...

> +       /* If the clock frequency exceeds MMC_HIGH_52_MAX_DTR,
> +        *      disable command conflict check.
> +        */

  /*
   * The comment style is wrong and
   * the indentation in the second line.
   * Fix it as in this example.
   */

...

> +static void ma35_voltage_switch(struct sdhci_host *host)
> +{
> +       /* Wait for 5ms after set 1.8V signal enable bit */
> +       usleep_range(5000, 5500);

Use fsleep()

> +}
> +
> +static int ma35_execute_tuning(struct mmc_host *mmc, u32 opcode)
> +{
> +       struct sdhci_host *host =3D mmc_priv(mmc);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +       struct ma35_priv *priv =3D sdhci_pltfm_priv(pltfm_host);
> +
> +       /* Limitations require a reset SD/eMMC before tuning. */
> +       if (!IS_ERR(priv->rst)) {

It's way too big for indentation, moreover it uses an unusual pattern,
usually we check for an error case first. So, invert the conditional
and this all code will become much better.

> +               int idx;
> +               u32 *val;
> +
> +               val =3D kmalloc(ARRAY_SIZE(restore_data), GFP_KERNEL);
> +               for (idx =3D 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +                       if (restore_data[idx].width =3D=3D 32)

sizeof(u32) ?

> +                               val[idx] =3D sdhci_readl(host, restore_da=
ta[idx].reg);
> +                       else if (restore_data[idx].width =3D=3D 8)

sizeof(u8) ?

> +                               val[idx] =3D sdhci_readb(host, restore_da=
ta[idx].reg);
> +               }
> +
> +               reset_control_assert(priv->rst);
> +               reset_control_deassert(priv->rst);
> +
> +               for (idx =3D 0; idx < ARRAY_SIZE(restore_data); idx++) {
> +                       if (restore_data[idx].width =3D=3D 32)
> +                               sdhci_writel(host, val[idx], restore_data=
[idx].reg);
> +                       else if (restore_data[idx].width =3D=3D 8)
> +                               sdhci_writeb(host, val[idx], restore_data=
[idx].reg);

As per above?

> +               }
> +
> +               kfree(val);
> +       }
> +
> +       return sdhci_execute_tuning(mmc, opcode);
> +}

...

> +static int ma35_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;

Since you have it, use it!

> +       struct sdhci_pltfm_host *pltfm_host;
> +       struct sdhci_host *host;
> +       struct ma35_priv *priv;
> +       int err;
> +       u32 extra, ctl;
> +
> +       host =3D sdhci_pltfm_init(pdev, &sdhci_ma35_pdata,
> +                               sizeof(struct ma35_priv));

One line?

> +       if (IS_ERR(host))
> +               return PTR_ERR(host);
> +
> +       /*
> +        * extra adma table cnt for cross 128M boundary handling.
> +        */

Wrong comment style.

> +       extra =3D DIV_ROUND_UP_ULL(dma_get_required_mask(&pdev->dev), SZ_=
128M);
> +       if (extra > SDHCI_MAX_SEGS)
> +               extra =3D SDHCI_MAX_SEGS;

min() ? clamp() ?

> +       host->adma_table_cnt +=3D extra;
> +       pltfm_host =3D sdhci_priv(host);
> +       priv =3D sdhci_pltfm_priv(pltfm_host);

> +       if (dev->of_node) {

Why?

> +               pltfm_host->clk =3D devm_clk_get(&pdev->dev, NULL);
> +               if (IS_ERR(pltfm_host->clk)) {

> +                       err =3D PTR_ERR(pltfm_host->clk);
> +                       dev_err(&pdev->dev, "failed to get clk: %d\n", er=
r);

Use

  return dev_err_probe(...);

> +                       goto free_pltfm;

This is wrong. You may not call non-devm before devm ones, otherwise
it makes a room for subtle mistakes on remove-probe or unbind-bind
cycles. Have you tested that?

> +               }
> +               err =3D clk_prepare_enable(pltfm_host->clk);
> +               if (err)
> +                       goto free_pltfm;

Use _enabled variant of devm_clk_get() instead.

> +       }
> +
> +       err =3D mmc_of_parse(host->mmc);
> +       if (err)
> +               goto err_clk;
> +
> +       priv->rst =3D devm_reset_control_get(&pdev->dev, NULL);

No error check?!

> +       sdhci_get_of_property(pdev);
> +
> +       priv->pinctrl =3D devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(priv->pinctrl)) {
> +               priv->pins_default =3D pinctrl_lookup_state(priv->pinctrl=
, "default");
> +               priv->pins_uhs =3D pinctrl_lookup_state(priv->pinctrl, "s=
tate_uhs");
> +               pinctrl_select_state(priv->pinctrl, priv->pins_default);
> +       }
> +
> +       if (!(host->quirks2 & SDHCI_QUIRK2_NO_1_8_V)) {
> +               u32 reg;
> +
> +               priv->regmap =3D syscon_regmap_lookup_by_phandle(
> +                               pdev->dev.of_node, "nuvoton,sys");

dev_of_node(dev)

> +
> +               if (!IS_ERR(priv->regmap)) {
> +                       /* Enable SDHCI voltage stable for 1.8V */
> +                       regmap_read(priv->regmap, MA35_SYS_MISCFCR0, &reg=
);
> +                       reg |=3D BIT(17);
> +                       regmap_write(priv->regmap, MA35_SYS_MISCFCR0, reg=
);
> +               }
> +
> +               host->mmc_host_ops.start_signal_voltage_switch =3D
> +                                       ma35_start_signal_voltage_switch;
> +       }
> +
> +       host->mmc_host_ops.execute_tuning =3D ma35_execute_tuning;
> +
> +       err =3D sdhci_add_host(host);
> +       if (err)
> +               goto err_clk;
> +
> +       /* Enable INCR16 and INCR8 */
> +       ctl =3D sdhci_readw(host, MA35_SDHCI_MBIUCTL);
> +       ctl &=3D ~MA35_SDHCI_INCR_MSK;
> +       ctl |=3D MA35_SDHCI_INCR16|MA35_SDHCI_INCR8;
> +       sdhci_writew(host, ctl, MA35_SDHCI_MBIUCTL);
> +
> +       return 0;

> +err_clk:
> +       clk_disable_unprepare(pltfm_host->clk);

This will go with the _enabled variant being used.

> +free_pltfm:
> +       sdhci_pltfm_free(pdev);

This should go to be correct in ordering.

> +       return err;
> +}
> +
> +static int ma35_remove(struct platform_device *pdev)

Use remove_new callback.

> +{
> +       struct sdhci_host *host =3D platform_get_drvdata(pdev);
> +       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> +
> +       sdhci_remove_host(host, 0);

> +       clk_disable_unprepare(pltfm_host->clk);
> +       sdhci_pltfm_free(pdev);

At least these two will go away as per probe error path.

> +       return 0;
> +}

...

> +MODULE_AUTHOR("shanchun1218@google.com");

Needs to be fixed as Markus said.


--=20
With Best Regards,
Andy Shevchenko
