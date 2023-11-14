Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBBD3FE24
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JYlvoiNc"
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E239F197
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 05:02:10 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5842a7fdc61so2828082eaf.3
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 05:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699966930; x=1700571730; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZ7lI/47qj9ovIXjugVBgcYNb/63apU98UAvoft/LRY=;
        b=JYlvoiNcLLfYSdWrAyyez9wj/BJMRoQnxBx8MW7mi14YuQ4HyTnkgVtKU2jRaH+3EC
         VvQnMjadCEd4otF1R+oEPX1EuzZauClkoAdH4+JrjYTT6mtJz3ZONFBNTZeo76jZ/c/h
         LDW/EZZGextjuJoj4eoZiQL3wdVTdHdKTdEYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699966930; x=1700571730;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZ7lI/47qj9ovIXjugVBgcYNb/63apU98UAvoft/LRY=;
        b=BQb6VaxbhZXyChvlkyq2/WWC6ldhDFmR6j62/L29WliqiJ0PEmgt0c1ATcuBX2+yyh
         06rKuQ2zKSRg4YyF4V4lpdRuIiOZ3jLqiHmeyrjjn+IszuYhbXrUATMI3snXR1P6AzYA
         qjAazIn+nghFE3PVcMBCQah/opvM67ewhxNt3NWh0PFgas5m2p4MFILRBcMmT5uX32C9
         vP3/thfmH4/ZN/y00WlPIxDaPVjN7egBfSmxK2EiMt9PJo4v7CsJfVz12O6VzHkvFcS/
         BxAVcZAKugh+htZcR7bNyjYfr7oOsmGt3tpcEchM1bl0k193d9ZpR1BsahBAS4onjZGW
         ksYA==
X-Gm-Message-State: AOJu0YyhaK157X+vSohok1s8Nk7WTQ2N4bgSoWrXVG7dag7bzO3qDWmT
	QPPk2f+wz6m1NXitSDZoUCToUpZH1UGLT6W4O9GJtQ==
X-Google-Smtp-Source: AGHT+IEwtd5gnwVHSVciuUo8/FI+ZjQufFQEbeZiEA0eq9eSDp56QnoYf+Ox8zdKBQCKrrwrz0s04Z+SzhYiXAAhENo=
X-Received: by 2002:a05:6820:293:b0:584:bb9:4945 with SMTP id
 q19-20020a056820029300b005840bb94945mr10923648ood.3.1699966929817; Tue, 14
 Nov 2023 05:02:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114115516.1585361-1-korneld@chromium.org>
In-Reply-To: <20231114115516.1585361-1-korneld@chromium.org>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Tue, 14 Nov 2023 08:01:58 -0500
Message-ID: <CAG-rBig6XHoPSch5OqO_yNrYsX2szkyce0K==xqmrJXKT-2Jgg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: Disable LPM during initialization
To: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Jason Lai <jasonlai.genesyslogic@gmail.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM.
Reviewed-by: Sven van Ashbrook <svenva@chromium.org>

On Tue, Nov 14, 2023 at 6:56=E2=80=AFAM Kornel Dul=C4=99ba <korneld@chromiu=
m.org> wrote:
>
> To address IO performance commit f9e5b33934ce
> ("mmc: host: Improve I/O read/write performance for GL9763E")
> limited LPM negotiation to runtime suspend state.
> The problem is that it only flips the switch in the runtime PM
> resume/suspend logic.
>
> Disable LPM negotiation in gl9763e_add_host.
> This helps in two ways:
> 1. It was found that the LPM switch stays in the same position after
>    warm reboot. Having it set in init helps with consistency.
> 2. Disabling LPM during the first runtime resume leaves us susceptible
>    to the performance issue in the time window between boot and the
>    first runtime suspend.
>
> Fixes: f9e5b33934ce ("mmc: host: Improve I/O read/write performance for G=
L9763E")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kornel Dul=C4=99ba <korneld@chromium.org>
> ---
> v2: Move up gl9763e_set_low_power_negotiation to avoid having to forward
>     declare it.
>
>  drivers/mmc/host/sdhci-pci-gli.c | 54 +++++++++++++++++---------------
>  1 file changed, 29 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index d8a991b349a8..77911a57b12c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1189,6 +1189,32 @@ static void gl9763e_hs400_enhanced_strobe(struct m=
mc_host *mmc,
>         sdhci_writel(host, val, SDHCI_GLI_9763E_HS400_ES_REG);
>  }
>
> +static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t,
> +                                             bool enable)
> +{
> +       struct pci_dev *pdev =3D slot->chip->pdev;
> +       u32 value;
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> +
> +       if (enable)
> +               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> +       else
> +               value |=3D GLI_9763E_CFG_LPSN_DIS;
> +
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> +
> +       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> +       value &=3D ~GLI_9763E_VHS_REV;
> +       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> +       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> +}
> +
>  static void sdhci_set_gl9763e_signaling(struct sdhci_host *host,
>                                         unsigned int timing)
>  {
> @@ -1297,6 +1323,9 @@ static int gl9763e_add_host(struct sdhci_pci_slot *=
slot)
>         if (ret)
>                 goto cleanup;
>
> +       /* Disable LPM negotiation to avoid entering L1 state. */
> +       gl9763e_set_low_power_negotiation(slot, false);
> +
>         return 0;
>
>  cleanup:
> @@ -1340,31 +1369,6 @@ static void gli_set_gl9763e(struct sdhci_pci_slot =
*slot)
>  }
>
>  #ifdef CONFIG_PM
> -static void gl9763e_set_low_power_negotiation(struct sdhci_pci_slot *slo=
t, bool enable)
> -{
> -       struct pci_dev *pdev =3D slot->chip->pdev;
> -       u32 value;
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_W);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_CFG, &value);
> -
> -       if (enable)
> -               value &=3D ~GLI_9763E_CFG_LPSN_DIS;
> -       else
> -               value |=3D GLI_9763E_CFG_LPSN_DIS;
> -
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_CFG, value);
> -
> -       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> -       value &=3D ~GLI_9763E_VHS_REV;
> -       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> -       pci_write_config_dword(pdev, PCIE_GLI_9763E_VHS, value);
> -}
> -
>  static int gl9763e_runtime_suspend(struct sdhci_pci_chip *chip)
>  {
>         struct sdhci_pci_slot *slot =3D chip->slots[0];
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
