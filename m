Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C13B7B64
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778486548; cv=pass; b=nQMezvPMcR9iT4IKpUP7SgFfzI4X8I4bWhaH5Ex13Hx/ibLr4xMUG4l5wQQo6W3LN+VYePJFOrikPwWOmuOrMi+nwtqhxJa6+sRWuYAHdKMxTg0VjBcSrMBFXD0ieUHT6/cDCUqXVB2+pYtLXYRLnHgLEA4CSVj315iH+GbDj/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778486548; c=relaxed/simple;
	bh=hAvNwN3LdfvaDvVGl1LPpgogRMQ+ezfmubbeLc9ID7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjAMJpjrDFmM4E1XmVR9y466v89l3Q93WKvNPqFGH8bJUPR+U4MFc9vpLo7BV+x+cwARQGGS3BnS2bgrFtgjag5q9vLuSg7NTcH5n5PUp8KNA5qRCEv9/hnTraQ3VfUB5zY2w8EX9bGbM6xk6Vd/ojq8ULp95Pg2eULdyhw78ug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUkO44xe; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUkO44xe"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-651b4d09141so3976905d50.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 01:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778486530; cv=none;
        d=google.com; s=arc-20240605;
        b=WKlh8OEaW9K/Zts1C7kph7UgS7fAAc2JDiPqcs/oFOe6JPdHej6KJ7FrBLVZHiqhk1
         H74h1A/CjBluEoFn5EYBRuihmSUg5qwXtIQZjM9qHEobzWVJvhtC/7dk/uiR3HckiMHF
         TGf8w85AKvGg4lleSYYPvOuGXTX2n82HWNmJsYvt5Ish7fh1NIsKLdu9IXIIq/oDHj9D
         0882qUHHPhmE4mdlxeMyYiZllUVBpdkrcRjPnd5rnDIU1T58TSlWCTli+QwI3/iyr1qp
         9ohPozbyH6fHvClQ8DIszigCnxBUytmSoj2oURD2KWRbRGmf7bPOhldlCgbHLW5FpLCp
         uhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sW6azkXa80yI0rJXwT2HYG22XiYQ/sn39R3AWBjjzho=;
        fh=zN5cxb7JLybkm0LkfT1haCDlXiYjsUlwfbvyrZrNphw=;
        b=Q8swieK8jTABjrA9b9WN0Fp3dusMB4qe/xQQxYXcOp+1kNIfxRwyRkclHY5HLk+VQP
         z/a02jf4x6VOKtTJyS42ELIHneN5w7R0yIIBgnMHv0t1D9hECu9fgfdoLm/cOAdkGb/m
         jYVCJDILnFdCqJG3n3KL6lJu5Svt44MJu+3QCydLj3HdMBxQVbLAuY6g/SLpQ8PKoume
         oBVJbZpiQHU1fdLWph+l7UXSwb3UUr7bIekR4Plp/leznOgANkD6Q3yNjTnRrNNU79qf
         vfQ3v5Demhj9cHYrATFtn5ZCCYA4lyecN3wpp2aHCjJTCguit4B95o0xHIkwQOhfxpEW
         3abw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778486530; x=1779091330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sW6azkXa80yI0rJXwT2HYG22XiYQ/sn39R3AWBjjzho=;
        b=eUkO44xefUFP8aEssUo9MXyWjgm1v1yHWVLPH/Zbdfqd2B/O6cCKT/4ABqCzT7xUUp
         FO2H4Aj9CilhbibtcofkQakiQB2WgKqRXLfdeJg0JYsRaQOYHTYmvwzBjkgZC6cRNX9m
         CAqAmzVufJkP8xBZjiRMNKsKytiCEnqOKoqzANaQo0erh1HqIj4d8hQ7HNtuEWJqQ7FU
         rRZFBJT1dg1sLxdxRUHywmoSowkA6ibL3DH2wAjk39QEe7natmVTiMfO90Wx2OKvm1V+
         ZEtO4T55bQ8yBw2hrM0uxHJql1DEjN/EUIsTQHTVi9avuPayKye8iES/h18ROY4CxAp/
         oWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778486530; x=1779091330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sW6azkXa80yI0rJXwT2HYG22XiYQ/sn39R3AWBjjzho=;
        b=dATqYMnm4Su5d5weEvkRsG2Id0UM12jPs1ZYY/A8tkjhlvrCfL10OzEhAPz8GzGqms
         trkm16e6rWmMTObmgWN41lsh6E9JqEGV+gnAHnRphq0G9lJXtbZgepGHwp6P5Nu5ggVD
         KP1aaZ8kPmWWf0KtK9D5hVBExnyKeaU0HkGSEEQJ+Qs5ALuZMNe5/b1YMa6tEMWbi4Kh
         mAeyTqdstkw50K89Qx4sIOrsCioY5WbLGSRhWFqHz+d7637b1p8/3L9TKFq29JoOejft
         sn+CGV+1VmKibXLP+55iKA9K05gH3BSJaaL/nICHxOwiRFy+gOI3A/f8feU6NKa5YRfS
         LXng==
X-Forwarded-Encrypted: i=1; AFNElJ+MXCZ3SN0/HZVJHOq7PbAFYJ9lF1tzj4jnbOLku0orw9vvRE5tHl0FioeXWf/63yDXNN7+sI1BdEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCP4OlW2n2mEFF9Y9ufrbvxlylqWRkgPmtLGUUmKuFBBKkA3eg
	49iQOvxwIJNU+WArEUpnVPySweha3E1zo5qTDH3VEnYyZOizh27PDFNBFwrQC8tJGbh7BvWKifL
	uqYUTOClXM6bEUTREb5TwSMnmIV38X2A=
X-Gm-Gg: Acq92OHWRTBkU2RJy9r8+LmjS++P6rApNwSyXtoOBuVZZKb97Bh3H56hD8Gz3Xmf26K
	RIXV0tGXGRehRjay41MBdB0qkA2sWRAuBgtZ260vZLiN5aHdiGnWQWPToJNyrSqA1hTJu29Uj90
	6wHty2v4qKuXD96H5tzzHY0fbeqWp02FVCWhvLNeDrLxipXg7bo4Vogvfujh1sBbPX3+YZTBkcV
	uTiZJe6nxP75rW4P5oa6vdaGhT+VOPtbjOQ78S+2js4S8W/rBlJmDWXdEMtueseiH079jt6bwIX
	v6YZPl9y
X-Received: by 2002:a05:690e:1905:b0:65c:6ffb:3038 with SMTP id
 956f58d0204a3-65d7e822e64mr13587707d50.17.1778486529994; Mon, 11 May 2026
 01:02:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <20260413-orangepi-sd-card-uhs-v8-8-c21c40ec16d0@gmail.com>
 <CA+Xcp4nY9GVMOmtMG-PNhY2vqP4Cc_amAMSa+M3vuDjWUkuCHw@mail.gmail.com>
 <CABdCQ=OsPva9=YPdBd=3HW1OO7=_zJtpXjvaiA0WLEDT5Scs_Q@mail.gmail.com>
 <DICDTHYTPDSP.210EBVHTQ6966@linux.dev> <20260508225341-GKB3590877@kernel.org> <20260508231051-GKC3590877@kernel.org>
In-Reply-To: <20260508231051-GKC3590877@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Mon, 11 May 2026 10:01:58 +0200
X-Gm-Features: AVHnY4Jd8hC8nSk1elUyO1V0E_fXdX8QCiSMcWMOA11otgjNrlNzYjy97ZtHNls
Message-ID: <CABdCQ=NFuW-XBK2zrw2TUFrEg0Q1Wf3_qS28zT3v-Hfud8mkew@mail.gmail.com>
Subject: Re: [PATCH v8 8/9] riscv: dts: spacemit: k1-bananapi-f3: add SD card
 support with UHS modes
To: Yixun Lan <dlan@kernel.org>
Cc: Troy Mitchell <troy.mitchell@linux.dev>, 
	Margherita Milani <margherita.milani@amarulasolutions.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 9 may 2026 a las 1:10, Yixun Lan (<dlan@kernel.org>) escribi=
=C3=B3:
>
>
> On 22:53 Fri 08 May     , Yixun Lan wrote:
> > Hi Iker, Troy,
> >
> ..
> > I would object to add CONFIG_I2C_K1 as hard dependency, the reason is
> > that the spacemit sdhci driver (sdhci-of-k1.c) has no used i2c
> > api/function, it's just need I2C function via an indirect requirement,
> > which sdhci -> regulator(p1) -> i2c, besides, from the hardware design
> > perspective, it just happens that K1 use P1(via I2C) as PMIC, it's
> > totally possible(even in theory) to use other PMIC as power supply
> > control which may not be I2C interface (maybe use SPI, for example)
> >
> > If we want to solve this more gracefully, I'm in favor to add explict
> > option enabled in defconfig..
> >
> or I think it's better we do this way..
>
> +++ b/drivers/i2c/busses/Kconfig
> @@ -794,6 +794,7 @@ config I2C_K1
>         tristate "SpacemiT K1 I2C adapter"
>         depends on ARCH_SPACEMIT || COMPILE_TEST
>         depends on OF
> +       default ARCH_SPACEMIT

Thank you all for the feedback! I agree that enabling I2C_K1 by
default makes sense for the user experience.

To keep this patchset focused and avoid cross-subsystem complexity,
I'll send the I2C default configuration change as a separate patch to
the I2C maintainers after this series lands.

This way we can get the SD card support merged without delays while
still solving the dependency issue properly.

>
>
> --
> Yixun Lan (dlan)
