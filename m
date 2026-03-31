Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F213AA1B3
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955736; cv=pass; b=eo8hx9wo+NBznAmDvIK2Iw9xGvpGFBuQ3x9FN+lZYZvljDPxclWM6wjdSqbLuFrvTvJksyQgY/lHHkAARr0EOw3T3HjQKaZ3l7DkmFXLzRqyrRmB+yoVVq7UgMuU3ZlFTGZDw4M420zs6hUsj24fSEn9hEkevSggXcSnUqbNyfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955736; c=relaxed/simple;
	bh=GopF16/z5G8zNbMombGRfMDcN1FFx6IVv7WLuVmZ+h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKjUWon5AAS2NHm8BQfFqYeYJTJT+QJePK/W4X9ob2SjqEb1Xk2wus2kr4wp0EJEjd2pj89101qsbCnwriRJceFhJwseo/xRkNVPSp00K4RubP0+SrcUxZaNq1/gCfKdk0g8QcJQl5NTLfLAdDHKUbmKdOvCaFgRLtBweZfcoOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XRGBVMzW; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRGBVMzW"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a2a70bb69eso6005148e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955732; cv=none;
        d=google.com; s=arc-20240605;
        b=ivXPc11XRjhGHegE7ogslmdn6CbBY6eQLKLTJyht3CVBj9cR/kIK1jlkOkdVNupPAO
         jp+CTyBdG+owTecVznJbIiujaR53+JoPrDYxkcWuTfo6zmes+T1U0Tn2F7vyypJz1YTK
         +pGGfx10DSu9sJyeB5SfHTQ63WlG0o+GtAX1Burx4s26Stls7rIkTD4XpYyGKMt3S/GK
         s9FHjDRM0c9HqxzwuLTM7EFE144wWxOEXplGn7HFg70ulGe5jiU2wJ7ZInU9rzyMsn7G
         UCud+HdT77ivDLeqzL/fm6pG14fGYPjOREl7gDu9eCMJPA7oIN1ue4oEUB8AIh17i6td
         owpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gCDefte7tXHdky36Cv2hCqMPGKdB19SojrVcm46qsnI=;
        fh=jx5w+ARVd26zsqYuTU3R0VBkTOV1wxiIqABs4QYqcRk=;
        b=B6oGgMc45nDR+6k4Z8Wdk/lSAa0XanGmARSvOt1Jx0j2MWSGlvHt0qxq2bgb/y7c4s
         grgALjsvugDWsVqplIGNLLeWcxmdD1UiEu3F+Xht8W4Mx3pFcFhkMRi5WeJkt0qmGvGz
         dsTvSIyrJpyvyPJUNhWnHPrGbfMKyT7mH7Se0FtfC72woDm4meXu62LnZDf9Z71dQdJA
         j4NcF9be6FRHCmUVJi4YM7eOqyMn/HKHpPIMFDAmUuHTtBhBGZuooaVj0GqPuNH1Q/oK
         wCeOstgXwxZS5v8/BPaFitgJ989HHkOLSMxl/PWWmXoCW8lnS0e4LpHnev2joCfQR/8J
         h0RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955732; x=1775560532; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gCDefte7tXHdky36Cv2hCqMPGKdB19SojrVcm46qsnI=;
        b=XRGBVMzW4p+br6SSRcpisClkAEjK2DyEHqowYUZdZruowOiVEnEEnZ7KgXC/dn7H0E
         bAEKktZc74vpetu94m8q1Hg5/qmBzT+TYGEi+1etxE68Kb9XKdemIDn590WL37TZ1Icr
         g4GKUiufDA2QN6eIxfh8UilgF3EIm40ZD+Fuc4DLvcsiP+T5/sUcZF2sqCLsQAfLQEDd
         SygikCdVkyMwBso3TMlxdu5WuTGTvUqIVKWtGhVIjqrK7d7QIIQ+xUdXfXQr75tS6HTd
         FBBE007+81bYNCZD+YRazuH0WiM2GlGYKSy1zRkHUl994KUtiq3x5YkOMQyiPJka3KjJ
         bqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955732; x=1775560532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCDefte7tXHdky36Cv2hCqMPGKdB19SojrVcm46qsnI=;
        b=jpG3F6fJFA5uDP3igdw+D/SHRBEtKP4HRdkbg33WLQEYYcXQT+NdTFV9cZdXrKYNTI
         rqfR+8REQU1yGzeUM3vNckmwXOuFrTzwGheXKUu4XoOWjv/Dn2UtUM0ZTCKE/L4qpm5r
         U+yinkej4QRTzApR9az08tL8rMqt9J0PVMggRAWxnCy9AnkuBlwK24fvmYwdEy0IuVF/
         i8HcXnktR65Sk050D7z58TY+5c0WA80/18ErFG1ysGd3IENbf0JbnUGVXKN6h6fJoqxd
         xrTqwDx6FSK+pE7qPUvngSOveKuqkxx6Lmf9kVJMxK5sTogz2cQPVA4UeYet6FxYHMDn
         dk0Q==
X-Gm-Message-State: AOJu0YzO5RolFePUb+dz52og7izD3AJ4azcVXx6oxYclDwUGIKoaEM2q
	0L9eYAjnW+pRjqw0LdxR7UAiwoy7of3NnYNrnSesdDGV1rb6PJei+002YP3d1URc1pLdctIVg/K
	BBOuwdvIh0eSoiRncVvShUPFBBom2epjlrA/ZinvgfA==
X-Gm-Gg: ATEYQzycXPmGGc+Xg//9JVg6UNAYthk/jWa446NYl1NlBK0GUoxf1I2wLD+1bNCRV5W
	1lS99D40lGCHhrMkoTz5CFcCnXUux/6lJR7u6UIb/FOkvQprYZM4XIcFhFI4JFhtbvaMViZiN+R
	Qpv5/XmERYrAzb25JCo90EK1MM3qxokDGD5B3mIIvLpe+Jr0VupmaFqHJKzdWCGIpSZlctwYsuk
	XliE/n4Rg1ubsSS+fwHEkxvSYWMlIkHfXdLte7moTwhDeD0i6Dy/CgITx7j7SkraDjgtZbPk12f
	KVC9LS3+
X-Received: by 2002:a05:6512:3d05:b0:5a2:7cd6:d5eb with SMTP id
 2adb3069b0e04-5a2ab92614cmr7016114e87.27.1774955732039; Tue, 31 Mar 2026
 04:15:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org>
In-Reply-To: <20260327105208.1310739-1-johan@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:14:55 +0200
X-Gm-Features: AQROBzD0yBQiBTClmOkzWg73Q-KiS4v_3InnW1vFFShezN0TRysVka36_J_7rLo
Message-ID: <CAPDyKFpHD+kPq__C+gvxwRt5CSVxf6E0aTW9jrChQWa3Vvc4NQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: vub300: fix NULL-deref and UAF on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
>
> This series fixes lifetime issues that can lead to NULL pointer
> dereferences and use-after-free.

Patch1 and 2 applied for fixes and patch3 and 4 for next, thanks!

Kind regards
Uffe


>
> Included are also two related cleanups.
>
> Johan
>
>
> Johan Hovold (4):
>   mmc: vub300: fix NULL-deref on disconnect
>   mmc: vub300: fix use-after-free on disconnect
>   mmc: vub300: rename probe error labels
>   mmc: vub300: clean up module init
>
>  drivers/mmc/host/vub300.c | 70 +++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 32 deletions(-)
>
> --
> 2.52.0
>
