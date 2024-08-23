Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73E13541B
	for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724410882; cv=none; b=ZyWD5iYjuX4lFeQChkDfcbjk1wOP2P5A6eUoDb+6Zk8/YkRBswApO63VMxWFFxcUPs4S4bPDhkK5xnYTAALvzYrea6g7WCXANVnCC4WegMbclRlnJaYtNTCKClqdIFByGQlJDX03NywRo9xrqRcfiXwTBouyL2/fQbyXUSH50c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724410882; c=relaxed/simple;
	bh=jCGcYJC3DcdlK/VJvH61PlRhurr+EMpSesr1zeYyMyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hLUQo62+7Dax3DtIYilPwHS1kILMckwDVpOGZt38PGLExVsO46nPQvuNRKmS7GWx6xaMhmcBmXDXph/DGOSm1evMZQlOJ/eU2iAoZNIZUG5L16wdFP6xuEzHf4b/SJA06UA6/OxbO09tQf1YsYsc7Wb6XR/i06IzUsFfypR9MIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dThpBYkL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dThpBYkL"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e16582cb9f9so1424604276.0
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2024 04:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724410879; x=1725015679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Etw9lAfOptH5bhz4rHuyZG/BeS9l3H1TyR0g0f0YHgo=;
        b=dThpBYkLrk15e3uITe6scEzGmQwLja/lXQOY6fECwjIzqgHPeP7+6aLPxkLQhYDcJG
         uflbgPnchpShL8hrmkdc+9DrIwpong3FX6fn4u9vPPFKRA7+YyLkFrSROssJO4zj6W8+
         zIqcsaD+L/VEHLSp2SPPmQUYNosnYQuEFBrXREutHfHXv14nnR1qjV2+cpGNxXHu0kwU
         P1f/V2AQ6ntvgcTMcDWlsLQhL8RRxPdmXPtylBOcc2BlqeLK8G9UY74nTdZXtFYiYpYq
         maHiLoq6AI1KlCKnQRY77p/BwYHKf1Osu9iatm+DtRzWDhxIOhdKZODRk+ycF3rBceJO
         WRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724410879; x=1725015679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Etw9lAfOptH5bhz4rHuyZG/BeS9l3H1TyR0g0f0YHgo=;
        b=KFjfH4XyFgeyz+SrcgIJkD5I3ZZT5ydACsRkXXNDICYTpcKScLrq6ypRNL7Zde0RCQ
         fYALxRmThyXxtSTBxoJq8+d2ZbTRrdCcMllPlZBjcKfSOqaB20jiq5QIfbj8Y4I6SyZf
         JHgdKhVCvzA30QHS3N026nT+AmornJ+/VrFpJMcRzHiznGO7fGo7ZikR+vX6Hor3X6Vn
         lZA+kaAN/f+6P5hZiV/zQdh23TeYWHXqh+lcEirlgJ/X1HOc4tSyTHV3eyCZkMGJR2h9
         +yBeLvSRJ0JAQR2cp6j/J9qFKizXy6QYId99567ZYqyJc71p0mG3ChbdCrohMOwlmXL3
         vG+A==
X-Forwarded-Encrypted: i=1; AJvYcCVENf18RUIXh8yZ4pquGQs+kdjnD0QX8Hzw5f1MLClpo1z4mCVlpNa1QQD/CPDOhtGZPtunQajn9p0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Nb0V2AS0VxWPw8qN/wXGwVI9sBywZmaIdlj6u1TdenMJyiZ8
	L4bgGC9FQCX+85391x/eFtN48XvtjdOYXPRS4RItmQc6U+e2ca4a7tqYKL4s/MXSDqIE8gR6762
	1uPKbYGfcrbZNzdpJ3MgXbf6ajFSVD+4U0JHEk4zLVgwTiT9Vx7A=
X-Google-Smtp-Source: AGHT+IGuTAUXYGuoFczcZ9F/O/HV4ODtqiVstn6XEgheiBsiZuK98u0eN9pDPYlFkhTi88W5GaiKyT/7b2gDM+Hwqys=
X-Received: by 2002:a25:6608:0:b0:e16:7070:97e6 with SMTP id
 3f1490d57ef6-e17764c6e59mr5879394276.9.1724410877637; Fri, 23 Aug 2024
 04:01:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240823071040epcas1p1309967537fb6286a9e67a38e598ce104@epcas1p1.samsung.com>
 <20240823071025.15410-1-sh8267.baek@samsung.com>
In-Reply-To: <20240823071025.15410-1-sh8267.baek@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 23 Aug 2024 13:00:40 +0200
Message-ID: <CAPDyKFpSf8GZppkqJCs1r990QXDJMHWHAbVXS2XoffCLQdgSug@mail.gmail.com>
Subject: Re: [PATCH] mmc : fix for check cqe halt.
To: Seunghwan Baek <sh8267.baek@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	ritesh.list@gmail.com, grant.jung@samsung.com, jt77.jang@samsung.com, 
	junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, 
	sh043.lee@samsung.com, cw9316.lee@samsung.com, wkon.kim@samsung.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Aug 2024 at 09:10, Seunghwan Baek <sh8267.baek@samsung.com> wrote:
>
> To check if mmc cqe is in halt state, need to check
> set/clear of CQHCI_HALT bit. At this time, we need to
> check with &, not &&. Therefore, code to check whether
> cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
>
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

Hi Seunghwan,

Please re-post to include some additional and needed maintainers.
./scripts/get_maintainer.pl drivers/mmc/host/cqhci-core.c should give
you the needed information.

Kind regards
Uffe

> ---
>  drivers/mmc/host/cqhci-core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index c14d7251d0bb..3d5bcb92c78e 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -282,7 +282,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>
>         cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>
> -       if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +       if (cqhci_halted(cq_host))
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>
>         mmc->cqe_on = true;
> @@ -617,7 +617,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 cqhci_writel(cq_host, 0, CQHCI_CTL);
>                 mmc->cqe_on = true;
>                 pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -               if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +               if (cqhci_halted(cq_host)) {
>                         pr_err("%s: cqhci: CQE failed to exit halt state\n",
>                                mmc_hostname(mmc));
>                 }
> --
> 2.17.1
>
