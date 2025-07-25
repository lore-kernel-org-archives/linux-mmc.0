Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EB9217F33;
	Fri, 25 Jul 2025 11:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441332; cv=none; b=elMnxAhP3O2JQcKud+1YHEs52mFw4gYBgojeQD1AjtN6Lo2my84zEKl9KPKPvDIt+wpfyNsKXzdDBzkwajRRYUAQ8xCoOJoTRXJoUsNHjky/nxbf05fxWNndygNfvtOEe1nwokF9De9ty/LMZ4vs4b2CiCSgxeVESDV3MyXoB1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441332; c=relaxed/simple;
	bh=Ngio8xfyWIIDwlnM0W+JAkMk7HyR29dVYpj61dVV4ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b1uU4NOu1oX/CK4hLs51r+fbDTOaezgVwLtVooiLlQq6Jfrz12wbiEVcGFWIK5V9X0me3INwuSOafvtxGmekeEwfHMrog8lGqy/+TLUXIDoMhlx1BPXXcmQFY3KzkWFV5WYOqUWk7oFZWzjJv7s0DOWyhZAjA6x8lHO7wHTuvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XJiIzFXc; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XJiIzFXc"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-53140c33563so1293791e0c.3;
        Fri, 25 Jul 2025 04:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753441329; x=1754046129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ihcslW5gx76Wnmrg/L2FGmXABDcUFjb21/r/z7IBkg=;
        b=XJiIzFXcbSUlOdVKOLSBFloURuhSMPMluX2ag01rhZ9qeNuDETt5IcmYxmzhR6xcyS
         btX6vpdQCORjK2Foe1VU5ZFfrfWcFOfgROtsC/dQxOd5yacyi9e0HXB+tJEDfUNLXoca
         LvHlTz7EFPfTysDvnFdd13tIAmxm/W/uf26vZEZ43U0Nzn/glSQrg6hzWiRx6x0d3F4O
         +eWJ4JgvPwu5j2iqwFtvf/gEeUkPLNdW5+fsPxVaJAeDwh1x57Q04BW2ofI3JVOxozyk
         sSMf1oemodbVrCu8zRKAWUQ18lCOnH/1d7EPUQo/8hemHHE3Cpwlx4N8XuhzOihmBaWa
         6czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753441329; x=1754046129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ihcslW5gx76Wnmrg/L2FGmXABDcUFjb21/r/z7IBkg=;
        b=FFYbQ7oq2snfySRrnYaPv000anwZrzXwvKcGNNUb1X2Wkq1MWJZVC21oIkNMiC0kGP
         +P6GWZDF6toJUEhDl2XHzgOXh2ySKjb5LgKRQIZpi78heIlEvwtUb41cw+hOW5YnlJMV
         2HUgxTZTZg0LzyTjA7JRbQbRoLZJbjmJkUl9bzkqETXaF2b+AGoWBNbMDqfDoFmThuCC
         wOAAnGciU2oAKGAQMUtnGpdpgHk/QsrVc/BnHWuLMVzvGG6NExzctR7wYzUs67+fL7DP
         2OK9M82e9tFFO0bGTDjqQ14HpnXymjxZBOJSFSleP0YnFfuamQNQsuDCsRh0tZNZWqW5
         QFqg==
X-Forwarded-Encrypted: i=1; AJvYcCVKD2ThX1x2TxOfKbb00QsmkEwjJh3hx1zIiVLDJNMvto+ykPgdd8IVYYS+TDBoUjhbLYMX12m1hCA1Ms4=@vger.kernel.org, AJvYcCXqipGXuvIufMINMw/MY7iRQQt0hq8WCDOUwLg7ao5/qYF8Xm6dWiMfEvZUdjKvd9FMwYtMutRlxNd5@vger.kernel.org
X-Gm-Message-State: AOJu0YzRHauJ7GYxKBDK3jmn/YyWRjIRG9VTluEr2HEO8GLE9/lzqhVO
	2SyehR5hO74uEL/Y5bOlkrPRwHWs/hsFX1P9SlHuiICo0n0Pn0m3b0Am0buxl7qTnL4Yum7zHVY
	Qs5pXvpLvfeWDDtObB1NsVFnhfDDci2w=
X-Gm-Gg: ASbGncss49ywqEHdk2VCi4MTcrOtdvrwS2IZam+SX1Hwx4Mx6YjDXp5VtneTrFmGZbb
	wv2yO1Xh+TnjG2QSznEybz6yrG5nMWXba0WeSe41ZZWudJndyJgmwpbLU7J1LAg5A3UezSKrg0j
	sYLc4TtMi02E/GyBeiDSh/mKi011e8JIcDLPvsa7XrFXrzUaHCsymTJZCzLhlHPiu8+rPT4kvpz
	nm0OvlefVPo24CvVsb31zPRbfPNfPf9IBZJBsU=
X-Google-Smtp-Source: AGHT+IGQMHgfEY7BuclRsjz6OH/7UgX+5R631hDtSjohy25v3ShupItv1BCYnry5FYvFEIhnzI2+C6EvDM+5V5QrM6A=
X-Received: by 2002:a05:6122:46a8:b0:531:236f:1283 with SMTP id
 71dfb90a1353d-538db602ff1mr319083e0c.10.1753441328963; Fri, 25 Jul 2025
 04:02:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716104334.44020-1-victorshihgli@gmail.com> <d5a0fcf9-4ae0-4d0a-842e-d9475997cdb5@intel.com>
In-Reply-To: <d5a0fcf9-4ae0-4d0a-842e-d9475997cdb5@intel.com>
From: Victor Shih <victorshihgli@gmail.com>
Date: Fri, 25 Jul 2025 19:01:56 +0800
X-Gm-Features: Ac12FXxlVobuRC8ZRTJ3xs8LnvzOZsLYryZXrXwLx982Oskd-13JLoxCmj_N6RQ
Message-ID: <CAK00qKCUPOcSrjSuDyHiVsTUw6we029Uq4UjH2Q+JGuZ0KDOww@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: GL9763e: Mask the replay timer
 timeout of AER
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 7:59=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 16/07/2025 13:43, Victor Shih wrote:
> > From: Victor Shih <victor.shih@genesyslogic.com.tw>
> >
> > Due to a flaw in the hardware design, the GL9763e replay timer frequent=
ly
> > times out when ASPM is enabled. As a result, the warning messages will
> > often appear in the system log when the system accesses the GL9763e
> > PCI config. Therefore, the replay timer timeout must be masked.
> >
> > Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
> > ---
> >  drivers/mmc/host/sdhci-pci-gli.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-=
pci-gli.c
> > index 4c2ae71770f7..eb3954729a3c 100644
> > --- a/drivers/mmc/host/sdhci-pci-gli.c
> > +++ b/drivers/mmc/host/sdhci-pci-gli.c
> > @@ -1754,6 +1754,7 @@ static int gl9763e_add_host(struct sdhci_pci_slot=
 *slot)
> >  static void gli_set_gl9763e(struct sdhci_pci_slot *slot)
> >  {
> >       struct pci_dev *pdev =3D slot->chip->pdev;
> > +     int aer;
> >       u32 value;
> >
> >       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> > @@ -1780,6 +1781,14 @@ static void gli_set_gl9763e(struct sdhci_pci_slo=
t *slot)
> >       value |=3D FIELD_PREP(GLI_9763E_HS400_RXDLY, GLI_9763E_HS400_RXDL=
Y_5);
> >       pci_write_config_dword(pdev, PCIE_GLI_9763E_CLKRXDLY, value);
> >
> > +     /* mask the replay timer timeout of AER */
> > +     aer =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ERR);
> > +     if (aer) {
> > +             pci_read_config_dword(pdev, aer + PCI_ERR_COR_MASK, &valu=
e);
> > +             value |=3D PCI_ERR_COR_REP_TIMER;
> > +             pci_write_config_dword(pdev, aer + PCI_ERR_COR_MASK, valu=
e);
> > +     }
>
> The same code is in gl9750_hw_setting() and gl9755_hw_setting()
> so it could be a separate little function.
>
> Also should gli_set_gl9763e() be renamed gl9763e_hw_setting() for
> consistency?
>
> Also should this have a fixes tag?
>

Hi, Adrian

Ok, I will update in the next version.
I think I should only need the stable tag.

Thanks, Victor Shih

> > +
> >       pci_read_config_dword(pdev, PCIE_GLI_9763E_VHS, &value);
> >       value &=3D ~GLI_9763E_VHS_REV;
> >       value |=3D FIELD_PREP(GLI_9763E_VHS_REV, GLI_9763E_VHS_REV_R);
>
