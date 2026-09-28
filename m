Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693E92652B2
	for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 12:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598637; cv=pass; b=ao992AoCbIdKi7/zlK9hW1yLuTf/zT222ne1XCiyG8fOmVTyX+eI+w3JlA3209mufQnWJ0jjuv+9T3jlva4fO89WZaQJo1LeYnhiHBkDHPWe5ANXH++vJNXnqNBPT/sTNGIiozLnFYQhsnsgw0i3a1XKXAKmKI5U1xzNTM0Bg60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598637; c=relaxed/simple;
	bh=huKQAayLatyglgFbqKm96EgnqJce6Ukx2wu42Xr6OGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZitCgKl7xM8cTjDa6m2pTfv6Ff3GjClDItQob2dfhxMBTLTv81xZHBaH7RI8mtO3qDd2EE7Ldw5LvH1jdeigxgn8yUxracMQYAtNxg/1ojcjHj0ULbMat7sUI8e1sU+khoiz5Wcg8AQO8YInv2PlOU0kBjvC33XwpFfLxljAbm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=qZhw9SfX; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="qZhw9SfX"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df964b6893so12832055ad.2
        for <linux-mmc@vger.kernel.org>; Mon, 28 Sep 2026 05:30:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598634; cv=none;
        d=google.com; s=arc-20260327;
        b=d+bFC9UPRuNyTD2n9dix64bf3qCl0164rm30bTAB4rjC+eJXWHUpIQzAqOu6FyZHR3
         A+F0OJ+3Qso/qM0NRCpmQCJSDKiSrWw5ZIUz+QnARg7XVyqXe4ieQ6f+TqEkNFQWXiRX
         hcGxNl6FLm20DpGrVPiEHOulsWJtqpaocyIPsuWWA86g8m5EBNbUJXvTMTQMUlwRh30k
         RB8bL6WYZKrt17cTGtMGrR1Ih7abFTDpnOEurj5VTodDzSqoDy3cfuZEegrzu4TAqfkj
         f9FsAAzhpakIubYhe0RHXMWdt1uetn34CDBS66wAivmF8pR4COPH88PD107NCN9x90Al
         tWYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XTyKOTKAooo2ab7rKhntAizVnn77+wfpctlc2hgSt4A=;
        fh=1DWhmA1+bWxLT8DaAeKeShBCiXXw6cKNIwiLrIfxv7M=;
        b=C9AP3y16+bWv2MTf5mzqliHe60BkaNkJElc02XV7MTgpmlf/MJdflj6Gqcx+ASNxJP
         ZHVucd2qCsihS5DLQLAt7XJeHMfZ+ndb5otk55Np0huS/Yjtp8Woi2cJvOzZA7wy5/pj
         GkxcdJD1IV5KLJ0f/dDlHCbE+2wF0Nij55/jjFLm4EfMxz1DhNGYDkU/1sphbj1lNPsC
         PpMMk0d5frHmDp1h4ncBuuYlOiz/+r5DxNKw0buXe90q22/71X3zeiw0Ki/HqUYymyG4
         Ji6ucr8sgnnH+mOyrfxNgedanoQdGzn0GnWJxcuND+39SpHYqcAxXYE91IUs0P5yT6eA
         Pb/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790598634; x=1791203434; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTyKOTKAooo2ab7rKhntAizVnn77+wfpctlc2hgSt4A=;
        b=qZhw9SfXzomlQg37NZRw1Gf46SkuvQpa1N6CnCdxoIZFJp2k0xVBzXcqYZZThhROeH
         SfRmjmxGCBGAmWrK0LNQPrTvqOquGpkS7TpdvIZQC2Jr2atdg4duBMcf6150KRFfQiVh
         oZdFJnDL85s5C3W5/iEFSEaC22TJDPQtDQ2ZkzvBYtUQfKAjwS1DofdgR2qgqGNOfgs7
         2OyVBIOIZ0dp6moCcgIWp5GAZbHF2MpOFofvVZg78+myDy5r2PCMokAnjmVe+NjznNhZ
         U//VZZkqcqzP+Kf0IcBShcvIsrixiAl4sRZZNaEaIaGoIshANK2HXq5NIJVroLgcsbCE
         8RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598634; x=1791203434;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTyKOTKAooo2ab7rKhntAizVnn77+wfpctlc2hgSt4A=;
        b=1T2kr17Ao2W0+j1K6NGyGVoSkw7yBbISbAStAIzWdu7BFJBabkJZ+bhtq2ZeHxb2I8
         w9NuoUDY4NCIJpB26JBTIiJY7/rYyh27tGRQfcfyCbDplrTp3Brl3+Alrc9RXvupsX5G
         rL8ZcAOfD8OxNrLocYm/GO+HIxhTG8KtHJYpxLXcQbG8I+pp3b/LaC7JOMdNKmwayn4N
         5hP8V1+U0JK7mp+VkwGWzyWdgj3UeO3/IPgZIfDd2IEjC74G75G/dztfSsh6ZZ1dzpCG
         Hjw2iRx5Jvzoy1ZKh8Fh2LNC6tA3eZWmFywhFdReXVY+V1BUtA38RYo5mMdr7wmTIbE8
         TM6Q==
X-Forwarded-Encrypted: i=1; AKwUvBy9W94jdzwnNLG6PBlDoUnusio9i8vB0QH7yMbtnFaEZdsf0gkUnMLFqBO6NUuvP19pbc4iZzDhEK8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLYnVLJZvNqBW++56gUX/4AE8GYpvsY+3XlA0Mk+srpvpWYRpt
	4UlzRhMJuqytUgQecE2sMnn5+0ZtYxpQ9be5aklmFIcI1Fv4cucvWqrTbDEqneXpshKA5zCR72C
	30F1LCpi6TxLXgn/bg3IIC4jCbm+WDR71rQ5D93v5ow==
X-Gm-Gg: AYBFou18RhzS3DvCKcZm90z3UoFHp1RMF4KMRGV/DgAhNE7sHVxv06XRNkm7kap3Smu
	0BcqzN4Np3UNtmJCiCMEEGEFTHqQcxdpyYzYJF9fr4FtcGpI3TL3XVovk3EYBdJ6ZWLpRjGh9Sp
	06Dl6t+TacBlemjUtg5Q22wBK95y2jevA58Lr7p6QQmavDmHzK9hmHIyV/vtImuK2bDSYzbdND8
	eCptxhpjmDRioZV30LUoB6q9k2oeQKDp2wpOskgHZE5KD4Cb1/yyvvf4sEUrkf5x79KOKunCZzT
	Xyrb9/UHobhX+5LzUAk83XNhXHAAn8KDzZCrJazc4wV4iBs97Z5RFh0P00Ivii49LDiGzWRMVPQ
	IwA5nJAvQMrIQO/Dzj7pyMZVfZdt0LTNvnek=
X-Received: by 2002:a17:902:f54a:b0:2df:736b:d7df with SMTP id
 d9443c01a7336-2df7dc59ed3mr102946795ad.42.1790598633625; Mon, 28 Sep 2026
 05:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907132617.1198548-1-robert.marko@sartura.hr>
 <20260907132617.1198548-6-robert.marko@sartura.hr> <tl5ep4ze2e5ctv7c47jsjedvcpnibdspo5az7a73i5p7iwbivk@vbtd4rhtvroa>
In-Reply-To: <tl5ep4ze2e5ctv7c47jsjedvcpnibdspo5az7a73i5p7iwbivk@vbtd4rhtvroa>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 28 Sep 2026 14:30:22 +0200
X-Gm-Features: AclHuK_ApYIEoqpVKRFrihxpibz6Yiy03tz8KYmapFitKvFghmCeqBLThyFR5Fc
Message-ID: <CA+HBbNFRufMuhuSiPnJSgSMrGMN6DeskS3kLLogwHk97oHzx1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] arm64: dts: microchip: ev23x71a: enable QSPI
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: ulfh@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
	claudiu.beznea@tuxon.dev, adrian.hunter@intel.com, 
	aubin.constans@microchip.com, ehristev@kernel.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 10:09=E2=80=AFAM Claudiu Beznea
<claudiu.beznea@kernel.org> wrote:
>
> On Mon, Sep 07, 2026 at 03:25:33PM +0200, Robert Marko wrote:
> > Enable the QSPI controller and describe the onboard SPI NOR flash.
> >
> > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
>
> Missing '---'
>
> >
> >  .../arm64/boot/dts/microchip/lan9696-ev23x71a.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts b/arch/=
arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> > index 4012ea7d07bb..985ca31e74e7 100644
> > --- a/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> > +++ b/arch/arm64/boot/dts/microchip/lan9696-ev23x71a.dts
> > @@ -463,6 +463,21 @@ phy27: phy@27 {
> >       };
> >  };
> >
> > +&qspi0 {
> > +     status =3D "okay";
> > +
> > +     flash@0 {
> > +             compatible =3D "jedec,spi-nor";
> > +             reg =3D <0>;
> > +             spi-max-frequency =3D <100000000>;
> > +             #address-cells =3D <1>;
> > +             #size-cells =3D <1>;
>
> As sashiko pointed out, #address-cells, #size-cells, should not be
> necessary here. I dropped them and applied to microchip-dt64.

Thanks,
Will drop it from future v3 then.

Regards,
Robert
>
> Thank you,
> Claudiu



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
