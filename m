Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD5F18453A
	for <linux-mmc@vger.kernel.org>; Thu,  1 Aug 2024 11:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510105; cv=none; b=Hz4j51qGswajT091nccgFr3fiupBpOSho3OgWG/Jr5RVYyZ4wYkZBP94BEM2nwFu+F7xAxMkqPx4VST0EGBVwvlvei6dSVyFgUL2gOvyZPpzMaUoSJ9/0PZKss3fB+z+SDM2UTeZKkwkof911MU7ckd34c9VYga7dOFIgzSvgLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510105; c=relaxed/simple;
	bh=MRvLSRflFY9cBgACqddCPno2qFWCVu9cH8/xiZokPPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JtZHxxrFNmCll4QxpSl76/7nX0T8w0FanQByCkLygZlNPMt/lzy8VIvU9y6eF9QP2rHvXnPwUjg2BRYMga6w0AsjVZP501f5AZ8n76+FR/ykFOuy1UPw70DucbFaMG3QheRQZuZtZwMTnNTTYEY8YRlqB5F5Hce0L8lJgoCR08Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=keGqqvan; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keGqqvan"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65fdfd7b3deso54402497b3.0
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2024 04:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510103; x=1723114903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4trUpMv/W8d4ikbqlUsjU17uBaeiu1bYnhrDFMlu+YY=;
        b=keGqqvanqm6LvUvP+Ai8ITi8u0IMZYvfFGxvJMp0JBVHD/yi2jtmx8UrbdDX/NYNUe
         G/lsvPki4XCyDyeKuFkrfyPSX6mEow8fJxoXnCKrsS+rcCjUJ7GIwe3a8HdoNFR7rW7p
         ZlQhURQNN5OxYQ0v/o2StjIxETiH/QUPjkWoH7QGS8UesrrXGzMhtOdV2euphyvC9J4z
         f+p0bk76nqoWGB4IO8/OVzsV4acoFL1u6BIrrjH2oln23/dDEYINLP5QpJWb+2DQuwh7
         bNqGOS2p/Vy2KS4J4ACWZpfqK7BvzFjdkrchUkmXV3yTuvTa3+HmgnpxZ9MFadu5Iqmh
         lKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510103; x=1723114903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4trUpMv/W8d4ikbqlUsjU17uBaeiu1bYnhrDFMlu+YY=;
        b=mAyGZ/rI25m7P0F/8dBXjPVkaO+/PS6NujUhqXKRJMUtJCg2KBU5fyHNrZo9DSdaRg
         q+iP0Dyx4RloJww6w738nu5BSXWkFeCXwoD2kICwFB40/+WtPgcJP2pC8o7TvEJNkC5w
         rL7eiKDfWRIDVGMCgRYcTRRRuD2fToESb9ET1p4bAsyhRnCC5eAkXSyF2BrTRTnuG07R
         XUINvwphPxfvBZOa2E75Rs1gQEtQtCm/TCSSX80/TuogX8NFRyk7Wixh10iLmJ9rbb9W
         tNEJq0v0TGJOCzsarmTft+/7v8tTsx65cWfhJR33zC/CHHzYhxCyuuibxs4lOnZy0v+v
         PtFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp1EtdvHzDet1r8JpHVlt91ubX1Riho2XP49HBxcxubldz95BgLW3HAXRBEebXJ+whIUgfvkL+oBdZsNVzxpbS3TEHhLtViR/q
X-Gm-Message-State: AOJu0Yy6dB/nbVQdnYp1V1LZxLIz7jMVxkjHDnwUcJXLlkdK5+rCl/h4
	tNKKdfbC+Z/wW9BQPGc4kjG9su3RpMywE9CV0XkRICU1nifafMJ8Bpcs0t4FVN8taBjsyeFHNcd
	iCOUWel8leV/mRNqxWsMSHaibo6JQEdCzlVy3hg==
X-Google-Smtp-Source: AGHT+IGsJtr765trHWKToCgzsb+QNQeokpwLn93TcvWJ2oyDkYmYJl8bttv2EoecCGf3CWCYpquOz6J3evhCbjRj0fY=
X-Received: by 2002:a05:6902:1582:b0:e0b:d6aa:43e3 with SMTP id
 3f1490d57ef6-e0bd6aa45acmr624829276.17.1722510102849; Thu, 01 Aug 2024
 04:01:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240714155510.48880-1-doug@schmorgal.com>
In-Reply-To: <20240714155510.48880-1-doug@schmorgal.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:07 +0200
Message-ID: <CAPDyKFoa2s_L4T-SKkfNwBv0_p1jQDkJh_RAWOCOw_MiH69Nuw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pxav2: Remove unnecessary null pointer check
To: Doug Brown <doug@schmorgal.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Jul 2024 at 17:57, Doug Brown <doug@schmorgal.com> wrote:
>
> There is no need to check for a null mrq->cmd in pxav1_request_done.
> mmc_request_done already assumes it's not null, and it's always called
> in this path by every SDHCI driver. This was caught by Smatch.
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/9ddaef2a-05bb-4fe7-98c5-da40a0813027@stanley.mountain/
> Signed-off-by: Doug Brown <doug@schmorgal.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pxav2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
> index b75cbea88b40..7b957f6d5588 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -126,7 +126,7 @@ static void pxav1_request_done(struct sdhci_host *host, struct mmc_request *mrq)
>         struct sdhci_pxav2_host *pxav2_host;
>
>         /* If this is an SDIO command, perform errata workaround for silicon bug */
> -       if (mrq->cmd && !mrq->cmd->error &&
> +       if (!mrq->cmd->error &&
>             (mrq->cmd->opcode == SD_IO_RW_DIRECT ||
>              mrq->cmd->opcode == SD_IO_RW_EXTENDED)) {
>                 /* Reset data port */
> --
> 2.34.1
>
