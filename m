Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B93AA512
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 15:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414425; cv=pass; b=NPdsCaWlCi66sika+GT22xFLuFStwz1/ETBLjS3MntWsblJFef4UzaOht+WP26tcEqTB+fgInlL8KeDzpf0cDVdx9UXsscDlOkZ3MYRG4TiUvSSHDnuj+dI0PhTusb8F5UrnO1rwFDQefRzN89AwtzZKAk3yDj4n+eiDB9hGA3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414425; c=relaxed/simple;
	bh=oGY2ctpj9ghSA/kNXN45JoI3buaXV929HHTybkJA4UA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t+2o6qU5LppAZvphFTKHSalXAH6lpDraenq1oFfxWyHvfXUZ0h6Dwp2oP1upu5EZ9RQWdc2rRcvKgtfPjoVrjlrVS4sh/td0/OM11sTJYC2LkVPDQ7TwjipREbT628naeI2WZYwzfjUiEdGlRhWejXowsgS2EcLSMunQSQfUv0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB26FPsk; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB26FPsk"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ae222d87dso2293494d50.2
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 08:07:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773414421; cv=none;
        d=google.com; s=arc-20240605;
        b=cp9LgfGmUcQAX0Upe2bgyC1EFjJVMlg5k2RzlDVFX92av6XQOd/BBIkY9uD8SVm2Ef
         APYdV5hZNh89z/gGMkV9HCEF6n1cCLTaZi8dt4luZ5eFKwueP2vgUcsNuLr9bmAfKUtF
         Wfrw6BHFDpjkJm2KkLy8vUrjadagVUpk+MNwtlvq30o0T06FxFmyFP/Ab/3LBzv6+xbD
         ZetjF8CbYc3oHdJVrvO+6Bsv52vYz3ogni5TSPn/F57Q9yBr/gDy63dEiSwh1KOlnC2t
         t/1sdu+RPpusY1+OiaCRx5ahhFPuwAhUZvxBRDiJrztLr2p+xjEq7fo3vEIQ9zkqo7i4
         0eEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Bwl3bu6QXSYK5p9OS9Lki1nNQiVBfsiIDBhWlq7lhck=;
        fh=R1XXbQcE7nVsPecLqknv2adfeRfYB3N3CxfosPlAXrM=;
        b=gpkqFKzf1NICfA+n0DNRhNDKwqVkWcK3LbfTEpWCNMSV0VjKpGvgqr8/U2r8X6hBaJ
         8r2Xg/f3PHNJ7IBvF+JzLmiCXLRDh/DTqGbuLG7TOJkSd8PzqVW4ngGB4SGD/iYzoUlN
         XhlmaN2cVuaWEguYQNCJqbx6QGleYcg2mO9f0xZAHvJfNcTriig4HwLl/DIFBIdBbWyA
         ii42bCZ7uFUMRr1a05N+pyoUOWJMggO4CX3+gxH8XILl4EjR7uz78JfvY6fh/hVOoUbE
         jcx56ljNf7x0XSVRJZCtXGBvniS6X8ncTmtYxfbGszLhhNTv24Y/wEmvztD3mwEuDh11
         6hpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773414421; x=1774019221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bwl3bu6QXSYK5p9OS9Lki1nNQiVBfsiIDBhWlq7lhck=;
        b=aB26FPskOwIQv1FT7RlgtqMMkfJGmqJ82J02Z3oi0K4iynQCWGcrmZ+7KrdJZCx2LF
         KOu98LRw0bCghMlu58EM0O2h+6p0nrahvzIJHDI2Mf1D+hVVlSisEBFhh1NaY4szpqi4
         YmAFrVNUMOalRXT5d3D3D8TvPlftk5wjQrCclqRkqJWiwf4mUt+Qa/xcLhEWC7xWGLuw
         InWZAyz4BgKS1LCnY0v8pkEZ85M47VhjyQNpxZZJF+X4A3rYJfxF8/RtJYGt2JcVB0AL
         TGXnmNblyMZk5N0UaRDbBkC4Te6hfQ/rR88R4LPlunpG1P0yHCAs/CCDi/+N3El8j+pu
         Rf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773414421; x=1774019221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bwl3bu6QXSYK5p9OS9Lki1nNQiVBfsiIDBhWlq7lhck=;
        b=eOOqvnvgpVBtZE5T2atfAqvvG5aYlKdcNtkKqpISJ34UZPdsYlkZQFsshHMl1bQn6f
         6K/ZC3Z81HgYSoIYQzEUDqqfQyIeAvLXvaclWDCPshZiguMPAP6O8R+q37lwKN1GFbkw
         Ioiizt2YKbVaIhDMTTbvCjxACDEc9tSJvY2cirIdn/7p5MVB5K/fMGRo4zzHZ3kmDvmk
         yjOUdVueS3HkA1C+OIAv/7CrZqTa1/A+k0fSwUERwm127SIySTIbBbsJw39UhAUJl0j3
         OrHfodI19TPAt0OrqRn5QMncbhudRW+5CLXgGFM8Jn6xaUgJ+/VONf/yJsZyoqfvERh8
         KhEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf32C13M/00EKfEH1pQ+A09Jn0YExGAZnfsPCEFOls1Ulfg26ditsyX1qZANlpD2CPMjT9gwyMayM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWqoCI3JEEY7jgqhV6sn/l7/jaRSklx5ZXzDNr0gzkNDv0waSP
	FHnK/YUr+DVkJOoe4UG1xgKQefha92SDDm9Xw61yenZPckiRsYjzb2AVnudKlw66ASF+7OfPY86
	LeNj072hjdny5oAfNv1h9VLmBWnQMidg=
X-Gm-Gg: ATEYQzzSDcn3AGq8CzXpPzDKIEtlej2a37eHDGGH887hzyx09NO1hi1YrrrhRumNlxQ
	XMsj2WFsRm+3Ocn9pdS91EbyUrW4wbJxC+g0KnmMvjcKp/5WDbmdnGE0n69l9z8z9hNcv5Eus0m
	qTbQqrSdy/oTQzRHG5/3CI2ojA0EfXXlhpcK7CV+LE/VQYfFk17hMrnphnybjFCuAwI8OYOf0PN
	peM+r8OutO8XOvjn3Rv8h6ZZMDybit45lsnOrkSSylfWzw97FppEvbj2KXTAma2KqSz1HHGfcSV
	uo+j78NRvY1NlfjLiQ==
X-Received: by 2002:a05:690c:4a08:b0:798:7322:b676 with SMTP id
 00721157ae682-79a1c0cf4d8mr40164837b3.20.1773414421451; Fri, 13 Mar 2026
 08:07:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
 <8e91c86d-ea41-4535-a7cd-5b602c546cb7@baylibre.com> <20260313001940-GKA407679@kernel.org>
 <CABdCQ=Mv-3X8KE1WOWKVTmq+POgJczsL-qFdAyp5qzM6=0s28A@mail.gmail.com> <20260313111108-GKM302167@kernel.org>
In-Reply-To: <20260313111108-GKM302167@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 13 Mar 2026 16:06:49 +0100
X-Gm-Features: AaiRm52ZDS_Bl9kTuuFRUA2s_aJbBWslNAWTIUfq3zQrzhaCgdDVn7wblDGcbW8
Message-ID: <CABdCQ=O9PEXWrPnofK56tGc_KT64PF3QtFGNr-r2Kx_-3Zzi0A@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] riscv: dts: spacemit: k1-orangepi-rv2: add PMIC
 and power infrastructure
To: Yixun Lan <dlan@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El vie, 13 mar 2026 a las 12:11, Yixun Lan (<dlan@kernel.org>) escribi=C3=
=B3:
>
> Hi Iker,
>
> On 10:42 Fri 13 Mar     , Iker Pedrosa wrote:
> > El vie, 13 mar 2026 a las 1:19, Yixun Lan (<dlan@kernel.org>) escribi=
=C3=B3:
> > >
> > > Hi Trevor, Iker,
> > >
> > > On 14:27 Wed 11 Mar     , Trevor Gamblin wrote:
> > > > Hi,
> > > >
> > > > On 2026-03-09 07:40, Iker Pedrosa wrote:
> > > > > Add Spacemit P1 PMIC configuration and board power infrastructure=
 for
> > > > > voltage regulation support.
> > > > >
> > > > > - Add board power regulators (12V input, 4V rail)
> > > > > - Enable I2C8 for PMIC communication
> > > > > - Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
> > > > > - Set up regulator constraints for SD card operation
> > > > >
> > > > > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > > > > ---
> > > > >   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 +++++++++=
+++++++++++++++
> > > > >   1 file changed, 48 insertions(+)
> > > > >
> > > > > diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/a=
rch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > > index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..414b03f5e6480f05f=
5d7eeaaa0afb4e86425ae36 100644
> > > > > --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > > +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > > > @@ -19,6 +19,25 @@ aliases {
> > > > >             ethernet1 =3D &eth1;
> > > > >     };
> > > > >
> > > > > +   reg_dc_in: dc-in-12v {
> > > > > +           compatible =3D "regulator-fixed";
> > > > > +           regulator-name =3D "dc_in_12v";
> > > > > +           regulator-min-microvolt =3D <12000000>;
> > > > > +           regulator-max-microvolt =3D <12000000>;
> > > > > +           regulator-boot-on;
> > > > > +           regulator-always-on;
> > > > > +   };
> > > > > +
> > > > Is this the correct voltage? I don't see a 12V rail in the RV2's
> > > > datasheet, and the board's specifications only indicate a 5V USB-C =
input.
> > >
> > > Right, this should be fixed. Please note Han submitted one version of=
 basic DT for rv2
> > > which I think that series will go in first
> > >
> > > https://lore.kernel.org/r/20260310161853.3900605-1-gaohan@iscas.ac.cn
> > >
> >
> > I'm fine with that. Do we have an estimate of when these changes will
> > land? I'm fine with rebasing once those are merged, but I'd like to
> > continue with the review for the remaining changes in this patch
> > series and I'm unsure on how to proceed.
> >
> For that changes, likely will target v7.1 merge window
>
> You can continue with current version, once that happen, you can rebase .=
.

Ok, that sounds good to me

>
> --
> Yixun Lan (dlan)
