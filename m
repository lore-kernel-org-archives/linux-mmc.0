Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EE720ADD2
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 15:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153072; cv=none; b=UzuJ45jh5Gd+Qi0byRXYUA0eGVzhr2LiOsh8ox7Jan3QfL/tF5+43Sn8uQtEZ5gZYhq3lixPq9zmR1g5cGnkovbuI3OACQoKJ1SRw5rk87A6HcteqIMcBLz0S7i5MM+n5Kob+6rO0gvRMhxnzcC1FE8t6zmKG0cbaolAjg3Xxgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153072; c=relaxed/simple;
	bh=3gPoqlU/lVE5xUuM0NiL+r0pSn8/8rHBVsYTlF7NftA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZpsZRWvxlfgEz/1gBTVwk/bvlOBoy/FrjpPuD6bgRWeF5GHFS0sSuvchorXYMEVBZdbcvdA4wXaM/0H5Kmv/DTQvFguilOMfZZp7ipLTfQv2FkIOsNg+QGk7RzvHKgW0iPhEXpfCgFALssdLV5E+67hno7wzoslk0i52xOx7Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iwq3+P7i; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwq3+P7i"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0875f1e9edso3565453276.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733153068; x=1733757868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YjTimCeXKhqZkZ2I4f+pexjlxgsq58p8L6qd2thgsT8=;
        b=iwq3+P7iJnd9FSww65hMYq52EqsRfn9fElg8M/j2fyg+i0z/KkzZYB3+/RShyg6kxh
         4uCCdBYOUrF5Z+Hr+J4ru4VC7ixE94NUqwj6myg/ddNoatcAQ/5WV9Lbm5A5odXk7aU7
         xGM0HFIwFbYfmdGMHc5aHbjhik3LxmaOxcsVUxkJqIaUBdpmgCObKdh9dFQJlgbdAayH
         w7jmGtLT2D6j8qpVGSbzTil5pAs2bCi3+j4K9VlvDOwz3BJqmFbn/KjZCx4cDdb60PDC
         oJrZm91bBipDOfZ/nIMtjuMs4bDpMetYA/p/EqjEU76ciraeFhDKAAsOrPGrPHITXtXL
         FSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733153068; x=1733757868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YjTimCeXKhqZkZ2I4f+pexjlxgsq58p8L6qd2thgsT8=;
        b=tz/kOiysk8xwFs2Cmy6CrWWBuPReN+v0vBumt/YZB1AUUsgKVWxI/nhmYHJETalqfM
         uEifeLWCPYUHkK/TlZ8tlnOpV5/3HMi17WRjrthvuU/YKgVuNrd/90xuqEOmTN0C6lp6
         XWSz17Hxog7Z//ZeGYu2uuakut7LSfMIELIcwW0GmDL1+LmcAJl7GWY86Btana++KfhX
         CzqPX4adOxoDaRrpZPZPcQYp/CfH5ISQEheH3dNkEZ9RR498IHAOAXSqu+Y2bJuRdNWO
         y6djDQYch6EkaGKnPMWXFXpfaefJy6Cp+aH4qqRmi9QPKRZ+YdUAiJDHcjgeHcRRsvwP
         BBrQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6E/o37e7SUGu9JhjSEjfiiZ9W+IhsqN0AksHoTrRmGZ4YmjIqHmWrUjEl3yBhgULKmu2A8TRPK/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHBvZmPxpX79VK68z5bqqXm2qRaNDeyYh2dDDBj9WCydZtm0e
	ZUWpyLCXsG/iQfoSlOdmYvf775bNqHTe6UFyOXtRftaZaCSDZOnuLJREflRujE6te+P4CfqAXeH
	vrqiSakOBaUlr64VT7nDvBh3iH2+ztPmynhEws/Z3XC17rt8S
X-Gm-Gg: ASbGnctVUYOhdC8uUNtd7w7wk8zabNMrIcqNlP674N1Ej3UocDC9vxTvZK6EAy61McP
	YVjAQeJWIYUomtvKgVTEoHb7GQd9e/Iy0
X-Google-Smtp-Source: AGHT+IEhR2D/dt/Vw7dqmP3c1NfSMof6dcurrBG0/Efhevbt891KsJCPtAS1p2Tq5jM22ure7AFSts86rVb6VBUO0Vk=
X-Received: by 2002:a05:6902:120c:b0:e38:8e02:1f13 with SMTP id
 3f1490d57ef6-e395b869cc6mr21365154276.10.1733153068170; Mon, 02 Dec 2024
 07:24:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com> <20241118072917.3853-9-wsa+renesas@sang-engineering.com>
In-Reply-To: <20241118072917.3853-9-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 16:23:51 +0100
Message-ID: <CAPDyKFpNTCEGzi43GABuQNo6rHV_OWWLhemu3p7Za0+rs3zVTg@mail.gmail.com>
Subject: Re: [PATCH 08/15] mmc: core: don't include 'pm_wakeup.h' directly
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Nov 2024 at 08:29, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The header clearly states that it does not want to be included directly,
> only via 'device.h'. 'platform_device.h' works equally well. Remove the
> direct inclusion.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/core.c | 1 -
>  drivers/mmc/core/host.c | 1 -
>  2 files changed, 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d6c819dd68ed..c877dae8b4e2 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -19,7 +19,6 @@
>  #include <linux/scatterlist.h>
>  #include <linux/log2.h>
>  #include <linux/pm_runtime.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/suspend.h>
>  #include <linux/fault-inject.h>
>  #include <linux/random.h>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 48bda70145ee..bdb22998357e 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -14,7 +14,6 @@
>  #include <linux/idr.h>
>  #include <linux/of.h>
>  #include <linux/pagemap.h>
> -#include <linux/pm_wakeup.h>
>  #include <linux/export.h>
>  #include <linux/leds.h>
>  #include <linux/slab.h>
> --
> 2.39.2
>
