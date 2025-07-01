Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2624326B778;
	Tue,  1 Jul 2025 23:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751411246; cv=none; b=D+7crq3HOQdVbzKU/R97M76xYL8Vok5lv2AfjC5hPazUhaW83q98QsxgR4ZMU94M8DQ9aEWmVkQOL2uz82gL0SoIBudbCFO2ISM7jJPQxogLdVwnThX0/7JVbcoJB9JeDB6g+3sIvrBxk5xvUWxeuRCEer7/sHYMKfkHahYQZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751411246; c=relaxed/simple;
	bh=bnXTIZnt58zVSPw/pEjUapov8qNztfK+SHcFgBsY7Cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=faxqtn2NxT5mb7x/IcKYUr2m9P3vrDmX+JiCPIT51jtSyekpO+zh6uIW/ysXWOTaLlSOhIgqSlr+ZlyyO/IT1tjXN3bNtbbfFqXy1zJR/yTfRlJYLByXl553VOBUl0IdyFEO+Q1+IoJNOrW0Sk1Cm55YCAlUN/IZd8g4wAzotsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nonsCkF8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nonsCkF8"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70b4e497d96so40429707b3.2;
        Tue, 01 Jul 2025 16:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751411244; x=1752016044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMvtvKjN1VkA8wKzZDJDW7JlV40jKbOqdJBCEdXm5u4=;
        b=nonsCkF8GwHLXcb4KP4v6S6+HBSbOG0xfal1IUIxrBJC6VzzrPVS9eT7tQA3my/bVU
         jGWoBwjru4OTNiGjWzprydjCfEcGEECyByma63Rq52O6nhVmDdGdeCxk91DyRMKkGMrS
         qm3ed1YYjyhBLJ/hLYJlYl7ON7OUNP4zXIYDZfWg+wqbTb+4Z9s/Xxq3FpSMhLf6q3db
         JZ9BBJZHC1SOq2rP9ZFQI30tmVRRrnsk1Rd37y5WpQVknkBMiR1XGqj10DL5BEreR5FZ
         SZ+NpE7TyIuB7scqAanC3NaFrppwdz+bBd1i/nXNBLW08kOyQbAeypKV+5fzdj4yS/+J
         WZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751411244; x=1752016044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMvtvKjN1VkA8wKzZDJDW7JlV40jKbOqdJBCEdXm5u4=;
        b=iW+lTVYr8QthGva9VnhwhsuMs4f6918l488l6t10ifqczu7AZKU63rciOldNyqVp9a
         rqw1dUZMrFYS2CwALOItu6LZeUF16VYbF0dw9aIAxFbTztM3qSRgkLGlmiuwO0C3mtCS
         8HiOpt1LJnfib5RDolFr+6cqiPko8r/YmkSIYYgwc//xCrs08+gft5+kNWd929fTZEtn
         zrISrrYb7C3JTC45ZXOWkjwWqVenGzReIpYDFf2DNQbtpvZelJy1+GmC6r8yMquS6sVi
         hTJzw1fO4hVVx7vN1NmEGP5b7ey7VsraMddDrYSwwPf0xP7BKEVRf6wWhHkCH7hwHPPI
         VaiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVaKV1rAJ9a+ewXanj32Xv5LCsErThMv5ClHItB5yuYfrIokRlf13f6Q95k+aV45w/flvVGd+09SuaY@vger.kernel.org, AJvYcCXQKKG83ZGswe/NbMJk61R5pxRDZE11de3iFQJOiY3qKPujL6DFqUedytZsYWT26nFgWLyEvTZWDVODp40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzo/uflX2z8eakzfnSHMmkWtsu1EaotAKndp00asu1wu0sU9xm
	/H6iPQzf8XyumHXD7gvVFUH4HMy4NlxPp2wLicyXnuoYxadKGr9rdJhhHDW6/Jmt4czgzpI7nR6
	hp+dGQ8tlGkCQqNSuCEEu7CQW4wZ/hO+a11uL
X-Gm-Gg: ASbGncs+BEahjZseOHVlV1/sgHFu4bXbEA7H4ucXzX7y9zlfvu/2gnxaRW4nambyw6A
	YT05qEBz9DRFk7fBo3gWb6eM3r5epNM/0RwqATNquVlq/hDx3xF+4cSia8tSxQk0VEGl3qmSyW7
	xLCzkpgR9NItl99j0IK6OV+wLyMYzs1kAMaQARfPLMBj4=
X-Google-Smtp-Source: AGHT+IEGaS/WiSVuPkrKC2Aspd+RJF5lL9pe4j8I9V0Wl3UrVrluyjV+862CCo8SBEYbP/Uk69mRFgePhEm5E20ZcXY=
X-Received: by 2002:a05:690c:601:b0:712:c295:d013 with SMTP id
 00721157ae682-7164d4cdc31mr7795347b3.34.1751411244062; Tue, 01 Jul 2025
 16:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626112442.9791-1-edson.drosdeck@gmail.com> <81d519f5-caac-4fd8-8491-3580ce1b6060@intel.com>
In-Reply-To: <81d519f5-caac-4fd8-8491-3580ce1b6060@intel.com>
From: edson drosdeck <edson.drosdeck@gmail.com>
Date: Tue, 1 Jul 2025 20:07:13 -0300
X-Gm-Features: Ac12FXyhcrJppyQrjbVm1J80uP3O7bfD9uEOLb3JAKhyqWDSYc7tA0G2wVJMA-E
Message-ID: <CAMSsBRyvdvxgAQMkoB3UTZUs8MDEdPEVcKh2fFto6TFz-hUeiA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: Quirk for broken command queuing on Intel
 GLK-based Positivo models
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback!

Just to confirm: should I resend this as v2 with the corrected subject line=
?

Best regards,
Edson Juliano Drosdeck


Em qui., 26 de jun. de 2025 =C3=A0s 11:05, Adrian Hunter
<adrian.hunter@intel.com> escreveu:
>
> On 26/06/2025 14:24, Edson Juliano Drosdeck wrote:
> > Disable command queuing on Intel GLK-based Positivo models.
> >
> > Without this quirk, CQE (Command Queuing Engine) causes instability
> > or I/O errors during operation. Disabling it ensures stable
> > operation on affected devices.
> >
> > Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>
>
> Subject would normally begin "mmc: sdhci-pci:" instead of "mmc: sdhci:"
>
> Otherwise:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Also I guess:
>
> Fixes: bedf9fc01ff1 ("mmc: sdhci: Workaround broken command queuing on In=
tel GLK")
> Cc: stable@vger.kernel.org
>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci=
-pci-core.c
> > index 13a84b9309e0..e3877a1c72a9 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -913,7 +913,8 @@ static bool glk_broken_cqhci(struct sdhci_pci_slot =
*slot)
> >  {
> >       return slot->chip->pdev->device =3D=3D PCI_DEVICE_ID_INTEL_GLK_EM=
MC &&
> >              (dmi_match(DMI_BIOS_VENDOR, "LENOVO") ||
> > -             dmi_match(DMI_SYS_VENDOR, "IRBIS"));
> > +             dmi_match(DMI_SYS_VENDOR, "IRBIS") ||
> > +             dmi_match(DMI_SYS_VENDOR, "Positivo Tecnologia SA"));
> >  }
> >
> >  static bool jsl_broken_hs400es(struct sdhci_pci_slot *slot)
>
