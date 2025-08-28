Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2432F270EBF
	for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 18:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756406021; cv=none; b=mwhhnvHL5OlZudQB+NPtzpO72XGXI7GTTe0y/KlD3ndAeHGMCMa6ysF0/x093IwynygV24tYk8dKFPW6H8H9JEdqRPk/6e9oizYD/qFIo1f18vGgODnpBKjD3+neLgD1DqFpsWqhX2lOmMJ8Iov7oYqv0GR75lsyIFglAZdo50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756406021; c=relaxed/simple;
	bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r1w5XOnjNGi7WwnRP39oxaQPWy/NuBxPPFpnYjHVQvTmXYGQKpxAHP8risgP61d5WA6JeLYt/0OsglAbuyJtWTyjiABFOFhDfdaddpkxej0AOPxA8CjD5/6TqWRC0YE+puhWZtaOpQHrhLRB+UXD+UNiJDp1Dki7YKIS4gc51gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogQ7rHo1; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogQ7rHo1"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-55f42dcbf4aso1301747e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 28 Aug 2025 11:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756406018; x=1757010818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
        b=ogQ7rHo1xUsh1MRii+DSgw79BIwRz1F5WcxON3n/wkvNlKijTpVC/UnPIEcbgpIt8C
         fj0seneEGr1pIaqZLwOkBfUCQTczUwNMhxErC4NlbMt7Pcn9g6oQclglzaQ71N8qSOWA
         BAYqezz4iM5ppEPnXfJGdpOGswdlzmYUZNyY4Kxz4L1Su8h4kXpPVk4zOIn57Vdqr8SX
         6JSslz3pscHIbA7Ox04Jdi3mRCfN7cx0cdky+GlQHGQ0TI53gc3vY0uOWWtye2+KPZmm
         VGrjDeTLP+mSoXmbzo++ENz/c/+VGtwvLKK2hEOJuU0hxDmkKZsVm/Vd8tO4IpopCT3C
         hxeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756406018; x=1757010818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ug7kHWgRNLIoSkrQx+bdDx9etZY66BZYRS/MMV25bdk=;
        b=gLuj7NuLJlbQsplHzmy8MsipkMnM3wOeEWtVFJQiRVuNHu5pCz5CYeGtSgJRMotSW0
         eO6Jc6FuiMISSd4i0R+5z9OoLfYexGOr3SzPQ7tMcShmSPvQBSc+I6uEcNj7kCVNjywZ
         oT26grmxc5cI5wbQA70Kb2Ca5+z29XSFgId6O7c96JquhYaknSf4ikb1pDwVSEe2ZfpA
         /GeEPP1SFQG4xBWgcnB7k/VWYmRGHjA2qgoHQ/gOhkN0QnQToTo+359vqj3tYbn/HLVY
         Wbjg9Y3Y9pufPcYsS1kmAzR2kRzCJNON/vS0lZEhXATRG0dSj700cvatvGYJ2dTah1QS
         Rwow==
X-Forwarded-Encrypted: i=1; AJvYcCVW/BgZBbCEtqz0sPWkBCsyKh36M+1PHJQfpJ2rUKLuLbO0gMhgU+7A4l8S66qkP5wRB+d/N2CrNRU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8hcmIqyAYELVCVOOafycpZI87D239YFnFrpQLFPeAFz5PHNN/
	6Ra92MQLNHC4x6haLcwSdPEmug9VW+qIlACq5iglvRzJsJTq1vS1RZkZTQWYbUCBEyfWfoyUBon
	a+ofEwuoOCPPi05N8py8y/mIsND9z8NnEBsOAucBckw==
X-Gm-Gg: ASbGncvrtAhyjKS5JIdMB0pOHT1zt4zB7MhwuFLroAa0+hw90MMEmevIgvkMxQPOECb
	RNUnGNTxjImpdDBKnviPvKyHjIg7eoqFhxJFHb5k2Cawz3r7KSk92dpTI+t1zHnKCHHUv+XPRmh
	0EDetghn4CK9HXUnJvXEqMEZE+lWaAuG0rmT/bb3H7Dt5E9I40MDA7W0MU2vVKt1bh5NoXkpwS0
	oQzCwA=
X-Google-Smtp-Source: AGHT+IGb4FhQgeb6pylU+foopmFlzVZy35WsHuHgEvOZCfi3ebP7rSk+t1LD48Shfg9PDb2NUWM5svtDXgFS2btqXyA=
X-Received: by 2002:a05:6512:6cd:b0:55f:4e8a:19a4 with SMTP id
 2adb3069b0e04-55f4e8a1b35mr3937880e87.23.1756406018199; Thu, 28 Aug 2025
 11:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826075812.82305-2-fourier.thomas@gmail.com>
In-Reply-To: <20250826075812.82305-2-fourier.thomas@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 20:33:27 +0200
X-Gm-Features: Ac12FXzCysAJtxk2vG2apRImmPlR_dR4-9QzpsS002mZ0t6e2m5C_RfHnYJm73c
Message-ID: <CACRpkdaVHTh7MJfngQ=qhe_ZfZxr7b025G=tAwsCvBfpXVYZEw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mvsdio: Fix dma_unmap_sg() nents value
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Nicolas Pitre <nico@fluxnic.net>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Pierre Ossman <drzeus@drzeus.cx>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 9:59=E2=80=AFAM Thomas Fourier <fourier.thomas@gmai=
l.com> wrote:

> The dma_unmap_sg() functions should be called with the same nents as the
> dma_map_sg(), not the value the map function returned.
>
> Fixes: 236caa7cc351 ("mmc: SDIO driver for Marvell SoCs")
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
