Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE9038BF70
	for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2026 08:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327554; cv=pass; b=azykkWxDMlyoiDPQ9atuUzFPfKIFVsCk2mUmmgMoThW1MwryzjP5Ny2jJ7qtPYg/4eTfNTOcHhIH2z8PmfV0NrDW+CHaVv2ZbXA24vAaNV6nr+6WjCGkHKXDBXp8zd1a5LAhoC8cU7VRKwiHf5XhyBuak3y1oNl62AuH9hYuLF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327554; c=relaxed/simple;
	bh=gyfD8pfwhSxVR5c5TiqO6lAdCFrxa/LwfKRn/PLAYnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/J0vZ3LtRaqXKA8KW6d3xQgABJZbSoKJxJfTCdmdG2yXB6JH3cElFtKYwiopztlZxSMIkkjQ0cimjjdjM+ibuMCFUvw/rQ5a6wPmGrVFgMR1iR+aXT+bhV0+MXAmlo7aWiIO3q8Mq+8sxNYk/eZwtax5/bBA7YMNWftdVqw/58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sylJ5RNJ; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sylJ5RNJ"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-650775f427eso8026195d50.2
        for <linux-mmc@vger.kernel.org>; Thu, 16 Apr 2026 01:19:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776327552; cv=none;
        d=google.com; s=arc-20240605;
        b=IfIFJyqvgC3mk4KLgAtg9Qg7RlpV1tLrEouhGcsgxjmlK2IiRdm6k5o4kDc5+HFULI
         KE1f6TOuWT5e0PeSFI5aT4xi+133osEKVYJb3C7wL1tSF3Lb3mH6KfWpEuG/f1AB8+Cc
         Mt5JKdM1eDo58IIEYAr2+n53pBldnPR+nC5rmlkKsKPr3kuIVVJwqKvLhnocBLi+5rwz
         I82y0ADfyak+MnQvSCQAJRcNdlmnARp4XOkN3ptbKyr5mIkv3hQcLMJ7FHdEzXaN7uaq
         N0MciVSzpC94Qtkl/wQi7WBzznvMAgpJC8G7FChRKHrrF79wRma+ZcmUNLPKCo6WBzlM
         H2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UYfM78rx5R3ZVmMPKEfuM0RYI+r7ma+Zgwh+UTlTNLE=;
        fh=sEpgrYRbh9jnw/HmXqcKRikwNw16UXncPai4C+Ump98=;
        b=DVjDs4i+ZVj2+UwKM+FOyCcQ8A0bI4I1R1bC5K+UV8tuvuYdKXnE29p3+A6S3r8Jjl
         p6v3h50Fv2YKTA2OJnkC6vDGMRIEkWuHUYXYSD5v6l1zaA77yebYyWCzj3L4qCFeQTYp
         gIARD0xc1tvB7z7GDP0GhK+FrysqQmpaLAiGiew6+CorIVNixH/d3a+ZAbddrp1Vk57D
         bkfqN1RE/ykxLQV9aTd2/hpuFafqVNKFQO7NAxDRoOsMMtbLKCa1h9oqkLrp+cX8Ohr2
         i9PUz12aIk/lGu0TDNoBoivygAujTXgjR/L6JXS/P4UCr+lQ6uxPakv6qFsCFA98J02d
         Cjqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776327552; x=1776932352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UYfM78rx5R3ZVmMPKEfuM0RYI+r7ma+Zgwh+UTlTNLE=;
        b=sylJ5RNJ+0hXdCnnGdXR5eE2v/EkbzJ+oigAXEMD1d0JhM51NM0L6K7wu1tcH+Z16h
         fddFr8COfi6g6L9XHp+VYZU2YM1JYRkWOM9/ZKjAq51WvqJyvI8C0OBbhgbusvysg16H
         1c7HjqPW/UBIkdmtbXS2m/h+jQe2fN4oxYt+QGpx2DwVaIwUHOFs7CNgDzGBrcThXCNG
         ppbcN7ahpVYYu9SGmOcGyfwueSPJen5kHS86KuGFkSMrEhweMCB11zKNRvcHJNgNzL1M
         ZUVNP+BQEmxlUmkFiThX5wdCPE6cX9B+OQV3CN/QMurXfMXZdadBaPLnDjE2QZpuHFK8
         kmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327552; x=1776932352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UYfM78rx5R3ZVmMPKEfuM0RYI+r7ma+Zgwh+UTlTNLE=;
        b=Vfun1Nd7MCYnajBTsXyz4+CrFyBjN6RG8hstrzhMTWowCuA3N8jlQJH3va8/ToI6FO
         ZQoPmL7oYn2hCfrPb+Wd4aQiHR5P6LbCoCBnDhPwBOYri4za/9v4ojsA+cXo8DGPZ6xl
         NAtgOUZ2FFJfasDaJ6ArZkWxC7mz0+xMOOvAmqDJfIX/L/THEsYGFkthfE0hMYrtwjLE
         mhZBpBdEwTrMjHP017lOGoCvTBh68PZv/9jMbem9vl0mhR6yO1ZyaZwRUscmU1MYNJR5
         2mvhPnYO+AfyZ7wt+awRXZdclIzeI2Ze8Iqrh/QAXXWuFtd4/uhpRGKemuBHP9FCI5bb
         oVvA==
X-Forwarded-Encrypted: i=1; AFNElJ8JIqI90kNsE7HRSbqVug7HwNhajlf8bJk9apQ3tolBK615LsMMg/13373KTjxN3026m6F2cEy49WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+GJk33LAsCxXqB5K8IRk1GHpXQ5ZikG6ej1aZltYj71KNBJE
	6ULsGTzC3/8sIsQ0OznnVGx0Js8CcSkymw1FS/vqGr3sYabaaoYba9Gy4xNXzKIGJKSw14SohQq
	0KH4cC25xXxMYigbtUK666PbkJNFYcLM=
X-Gm-Gg: AeBDieulrYa5PsxMeSoHUNliNri/+bYD9uushQzaGoFIQCGA6n6Ix8BjKvOF+TO7Eg4
	BfCYNZ7YSuUx0jjkEcvTJQNx3qH1pX5zpaAeDRw0GqfW5XSNJw8hqP0BFXy0JywgTCHOYuwy9Ey
	WaEfeh/CEMkyNbdFeG3xpsuG8zptHbwDZ4ODj7ETeNLBxFDOvTGbdAqMwUsJ8uOPuCKj55KrAtZ
	CqQdtlT5HNuzPz+yiC75Z5Js39GebP35Yin3ycGQT8+sXlSSRgjGwrnKWxIALFCpVKbE0nln67m
	2mhkEtYGnkKw3iLuqwI=
X-Received: by 2002:a05:690e:bc3:b0:651:becf:4523 with SMTP id
 956f58d0204a3-651becf5113mr15959082d50.62.1776327551592; Thu, 16 Apr 2026
 01:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <f58ec12c-3957-4d44-b823-6a1ae1a1dd94@kernel.org> <CABdCQ=NhTkGJUh_fKnZoQMzdpyO-UbV5zrSfiNVUC7bkSBifTA@mail.gmail.com>
 <DHSQ6VG82QYX.1EVAYV9JTBCL7@linux.dev>
In-Reply-To: <DHSQ6VG82QYX.1EVAYV9JTBCL7@linux.dev>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 16 Apr 2026 10:18:59 +0200
X-Gm-Features: AQROBzCXo6p3fgZAxRfHTUW7b152HxWrs_jxAbTxvFG6AIyn1RGKEh6tq-Z2nFo
Message-ID: <CABdCQ=Oata1oXds6pV-RipwZjcztM0xk_J=Rk8Of2w2RqegbHA@mail.gmail.com>
Subject: Re: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El mar, 14 abr 2026 a las 10:16, Troy Mitchell
(<troy.mitchell@linux.dev>) escribi=C3=B3:
>
> On Tue Apr 14, 2026 at 3:12 PM CST, Iker Pedrosa wrote:
> > El lun, 13 abr 2026 a las 10:07, Krzysztof Kozlowski
> > (<krzk@kernel.org>) escribi=C3=B3:
> >>
> >> On 13/04/2026 10:02, Iker Pedrosa wrote:
> >> > This series enables complete SD card support for the Spacemit K1-bas=
ed
> >> > OrangePi RV2 board, including UHS (Ultra High Speed) modes for
> >> > high-performance SD card operation.
> >> >
> >> > Background
> >> >
> >> > The Spacemit K1 SoC includes an SDHCI controller capable of supporti=
ng
> >> > SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
> >> > currently lacks basic SD controller configuration, SDHCI driver
> >> > enhancements for voltage switching and tuning, and power management
> >> > infrastructure.
> >> >
> >> > Implementation
> >> >
> >> > The series enables SD card support through coordinated layers:
> >> >
> >> > - Hardware infrastructure (patches 1-2): Device tree bindings for vo=
ltage
> >> > switching hardware and essential clock infrastructure.
> >> > - SDHCI driver enhancements (patches 3-7): Regulator framework
> >> > integration, pinctrl state switching for voltage domains, AIB regist=
er
> >> > programming, and comprehensive SDR tuning support for reliable UHS
> >> > operation.
> >> > - SoC and board integration (patches 8-10): Complete K1 SoC controll=
er
> >> > definitions, PMIC power infrastructure, and OrangePi RV2 board enabl=
ement
> >> > with full UHS support.
> >> >
> >> > This transforms the OrangePi RV2 from having no SD card support to f=
ull
> >> > UHS-I capability, enabling high-performance storage up to 208MHz.
> >> >
> >> > Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
> >> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> >> > ---
> >> > Changes in v8:
> >> > - Resending the series as v8. The v7 submission failed due to an SMT=
P
> >> >   error during transit, which resulted in a broken thread on the mai=
ling
> >> >   list.
> >>
> >> Hm? Everything is here:
> >> https://lore.kernel.org/all/20260413-orangepi-sd-card-uhs-v7-1-16650f4=
9c022@gmail.com/
> >>
> >> You can send individual patches to fix up threading, use --in-reply-to=
.
> >
> > My apologies for the noise and the rapid resend.
> >
> > The reason for v8 was that the v7 cover letter (0/9) failed to reach
> > the mailing list due to an SMTP error on my end. This left the v7
> > thread "headless" in the archives without the changelog or the full
> > context of the series. I was attempting to fix the threading
> > immediately so that reviewers would have a complete set of patches to
> > look at, but I realize now that resending the entire series on the
> > same day was premature.
> So that's why Krzysztof said you should send individual patch with --in-r=
eply-to.

I see, thanks for the clarification. Just to clarify for my future
workflow: is it acceptable for a series to be 'headless' (starting
with Patch 1) if the cover letter is lost, or is the cover letter
(Patch 0) strictly required as the thread root?

In such cases, would it be better to just send the missing cover
letter as a reply to Patch 1 afterward to complete the thread without
resending the whole series?

>
>                                       - Troy
>
