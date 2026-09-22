Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7413D5349D6
	for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079008; cv=pass; b=Xc6kK39Zy0jeLrbgkA+29baaDzTE+zQ6Eng2Q3BbbUGeNSygpsZpLM+J20YAWMeqs3Td/Not7oimKjQDB6Wr+Jkgf8MkrwLq8S4wXO3ArKgaKWRDTmCvt/WnS2nFcKR65FHiktUEH3wQJaWIW8C20pi1oQr4E7Jhf8DH/2yavQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079008; c=relaxed/simple;
	bh=EEicGhaPn1nMCsQoVuKYMwhQ6GyzIikHfbYLcTzbN20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E00Fp/5CISU+zcV5CE28O5bGYwM3IGJLwkJtFBWqV592hfh8z9S1j6DIqSG+EXJNihJgtbEw45X5bbeZrHepdXZG94Pe212eO54F6vSGJiVKxBhZDqbziPTfH3/vrN+1v5++njYIlQfhlYTpetX6EvlLEElU5iurz5tuvbLGQEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=dlsCwRIm; arc=pass smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="dlsCwRIm"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87ac7657a24so954654b3a.3
        for <linux-mmc@vger.kernel.org>; Tue, 22 Sep 2026 05:10:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790079007; cv=none;
        d=google.com; s=arc-20260327;
        b=gOQE+vy3mU+qWeulPohcFz0lrRosUdWjZDt/JeQYF7YbtsOblAo9kGRC3/I6rcOecZ
         XcsOLITgdQJK/TCxFtV/ir7dLmry6po1DltMTIIFbVvffjCgahs3KgC17IrMImKzV7uH
         AuNNtaTlY9rMZiW+w2EtjuMGR618tihY2DOsNLBp1vRu+dA4fv57R9Z2XeIA+Xa9E5Eb
         4PFQEBwj4OSuO+UHLaPdlK+wQ8eo5ZMpXMH6lONIpLWUqh+ZlL7Q5ccJ23q+7F1HI5dK
         cdyQhjsIMNHkGFkds5GNGU9ZA0Vs4xvgUIYV/fwKoikjN83XlGqNmXJXfjRUY2eXjYgX
         S64w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YqZypLrUWsygd/HKyP66Nb8yxEOESbP2MWGoMZWSdRg=;
        fh=MSJh2AvvlR83/DiUp5N2RLohItkdyc9j8BvFSatUnXA=;
        b=kxzUtrH7Iz+pYtUNvkH9TPeaqVSlvIPj/+KEg0C55e33iXeufpWeHbSIxZzl88nPGC
         u23LfxoWGatsBY4IUlUFf8PXmr8uoe7KNmWApZTt/pIsJCCr5xySDNgu4Bci4ktkzjOa
         doy3CRHbHA8AoUgx2Y4s8VsxaRLL6j1AGNlP4KtplbWfZpEiWpfElvcN+fokPjbwfIkm
         IIO8bQPSE2qPeyQghAOaqdAenT5jUATuXIOwE+VXOsS+IRIqI7BIKvajFJJpBtZWA0cO
         SlHuVqZ2IzqwYUGhdcLbaONttoq7mRmqcwCeCr3RlFX9SsMZT8LKCybLmbamrkNo0KhU
         HN9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790079007; x=1790683807; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YqZypLrUWsygd/HKyP66Nb8yxEOESbP2MWGoMZWSdRg=;
        b=dlsCwRIm4HVRezPlXgMjqL2pwFl3y7jEdYHkWisPlod+xjNJOXLjGgx/ai7bwzBAp0
         4S/E3YvWDP2zUQqrq3yOsIQeU5RwYHMwL8Q5ZpPNoSntHmAGNX+vcHz1CyJ+iU/4QTY9
         QP0DIWJ+CFIpazkjDeUCbJdiTNi43nM8h2xxvR12JmftguwKzG4WRc4m4cb4MsmL8X6Z
         zFSGwDcOeuUNlGfdWN1wCSKmJHk0+tnRnfId7s0EnZCAJHEqu9iflxD/D8k2q/nTe5XA
         QFUR8YG/YIh4ZVXTP+rjpgLEE8nY6EZGEMOngbUIpk2dU1CB905tM6h1tBS4v54QJ2Dh
         gIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790079007; x=1790683807;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YqZypLrUWsygd/HKyP66Nb8yxEOESbP2MWGoMZWSdRg=;
        b=QWjHYZF2h0k4X/alhpUOFdP1AxInchMck14+u7k+WI03XfQbeh4QIBLqB2k9Aj+ey9
         FeG0X9LCFxkZiiBvZOg3tyljITgAzIdjzkPLIsNCKO1h1kdzmgVZvh3Eyi5UQlSZSdl3
         1mywKZ6iSGyJJI1FCodpUeUaTXlXsJqOLGzxtqeFS/b6rDwW2cZsiqmdQ4WesnDbGFvW
         Z7wZO5RLayaRwV4gETDxFzgC9gWcA7pCom2knQjIMDKkl52vWY865TeHPLuEWa/22Jlo
         yLv1+K6olH6V95Vu3fs2nFOPV4ZvEkO3DsKjCDCEPME6+AgJcgqa8OILC2a0xPi4XWM5
         eHiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJm1zUGz70rc5o+cq06fBdm9mM/EiRN5ie3D3D6fTgsEO2D4kkcwDni4Kod9Is5msZiM8cNcdRzxs=@vger.kernel.org
X-Gm-Message-State: AFuF++mCiT3iOBe81GdSSFLk5OMEnMZRsptRs/4qBqieUDKuzmhxQu/m
	r8SPDFXWQa45gwvLNw/+EF76gofOrW8EMXnfolJkLc0LtTTwoIbT+IVBv2nEr8imCPVeuNSGd4s
	UwN5b0GBJrxgiJ3RSHptR46Bfn3i2/0a1ojMUkkKfZw==
X-Gm-Gg: AYBFou0MQCLg2q6klvmu/3OagYtOQGb5OejdAyj6RfZxCNzV69sDYpJn8IwDTMUv3FM
	R11FRlaqabn+o4A4sxWFmqE8SSMb9AghzofX/pIYPtwjMUdow79xWOOYWf1k4nuemKd8cGZQXrU
	k0rbvRq6JgNd5I08Gk1uAe6zYfYZT506HfHoXSoqNMzImhvkYa2r7+8m2ZF6sC9G5z+eVCyhaZm
	7SH5IHz9Kx7ExuwfSPwDV/t0ZRBdWfsPR24FJf7J2xw7yxhObzNYzAOTEp+K8wwrIV7+FJUwbg/
	T28gofs70w0nttacdeNE++UZtp6fJnEAc3Ut819TCwaLqLMR39CWF67mljB8x9S6TQzs5LuasxL
	9chgDayF7ZBICfzc5NDS5fCL59pLRy4lJQUA=
X-Received: by 2002:a05:6a00:3a25:b0:878:34d7:69a1 with SMTP id
 d2e1a72fcca58-87c8472a93dmr1072253b3a.49.1790079006604; Tue, 22 Sep 2026
 05:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-4-robert.marko@sartura.hr> <2d7a6e8b-029a-4b9e-b7d4-8b7e96ea6aa0@intel.com>
In-Reply-To: <2d7a6e8b-029a-4b9e-b7d4-8b7e96ea6aa0@intel.com>
From: Robert Marko <robert.marko@sartura.hr>
Date: Tue, 22 Sep 2026 14:09:55 +0200
X-Gm-Features: AcwNN1WXi_VCQa282Ypqp9POkhX7gCRsmqb0WReRGFy-rkyIzQdlxyeytRee81g
Message-ID: <CA+HBbNHz4_HTMHPv8wPGq_6UP+S_RbfcToAt6W_GN57aB5hG1A@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] mmc: sdhci-of-at91: add LAN969x support
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, aubin.constans@microchip.com, ehristev@kernel.org, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 12:42=E2=80=AFPM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> On 07/09/2026 16:25, Robert Marko wrote:
> > LAN969x uses the same internally generated base clock layout as SAM9X60=
,
> > but its SDMMC controller stops responding when runtime PM gates its clo=
cks.
> > Software resets then fail to complete and the internal SDHCI clock neve=
r
> > stabilises, causing subsequent I/O requests to time out.
>
> Is this a known issue of the SoC?  Is there perhaps a hardware reset
> for the controller that would bring it back to life?

Hi Adrian,
It seems like the controller was reused from SAMA7G5, which shares the
same behaviour.
Unfortunately, there is no HW reset for the controller.

>
> Does that mean unbind and rebind of the device from the driver
> also does not work?

It works as long as we avoid disabling the clocks.

Regards,
Robert

>
> >
> > Add LAN969x-specific SoC data using the SAM9X60 clock layout and select=
 the
> > option to leave its clocks enabled across runtime suspend.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> >
> >  drivers/mmc/host/sdhci-of-at91.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-=
of-at91.c
> > index b7e2a89da348..e7affca8da25 100644
> > --- a/drivers/mmc/host/sdhci-of-at91.c
> > +++ b/drivers/mmc/host/sdhci-of-at91.c
> > @@ -158,9 +158,17 @@ static const struct sdhci_at91_soc_data soc_data_s=
am9x60 =3D {
> >       .divider_for_baseclk =3D 2,
> >  };
> >
> > +static const struct sdhci_at91_soc_data soc_data_lan969x =3D {
> > +     .pdata =3D &sdhci_sama5d2_pdata,
> > +     .baseclk_is_generated_internally =3D true,
>
> Should be a comment here explaining the issue that needs
> keep_clks_on =3D true
>
> > +     .keep_clks_on =3D true,
> > +     .divider_for_baseclk =3D 2,
> > +};
> > +
> >  static const struct of_device_id sdhci_at91_dt_match[] =3D {
> >       { .compatible =3D "atmel,sama5d2-sdhci", .data =3D &soc_data_sama=
5d2 },
> >       { .compatible =3D "microchip,sam9x60-sdhci", .data =3D &soc_data_=
sam9x60 },
> > +     { .compatible =3D "microchip,lan9691-sdhci", .data =3D &soc_data_=
lan969x },
> >       {}
> >  };
> >  MODULE_DEVICE_TABLE(of, sdhci_at91_dt_match);
>


--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
