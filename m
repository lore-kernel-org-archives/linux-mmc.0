Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615141459E2
	for <linux-mmc@vger.kernel.org>; Tue,  4 Jun 2024 11:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499656; cv=none; b=qMcmOxxKf2VY6FkeVl20+oaD6qn7E3Xl/h7B6NpPMx1gX7pgetPcRdujQK33dxmrstToyvEo/9xchJxia/abeD93cgifTNNgSAzdS9LwWvyc+pTYjMMkvmqa3bJ0y0YgqnjTHDJChm10PlB5b8SybuqwDh2QWKtfLY8DRizB/7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499656; c=relaxed/simple;
	bh=KZaP+W+AgO8UjXGPeYtVYh/VGSuW1WC9D807PjO3AY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zgl7Bq7t7rrJ0jKVPCVX/wAHWAO3GuQZi48e65XV5lLCwdxMWxletV2unTxSkLk243l/GRmjC9JDkiIgIZLkQ97nZ80FIfTLBy9DVXwwkJy3X/QlsnWtu0fMKInMHwMbn22H/rwjFTQF9/YHZgUELd10t0G9WMevTyNr7NwMmpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ikeSI735; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ikeSI735"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfa4876a5bbso4931102276.2
        for <linux-mmc@vger.kernel.org>; Tue, 04 Jun 2024 04:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717499653; x=1718104453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eVUyuT3A5QeSmQ0Yo5lYgoWJs12u7HyL9xFqeZu4VYk=;
        b=ikeSI735cnnh7A3GxhpbD3MgFechOdxDE6xsMS1hfUfg1UfNoz6Mbl/nUTL2uN5jVx
         39r54fsnCld0zUXEeKEywdD9C5oBka/RkaVph+z1bKfeiFmltR+/+4ykuJScwZf76EKd
         yPv330hj6h5XeO0y7XcJEUU+wfcWcHHvG8JMUdgJ2FHPBmSem8STQ3/QUra+JgqnPPHe
         uXGnWzBWPmJCXULHtjyOTNKKR6ykotR6tvNaNboyTIntBs7ICkcT3Ki/aqkjeBe9dTdo
         7gveGbJMe7rPb8vT+dfkUsLHt9DzMtKg4G59r6gfjrxT4nSAOFE+DbjmWnJtXKfc+nFI
         tb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717499653; x=1718104453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eVUyuT3A5QeSmQ0Yo5lYgoWJs12u7HyL9xFqeZu4VYk=;
        b=P4Lr3pV6vi859SEubqOrg8I6Ql5sIHbQpVa1QJM62XTZgy1RuwE/omhOBCGjOyaI+O
         DDIPM8kvBhAjSeDaCc1Qqg5TELaOTqyEhEPsorfMqcD/+djalMk+zNAj0qUqbeTlFsp8
         /SdQTJp7Uk7AYq1p5Gd9YXlPUqILsHyjy6BkJxGllmmTCQPk1GUJ39IKVpsVzuj9Ur3J
         wRbKepyLqiVG58baQ0/DsJwDkBidwQou4eHiWVF8SJbYKP7hLlI5voK7e0MsaKCifwQG
         6smnEufYd9Cw62eRIkrB0dDJbUPZz4T8Zk74Ws60NTS7ECOw2pziotxDvPycQHvhhnTL
         OUfA==
X-Forwarded-Encrypted: i=1; AJvYcCXcPNtwDjNmKJIGZC3qm3iqJIffO1ZsDTkBszhwo9aH/BBENDwaRj4DoC3u9W5uS2GGDd4szFmUbViAUEZORU31yinbRZ08N+Da
X-Gm-Message-State: AOJu0Yxu/aOGabJoHF87ioyahGX/K2tkHS2qu2wSOiebz7UAGzK0Thw6
	tr7tKmMd6MY9ns2vdSXYxV5AJLlIMO4j1KofjRDhPzjiA6JbgJt6tu7laOLPAEKP19htBAAr75I
	njXuk97MNgQrBZkqdde2zASqNR39ySWzUycS9iA==
X-Google-Smtp-Source: AGHT+IGjxz+Q6LL4Xz4NJTZ9jcZ+6vRdGY88hj71HwafBzPDpdymdJF0XsrFwb5rEFsxn5mPGXo+60k7wI8LPadPS2s=
X-Received: by 2002:a25:addb:0:b0:df7:8fdc:274f with SMTP id
 3f1490d57ef6-dfa73bc2dbemr11736204276.2.1717499653278; Tue, 04 Jun 2024
 04:14:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527132443.14038-1-ilpo.jarvinen@linux.intel.com> <20240527132443.14038-2-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20240527132443.14038-2-ilpo.jarvinen@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 4 Jun 2024 13:13:37 +0200
Message-ID: <CAPDyKFoxBLQDvCAd3cO12fFN3NTwFHPKra7QwQqM0gw0_z6koQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-pci-o2micro: Convert PCIBIOS_* return
 codes to errnos
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Chevron Li <chevron.li@bayhubtech.com>, 
	Dinghao Liu <dinghao.liu@zju.edu.cn>, Adam Lee <adam.lee@canonical.com>, 
	Chris Ball <chris@printf.net>, Peter Guo <peter.guo@bayhubtech.com>, 
	Jennifer Li <Jennifer.li@o2micro.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 27 May 2024 at 15:25, Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> sdhci_pci_o2_probe() uses pci_read_config_{byte,dword}() that return
> PCIBIOS_* codes. The return code is then returned as is but as
> sdhci_pci_o2_probe() is probe function chain, it should return normal
> errnos.
>
> Convert PCIBIOS_* returns code using pcibios_err_to_errno() into normal
> errno before returning them. Add a label for read failure so that the
> conversion can be done in one place rather than on all of the return
> statements.
>
> Fixes: 3d757ddbd68c ("mmc: sdhci-pci-o2micro: add Bayhub new chip GG8 sup=
port for UHS-I")
> Fixes: d599005afde8 ("mmc: sdhci-pci-o2micro: Add missing checks in sdhci=
_pci_o2_probe")
> Fixes: 706adf6bc31c ("mmc: sdhci-pci-o2micro: Add SeaBird SeaEagle SD3 su=
pport")
> Fixes: 01acf6917aed ("mmc: sdhci-pci: add support of O2Micro/BayHubTech S=
D hosts")
> Fixes: 26daa1ed40c6 ("mmc: sdhci: Disable ADMA on some O2Micro SD/MMC par=
ts.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 41 +++++++++++++++-------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhc=
i-pci-o2micro.c
> index d4a02184784a..058bef1c7e41 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -823,7 +823,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch &=3D 0x7f;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>
> @@ -834,7 +834,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_CLKREQ, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x20;
>                 pci_write_config_byte(chip->pdev, O2_SD_CLKREQ, scratch);
>
> @@ -843,7 +843,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                  */
>                 ret =3D pci_read_config_byte(chip->pdev, O2_SD_CAPS, &scr=
atch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x01;
>                 pci_write_config_byte(chip->pdev, O2_SD_CAPS, scratch);
>                 pci_write_config_byte(chip->pdev, O2_SD_CAPS, 0x73);
> @@ -856,7 +856,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_INF_MOD, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x08;
>                 pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch)=
;
>
> @@ -864,7 +864,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x80;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>                 break;
> @@ -875,7 +875,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>
>                 scratch &=3D 0x7f;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
> @@ -886,7 +886,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                                                     O2_SD_FUNC_REG0,
>                                                     &scratch_32);
>                         if (ret)
> -                               return ret;
> +                               goto read_fail;
>                         scratch_32 =3D ((scratch_32 & 0xFF000000) >> 24);
>
>                         /* Check Whether subId is 0x11 or 0x12 */
> @@ -898,7 +898,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                                                             O2_SD_FUNC_RE=
G4,
>                                                             &scratch_32);
>                                 if (ret)
> -                                       return ret;
> +                                       goto read_fail;
>
>                                 /* Enable Base Clk setting change */
>                                 scratch_32 |=3D O2_SD_FREG4_ENABLE_CLK_SE=
T;
> @@ -921,7 +921,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_dword(chip->pdev,
>                                             O2_SD_CLK_SETTING, &scratch_3=
2);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>
>                 scratch_32 &=3D ~(0xFF00);
>                 scratch_32 |=3D 0x07E0C800;
> @@ -931,14 +931,14 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip=
 *chip)
>                 ret =3D pci_read_config_dword(chip->pdev,
>                                             O2_SD_CLKREQ, &scratch_32);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch_32 |=3D 0x3;
>                 pci_write_config_dword(chip->pdev, O2_SD_CLKREQ, scratch_=
32);
>
>                 ret =3D pci_read_config_dword(chip->pdev,
>                                             O2_SD_PLL_SETTING, &scratch_3=
2);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>
>                 scratch_32 &=3D ~(0x1F3F070E);
>                 scratch_32 |=3D 0x18270106;
> @@ -949,7 +949,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_dword(chip->pdev,
>                                             O2_SD_CAP_REG2, &scratch_32);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch_32 &=3D ~(0xE0);
>                 pci_write_config_dword(chip->pdev,
>                                        O2_SD_CAP_REG2, scratch_32);
> @@ -961,7 +961,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                            O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x80;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>                 break;
> @@ -971,7 +971,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                 O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>
>                 scratch &=3D 0x7f;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
> @@ -979,7 +979,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                 ret =3D pci_read_config_dword(chip->pdev,
>                                             O2_SD_PLL_SETTING, &scratch_3=
2);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>
>                 if ((scratch_32 & 0xff000000) =3D=3D 0x01000000) {
>                         scratch_32 &=3D 0x0000FFFF;
> @@ -998,7 +998,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip *=
chip)
>                                                     O2_SD_FUNC_REG4,
>                                                     &scratch_32);
>                         if (ret)
> -                               return ret;
> +                               goto read_fail;
>                         scratch_32 |=3D (1 << 22);
>                         pci_write_config_dword(chip->pdev,
>                                                O2_SD_FUNC_REG4, scratch_3=
2);
> @@ -1017,7 +1017,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip=
 *chip)
>                 ret =3D pci_read_config_byte(chip->pdev,
>                                            O2_SD_LOCK_WP, &scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x80;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>                 break;
> @@ -1028,7 +1028,7 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_chip=
 *chip)
>                 /* UnLock WP */
>                 ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &=
scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch &=3D 0x7f;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>
> @@ -1057,13 +1057,16 @@ static int sdhci_pci_o2_probe(struct sdhci_pci_ch=
ip *chip)
>                 /* Lock WP */
>                 ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &=
scratch);
>                 if (ret)
> -                       return ret;
> +                       goto read_fail;
>                 scratch |=3D 0x80;
>                 pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch)=
;
>                 break;
>         }
>
>         return 0;
> +
> +read_fail:
> +       return pcibios_err_to_errno(ret);
>  }
>
>  #ifdef CONFIG_PM_SLEEP
> --
> 2.39.2
>
