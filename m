Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85453570D2
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707877; cv=none; b=S5v2tvWV0C2HyTiuebzAIapSmoejfMyhaDWZ0m/VCQZ1VyvYQP5vIj0byhmz2xn95QGWtsfy5uMkgDzISC4Qeuz3QRA6kRgZ+YvWaFrCV+eVYkJW+4nyXptfrHJ8S7kNujOuSFV6+z3N6h0apqdrmH/3VtD2+0AFAQDtUqY5+6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707877; c=relaxed/simple;
	bh=H/E6eV4Q7AUMWgroZUZA6TBNnoUDvpB/AuCgLUH7pNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOc23wrNDzfN3EYpp7XOWGrdeZYq9LKfs9gySUBPTfLSyHGW2YPfSoLt/eT5MMViG4WjtvhOLa4I+uYU9M9w21W46Mn64L8/Fh001X4T5hsYWhdIWGEJFQix8DLxDwzDg715pDh49zJOBzTERFfferq+RagZC6aVfZ7G4/wkJ0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lqPAh5FK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lqPAh5FK"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7815092cd0aso22568927b3.2
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707875; x=1761312675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ya09/FJ0Jt2vkZFs3L65EX9oqmt3XQlAivywk/xyHOw=;
        b=lqPAh5FKKVXDN2Bmm1rMBYxhJtCsbWw/aifNqeDcxfWtQc/NBxsGNOxt4vGfA/mHSP
         SBQs3rgl+6/zcvgh5vvazZCBZpBAK/vRh+b1FWXOsQUOTBinh1n8SA0dR0TISWbWrUP6
         m/7GyUYDDMlk+Eaze24C9+Ba9ewKAp92Hzy6iZJFl99hADT0vyGEs9LI2tUyXGDlDCaw
         QMFeoeDqLl63PzFQEEGf9C1qxxBQLqj1n/EVS7PkKwCihMjvu0d6HUW11KEDQEq9slx+
         GYMHPzfhoAZg76RVfnd3V2j0XfVdYqNU9xaxW8OrjXKwJXSaZ2+8kuty5XZmFzfmyts8
         ipig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707875; x=1761312675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ya09/FJ0Jt2vkZFs3L65EX9oqmt3XQlAivywk/xyHOw=;
        b=vFMg3EIaBOVb3cbFofaU7Ggho7razIDEwwvGpl6YLTLFKp+7sR54HteS94pjG2Puhd
         NsLRNivGbgoiFvO41M+FrLyaNaKiX3NOvledWhvU2Wm+d1gOM9VxNFAh4DToxvLLkuNu
         hDVPZIguW4qJMJUJ8O3x7SONGNlgGz16v83T2jzO/wT7wqHYbhQmTPPNKdCA3xX5mcuq
         XbjXbYDFOb8YIGErG/Sxkf7nAv42fDgP+IF0JeCwK0dy4qYdvr/n8DUVxz8KZaChRqQ5
         81uYzwlBHuW5hmTnHC68yrhTh45adUXKDxNXyMFvYww4lmiGyU7lB9PQcXp9FkElhgh2
         2tzw==
X-Forwarded-Encrypted: i=1; AJvYcCX7Zn67BxsHnX1eT6TdPVuL4FkeiKO6CUeKEeL4TfEdWUr0zE+vtNtESZd80TDVLGok9UaPp0O/SBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzltAoIe/IL3tR/8eDQnNv2TQmvnp2DUrGIK28NvWqgFfZC6/5T
	xqmNT3YcZHLi3wYXnc5Un68AfEsNCklWcX7odikgS0GUv0LtGSBXMfxf7cVvw6XXvLcssw5tpys
	EAbfTN6ERFzx2cJID30MK0REpHtMeHVFNmnYjpBSAxfSJpWXS4k2c
X-Gm-Gg: ASbGncujA0fgAp7Lv+wVT11sBSlS5+sXAQHqYpUUgiGeUk2SZb6yuQQ4pccTC5gOT9d
	xrkH5vuvDwCt9GdHeILkq1srGWRocb3p4RBP1hPzzp4LdWSYFpD0p4GeU6bHUcIeA787sh0vNki
	Eo86f4oU7jXBxckgV9bN8LnC34sB7Dy6x4GFy3aQ2LfFtHPreDZsEHzcVZ6Kb5K32lgjlaYafI9
	iGAM+m0nZRUzqOL++qkcumZHry5QKGsdDfSpkyXy524sjyVUbhjzX/tf+APogDbGtABit6f
X-Google-Smtp-Source: AGHT+IHaMyplibGsKvyBsWf4d8oq0ZtFb9Ijd7iI1n1vX2MO6Zfy04PAud6LZQhNkNWoz2gofV0tnhz9h8UzU+Vv9kY=
X-Received: by 2002:a05:690e:2505:10b0:63c:efd6:c607 with SMTP id
 956f58d0204a3-63e160d904emr2631024d50.3.1760707874702; Fri, 17 Oct 2025
 06:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1760067445-165115-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1760067445-165115-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:37 +0200
X-Gm-Features: AS18NWDwfs0DQUBqQWJnaR7XpTfTNymg8CKiu65Cb0p3e4ukXpjx9CCcZmxG414
Message-ID: <CAPDyKFqM2bYJyY+JpTLh7zF-Kjs7HcZEX_JVHgPAyVzC9kWvkA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Use dma_set_mask_and_coherent() helper
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Oct 2025 at 05:37, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Use dma_set_mask_and_coherent() instead. No functional changes.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/host/dw_mmc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92b..c4f5f44 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3120,9 +3120,8 @@ static void dw_mci_init_dma(struct dw_mci *host)
>                         host->dma_64bit_address = 1;
>                         dev_info(host->dev,
>                                  "IDMAC supports 64-bit address mode.\n");
> -                       if (!dma_set_mask(host->dev, DMA_BIT_MASK(64)))
> -                               dma_set_coherent_mask(host->dev,
> -                                                     DMA_BIT_MASK(64));
> +                       if (dma_set_mask_and_coherent(host->dev, DMA_BIT_MASK(64)))
> +                               dev_info(host->dev, "Fail to set 64-bit DMA mask");
>                 } else {
>                         /* host supports IDMAC in 32-bit address mode */
>                         host->dma_64bit_address = 0;
> --
> 2.7.4
>
