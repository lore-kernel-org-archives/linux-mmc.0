Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D234D1DFEF
	for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732107409; cv=none; b=FQpDbyS+XTidAlD/aex3F+E6Lj4pBSjE8ffROjikC3zInfqpzTJBinIWtrH/rUp7Zmv++uSsR9hc+ccmz20g/9IEdgydu9B5tuT2ZSE/U2fro7q0P2tn4i2pcuS66AZ+EItHDol2f6QvBO/pthAY8RxrTFir79a+3NUCEjBuhEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732107409; c=relaxed/simple;
	bh=ZeM63XqCzuu+vMjlQhKvzCYJvpdJDiNI3dTZwKha5oA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tK4VbiDZLqEdiwbh6Cels1m7UlczXHLEqCmu67XUTBHQgd8HhRsbIpYcsFDgyF1peWT6Nr4/SbrSqKGmy3gfOfRxJnL/2m52JUCSVOuY0CZH3OwL5wfpf9GCTEVttwF4Bk/ZS6YZcbEUUTzkN8vv/nkPZrN2+umcNDPYuRJQk1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AO0b7Ggi; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AO0b7Ggi"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e387e50d98eso1857320276.2
        for <linux-mmc@vger.kernel.org>; Wed, 20 Nov 2024 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732107407; x=1732712207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zhy4N4GY1+ZvMEMkVSolrHoQCEqYRT3om0rXzZlH72o=;
        b=AO0b7GgiBQGuf32wmdRt4DRMt+54dQ74rHIZ4+IUyzgzkFGNTNlTiTy63wwjYBShZA
         GtZb5nsxjEWfHuJEcXGjuGZohIPeCxw23wKIH3rDLCbI36aVt9JLv3zkXbbErVdBMvAY
         cvJrlA4Ne4MLpgQ+bu4fJCVne+te2b88ej6YwTRoAv/cBerxD7PHHtm6xn13LAD0NX9F
         ShL00qhvGIbmAXJ6+ewWxwNhY6N9QbRS2ra5EMee9Ahev9alXD7YWp2ZaYs+a7mRM3lP
         qiuQAVkrOM41qmSqIKgX23HLuZIkTyT9+D2YL/aX7Ko6zifa4C76SYcoKuuLXK1BVO3B
         gYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732107407; x=1732712207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zhy4N4GY1+ZvMEMkVSolrHoQCEqYRT3om0rXzZlH72o=;
        b=u6CLj3XT9xXSUCXFHMEBmDjnh6CYV5Lr9C4yH7VUysCA1uuk7viTnGLueWo2dQ+rW0
         8BHMKhITwXNOfn5kXB6vBOyT4tGegxkgjdP5P8WqReXu93p3MejOjaWXHit+KML/ximY
         1CQW5LWyjPvjaCrnFXxcpAPgp0Vf91B+2MC3u8vXhkpydqyPL+rSMXxtRvFM3IqDCObC
         +FrCJYvKRMBA70sJGlgOnX1fHfI40youfiuGWEVfYqRC+rqElfvvLsXE0cUaIvYN8S6H
         HefnpJdhmtizZVdKAUe4T6AdEhSSm5XquuuI1fyug6Tqg1yKrLgOb0omRANSSg/DIELt
         8Z2w==
X-Forwarded-Encrypted: i=1; AJvYcCVuas+HE//2BXJ3WRTTw7uLuRyIJdQGfEe37mLWow8JHLwTScyiVco2eAwtqvh2r47AKV5iiUbAPPk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzudUbLNXk4I3ilEd/OZd3cK31WhxdXDMmLsXPJYemhGk4HHgmP
	EhQHVQdRmBNtI0aIIwCHcziG3DUR044HMEAORO4kYYPUsjg38FWNDu/DE4fmjPYW6u9DHLljV0+
	UuI2eLktyUOWONE8K2FaiuGRVbIFAfIA2xn+1soeD0SEKzZib
X-Google-Smtp-Source: AGHT+IHB/Q1GiOFWTzQsjHiArNAhHNGKTW8uZyCB2r5DunNeyOJiTs9Rr3/hwDxp86DfnITs/kcAWJtEKoHqPKLt33g=
X-Received: by 2002:a05:6902:240d:b0:e33:1096:f2e1 with SMTP id
 3f1490d57ef6-e38cb5ebaa2mr1930702276.40.1732107406797; Wed, 20 Nov 2024
 04:56:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118210049.311079-1-hdegoede@redhat.com>
In-Reply-To: <20241118210049.311079-1-hdegoede@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 20 Nov 2024 13:56:11 +0100
Message-ID: <CAPDyKFov29aLGq4vmTZB45mfkLEAAsC_NMCv2u858K9XPdCPkg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Nov 2024 at 22:01, Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
> Andaluc=C3=ADa region has no ACPI fwnode associated with the SDHCI contro=
ller
> for its microsd-slot and thus has no ACPI GPIO resource info.
>
> This causes the following error to be logged and the slot to not work:
> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpio
>
> Add a DMI quirk table for providing gpiod_lookup_tables with manually
> provided CD GPIO info and use this DMI table to provide the CD GPIO info
> on this tablet. This fixes the microsd-slot not working.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I assume we should tag this for stable kernels, but can we find a fixes tag=
 too?

Kind regards
Uffe

> ---
> Changes in v4:
> - Count number of GPIOs in the lookup table instead of assuming it is
>   always 1
>
> Changes in v3:
> - Add a cd_gpio_override pointer to sdhci_pci_fixes
> - Add sdhci_pci_add_gpio_lookup_table() helper which kmemdup-s a const
>   struct gpiod_lookup_table to avoid races when using async probing
>
> Changes in v2:
> - Make sdhci_pci_dmi_cd_gpio_overrides static const instead of just const
> - Drop duplicate #include <linux/dmi.h> (already there at the end)
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 72 +++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci.h      |  1 +
>  2 files changed, 73 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-p=
ci-core.c
> index ed45ed0bdafd..2e2e15e2d8fb 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
>  #include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
>  #include <linux/debugfs.h>
> @@ -1235,6 +1236,29 @@ static const struct sdhci_pci_fixes sdhci_intel_by=
t_sdio =3D {
>         .priv_size      =3D sizeof(struct intel_host),
>  };
>
> +/* DMI quirks for devices with missing or broken CD GPIO info */
> +static const struct gpiod_lookup_table vexia_edu_atla10_cd_gpios =3D {
> +       .dev_id =3D "0000:00:12.0",
> +       .table =3D {
> +               GPIO_LOOKUP("INT33FC:00", 38, "cd", GPIO_ACTIVE_HIGH),
> +               { }
> +       },
> +};
> +
> +static const struct dmi_system_id sdhci_intel_byt_cd_gpio_override[] =3D=
 {
> +       {
> +               /* Vexia Edu Atla 10 tablet 9V version */
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AMI Corporation"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "Aptio CRB"),
> +                       /* Above strings are too generic, also match on B=
IOS date */
> +                       DMI_MATCH(DMI_BIOS_DATE, "08/25/2014"),
> +               },
> +               .driver_data =3D (void *)&vexia_edu_atla10_cd_gpios,
> +       },
> +       { }
> +};
> +
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd =3D {
>  #ifdef CONFIG_PM_SLEEP
>         .resume         =3D byt_resume,
> @@ -1253,6 +1277,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt=
_sd =3D {
>         .add_host       =3D byt_add_host,
>         .remove_slot    =3D byt_remove_slot,
>         .ops            =3D &sdhci_intel_byt_ops,
> +       .cd_gpio_override =3D sdhci_intel_byt_cd_gpio_override,
>         .priv_size      =3D sizeof(struct intel_host),
>  };
>
> @@ -2054,6 +2079,42 @@ static const struct dev_pm_ops sdhci_pci_pm_ops =
=3D {
>   *                                                                      =
     *
>  \***********************************************************************=
******/
>
> +static struct gpiod_lookup_table *sdhci_pci_add_gpio_lookup_table(
> +       struct sdhci_pci_chip *chip)
> +{
> +       struct gpiod_lookup_table *cd_gpio_lookup_table;
> +       const struct dmi_system_id *dmi_id =3D NULL;
> +       size_t count;
> +
> +       if (chip->fixes && chip->fixes->cd_gpio_override)
> +               dmi_id =3D dmi_first_match(chip->fixes->cd_gpio_override)=
;
> +
> +       if (!dmi_id)
> +               return NULL;
> +
> +       cd_gpio_lookup_table =3D dmi_id->driver_data;
> +       for (count =3D 0; cd_gpio_lookup_table->table[count].key; count++=
)
> +               ;
> +
> +       cd_gpio_lookup_table =3D kmemdup(dmi_id->driver_data,
> +                                      /* count + 1 terminating entry */
> +                                      struct_size(cd_gpio_lookup_table, =
table, count + 1),
> +                                      GFP_KERNEL);
> +       if (!cd_gpio_lookup_table)
> +               return ERR_PTR(-ENOMEM);
> +
> +       gpiod_add_lookup_table(cd_gpio_lookup_table);
> +       return cd_gpio_lookup_table;
> +}
> +
> +static void sdhci_pci_remove_gpio_lookup_table(struct gpiod_lookup_table=
 *lookup_table)
> +{
> +       if (lookup_table) {
> +               gpiod_remove_lookup_table(lookup_table);
> +               kfree(lookup_table);
> +       }
> +}
> +
>  static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>         struct pci_dev *pdev, struct sdhci_pci_chip *chip, int first_bar,
>         int slotno)
> @@ -2129,8 +2190,19 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot=
(
>                 device_init_wakeup(&pdev->dev, true);
>
>         if (slot->cd_idx >=3D 0) {
> +               struct gpiod_lookup_table *cd_gpio_lookup_table;
> +
> +               cd_gpio_lookup_table =3D sdhci_pci_add_gpio_lookup_table(=
chip);
> +               if (IS_ERR(cd_gpio_lookup_table)) {
> +                       ret =3D PTR_ERR(cd_gpio_lookup_table);
> +                       goto remove;
> +               }
> +
>                 ret =3D mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_id=
x,
>                                            slot->cd_override_level, 0);
> +
> +               sdhci_pci_remove_gpio_lookup_table(cd_gpio_lookup_table);
> +
>                 if (ret && ret !=3D -EPROBE_DEFER)
>                         ret =3D mmc_gpiod_request_cd(host->mmc, NULL,
>                                                    slot->cd_idx,
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 153704f812ed..4973fa859217 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -156,6 +156,7 @@ struct sdhci_pci_fixes {
>  #endif
>
>         const struct sdhci_ops  *ops;
> +       const struct dmi_system_id *cd_gpio_override;
>         size_t                  priv_size;
>  };
>
> --
> 2.47.0
>
