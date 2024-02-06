Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4639812F5A1
	for <linux-mmc@vger.kernel.org>; Tue,  6 Feb 2024 11:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707217905; cv=none; b=jmOjZSpjs+KxBwgzpTaZzIq7YTOX+BjKFF5Vmb3YgLV2jx6h54G78AKu4LS3yh7nh8wGvMtX7kV0ci6D52CLnxH4LzhF8J2PsqQ1SUclWQDaYmLSCLAV8dYKxRggNM4udS9GvRcv4nVhgbR2wdhfhE+IqkVWaHYvKjUHjjzdKDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707217905; c=relaxed/simple;
	bh=gmSIAQ9DDt05bVHI/NtIKKyGCA9vdcu0iTDtCnZuS08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHT7PRPv2vtJHPOf+QpNZddfLAkag+RJe7qUYaZAOCBJ+Z5XZouzA53ot0zn3IK3Bk/Zgfggn7MZUjLz/uqnIWTqO3By0YtWWSvalKhUqCY9e2t/y1tQbtOhhMH7Gf65CF30N06vbOcpRsBXLocHZaVpSoZV1qEB8HpB7z2dHhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xo49biKp; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xo49biKp"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6040a879e1eso56747977b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 06 Feb 2024 03:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707217902; x=1707822702; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XszTxuvZN7yutGqIMAbw2TChYscmOcb11NQ6LeH5TfU=;
        b=xo49biKp1DFUQiBdTI9//Hr2YX32SKwuenGeI49gOUCs1VvTxv76O4G0L8Zpyk4s3l
         ca3uNaMXzDejadm/eeURQbbHQ0Wu5duRLELrRRVaZI/Lsy6HmHXVaKTkiINWlWdZo1mg
         05BoMGGdlP53gQVcv3EuuoHa1N5iGchx0ANToSlppiHLi10pmSoKIxaPqYxJwj/uxeo8
         0qrPaH3kzNe7w3pP0eMlBKqqaHTJoboz/bGTPsXJwgq3zuxl/QuKG7rXeDJrsHYiQvP2
         xs8t5mDbHf/q/dqDO4BbX2OOYd8RRce9dRvUMU3tPnanlnlv2gEOw26g8qdOQluBPD7X
         iWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707217902; x=1707822702;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XszTxuvZN7yutGqIMAbw2TChYscmOcb11NQ6LeH5TfU=;
        b=Kf7JO8n9q24+yeaXB/koY4kkXd9eSJqZjUCRqd/6Gcl3YFeaBdoW7tKJyPhDbzvJcQ
         s4wN+PonJ0GqGSuc7hLBZzcpWWBZ6EoiHEXh4Z6XfmK+90b92b5vLbXX7OsbeGNllpja
         x0v1GzvO2nD/Rc5HgnXIph6du6+FGgPYYWSzVxJ+mVAKyzoLVJbTg/h8JtVNPuvERIWv
         3keonDLOsBDvum090CInOA2oqCbMdnTcSMvksaK+cUhx1CcAjnrNe6RgXlaMlY0IRVUm
         aQa+2TVOfiiNx+31cljto1g2rWkA5qNFUWqdCoKcqstgmuhYTKsRfC/0ySiBwmLqZUPV
         icMg==
X-Gm-Message-State: AOJu0YyGHyTjqvg2LP06iCdNbSI+H86wC7rU16d7JHPQd5Kp8gFH89De
	3jJC/Stvfnbk4PVrYvHuqbC4K6PCv+mPv5fvn3wD/zCHwGkNsuoR9bgJUPPTTUz5g8kuuYw4tTt
	WSYezGgHB1LqFn/nyQctZ6sWokcKXYXN+CIR+Pw==
X-Google-Smtp-Source: AGHT+IGgEXecA09I+DXSWsEDl7V9PWcXhzjau1SbZnCeOgepIMJn2tM0EGMqrpp6CMZ2C7FYvkOO0VuCrRyGOrOtdns=
X-Received: by 2002:a81:4956:0:b0:5ff:a52b:55ac with SMTP id
 w83-20020a814956000000b005ffa52b55acmr1274510ywa.34.1707217902072; Tue, 06
 Feb 2024 03:11:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203102908.4683-1-fredaibayhubtech@126.com>
 <CAPDyKFrt80WPeCGJZsQaCsN5a+95ru6rKnQb3kPODMkU1G6Ocw@mail.gmail.com> <BL3PR16MB45709A1A9FC4BA160398E2E399462@BL3PR16MB4570.namprd16.prod.outlook.com>
In-Reply-To: <BL3PR16MB45709A1A9FC4BA160398E2E399462@BL3PR16MB4570.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 6 Feb 2024 12:11:05 +0100
Message-ID: <CAPDyKFqbERic78wnh_jWzzByd2+YmZJ_fJ=fqxrarRnB1m5RSA@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix a warm reboot issue
 that disk can't be detected by BIOS
To: "Fred Ai(WH)" <fred.ai@bayhubtech.com>
Cc: "fredaibayhubtech@126.com" <fredaibayhubtech@126.com>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux.kernel@vger.kernel.org" <linux.kernel@vger.kernel.org>, 
	"Shaper Liu (WH)" <shaper.liu@bayhubtech.com>, "Chevron Li (WH)" <chevron.li@bayhubtech.com>, 
	"XiaoGuang Yu (WH)" <xiaoguang.yu@bayhubtech.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Feb 2024 at 07:43, Fred Ai(WH) <fred.ai@bayhubtech.com> wrote:
>
> Hi Uffe
> I fixed this issue was based on below commit history.
>
> commit 4be33cf187036744b4ed84824e7157cfc09c6f4c (HEAD)
> Author: Fred Ai <fred.ai@bayhubtech.com>
> Date:   Mon Dec 20 20:09:40 2021 -0800
>
>     mmc: sdhci-pci-o2micro: Improve card input timing at SDR104/HS200 mod=
e
>
>     Card input timing is margin, need to adjust the hold timing of card i=
nput.
>
>     Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
>     Link: https://lore.kernel.org/r/20211221040940.484-1-fred.ai@bayhubte=
ch.com
>     Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Best regards
> Fred

Thanks Fred,

Patch applied for fixes with a fixes-tag according to the above and by
adding a stable tag, thanks!

Kind regards
Uffe

>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: Ulf Hansson <ulf.hansson@linaro.org>
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2024=E5=B9=B42=E6=9C=885=E6=97=A5 2=
3:28
> =E6=94=B6=E4=BB=B6=E4=BA=BA: fredaibayhubtech@126.com
> =E6=8A=84=E9=80=81: adrian.hunter@intel.com; linux-mmc@vger.kernel.org; l=
inux.kernel@vger.kernel.org; Shaper Liu (WH) <shaper.liu@bayhubtech.com>; C=
hevron Li (WH) <chevron.li@bayhubtech.com>; XiaoGuang Yu (WH) <xiaoguang.yu=
@bayhubtech.com>; Fred Ai(WH) <fred.ai@bayhubtech.com>
> =E4=B8=BB=E9=A2=98: Re: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix a warm=
 reboot issue that disk can't be detected by BIOS
>
> On Sat, 3 Feb 2024 at 11:29, <fredaibayhubtech@126.com> wrote:
> >
> > From: Fred Ai <fred.ai@bayhubtech.com>
> >
> > Driver shall switch clock source from DLL clock to OPE clock when
> > power off card to ensure that card can be identified with OPE clock by
> > BIOS.
> >
> > Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
>
> I assume we want a stable tag to be added to this, but perhaps we can als=
o add a fixes tag? In that case, what is the commit this is fixing?
>
> Kind regards
> Uffe
>
> > ---
> > Change in V1:
> > Implement the "set_power" callback in sdhci_ops, then switch PCR
> > register 0x354 clock source back to OPE clock when power off card.
> > ---
> >  drivers/mmc/host/sdhci-pci-o2micro.c | 30
> > ++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c
> > b/drivers/mmc/host/sdhci-pci-o2micro.c
> > index 7bfee28116af..d4a02184784a 100644
> > --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> > +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> > @@ -693,6 +693,35 @@ static int sdhci_pci_o2_init_sd_express(struct mmc=
_host *mmc, struct mmc_ios *io
> >         return 0;
> >  }
> >
> > +static void sdhci_pci_o2_set_power(struct sdhci_host *host, unsigned
> > +char mode,  unsigned short vdd) {
> > +       struct sdhci_pci_chip *chip;
> > +       struct sdhci_pci_slot *slot =3D sdhci_priv(host);
> > +       u32 scratch_32 =3D 0;
> > +       u8 scratch_8 =3D 0;
> > +
> > +       chip =3D slot->chip;
> > +
> > +       if (mode =3D=3D MMC_POWER_OFF) {
> > +               /* UnLock WP */
> > +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratc=
h_8);
> > +               scratch_8 &=3D 0x7f;
> > +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP,
> > + scratch_8);
> > +
> > +               /* Set PCR 0x354[16] to switch Clock Source back to OPE=
 Clock */
> > +               pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOUR=
CE_SWITCH, &scratch_32);
> > +               scratch_32 &=3D ~(O2_SD_SEL_DLL);
> > +               pci_write_config_dword(chip->pdev,
> > + O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
> > +
> > +               /* Lock WP */
> > +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratc=
h_8);
> > +               scratch_8 |=3D 0x80;
> > +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratc=
h_8);
> > +       }
> > +
> > +       sdhci_set_power(host, mode, vdd); }
> > +
> >  static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)  {
> >         struct sdhci_pci_chip *chip;
> > @@ -1051,6 +1080,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops =
=3D {
> >         .set_bus_width =3D sdhci_set_bus_width,
> >         .reset =3D sdhci_reset,
> >         .set_uhs_signaling =3D sdhci_set_uhs_signaling,
> > +       .set_power =3D sdhci_pci_o2_set_power,
> >  };
> >
> >  const struct sdhci_pci_fixes sdhci_o2 =3D {
> >
> > base-commit: 56897d51886fa7e9f034ff26128eb09f1b811594
> > --
> > 2.25.1
> >
