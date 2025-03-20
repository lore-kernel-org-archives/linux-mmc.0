Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152921EB1B7
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480242; cv=none; b=g+JsP1Jc57ricZ8N2zMW/nRBScCyNjOG78gePlCRrNNWOtHrFE3+I4h2U9+3azA0p7S6ktPXm0gBoawsVikzonlOcS4SU2dW63lfZawcPyDVqGh0QCuuydVir7kW1Dcavzhor6tJC7Bm7k/CZOSj7mh/3ud2/lKKNwQvMbFpzfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480242; c=relaxed/simple;
	bh=IlVHcIUwTHDGDzWDxXw5mj5DevpjPK7OG62Ebrk4Y4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvDWkI8ekt9RUYCUSe8uO/1fU1foSxYybnPQM4mDn7Fzn5HOEa0BXZHNO6mor5MiTpu8zaWu1xWUJSshB6ouBTEcml+SjKqXsL20zfpSvxeb4o3TDhTz9QG0NrZu7BRXfeAI1vSycy50NdbdZfkF1EManNBfAa8DqPShflNUO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yH341I71; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yH341I71"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6efe4e3d698so8059387b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480239; x=1743085039; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xySvCJOLXrJepe3VbecFXnHY3VhWrdBNrIlRTw8Fv1g=;
        b=yH341I713lDiSX1SY3WFEQA7JglWeuuC38Ol45MeEcnrxHS1VqM39X6+C5gVJOSC2+
         ZGMThva2x7TJeYf756XsosMAqoIggCW9FfgecGRkicoyLLp2Ec7S5rc0icfqZ6edTETM
         qktyBuOvF5VNVJHeh/4aHMQ4IZLbiuxgHM4FhODXv7voLi35xvvX4yyFkBr1H9SrHfET
         D8O5XCr8U9JfLdwOZUtZMINP0Gxp/0lg4t5RE0PbcxPh937L5x05e07jLfqEFF/ZgTg+
         8C8CokPFk7cLI5F84OOZ9HJD55pkrldGM/+CqOqtbuuOQuGTusYqMokVtVFbyIV5CGsk
         Lo2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480239; x=1743085039;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xySvCJOLXrJepe3VbecFXnHY3VhWrdBNrIlRTw8Fv1g=;
        b=wLIbsXUR+J1fpfluk3bpKb+YeX+cbjktp+lVg0m7wYCvS/wCuogQwrv6FBZYTtbR3d
         5+48dXd2qSJ2EEOKEtalpBJI+ik3AbOv4z9xEupuBqC9nTi5FSLO1lR6QYtRi5gVRSuG
         O/UJp/0DgBzA/c3TO2n1VA0XGm3oYBZ8cOGjyyZdPIfWWmgoUTs+oDHR5mxISkr2H+Nv
         8l5UEXNm3VvVgkib8Ecg6XfZboHy6bwkGfZ3WD3cjqjHpJWsLUYq5oqF7Xi7QK8gjAxJ
         yKp1uGKyok+M9Esagdtakp67AFK4SpP2FJgbneiUgdjSFBlf4osd5+/HN3ufMjmR6ybz
         xRyA==
X-Gm-Message-State: AOJu0YwMFCmXZnJN/iLQyyg+iItNi42KtL2o9XLdsmo/eU7Nv6YI20bi
	x58ZS507Uf6k9SO5XFmimGIuK2GS7J+Qvlabp3p5UTvVUoKYIJ8zRRQ4daKebEOx+2ud1CqUD7S
	Ly7cabp+p7G9E1Yjy6pCmnrNziw0z/eF5YcIxFx8ZQBq6A9Gg
X-Gm-Gg: ASbGncsZn3UzJtU5/NUrzLFvN1WPxbSj/lTNTHmMzaxN7pEATFZbTjVw4NjfDNBUuv3
	FrlcJGgRW8wnHnN2ZNNwZ3yLItCIio1G5YeF56ZgqllAIGlLMliu5ZytDRRzEo/g3QJOPrqcMvF
	CHcM32bMrCQUQiZfEMJVFw0SkeUeczxctl2acx6w==
X-Google-Smtp-Source: AGHT+IGgko416faeQRVE2tkudUuv/QKn021Rg6RvuC8kA3YkTzF42evnEbm/C8UtKjUS0Ha5DCyXu9VOZNGFENIJ0+k=
X-Received: by 2002:a05:690c:48c3:b0:6fd:4670:80e5 with SMTP id
 00721157ae682-700ac6e4fd7mr46108777b3.35.1742480238782; Thu, 20 Mar 2025
 07:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314195021.1588090-1-erick.shepherd@ni.com> <5081fa69-32cb-4fd4-bad5-5f33032efc39@intel.com>
In-Reply-To: <5081fa69-32cb-4fd4-bad5-5f33032efc39@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 15:16:43 +0100
X-Gm-Features: AQ5f1Jq7_vidRskaRn7KoiZCLYWPvDdfRXWjX4kSgM-fVSs5UbHOgXr8XZ3krpg
Message-ID: <CAPDyKFrOWHGVNHtKpaY02AXV9AV0NT6LoK2grcN9FTQmVOj7kA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: host: Wait for Vdd to settle on card power off
To: Adrian Hunter <adrian.hunter@intel.com>, Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Mar 2025 at 08:26, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 14/03/25 21:50, Erick Shepherd wrote:
> > The SD spec version 6.0 section 6.4.1.5 requires that Vdd must be
> > lowered to less than 0.5V for a minimum of 1 ms when powering off a
> > card. Increase wait to 15 ms so that voltage has time to drain down
> > to 0.5V and cards can power off correctly. Issues with voltage drain
> > time were only observed on Apollo Lake and Bay Trail host controllers
> > so this fix is limited to those devices.
> >
> > Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
>
> Can we leave a blank line after the block.  It was that way before.
>
> With that, you can add:
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Applied for next with the suggested change, thanks!

Kind regards
Uffe


>
> > ---
> >  drivers/mmc/host/sdhci-pci-core.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 1f0bd723f011..b1f7c11ea61e 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -610,9 +610,12 @@ static void sdhci_intel_set_power(struct sdhci_host *host, unsigned char mode,
> >
> >       sdhci_set_power(host, mode, vdd);
> >
> > -     if (mode == MMC_POWER_OFF)
> > +     if (mode == MMC_POWER_OFF) {
> > +             if (slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_APL_SD ||
> > +                 slot->chip->pdev->device == PCI_DEVICE_ID_INTEL_BYT_SD)
> > +                     usleep_range(15000, 17500);
> >               return;
> > -
> > +     }
>
> Blank line here
>
> >       /*
> >        * Bus power might not enable after D3 -> D0 transition due to the
> >        * present state not yet having propagated. Retry for up to 2ms.
>
