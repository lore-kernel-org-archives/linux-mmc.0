Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1335A393DD7
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881998; cv=none; b=h0/qwn2koWITlKg1Jy57BrJCQj3MVj1AlCAWu6sP0aD1oPP3OnuOXgTo1CbndF5OOqTiz5k7uAPdHWQK7Y8ltHbrD+ZfCTnIHJsA+66ftNsyeIZgde66faZ3ZrDC/DMdNjMC0yemFRmEW5Ifp/9S0SdI7bjArGIw2MAARbaQCKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881998; c=relaxed/simple;
	bh=gLZlyBgtJ3MUjBcqHnvAk4QOs+M/20Vxt09pxiKh9+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D65O5QsAV62VQ/VdB22H30yuP5khfLt/qOahBTQcQLEuUUuGAinp6dKHpqOychieghq8HncM3M5DyrQ7shlT6ysJvO50oYB4Fi3mwACodoIHaGRsu8zyWTDG4BX904ihgtm/qvC13DbA+gmZTCKMba1Wh3117XlUc+gN/VvyME0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U9dL09MU; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U9dL09MU"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-640d4f2f13dso3024676d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762881996; x=1763486796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TewqZFPJESwmo9iMjVP1ZKtGeHrO3yhZIYjcMZGPOps=;
        b=U9dL09MUWEzu0EOrb1Bu/rabKOT4KJEbgAZjnjW/XjoH6tvdVg612Dvx+/Ab4kRG6m
         Q4zRhOlv9D5HARwwouuTJx+Zy+ED0FxNbvxrBBVh6ijKwvF8cxOZmaLUbpaMZ4SnPARq
         MWkc2nxBNxSr5aov5E0nrx26XlCu/hQUqDXJe9Rsn4x9pDKoI7xG0x1jkGeoE6Ry5ZhX
         InQqz9MW90j6deJd63nJuq7NowiIqfFYYhBEuw8vFBHOLzArztHGWbil3jQk5GQExULt
         16dvxEjkCZDTVtJVL08FvMKDbuw5YFfal77ir9gRRb45DUQi0Y3936f1WV0eJEPRVqEF
         t1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762881996; x=1763486796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TewqZFPJESwmo9iMjVP1ZKtGeHrO3yhZIYjcMZGPOps=;
        b=DyHQ2Sxr8dbqACSYEUsOdwq75bV9nYRShVZe/UwQUjLQdGlL/xi/6TL453gnErtr8d
         YtCzS4hXV43CkdbqULAwEBKiOeVRytWXZtZD0PuJEth8s65tkYCffZC54aPU/+9cpKdp
         yQr4vc28bq7bfxTbPonlfImtNIx3cAUaByXniuOzSgpfBWaLuPfprHC6hYslw6DPfGEJ
         8eqVR54nG/XXlB4DEgEzx3qWylVibh0OjvFikZqwLv1o5QHfa8GABQFmnpnjBLY8Odwp
         2cEZrsKevOcAML2phhPtJ/Igro8fOgdn1u6WFxsFkhwmLbWHC64TO2+Ug147HcwA2wL7
         /yUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkIdtSusk7aXHQB5zSbOD31wgTTcuI0KyHpnC4ZoQUGoV2XgRFX+Fy31G8pa48B6LFOAisnAgMm8c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaj8grgtuWaSsgUWTWwY1eW8MHvc2cvUez2q3O2lJEukI+1ZpB
	n/Hecd2xoiOs8bmasIfR+04QDy/7iNeC0FgW2HlcWokj/mNfVUjXMkCuYMDi85JzqY3+Rk0bQRI
	E7xm+RCTpQHyPrsn3yErZIRl9Ab0n7LYYsAtj+z2tgg==
X-Gm-Gg: ASbGnctpEBDZfoE1/UlZu+VebmKD88Td67sQPVY+XTDu3cPDOyAF1iFXhJwxefEzLab
	d4kYHUhSeT4aQCSdeKgOlQvfrOF17ij7faif8mz4HVD9tHrVeF/691WUjYBkZhbE742a+boRgTW
	5TGrdgjDFRyt00uq5CYEU4wal44QU/weepa4h7eZMpxtAlc8xkdKcukQ/f/EqzgfWoMAmHiiyA4
	pvMv7gCgomi6FF60XO45BHarCfaDvw6IqV7PW87JQhMvG8/QEuS67Xqpcw3OA==
X-Google-Smtp-Source: AGHT+IGPocF7U+zZAQlqlm4U4/N/1JnxBlUtxG84oneYZC130a7a22xb7XFY4qOmaI3tdolUZR4tgDVGn4WJ/hb/mMM=
X-Received: by 2002:a53:acc4:0:10b0:640:d9b1:ed1c with SMTP id
 956f58d0204a3-64101a0b3d2mr186156d50.5.1762881995961; Tue, 11 Nov 2025
 09:26:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104200008.940057-1-peter@korsgaard.com> <af77b269-a9e3-470b-a6bf-81636235bf5e@rock-chips.com>
 <87qzud6jq8.fsf@dell.be.48ers.dk> <77ce48fa-dfdf-43c9-8094-c1c47ff48aac@rock-chips.com>
 <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
In-Reply-To: <PH7PR16MB619676787C5B72C51598EFEBE5C5A@PH7PR16MB6196.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:26:00 +0100
X-Gm-Features: AWmQ_bkJkgflFOhtkkZMfWh46zosmM4g5Ncvfw04XYla38k-S58h5OGnXqREsSw
Message-ID: <CAPDyKFp=mY7HprH5J6TnDO10XjyV43QHMovgLsq5oDOr_Lb_nQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
 year/month parsing
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Peter Korsgaard <peter@korsgaard.com>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Avri Altman <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Nov 2025 at 20:58, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Shawn Lin <shawn.lin@rock-chips.com>
> > Sent: Wednesday, November 5, 2025 9:24 AM
> > To: Peter Korsgaard <peter@korsgaard.com>
> > Cc: shawn.lin@rock-chips.com; linux-mmc@vger.kernel.org; Avri Altman
> > <avri.altman@wdc.com>; Ulf Hansson <ulf.hansson@linaro.org>
> > Subject: Re: [PATCH 1/2] mmc-utils: lsmmc.c: print_mmc_cid(): correct
> > year/month parsing
> >
> > CAUTION: This email originated from outside of Sandisk. Do not click on=
 links or
> > open attachments unless you recognize the sender and know that the cont=
ents
> > are safe.
> >
> >
> > =E5=9C=A8 2025/11/05 =E6=98=9F=E6=9C=9F=E4=B8=89 15:07, Peter Korsgaard=
 =E5=86=99=E9=81=93:
> > >>>>>> "Shawn" =3D=3D Shawn Lin <shawn.lin@rock-chips.com> writes:
> > >
> > > Hi,
> > >
> > >   > From the JESD84-B51, section 7.2.7,
> > >
> > >   > For e=E2=80=A2MMC 4.41 and later devices, indicated by a value la=
rger than 4 in
> > >   > EXT_CSD_REV [192], the 4-bit=E2=80=9Cy=E2=80=9D field shall roll =
over after 2012, so
> > >   > that y=3D0 shall be used for 2013. See Table 77 for a list of val=
id y
> > >   > values for specific e=E2=80=A2MMC versions.
> > >
> > >   > So mdt_year + 1997 seems wrong, too.
> > >
> > > That tweak is even not enough, E.G. I see the kernel does:
> > >
> > >         if (card->ext_csd.rev >=3D 5) {
> > >                  /* Adjust production date as per JEDEC JESD84-B451 *=
/
> > >                  if (card->cid.year < 2010)
> > >                          card->cid.year +=3D 16;
> > >
> > > 2009 + 16 =3D 2025, so what will happen in a few months?
> > >
> >
> > TBH, I don't know if there is any update from JEDEC. :)
> Hi,
> Yeah - they noticed that as well and proposed a similar approach by exten=
ding the ext-csd-rev to 9.0.
> I had the code ready for a while now but somehow failed to submit it yet.
> Here it is.
> Thanks for fixing the year-month misplacement.
>
> Thanks,
> Avri
>
>
> From c0e5ec1d3670161444943c8984b6cdafb82fac67 Mon Sep 17 00:00:00 2001
> From: Avri Altman <avri.altman@sandisk.com>
> Date: Thu, 13 Mar 2025 10:10:49 +0200
> Subject: [PATCH] mmc: core: Adjust MDT beyond 2025
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> JEDEC JC64.1 proposal, which was recently approved, increases the
> manufacturing year limit for eMMC devices. The eMMC manufacturing year
> is stored in a 4-bit field in the CID register. Originally, it covered
> 1997=E2=80=932012. Later, with EXT_CSD_REV=3D8, it was extended up to 202=
5. Now,
> with EXT_CSD_REV=3D9, the range is rolled over by another 16 years, up to
> 2038.
>
> The mapping is as follows:
>
> | cid[8..11] | ver =E2=89=A4 4 | rev > 4 | rev > 8 |
> |------------|---------|---------|---------|
> | 0          | 1997    | 2013    | 2029    |
> | 1          | 1998    | 2014    | 2030    |
> | 2          | 1999    | 2015    | 2031    |
> | 3          | 2000    | 2016    | 2032    |
> | 4          | 2001    | 2017    | 2033    |
> | 5          | 2002    | 2018    | 2034    |
> | 6          | 2003    | 2019    | 2035    |
> | 7          | 2004    | 2020    | 2036    |
> | 8          | 2005    | 2021    | 2037    |
> | 9          | 2006    | 2022    | 2038    |
> | 10         | 2007    | 2023    |         |
> | 11         | 2008    | 2024    |         |
> | 12         | 2009    | 2025    |         |
> | 13         | 2010    |         | 2026    |
> | 14         | 2011    |         | 2027    |
> | 15         | 2012    |         | 2028    |
>
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Avri, would you mind re-submit the patch so I can pick it up via the
patch tracker, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 3e7d9437477c..8f355a72b84c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -672,6 +672,13 @@ static int mmc_decode_ext_csd(struct mmc_card *card,=
 u8 *ext_csd)
>                                         (card->ext_csd.rel_param &
>                                          EXT_CSD_WR_REL_PARAM_EN_RPMB_REL=
_WR);
>         }
> +
> +       if (card->ext_csd.rev >=3D 9) {
> +               /* Adjust production date as per JEDEC JC64.1 */
> +               if (card->cid.year < 2023)
> +                       card->cid.year +=3D 16;
> +       }
> +
>  out:
>         return err;
>  }
> --
> 2.34.1
>
>
