Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B628BAA6
	for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 15:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777878; cv=none; b=bKdXF8RE/poYk7IGOL33Nz7A8foUPA6LMlaY6dq5Y1duqgKqZPg6UACPkrqPnTvXLioJ5hsdsFNh9inX8po6leXyAMqsMv8hWDMPtVUD6Ru4WsJL52bkRYb03oJgRYJ8/yIhtiX+VYHEvcLSFemR30pBK4eOWzz+NsRCgr7uk+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777878; c=relaxed/simple;
	bh=zM/4jnIerkh7BjJTADhSaTiNt1HHSQSU60svEA3kA8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K99a0N2FtSL3vPFCVzxYyOH6/Jxjt2aQzraPoZ7lJt083UJ23d1xstim0X4nyFelNun55qlRU4R8OJ+WejuywJZtoj2m9tSu6OoJ+Yv+UrdOKPLvvH/rz3nhP1HugYK22b8v6URcUHUzQOTbebcI75hwEW1wlBvLPwAyS1DQmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ttm8QQto; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ttm8QQto"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e7b4ba530feso4626826276.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Jun 2025 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750777875; x=1751382675; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cZyvelbjEQEqEmmuqZpMjpZROwmzP7cZ0+TBAMIzE3c=;
        b=ttm8QQtoAfImb6IPSHdfoIHB047p/QQ4euFwPDTKS86gxRHUreF4lho6PCKwtGXHCq
         seqGUuhgvkzKWXAKxRFq/4aJBK5wEQK5IFUndCC333jzpmOAEdmvAgJXEjOUbbmuEr2B
         lDlWTaao/yz7Qo1Y3WVOSAxJBjT6LGNjUj1lblRfOe2fPmQVKOSl0vFiahNUZiUb7F84
         HkJGw/ZWuglaVOX4c5z8pJg00sw3sUGioK73cv+NVFct4oInq6pWMAYra+WUsEzWoS7a
         RqMOVGIs0tbpCgdUuEP1GCDW3YpKPfMDQH1M6ScDRzFRGaiEHuiPKbi8XKMaO2HSVqZ9
         4SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750777875; x=1751382675;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cZyvelbjEQEqEmmuqZpMjpZROwmzP7cZ0+TBAMIzE3c=;
        b=DJPX1+KxyRF0PTlCDXMWpCcMXBnt/sP0ll0mVB2GQh2JnuPKz/6Qvlsd3IKEj6iPMr
         mJ3uX66hnrWEqSxl+JlGOf0LMGaeJCulsFgZbFWUNO+vOTS/4AeeKIBIOZi5DAlYADne
         mz/iFZtPW3VJ3slqiqtnrqWHhUcVJuCqR00ukdQ0BbPyfy1yC0qM2V5a9r+ntYqIAVW9
         P9+2RKfUQjbYosDTYl3IKkhj5cGMRzkGfJJxMtbwkG9p/UH01IXm7J/Had1pGvv2J+4Z
         cYpxB7NRtFPBS3bJEa6gCo2YKf9DkAUQZztuNNsShBI0CwNxRAlIVaaqfETg92bPrp+V
         sN3g==
X-Gm-Message-State: AOJu0Ywgkgh6ZAgsr8AaWOUjpta42wD49hMEv8tv8ugQYCmPjhZT1Vlj
	Z94EiuCUAxGsYwieomwMKMKykrgNPy0FGAj4vTQsi47UdU36nL2SBme5pF8683kTF+YsHHJRjb3
	jLkjRI+lqC+LCNLat5+bI4BLukqk3QLRF8tdKbPo2sXWcMa3Nwqoc
X-Gm-Gg: ASbGncs9CqGDXvjdqtpC7K7yp58uPf0Sf5dbx9z5CrmeZIzdgylPpNph94e5klnyEol
	dc3IgJU/2MPm5d3zvOhQc/lGI6hGU8ZRgMMIspyZOOYpvDICKzcTpZleNbRotBQKLP74373NCjO
	ACIA3QdnsaAO9phPJxX9wPW4V9cQAbVXLiJzOcGa85rmqoPjN9xi0tF0E=
X-Google-Smtp-Source: AGHT+IE2YE2dMSoRUC1FPE3vSTuYpaQnqEVAkIyEcbadurpq23DwVzL6j1/CsQ4NunZ53te+NMSVqJITZAanvE3PsSk=
X-Received: by 2002:a05:6902:90f:b0:e7d:d162:f15a with SMTP id
 3f1490d57ef6-e842bcffd85mr21917789276.40.1750777874952; Tue, 24 Jun 2025
 08:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623083300.236198-1-avri.altman@sandisk.com>
In-Reply-To: <20250623083300.236198-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Jun 2025 17:10:38 +0200
X-Gm-Features: Ac12FXzV_soGEtGVuddYArCOoZdvY38aovMRR3EnbzgnCNKc0Cna3LWar9M0LdQ
Message-ID: <CAPDyKFohJ4CXWWb0cqgTsFH1TRyKdknZ45su8B=wRToDysSRUA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Pass key_mac buffer to rpmb_get_key()
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, Simon Lindhorst <s.lindhorst@wut.de>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Jun 2025 at 10:40, Avri Altman <avri.altman@sandisk.com> wrote:
>
> This patch fixes an issue where the key_mac buffer was not passed to
> rpmb_get_key() in do_rpmb_write_key(), which could result in incorrect
> key handling during RPMB key programming.
>
> This is a resend of a patch originally submitted by Simon Lindhorst,
> which was previously rejected due to formatting issues.
>
> Fixes: 05051e40351c ("mmc-utils: Refactor RPMB key handling into a separate function")
> Signed-off-by: Simon Lindhorst <s.lindhorst@wut.de>
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Applied for master (and included in the v1.0 release), thanks!

Kind regards
Uffe


> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b2cc3d6..7994223 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2289,7 +2289,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>                 exit(1);
>         }
>
> -       ret = rpmb_get_key(argv[2], &frame_in, NULL, false);
> +       ret = rpmb_get_key(argv[2], &frame_in, frame_in.key_mac, false);
>         if (ret)
>                 return ret;
>         /* Execute RPMB op */
> --
> 2.25.1
>
