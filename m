Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401601A681C
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 09:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773394940; cv=pass; b=HN5bQaQ0kQip+WLhL6+4ZkQmiEYORiJq0cUdlcgGmU4n3X+MySSzCONv/xwsPYHwYq3/YwDqp7v3W6lMj/wz4ojqVd8zVVjZjfE9qJL2Vq6FgZz8p6OXoGfKktspPurXnHqHSFaElKVpJxuRX3lx1PdRuKpcCxXyKiCFWb18Fu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773394940; c=relaxed/simple;
	bh=MfYGZ05oe5Hl1+CugXl52UD3u1IznX83KLBTqcRp3jw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mn3uRWq1RULO0yOZynyWMZoQgabrhdraDS7OkwVPT/siAfRBKq0jq5K4fRyUnV7Q6TULJ4FIQYiS4lE7GRCs9tKcWom0/XmegktjF+yvVGQZYpaSi7B0ELoSY0Ou0MfIp2FEdZNdPUK9UqjKM3qwhF46tcjHp030JiBJ3p1dAIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBUcl/ao; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBUcl/ao"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7986d231b3cso46245077b3.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 02:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773394938; cv=none;
        d=google.com; s=arc-20240605;
        b=hWNzLICMAMPxqSf/TfEOKBQExzNI9xCSD9vdfKdkrCE44Qf5wIKsM0NFprYwNxpEUL
         b3wQZpRPHX/uJ9iojo9BEgRxNTPAYs95MXV1Mzqe6ImuXnUzkIko0+gBVw/TqW5a08yV
         kqV1FotXYaNOax0Z5rxt5gGbHTHX/H7x8A/WosGCBD+2w4DsltTI1ipz0yEYOyCCKd6c
         pP0aH8Gk9/gY86lcdzzskVkNmF99daoktR7JjmqHvgUV1JtDwseCYaPVbLMwysfCisgu
         yKUrl7cexyTNyIAWBo4Je5nnxWzEPwCSLKokS/0fz6UmmhSa64M9yz/NBFxqMRm3Oejz
         kNXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3WjmletplWN85DKdqz792fPfJhrtfvngbL64ZSg/oZw=;
        fh=CPzUFXZTg+zP+1yu+amvpr6DXEBguRKwp9rD8KfRJOA=;
        b=e1XiNhW7iPk/vmnx1sw8w4aB9o0wEC2pkJ1z8SiD7EVKCaeQPDYaaQzSoA3NVdMgX/
         CQmqBzOBpiuHZMWhi8GaK4Vmw3m0PMhVQ7gRPzyhsx1q9TkFfDKpdtrh4SVY8P3ykHE4
         OPO/o3nnMJWw+mDwYpeAED9Npq5RoOectkgyY/4UJkXYb9et+sEjL8LM6EzqAdauqGV7
         Jjeg4FKoUcN1UXZ9zLN58u537b4D2RwmtSRDhYKgKNZzbpm0h6ZJbHtKB5DoufIjVUXW
         EdOiRcfvAVg4DLAyZZ4+LcqmU8QqJX9JfpPIu14W0m/WKIeh8rNokP1NgkvrG6vWpXf9
         82Vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773394938; x=1773999738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WjmletplWN85DKdqz792fPfJhrtfvngbL64ZSg/oZw=;
        b=cBUcl/ao2cdnp6Gfa9Yo3vHBa2ZEjxXu3ZIy2Ss52o3gDLTJVI2DqXTiwI0LmWUKVq
         eWpEnIXN38f1I+/UvilqLm4Qu01CwFndndmU77NEIMFO/tb5tEwEp18YOVJpjiVy98fU
         LOE9veiwBOdOv4ukphvUvgG2mSmjOYZJDnQ6qfX0Be83W1BW2Fwozl5gY7jNcql+HdVS
         cB/DMkV0KBQRdWQIJcnmN3waX5sZRoEundPtxpUxutPW2trmILVoSUmFAru66et5q/bb
         ycoiU/UpC2f2gpjpq2dDZ++7s45a6smjJg9ouyVlvsf1mWK0/eUVOQPL+xU/wADhA3iG
         YHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773394938; x=1773999738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3WjmletplWN85DKdqz792fPfJhrtfvngbL64ZSg/oZw=;
        b=EWuUCQNsGnjsx9vEOUbpAKzKdxr3oet0c8fQUPtFqHQDWMK4P4O3qQArYzTssyMwDC
         qEvOdgx6nhei18FtaKORCewK4GwYFphmThKzCuM7ZE8THpxzI9NLgTpTd4g0E93rYYUZ
         RU4BSGeGge2r3FBUJt4y1LNv7riIrpNekDvAqLpjwAfMRf2vc1HqaUMg5AXU9iWSA44G
         EhBE1Mm5LIMT6juxTG6N8phcWKZoRV4sAtEcwZQBWXGoIxHcVVkAE5xWgAaPHjP+DgCv
         kItbd/BvqeD3TeXZ5GOTBY79pHXfJmxRlx9mk5rJlK2Sb39wU44w+e4+nY3+MO2HMYAo
         vnsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdtLTPa79NRLv6g7jyrYBY7bLwd6Bzs7pLWvcEjGvOQfgtBgx3qKeKry/NqbDbaNePKlU2fVXe9ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp4ng9eHIp6cT8oMisup/57ltO9Y7whwfy7HY+ZfwkVnnktXGa
	SfsE94VU5jKgRJYKM/goXCeNV6KNkI4T47Bl1wFprIGEe49+eOqIpEjEAMEFxDDV7Om1Yhs6dBc
	fFjiP9GkTrpMc3qZGY4eCCUJj4CFTsS4=
X-Gm-Gg: ATEYQzxn612YeoMwT4IuHXu4qu7ZleVQcoXnFBo3O7FHCY/D3vehyPGcXkrNw6RZ/q+
	WNZVUmOx2dhUmO7AAGWVytitkGrVUAFuUaxYAWyemHrgHTj77mbk6ogUdXQ+25yVpz6pAwcOXtR
	xupPxzUUxG9VNJh6oC8OjpEs3uXsqlcXBmUPQ2wMCgS9j5ztf9Drb2EdnVhOyTuCZm8LmRzOVYi
	c6ffQRhJ3enZsmKt7d0vR0O4069tefKYZR0fCC5Gg06/LO+nhdXv1mQtBkn1v3L4n0N2rzVn/K3
	EncPxCc=
X-Received: by 2002:a05:690c:c4f9:b0:798:7039:eecc with SMTP id
 00721157ae682-79a1bbb4527mr27419187b3.6.1773394938250; Fri, 13 Mar 2026
 02:42:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-6-5bb2b574df5d@gmail.com>
 <8e91c86d-ea41-4535-a7cd-5b602c546cb7@baylibre.com> <20260313001940-GKA407679@kernel.org>
In-Reply-To: <20260313001940-GKA407679@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Fri, 13 Mar 2026 10:42:07 +0100
X-Gm-Features: AaiRm51e5SToR1tOSk9liHEfRop_JhUUodJVYw5is_oXMgLYIQA1K8IuEgYknus
Message-ID: <CABdCQ=Mv-3X8KE1WOWKVTmq+POgJczsL-qFdAyp5qzM6=0s28A@mail.gmail.com>
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

El vie, 13 mar 2026 a las 1:19, Yixun Lan (<dlan@kernel.org>) escribi=C3=B3=
:
>
> Hi Trevor, Iker,
>
> On 14:27 Wed 11 Mar     , Trevor Gamblin wrote:
> > Hi,
> >
> > On 2026-03-09 07:40, Iker Pedrosa wrote:
> > > Add Spacemit P1 PMIC configuration and board power infrastructure for
> > > voltage regulation support.
> > >
> > > - Add board power regulators (12V input, 4V rail)
> > > - Enable I2C8 for PMIC communication
> > > - Configure PMIC with buck4 (vmmc) and aldo1 (vqmmc) regulators
> > > - Set up regulator constraints for SD card operation
> > >
> > > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > > ---
> > >   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 48 +++++++++++++=
+++++++++++
> > >   1 file changed, 48 insertions(+)
> > >
> > > diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/=
riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > index 7b7331cb3c726f11d597f81917f3a3f5fc21e1b9..414b03f5e6480f05f5d7e=
eaaa0afb4e86425ae36 100644
> > > --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > > @@ -19,6 +19,25 @@ aliases {
> > >             ethernet1 =3D &eth1;
> > >     };
> > >
> > > +   reg_dc_in: dc-in-12v {
> > > +           compatible =3D "regulator-fixed";
> > > +           regulator-name =3D "dc_in_12v";
> > > +           regulator-min-microvolt =3D <12000000>;
> > > +           regulator-max-microvolt =3D <12000000>;
> > > +           regulator-boot-on;
> > > +           regulator-always-on;
> > > +   };
> > > +
> > Is this the correct voltage? I don't see a 12V rail in the RV2's
> > datasheet, and the board's specifications only indicate a 5V USB-C inpu=
t.
>
> Right, this should be fixed. Please note Han submitted one version of bas=
ic DT for rv2
> which I think that series will go in first
>
> https://lore.kernel.org/r/20260310161853.3900605-1-gaohan@iscas.ac.cn
>

I'm fine with that. Do we have an estimate of when these changes will
land? I'm fine with rebasing once those are merged, but I'd like to
continue with the review for the remaining changes in this patch
series and I'm unsure on how to proceed.

> > > +   reg_vcc_4v: vcc-4v {
> > > +           compatible =3D "regulator-fixed";
> > > +           regulator-name =3D "vcc_4v";
> > > +           regulator-min-microvolt =3D <4000000>;
> > > +           regulator-max-microvolt =3D <4000000>;
> > > +           regulator-boot-on;
> > > +           regulator-always-on;
> > > +           vin-supply =3D <&reg_dc_in>;
> > > +   };
> > > +
> > >     chosen {
> > >             stdout-path =3D "serial0";
> > >     };
> > > @@ -92,3 +111,32 @@ &uart0 {
> > >     pinctrl-0 =3D <&uart0_2_cfg>;
> > >     status =3D "okay";
> > >   };
> > > +
> > > +&i2c8 {
> > > +   pinctrl-names =3D "default";
> > > +   pinctrl-0 =3D <&i2c8_cfg>;
> > > +   status =3D "okay";
> > > +
> > > +   pmic@41 {
> > > +           compatible =3D "spacemit,p1";
> > > +           reg =3D <0x41>;
> > > +           interrupts =3D <64>;
> > > +           vin-supply =3D <&reg_vcc_4v>;
> > > +
> > > +           regulators {
> > > +                   sd_vmmc: buck4 {
> I'd suggest name it more generic and add a comment where device reference=
 to it,
> since buck4 requested by more than one devices, will make people less con=
fused.
> something just like:
>                         buck4: buck4 {
>
> > > +                           regulator-min-microvolt =3D <500000>;
> > > +                           regulator-max-microvolt =3D <3300000>;
> > > +                           regulator-ramp-delay =3D <5000>;
> > > +                           regulator-always-on;
> > > +                   };
> > > +
> > > +                   sd_vqmmc: aldo1 {
> > > +                           regulator-min-microvolt =3D <500000>;
> > > +                           regulator-max-microvolt =3D <3400000>;
> > > +                           regulator-boot-on;
> > > +                           regulator-always-on;
> > > +                   };
> > > +           };
> > > +   };
> > > +};
> > >
> >
>
> --
> Yixun Lan (dlan)
