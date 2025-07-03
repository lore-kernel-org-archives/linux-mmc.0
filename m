Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738AD2E3AE1
	for <linux-mmc@vger.kernel.org>; Thu,  3 Jul 2025 12:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751545202; cv=none; b=FfQYoCsBcQ26mD+O9r51S5SYolxrf0gw0Ka2EswHMv2SeDTtUDUhCFF4RjD2cdwapezAs3ft4eallp1LdTFJAvNk+xsbAn38f+KAw9YjqIjOBU1aAo7ZthqbN6Iu7uRKkUSAMVFm0NcuQh6DFYbeVb7nt+ziqOSrLkVCQIuLcJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751545202; c=relaxed/simple;
	bh=kKL3IDHxSL9ur5slPrsn/ZT6vo1aStrKbY0F9D9k7cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shWodr6f+vTg8EFF0PWV4BSaG7NaiyWL914vMEO32RHiJuqtgyrCZ7qx66cD2U8uV4RsJ5Q91/ahTnoiGbjGO5XSb8sLpAmkGV16r8a5Sr/sDOU7zKpVMkviT03yVPpc+ToAw21cZMd1kVy4k07J/E2rM+jLYT5V/Oluuf7h/Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mUGzxWfL; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUGzxWfL"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e733a6ff491so5196016276.2
        for <linux-mmc@vger.kernel.org>; Thu, 03 Jul 2025 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751545199; x=1752149999; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5OmxI4SidnpS0vVfCbFw2K2gtQJNYphQeO8RrhcQo8=;
        b=mUGzxWfLcANgIxZC82zeORoSi9LpLxJy/TrmbbrTWvsWDXtbUhAMg7g/UfWKxCiLdx
         pWg9dQnI5SRs4wpZWbevVtXSYFK1A/wXGbrrrVDSBqsEG7U0D6INKcOnnUbFU6iksZ5K
         wqbVe1R5YEEeFeNJVXKZSWzyfWe0dJ/FvV2CLvMIyEPrCjN/idtFvrNrKJT/hHWDfYlH
         idUDFdL3MWn5fjFuOZyAiVx6wDx5puarMwaCDb0H+wlqE4wHrMSms6P00vMY7ZIGGYFZ
         pxQ7Qq4kRnttqwTEdMznfEsA7ly806I0CbvOUkMdIuFEoOiadaJ5wbsRjZsk1P6K93T2
         LIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751545199; x=1752149999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P5OmxI4SidnpS0vVfCbFw2K2gtQJNYphQeO8RrhcQo8=;
        b=uKbuTpN06vAdO9C3Xa5Be/8uIrG842Y6TcPZOZ/Zx0bqVuXzX2OwiylQI+LDCt0cM5
         CwTrUnlLHsOXJxOg/TQd8u6blvIEeTezlqHe5NzdoFWfTl/iOFpwzKdH26refb0NLd45
         jOpt92bTYaIeFcF508NA/jz4y7CzOd1e+/04kn/p26OU/5ycrNEVH1XINFXM3vXJ4wjS
         FOSU1CpUehVqcteC/3MKRHosvoy4zNs447VZTjlVi23NUEwdTBfOR7Sm4ssNzTvh3QYE
         HwIDCbEXrvtxvPw07wBWZw/uw5m91pViCf95k6agiDbKyb6BnF+IgDRjipNnoWscR1zU
         i8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXEofPeezj/USiB3fjhGIdIBo/C/yv0Z7Tppy3/s3aomMthqm/urdbiwwkLt38kLmnT22rtFuZFpJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzURklwp8VGrlGCk0bfFuBPTDne+cByeWDybSVpxGy8+xSH8YEE
	PzB0tP+ToE3yl+CT6YlpS7iTyvLZ3dnF8PpPBTYYmJaqswZlAC5EkfWu+LiWwFWt2XSp59VB1uK
	P1dyj2P06iT87IQM5koc4RIHk4f9KkFwErtt6vViD28GVdS0UnDHw
X-Gm-Gg: ASbGncuxT02J0gieF48hjHy6tHy7+aq0v0jKhnJEVo4ZN+5lTSRpoMZM0b9X68gNkpW
	UKYQZMXzb6GXz/z6+QZiklzSry97XeMjI6onVCxDQcKO9pUP6EwDkcyptdVzDaRb6dQMNVubLC2
	Mx4jvjQPEFr7QeQkQe48iXm++p7sMDzF1Lv2qqWhhmJeuX
X-Google-Smtp-Source: AGHT+IGeQ25BfOeCZ6K58In/sB8b1ZR/YJwrPf+U8PqmfpS8N2JgDxJX3EH5egsVw60A4HjnBNqsJSLLaMm5U7EBU3c=
X-Received: by 2002:a05:690c:4802:b0:714:268:a9f8 with SMTP id
 00721157ae682-716590ec815mr46729757b3.27.1751545199558; Thu, 03 Jul 2025
 05:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626112442.9791-1-edson.drosdeck@gmail.com>
 <81d519f5-caac-4fd8-8491-3580ce1b6060@intel.com> <CAMSsBRyvdvxgAQMkoB3UTZUs8MDEdPEVcKh2fFto6TFz-hUeiA@mail.gmail.com>
In-Reply-To: <CAMSsBRyvdvxgAQMkoB3UTZUs8MDEdPEVcKh2fFto6TFz-hUeiA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Jul 2025 14:19:23 +0200
X-Gm-Features: Ac12FXz3uWlhWrNuVR3FR61kkpyGiUJaNlibnmXBnTwXEWNnSDIxaj442r_4-YA
Message-ID: <CAPDyKFrLBV=AwDTiSC14N+qBknU+zM7bK-Vtj4a=c+byiUOgZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Quirk for broken command queuing on Intel
 GLK-based Positivo models
To: edson drosdeck <edson.drosdeck@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Jul 2025 at 01:07, edson drosdeck <edson.drosdeck@gmail.com> wrot=
e:
>
> Thanks for the feedback!
>
> Just to confirm: should I resend this as v2 with the corrected subject li=
ne?

No need for that this time.

I have applied it for fixes and amended the patch according to
Adrian's suggestions, thanks!

Kind regards
Uffe


>
> Best regards,
> Edson Juliano Drosdeck
>
>
> Em qui., 26 de jun. de 2025 =C3=A0s 11:05, Adrian Hunter
> <adrian.hunter@intel.com> escreveu:
> >
> > On 26/06/2025 14:24, Edson Juliano Drosdeck wrote:
> > > Disable command queuing on Intel GLK-based Positivo models.
> > >
> > > Without this quirk, CQE (Command Queuing Engine) causes instability
> > > or I/O errors during operation. Disabling it ensures stable
> > > operation on affected devices.
> > >
> > > Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
> >
> > Subject would normally begin "mmc: sdhci-pci:" instead of "mmc: sdhci:"
> >
> > Otherwise:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> >
> > Also I guess:
> >
> > Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on =
Intel GLK")
> > Cc: stable@vger.kernel.org
> >
> > > ---
> > >  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdh=
ci-pci-core.c
> > > index 13a84b9309e0..e3877a1c72a9 100644
> > > --- a/drivers/mmc/host/sdhci-pci-core.c
> > > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > > @@ -913,7 +913,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slo=
t *slot)
> > >  {
> > >       return slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_GLK_=
EMMC &&
> > >              (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> > > -             dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> > > +             dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> > > +             dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
> > >  }
> > >
> > >  static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
> >
