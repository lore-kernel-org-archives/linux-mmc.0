Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d/7DGhrS"
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64CE10E4
	for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:18:58 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5ccf64439bdso10051887b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 23 Nov 2023 09:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700759938; x=1701364738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DleoyAdHHxKmC5iQz+I0VB+4K+wFzgG4eGMYLWbfRJ8=;
        b=d/7DGhrSDB5OFSd4TQvQadc/mGHkurGDXzzNj5pJmqB8FydikWuIsoa16nWpXshGHu
         JuhJ2jiQKobeYbuFrW8sBbIavXb1SkXam8G8dc5+9br2H7RrC/GO1IAjE9n83PaULAMi
         l6ImiPtDV2fMf6cfPsYGrQyPp0l9EVvFsgD03LfTzrRYJOeb1GW8VdBGXL34F+QTI/iC
         /bSV2Z5ThY0lRpZQjqUhuOQtDWG+Fgi63EualApfPi0S0MkJ9pOumVD/cB9Z0bvSoEZa
         oXB4T4gU0CdloED0J9VPAHTVPGjB1qUzL2sAnG5+bJRaPgrP+J+nRhZEXOOPwMnGAxh2
         iXVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700759938; x=1701364738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DleoyAdHHxKmC5iQz+I0VB+4K+wFzgG4eGMYLWbfRJ8=;
        b=c1IxB1LAFB3KpfT+/TSeRVgUsFyLn1aLrlP5y1jT2QYuU5VdW7Wu8LOhF8Ta1aoEww
         zLxakq9zcvH/Uf4u+M6Yiok6CkydkQs3mFcCjb957hEuRtN0L43iunOW0ogLFZr4EsIv
         jWNLiQ+WbyVOnbBcS52FQtr5ldIEQAsLV1IkgYIE8zuT+47YKmI9H2wYfBsm2NfCiC2S
         OWBb480qv063YImslWY/auYvydIIGK1NMNO5kxvfJ/HKtlpOOm2rTyptOFpPqoD6bNRt
         qsEG7SpoyE4GmqLaKJ1CG7NhsH8P2GK/U2tdNanfoJTdMA7poJV9ahTh0EBsCbpvBIOq
         t+gQ==
X-Gm-Message-State: AOJu0YzL9Ad860CmWMBtouH/DBdU+h9nDUgl7bVwKRz+n7vZ/qOvVKI+
	nmL23UE5//gSKMO56qNfPhdudgLjYwNTP2uXF97kaQ==
X-Google-Smtp-Source: AGHT+IHfghaaZdA4ZT8Xx3Ju62k8RIFQp0fk0TMsrwoEV2UYRwle9HP2pqtqxG3fQHfuDvvctVA0pwf97KLNYu4uqnc=
X-Received: by 2002:a0d:dd01:0:b0:5ca:263e:dead with SMTP id
 g1-20020a0ddd01000000b005ca263edeadmr2740792ywe.14.1700759938020; Thu, 23 Nov
 2023 09:18:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231114115516.1585361-1-korneld@chromium.org>
In-Reply-To: <20231114115516.1585361-1-korneld@chromium.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 23 Nov 2023 18:18:22 +0100
Message-ID: <CAPDyKFooOy95UFS46BGOrFWhEYHkf2j4jFPuF7_7ZOF3KFgj1g@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: Disable LPM during initialization
To: =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Sven van Ashbrook <svenva@google.com>, 
	Jason Lai <jasonlai.genesyslogic@gmail.com>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	Ben Chuang <ben.chuang@genesyslogic.com.tw>, =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Nov 2023 at 12:55, Kornel Dul=C4=99ba <korneld@chromium.org> wro=
te:
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

Applied for fixes, thanks!

Kind regards
Uffe


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
