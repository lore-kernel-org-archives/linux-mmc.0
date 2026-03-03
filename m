Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7CC358393
	for <linux-mmc@vger.kernel.org>; Tue,  3 Mar 2026 13:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545899; cv=pass; b=ilS/u3ziNBn/MrfO07tBwE00Zr3RPubB0MsvBUPhtE/XH5QZh3e4jI/ixouUQAork8AMVw9E7ZzKLxhzt+zUZhJERmVYKYjOnuwXY7bwtxz47GL8DHoq3DgDUeSkm24YSkftwtd6fba460rSSZatxkc7vxkBpPm2gINzzRM6y4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545899; c=relaxed/simple;
	bh=mjmj1erYg/zPkh28cbgKmeKfsU11/6Ku7tNZPAtZaFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RIrqy5FNZIf7GGvAdI7UFmmU7jSOiyimbdeTGj12QbNQoJhShRBJAMknq3avdzjVYXWPfSfXfBLGjvbrRJ4FVm7oXi1rcaIMBi47To4JiDck7aWPSdrSGAaqJv0AXQ1J0dtTpBm7oVzezUhnf/Kw4HS3HC0QUlrRb3+yybVqtPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFQ5+lEo; arc=pass smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFQ5+lEo"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64ca4dfdd88so5392247d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Mar 2026 05:51:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772545897; cv=none;
        d=google.com; s=arc-20240605;
        b=eWf5/AXtem7SPpvKsmnBXqvjKaSypEr3SwjqeJwlSMRecML33zZT6AGloK+GGFonKK
         x/XZK7gOGV3EwHuZqL6i0tl2BwBQo5JD+/vdPXw/IrDoR1ddCMATHHfdoeouw0xsJDGx
         cZskf6oKpQODMnYQ3a7KAsKgP961sA/AspNvX6T8/uzMDmL7ta5wRv6fO9AjGJksShEk
         b3X7BI5p+SJyYLq2nKvXFICyWBD1gnT40swCABWxxsDWKpb3TUqyGNOHk76KUx0eBSeC
         /rbQSi/TNZnPU9Ch2eKK/IFxmeumkJrYhqVfy7PBaBR2l+PIPuxi+Wt8z8GFZcwB54kx
         Sb8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aZn4gqDyUQYxhmDFWGYkcAn3/Qr9cauEsxLXdsoN45c=;
        fh=U7NY6KGfwKWcMaNSSYVH30KjJFCsqSIpjlah0z0clQk=;
        b=dJl95X5PwzhtgFy99e1xykRyTbW/zqp5V53rUG715NB0kB2N+DGIfZj3ABLR5BhdTe
         1GFZUqVXJWOjOaGlL2UoBEOUig1yX9dVw2HkJMnDkjkRumUDohFIzyXeN6rH7xNdaZrA
         2GGAJgzfPMRuiWMr8LEjMQwtBpdCzGHEPLp9bq4dEcXGdaD7klvg8LIHQjiYI1Ve1Aet
         zeMS525i+Yyrb0QeJxiQDheVOgzLQtNgl8oRj5XLWS7N/1605uhzW4jxDA4gvqjSv2M3
         AqHQsyV7DBn9rJ3m4ZmzsfmpSvbvG265Kh+Lc6xogSzokWCcGFgpxmGaT/OrPlAZ8xHx
         uchA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545897; x=1773150697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZn4gqDyUQYxhmDFWGYkcAn3/Qr9cauEsxLXdsoN45c=;
        b=iFQ5+lEoB2el0avJWUiySiid7Xm3vF+lzTw7JeG21RlGZ/8F4+Aie8KJtOkqxkicwa
         WjucLXv1JekG49umecD7nAW7NShY5NZblI3nfTCzxkYi/mn/aW0/kVaAtdJLF0+CdMP5
         Ady10591p0R+MOEmpTf1Y+fNSp/gG16z9M7VpC4SGiyo71NGuQ4Pf4Cofa7uvqIX79Ae
         C7hQnb0Z+yVebxys+1HKZEmhpJwpsnoOMVyezMllEMZr6kds9T03hjYu2joimDXsgfdW
         r8NupcgBJLd+ZwEBusKn29a1R8Ma53Qo01yiF5KUE80+Q94+iyKb8TLCG+0683OwMCLi
         OX3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545897; x=1773150697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aZn4gqDyUQYxhmDFWGYkcAn3/Qr9cauEsxLXdsoN45c=;
        b=rz6l3ZyGC3/7sRDiy1aQqPjgKpvp6sdOTMV+FaDKS+Idm/Vz8UexYBOoXTn46moPP9
         j5uFXXv6FjrIMQWd1HRJmlSkBWLt1ftinhKMpX3eyeTheMflRMkBJ/B1itHuNY7DZtcz
         FJiQJj9hVy9ZXFgw6hzlhj9UPOeojUrpKrAue7o61XjwpKoTFOrlgNJuneWngUD9yX2Q
         MlCGVWeJ6d0IYCKeR1a48/l5YOhtPO0HvGtrPhPG6atzWh0/TrvHHQnLEzd5s8dSjhp8
         YW7xooSv/nU504UcNNkSaoV4xSuXxP+Uwh6dN2o3zhvHppNXaOJoHnXozP1QfbaP5pYK
         fl6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhS2+xv4d4dULblkTqj8iq4WGDmkzk3SUXJ8pYGpIL5EibdIC7CknF46+vUTbcsBOUp3jrMr+2Dz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWgLlFeawE7R7hoOH9YTy3pEOPC0on/Zy5JZGeTy6hM3TlVrK
	HAUKt6nYbAirdL/W0BxxhaI0hQd2HgHC6njvq8SclsCJ2XwSpS34nVzS9mxcEnliNTZQGNi2X89
	1HAz7xh77+HF5iXuNynha3JLgn1whwZk=
X-Gm-Gg: ATEYQzw/79ccSkJGahHxNRMztWw0BjPjI08YCbnoIk2Kc4uses2ycOdo2Jfd4OhrMLV
	Ukn2TLUBzy3s/1G6WS77H2vEoHVCuAjenKGaWo4GTea2dUI6WAsDiIvLXJ/Z+wc6jDdPgwd5EoC
	lAPScI7dSwrI2v+NhSRnIBLN9lvRS3AigfwLjjQGLcwWUfxvRYejnNHG9/kPqVs046IA7KHiQhf
	/0r/4SbCxjrZtrtnzpKp/M9Nc6xQl1rkfpTiPfcw6/EJWUGXO8ES/k+lGL8dg1sDeqL5DPdWLgr
	e+MsPAQq
X-Received: by 2002:a05:690e:90:b0:649:4997:3e94 with SMTP id
 956f58d0204a3-64cc20833c8mr10119824d50.12.1772545897333; Tue, 03 Mar 2026
 05:51:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302-orangepi-sd-card-uhs-v1-0-89c219973c0c@gmail.com>
 <20260302-orangepi-sd-card-uhs-v1-1-89c219973c0c@gmail.com>
 <20260302-crewman-faster-9fd00b62e30c@spud> <20260302223803-GKB289813@kernel.org>
In-Reply-To: <20260302223803-GKB289813@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 3 Mar 2026 14:51:25 +0100
X-Gm-Features: AaiRm52NZmZiw1yUUKvM0Min02zDkPktW8qIv-Jsblu1CXoYU1NePFrvk318i6c
Message-ID: <CABdCQ=Nd9ZW6OBnAiuki=2+DhVraW19bh_m8=LLQGUKN8TkEdQ@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt-bindings: mmc: spacemit,sdhci: add AIB voltage
 switching registers
To: Yixun Lan <dlan@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yixun Lan <dlan@gentoo.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 2 mar 2026 a las 23:38, Yixun Lan (<dlan@kernel.org>) escribi=C3=B3=
:
>
> Hi Iker, Conor,
>
> On 18:25 Mon 02 Mar     , Conor Dooley wrote:
> > On Mon, Mar 02, 2026 at 04:13:22PM +0100, Iker Pedrosa wrote:
> > > Add SpacemiT K1 AIB register properties for UHS voltage switching
> > > support:
> > >
> > > - spacemit,aib-mmc1-io-reg: AIB MMC1 IO register address for voltage
> > >   switching
> > > - spacemit,apbc-asfar-reg: APBC ASFAR register address for AIB access
> > > - spacemit,apbc-assar-reg: APBC ASSAR register address for AIB access
> > >
> > > These properties enable the driver to perform voltage switching betwe=
en
> > > 3.3V and 1.8V required for UHS SD card modes.
> > >
> > > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml | 15 +++++=
++++++++++
> > >  1 file changed, 15 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yam=
l b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > > index 13d9382058fbc1c12be1024d1c550f04a825673c..4d6590aa8262009b6e569=
7a04b45cf3736c0fa42 100644
> > > --- a/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/spacemit,sdhci.yaml
> > > @@ -32,6 +32,18 @@ properties:
> > >        - const: core
> > >        - const: io
> > >
> > > +  spacemit,aib-mmc1-io-reg:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: AIB MMC1 IO register address for voltage switching
> > > +
> > > +  spacemit,apbc-asfar-reg:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: APBC ASFAR register address for AIB access
> > > +
> > > +  spacemit,apbc-assar-reg:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    description: APBC ASSAR register address for AIB access
> > > +
> > >  required:
> > >    - compatible
> > >    - reg
> > > @@ -50,4 +62,7 @@ examples:
> > >        interrupt-parent =3D <&plic>;
> > >        clocks =3D <&clk_apmu 10>, <&clk_apmu 13>;
> > >        clock-names =3D "core", "io";
> > > +      spacemit,aib-mmc1-io-reg =3D <0xd401e81c>;
> >
> > This looks very very wrong to me. This is part of the pinctrl
> > reservation:
> >               pinctrl: pinctrl@d401e000 {
> >                       compatible =3D "spacemit,k1-pinctrl";
> >                       reg =3D <0x0 0xd401e000 0x0 0x1000>;
> >                       clocks =3D <&syscon_apbc CLK_AIB>,
> >                                <&syscon_apbc CLK_AIB_BUS>;
> >                       clock-names =3D "func", "bus";
> >                       spacemit,apbc =3D <&syscon_apbc>;
> >               };
> > so if you need to change something here, you need to do it via pinctrl.
> >
> > > +      spacemit,apbc-asfar-reg =3D <0xd4015050>;
> > > +      spacemit,apbc-assar-reg =3D <0xd4015054>;
> >
> > These two are the apbc syscon:
> >               syscon_apbc: system-controller@d4015000 {
> >                       compatible =3D "spacemit,k1-syscon-apbc";
> >                       reg =3D <0x0 0xd4015000 0x0 0x1000>;
> >                       clocks =3D <&osc_32k>, <&vctcxo_1m>, <&vctcxo_3m>=
,
> >                                <&vctcxo_24m>;
> >                       clock-names =3D "osc", "vctcxo_1m", "vctcxo_3m",
> >                                     "vctcxo_24m";
> >                       #clock-cells =3D <1>;
> >                       #reset-cells =3D <1>;
> >               };
> > so add a phandle to the syscon (like the pinctrl currently has) and
> > access these via its regmap. What you've got here is a non-runner,
> > sorry.
>
> We've gained this support in pinctrl which already accepted in mainline,
> it's done as Conor suggested here, so you can drop these properties along
> with the patch [5/10], see
>
> https://lore.kernel.org/all/20260108-kx-pinctrl-aib-io-pwr-domain-v2-0-6b=
cb46146e53@linux.spacemit.com/

Thanks for the pointer! I missed that these had already landed in
mainline. I'll rebase the series, drop the redundant properties and
patch [5/10], and send a v2 shortly.

>
> > pw-bot: changes-requested
> >
> > Thanks,
> > Conor.
>
>
>
> --
> Yixun Lan (dlan)
