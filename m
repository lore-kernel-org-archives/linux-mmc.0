Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6853C1F;
	Mon, 14 Apr 2025 01:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744594306; cv=none; b=mmuuH8Io87A3lKFQGm265XJa/3MusJedMkEVkMSFu8ystHsEmL1QenLW3AM/FS065E+ZKlMvs+iQAbByFzsgZJIqk0wMAf7iywEWeVWjxG1CVXbPTG+BvbQUPbQqsWvwimlIJgum6iY2il0iQfphpZWKaqHGPm81LsxQQcZ/Hjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744594306; c=relaxed/simple;
	bh=9xECK2ehynHxAbLBfaqh/9OBldVcrjO20TqR4gRuQUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pcY1i+837Yizqjwr0k0OzqU6seWR/ZxMNn3zuDHomW92pzuqNbGjHON+A0QMHU41ckz2eqNWGOWxQU0CJsQW9Q+Qi7OZPuV8BsXQzsTpFpipr6bZZNBoNCZ3M/h8vdIpxeSEMx31Kc8gRruhrbSwEVtwPBzUiW98ZSLKsxRVtok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bg8mCdtR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bg8mCdtR"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so6031979a12.0;
        Sun, 13 Apr 2025 18:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744594303; x=1745199103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBcdawRnzTZ8ZY4dlNm0WG8aDh/pMvgAkt6S8wOu0R0=;
        b=Bg8mCdtRXLk6WY9Xgyj3mgnwVDW4xTMMP3JzkrodhhGUh7vYliZxvJi30mHYK/dQIY
         mEl4umKkuB7kS3XCEh2e2XzkS//siiffetQc8iTlDByIaXgkAjW5jvqzKgEBFk0quwN2
         yenxTQC4tLZWDshmqUm1UoRj7OrNXiBsLc4oe+SmCgn0wsYoLLqjW/4+253tieplz0va
         mqItHsxvx+/KiV/QzQ3S6JrcUb5dUfRO9nysbC0zxjmJDmwpxbm+UE480ilR9tsFAxKI
         CfWTyPwCwYAPOcAwevyUZxmIIGP6kQVwZPFnB9zOLszeDdcBpNylpZ+zVgMTlH9Ph3d1
         RwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744594303; x=1745199103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBcdawRnzTZ8ZY4dlNm0WG8aDh/pMvgAkt6S8wOu0R0=;
        b=rLW0bVulM4Zi4z4r7f3eZHjTZTsL/YZN5lvlMLT8nkVIt0TsFVREbPblo/X/FWNJQo
         kXvkJ8vJtAdqQ1nD950NE/CDS5AUH3HmB1Zi/b6JjuL2NsmqV7JHg7FQJ9gpuVwL8sQm
         HnQ/sKUyANaNqhGfIn8r/8O1zcjVa0BvyYdJqdSzecq3jytXAkhWI/2x28ruu3T4vCgH
         cd21Pwgvc87v6TGnQ0vO/ADp4jWt0qpF8c/Wy8qjl8zaIQpXtnuy0d8JgV9aoeLoNsx5
         PLOFwypCCqLmT5uoPd5uVmUG9ubn71BmRjBRCi8fk7181dUaVb5yA8UrDGEURq1AWx1j
         cTFg==
X-Forwarded-Encrypted: i=1; AJvYcCWtDnbtoiRMWzeKGXjrIM3buajaSnK3pj8oAa+5Zt7962niCRJQXoYETwiov5YAGgyLbMrscIFzAO6V@vger.kernel.org, AJvYcCXSEVXgBXCWgG9lOqbDLW3LxNxg/UWNW4xA+9ioVdS6s/O26MleJZbm+DCmG4iacXIFMGcSrlV0wD5i@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcUa/9QTM/aOJ8GpTptMgpVq8q6jAt+ZKu/TIT8SKMSH1r+67
	ajLGDAc7WsNwciC0O9suWmLJIniIAlD+Pgxrp/4e0ALZTn1h+GCacTFw0cHV6/Z+kw7TzLLR4MG
	8fXBSR7I24aqHw1LXFDq0aQjnyIg=
X-Gm-Gg: ASbGncsyUX8Tx4CoE0DP+XHcJ7YqjhECBaEk1Mf5a0x7N6gVEt8r3C5qgjPQZIdQyhg
	jkqh4VjQwJF4M8eYjSs4aSWn39DX5YMUBr5PoBCOCjVlOHYVwtcoc8bGcMmd0lXHYWslvvIyaQb
	HfUsCIUNrl23Jm3dyjuQVz
X-Google-Smtp-Source: AGHT+IEWHVetZm0u5D2BM27qSiXz/lDX/oFTQJDOz5qkv2RHDUgoCD5ISwlVKLKNeGcIQw/0Z5POs6FbMsmeOjtQQVI=
X-Received: by 2002:a05:6402:254a:b0:5ec:c990:b578 with SMTP id
 4fb4d7f45d1cf-5f36f67797amr8516043a12.19.1744594302836; Sun, 13 Apr 2025
 18:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1744273956.git.zhoubinbin@loongson.cn> <cefcd16d303936247b94bc13047c8a1861bb8330.1744273956.git.zhoubinbin@loongson.cn>
 <20250411170535.GA3391061-robh@kernel.org>
In-Reply-To: <20250411170535.GA3391061-robh@kernel.org>
From: Binbin Zhou <zhoubb.aaron@gmail.com>
Date: Mon, 14 Apr 2025 09:31:30 +0800
X-Gm-Features: ATxdqUGXQwM-0SBsWpuCh-Gl2xc_HzNH9Z4F3bB7Sn1XybEc-5t-g0XOW9_YDmM
Message-ID: <CAMpQs4L=aNY9okXq+m=x+WdDBpoLa8v1FQ39ZSY14Qb9joH7YA@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] dt-bindings: mmc: loongson,ls2k-mmc: Add
 compatible for Loongson-2K2000
To: Rob Herring <robh@kernel.org>
Cc: Binbin Zhou <zhoubinbin@loongson.cn>, Huacai Chen <chenhuacai@loongson.cn>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob:

Thanks for your reply.


On Sat, Apr 12, 2025 at 1:05=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Thu, Apr 10, 2025 at 04:40:37PM +0800, Binbin Zhou wrote:
> > Add the devicetree compatible for Loongson-2K2000 EMMC/SD/SDIO controll=
er.
> >
> > Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> > ---
> >  .../bindings/mmc/loongson,ls2k-mmc.yaml       | 47 ++++++++++++++++++-
> >  1 file changed, 45 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.ya=
ml b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> > index f3e94f5f3a35..24d217a9bbe6 100644
> > --- a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
> > @@ -9,6 +9,9 @@ title: The SD/SDIO/eMMC host controller for Loongson-2K=
 family SoCs
> >  description:
> >    The MMC host controller on the Loongson-2K0500/2K1000 (using an exte=
rnally
> >    shared apbdma controller) provides the SD and SDIO device interfaces=
.
> > +  The two MMC host controllers on the Loongson-2K2000 are similar,
> > +  except that they use internal exclusive DMA. one controller provides
> > +  the eMMC interface and the other provides the SD/SDIO interface.
> >
> >  maintainers:
> >    - Binbin Zhou <zhoubinbin@loongson.cn>
> > @@ -21,8 +24,10 @@ properties:
> >      enum:
> >        - loongson,ls2k0500-mmc
> >        - loongson,ls2k1000-mmc
> > +      - loongson,ls2k2000-mmc
> >
> >    reg:
> > +    minItems: 1
> >      maxItems: 2
>
> Missed this in the first patch, but you need to define what each entry
> is.
Are you thinking that =E2=80=9CminItems=E2=80=9D should be added in patch-1=
?
I'm not sure if I'm right, but for patch-1 (Loongson-2K1000), his reg
count must be 2, so it doesn't need the =E2=80=9C minItems: 1=E2=80=9D limi=
tation,
whereas Loongson-2K2000 needs this limitation, and so it was put in
this patch.

Of course, for the reg description, it is true that I missed it, and I
will add it in patch-1.

>
> >
> >    interrupts:
> > @@ -42,11 +47,31 @@ required:
> >    - reg
> >    - interrupts
> >    - clocks
> > -  - dmas
> > -  - dma-names
> >
> >  unevaluatedProperties: false
> >
> > +if:
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        enum:
> > +          - loongson,ls2k0500-mmc
> > +          - loongson,ls2k1000-mmc
> > +
> > +then:
> > +  properties:
> > +    reg:
> > +      minItems: 2
> > +
> > +  required:
> > +    - dmas
> > +    - dma-names
> > +
> > +else:
> > +  properties:
> > +    reg:
> > +      maxItems: 1
> > +
> >  examples:
> >    - |
> >      #include <dt-bindings/gpio/gpio.h>
> > @@ -65,3 +90,21 @@ examples:
> >          bus-width =3D <4>;
> >          cd-gpios =3D <&gpio0 22 GPIO_ACTIVE_LOW>;
> >      };
> > +
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/irq.h>
> > +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> > +
> > +    mmc@79990000 {
> > +        compatible =3D "loongson,ls2k2000-mmc";
> > +        reg =3D <0x79990000 0x1000>;
> > +        interrupt-parent =3D <&pic>;
> > +        interrupts =3D <51 IRQ_TYPE_LEVEL_HIGH>;
> > +        clocks =3D <&clk LOONGSON2_EMMC_CLK>;
> > +        bus-width =3D <8>;
> > +        non-removable;
> > +        cap-mmc-highspeed;
> > +        mmc-hs200-1_8v;
> > +        no-sd;
> > +        no-sdio;
> > +    };
> > --
> > 2.47.1
> >

--
Thanks.
Binbin
