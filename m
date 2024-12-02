Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23AE1FECDE
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153035; cv=none; b=Og0D+6cCnr83OSSFanA9ffn/V2Bh09jRgPXPyN3dCNpCTBTLsbeMS2EmFysSxxfOU/5l3PhFKSO31TaAyxLq7y2JZp2ZAoBDt76Vrvq24W8lmew8P7DdxjQyPqOkdbFqxGv0hIsREOqIB464/lZ4+fe8eIHmAT4U2dYPMPoytfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153035; c=relaxed/simple;
	bh=x4Tp7Ji5tTFtDm+VDKryOJJHH8dzP3hI9Qi+1CIG/hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EBLS/ZZ6K2aC525IexG5161YhRJMaDxpKIoga516WOmhcY9znSlbp//gI49XTLd/Mm7eWufYBcbwLexeesxNKyK29tzp+XOrGI4KCghzuMfN5H57IRtD0Ice2wvxPrxwHy+vr9JGG8Tminx1PX5pEkmn1giqbi/0gbJBDZasAr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m9lbSeiv; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9lbSeiv"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e398dc7864dso2545873276.3
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153033; x=1733757833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFVdR4UZ/YOC85vUoT5PrPJ4wSmatK+AFc9PyWFNvm0=;
        b=m9lbSeivgwpx6yucNbV3fxczC4i6GKdJ/BYpgTN1Q5lJQ6CmHtdxUCh1Q5i4Ugwen2
         Po0V+JTplzLU2ebey8Qm3DTDqFBJZQS5k60DCJOlpoLr/sNncDiToV5+bZuL8j2t3Qle
         4q/pNBHKqk5AEZPwNy96n2m7ql9zGK1n0Ma+ewlnNy3ZcdJDJxdLNGr5cOODTp/Ef6rL
         YTlgQ2wgGg6Xcl9CTSdA4CNvs0HKrFpiXkKNA/mAzI/8ZaLN09Ftjq0896Mp/mdVgKBv
         pYqp+AH8FcTwu7lJ/rNfi2SeF/h3eK9gO+1odlHZIas1HAVdJL/cBFZ/h2HFXZu7jKCA
         S/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153033; x=1733757833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RFVdR4UZ/YOC85vUoT5PrPJ4wSmatK+AFc9PyWFNvm0=;
        b=vdtPBmhyF+VATKTCnbSDRWmmD/I2jWOr/sgF0f2Dri9rlmEW9ysq9ZiEOuzM3ddJVl
         +9JlpywhFf3cTXy7iNdE5qZoTPQhqgkTwykUQo/Tf1JRO/S6sIiTC6js6YhOs6joffvX
         RDUjHZpLknsAPuHak/o0+/U6tPy2Ju87JzPJ4aqJ+IM/Fq655WQ3Xq/9t4LxlS5ojxKT
         Q4IX/Pgq1RzXy0PKZ3yJHlFDN6WTdtSg48y8jEEd+oPVBL4Fwu1K4k1zczWEXK/A28tZ
         Ky5gfhK1oayx6iH/Y/2JysTnO+21Z6ZRFlYlrTDN00Lpm+QG7HXF6SA/Ow2VSpLdGwmk
         3p6w==
X-Forwarded-Encrypted: i=1; AJvYcCW6Ys34imI5CpKWe/PxLM8BP8mDFE3saGpWzzEIUvrxcRoDiis4bOc38ZhGnlHzCTf3HvK/1/ZvWM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUJQEcDaTyhGywsWUTGVJmYt81VYUryB8eVJ2RjIxcuYlr7yDF
	XOMjMBgxxfu/A5sHePEFiHMjI6d4kb8MqFtCqIFu3uNhzs5L9T4d5yyKUJ95nZTs/f3lqzneVs6
	LelTE6w9J/qLt+//7BS0N65xH47FHaYe9ucTUgQ==
X-Gm-Gg: ASbGncvn6j+IxdMEAT9llojD3hhBVFXm6HEixdEHm09AbaEsoFoMb4GijKHCApw1xfa
	QRfa7GvQBlVh7t/9+zc0jRijBmlYFylpO
X-Google-Smtp-Source: AGHT+IF8HcEhaGeG2oqxVopeez9Li3zfibcXSVN0OW0uxE+KbdEUAIh+uLlgcKcOPw0eaKI+msrsmL/CnlhvivMzcCI=
X-Received: by 2002:a05:6902:2b86:b0:e38:91e2:5173 with SMTP id
 3f1490d57ef6-e395b87336amr19485704276.8.1733153032680; Mon, 02 Dec 2024
 07:23:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118210049.311079-1-hdegoede@redhat.com> <CAPDyKFov29aLGq4vmTZB45mfkLEAAsC_NMCv2u858K9XPdCPkg@mail.gmail.com>
 <29949ef6-9c55-48a3-a96e-67cb78b96766@redhat.com>
In-Reply-To: <29949ef6-9c55-48a3-a96e-67cb78b96766@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:16 +0100
Message-ID: <CAPDyKFowzQGh1Z3RoWVFVjxQtf_s+tjo1X0hQ9KDb+KLCSt8wA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci-pci: Add DMI quirk for missing CD GPIO on
 Vexia Edu Atla 10 tablet
To: Hans de Goede <hdegoede@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 20 Nov 2024 at 14:16, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Ulf,
>
> On 20-Nov-24 1:56 PM, Ulf Hansson wrote:
> > On Mon, 18 Nov 2024 at 22:01, Hans de Goede <hdegoede@redhat.com> wrote=
:
> >>
> >> The Vexia Edu Atla 10 tablet distributed to schools in the Spanish
> >> Andaluc=C3=ADa region has no ACPI fwnode associated with the SDHCI con=
troller
> >> for its microsd-slot and thus has no ACPI GPIO resource info.
> >>
> >> This causes the following error to be logged and the slot to not work:
> >> [   10.572113] sdhci-pci 0000:00:12.0: failed to setup card detect gpi=
o
> >>
> >> Add a DMI quirk table for providing gpiod_lookup_tables with manually
> >> provided CD GPIO info and use this DMI table to provide the CD GPIO in=
fo
> >> on this tablet. This fixes the microsd-slot not working.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > I assume we should tag this for stable kernels,
>
> Yes please.
>
> > but can we find a fixes tag too?
>
> This is really a hw / firmware bug not a kernel issue, so I cannot
> really come up with a specific commit to point to as being fixed by
> this.

Okay!

v4 applied for fixes and by adding a stable-tag, thanks!

[...]

Kind regards
Uffe
