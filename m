Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B9D26056C;
	Thu, 24 Jul 2025 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753355242; cv=none; b=j7jDaA+uaLEJb8OYv8XdgmdxMHu5EqRYYfYsvGhJb1zKoBlxritHJwIeGlPb5i/y2oP/9y//swHS3yTUQE7BqkrBQ3jINrLNMQ7EdMO4+kySX2J93Zo2EXV071/qU+56uO3atkBbIP03AheUpqihhIVozl2IQ3goBaaw0vmOqPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753355242; c=relaxed/simple;
	bh=Xu48WpKj0SsCQWP/vCqMAOJbDzRPfDPK4MEn1Op/Olk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mc7ZPBTPWsxYN9HbuwxA+JFmNbX+F4ogMaUmqHWtoRYhtGqdcGGx/YQ6GuLtYBUg+ss2lX0nHFvnoqpwZ1FF6ZJN73not4+DL4h0B7RZrhe4+6zfIfZYXS0yYHi+JEGgxYxoskvddHG6Q5Al5ogB9l8tGm7y/pvUMZJwxjpg3c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nfp76cqG; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfp76cqG"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-4e2b5ffb932so258079137.0;
        Thu, 24 Jul 2025 04:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753355239; x=1753960039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MbPVMkEFJD6XkQQplvkRbG2dZqiB1ksd2yrntVRJPnM=;
        b=Nfp76cqGTCwp/DF/hHBTINgpMBXqbtUXQ6jYz8a/+oGIbUOMJsjkAVqbvwinLxjxFW
         oP9Duz5uGMuSxAh9rOsnN9W0J8B8cluIEaAMDy/okNXIhe5Ncz9Y65cBgSqVqvWl161H
         IWofAlDECAh0PAPO28LJkLFuDVx95VlTUZ1H5RihwgiN3aI/lRdDVo3Jw7vJcyOnXpDT
         oF56JKlBo2E3S5+uG6sMYxTvIqjfluJ5pfveP9xHupADZp4N8HkCvK2bB1LOoXt7w8PM
         GexpfQLyWJOASoYh82LpAnJsUSZnKD27LRQ+IuWZAKQLi2+WiuylPmIzfLPDORKegyan
         em/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753355239; x=1753960039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbPVMkEFJD6XkQQplvkRbG2dZqiB1ksd2yrntVRJPnM=;
        b=qHmFKWZ6oGpLqtS23nioGgJrZu8ssJ8iogFBnuUhGIZW89b9FRnURcYQhzjKmHi9+q
         YlIQ3W1h1LyLr1USpG7B1PrlSeooo8UnFgsivTx6BCCqqrbEnhPqtQwyo/rSyUxeLGb+
         dt5yGlgi/5aq1M6k99XuY/oxZHhbw26GvlsZXa2xd2SdhKatRygGBBGULQ4stz2xyrbx
         umz7k92oPRpFBXAaO3iPA3VWrJD4xUhzI7XDVQTVVQI6M2HDtzSmpohjK1QcKGaF9KZf
         0eM21bl0Z5oihD2BX51fTQjXUI3iikQQUlEiRb42G0qgCLUMGQzltdgEp1BXzn2pzEfM
         oNdw==
X-Forwarded-Encrypted: i=1; AJvYcCVEaIWcq+RbhuZ1fXVQE4g6ooBVwJRgANg8nkPPDUqvKo3uHFjZqdttC3rgV/1KBnR3VT6VLKSj5cXGNYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc2dQaVvmaXC/Jnudo7BJ5oBe9dfMbtXzHCLI0/rRkx9OAJf24
	aCZRpxjBvdnouUV2Uf32qIAkoMzCVbMsbeaaeXIJozQ8PmW6FACUk9Fdey9ObYSpUN62hQdAO1T
	h3LrgYiZUMUNlfmZzr4RJZLniNYhVIio=
X-Gm-Gg: ASbGncv21ufrylsbuhgVHt15wro9nC//0242itIEoD+75otmckO6AqpBjb85sT3GbIc
	pDyFxWakMAanUu4e/IIPCIh8QCC40z/HPdCmoK/Htecn9QlR/6wAEAlIEQaCNa6HCdsV5sk48T2
	VAj0CzzeiDafQC2oaX6LviA5BOzOJxJb0jRO1YbmBlXzALouEqGvESuMDbaTtOBoB0SYHH4YEU1
	KmtyOMHCbKTOX/VgBfpQ3ypBSaeSa6/GQCWcb1o64zHoUiveJs=
X-Google-Smtp-Source: AGHT+IHbQScuCfcy9d/Im06JXgoGrv0k2Wa14IPyUvV/QjDXnVixbwCarcR2uPJdlf++LVVFiIIya/cociO1mM4ofqA=
X-Received: by 2002:a05:6102:f10:b0:4df:8259:eab with SMTP id
 ada2fe7eead31-4fa151ee312mr2582077137.19.1753355239410; Thu, 24 Jul 2025
 04:07:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716104334.44020-1-victorshihgli@gmail.com>
In-Reply-To: <20250716104334.44020-1-victorshihgli@gmail.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Thu, 24 Jul 2025 19:07:07 +0800
X-Gm-Features: Ac12FXzQ8sqCHRAiCyvdT--M_8TyMxjlQVWigzFl0KuNyWKROQMrH_6VSTulRT4
Message-ID: <CAK00qKAqLwz17_DKvmcb1nqT8x=YpyUO8_hfTigs=HSkNF=02A@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	benchuanggli@gmail.com, ben.chuang@genesyslogic.com.tw, 
	HL.Liu@genesyslogic.com.tw, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Ulf and Adrian

Please help to review this patch and let me know if there is anything
that needs to be modified.
Thanks.

Thanks, Victor Shih

On Wed, Jul 16, 2025 at 6:43=E2=80=AFPM Victor Shih <victorshihgli@gmail.co=
m> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Due to a flaw in the hardware design, the GL9763e replay timer frequently
> times out when ASPM is enabled. As a result, the warning messages will
> often appear in the system log when the system accesses the GL9763e
> PCI config. Therefore, the replay timer timeout must be masked.
>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pc=
i-gli.c
> index 4c2ae71770f7..eb3954729a3c 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -1754,6 +1754,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot *=
slot)
>  static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
>  {
>         struct pci_dev *pdev =3D slot->chip->pdev;
> +       int aer;
>         u32 value;
>
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> @@ -1780,6 +1781,14 @@ static void gli_set_gl9763e(struct sdhci_pci_slot =
*slot)
>         value |=3D FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDL=
Y_5);
>         pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
>
> +       /* mask the replay timer timeout of AER */
> +       aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> +       if (aer) {
> +               pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &valu=
e);
> +               value |=3D PCI_ERR_COR_REP_TIMER;
> +               pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, valu=
e);
> +       }
> +
>         pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
>         value &=3D ~GLI_9763E_VHS_REV;
>         value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
> --
> 2.43.0
>
