Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF01DFD9A
	for <linux-mmc@vger.kernel.org>; Tue,  8 Oct 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728398186; cv=none; b=G9jow+V6joEdzOSMbAU0Ke8htnIVKuQi7EPGSgvY4RiJhWUrNZnOC15JyLVQcKwl4ex/s8DJDAQEcXPfjGs7E8WpDasqgj1uPzVrM1Q1kEbUNuIo7pzkd9cnijyhSwCEUBt0N46WdQuXDyZhTyoF7yZzm9L3fAWrAkxusjnQRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728398186; c=relaxed/simple;
	bh=pvwLIR+f2H1rAHx+blijIjuYe47lR8e0jD1uiAngXjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9C17qMRPO5GDS8FMtU4Xma5wn4Qgb4z9ppjPEuJB+5VsneWvrEUMXUwaL1/MPhvLStIDPB5mvxHXldU0cZAz8UPjRRLQqvI6BqsCixu6jZ7uAK6pGGEouL0kdwEEsDuHWfiSnaHD40dQirEI0mRKeFK82EMVXeVBwJadfFTrfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P2Wbplku; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P2Wbplku"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5094280276.0
        for <linux-mmc@vger.kernel.org>; Tue, 08 Oct 2024 07:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728398183; x=1729002983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5hYghN9Bflq1uLOIauFda1EkQt1NsIJkAjgd4KZaScI=;
        b=P2WbplkupvRPeoY7ltv/caRfMpUAoJPDhbH6xy0MlHHyTkjoQLcUbfnwLqh3K6ZiTh
         OQ+gIc93Qf/W4WVbj23r7wyLaSUtFefyNqBu7HdmYtKORiAkZuZZy2dp6O1Xv8H3Y8xe
         iUkzOHcKBIy1tRWgmMaZ1SDFHkOSuTgol2NHdbb68KPGkljXkOYpIsp6hSzERVDOoymO
         ravUP6tmj/FqRMiWNFGCm4/K6fxyCOdJOULgGZHEx4K1rJZN7n6W+BlV59ubJPwaQlRY
         T9yEqH9YykVEK7qbBvZAG5s0eqvK1LO4VY3bLUwFjkwQwMPjGJfW9W8ufdBlb1PEa58c
         RvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728398183; x=1729002983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hYghN9Bflq1uLOIauFda1EkQt1NsIJkAjgd4KZaScI=;
        b=LLZQnyv0lAJZDJzfsynP0D/P+I+e5ZwhBJNAhqkIU511hhsOhRPi/wvi/iNqqzjN0j
         pyi8CrUTp+IFkqgQ0EjHtZGhefC+wtWZ99GjSC5phEZuiKcQqW3uoXoGTLoSh/s0TLIi
         UktYccoaRQiiWTX+aDM+KT1AC8b0nBeAMVUzYOPcZytZB8SoFBLzd9uh89RbOuB3kWSD
         48pfLHelA0nJqeI+NzvR4A/g81JF6CgzSAcpc2o3ywGU0SfVuIdXf04PE3Q6TebUyVZd
         tH4sX3pZdUIT7f68RObKII2c5NC/u0mGfLp2WzTSUGxCnqpNJqQ3tfRgvEqJprfkzz5B
         497Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+rNsCKozVrlYqvTSw6STiOBRv9DeNW+FJDwHRWPSbQ8pzRwEPevhk7rRLCXyeplcAfhrFuMvJodQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZtDLQ0gJuRVdx0UVi+o7MUlmzuRSyyhFteQBco4Qt8HcZMh6
	fv3MrWD8WXgFoe3oi6kGJKB/UgDztjsEPtFKLqRXFZgG7aI7btazbLzX6Z0yhX+C7hLpemI0cyo
	ZNaZar/amUeCyb/5HbZMfPCd0ZCjqvxFtb2JKbA==
X-Google-Smtp-Source: AGHT+IGGmBfwrdY01r6VkpxLsYYPM+a+1q0RH65WIgTGYBqDcz+dPeOC5+5az3Zez4L3zlwVISZe14JZO2VHffMEBcQ=
X-Received: by 2002:a05:6902:2807:b0:e1d:2300:29ad with SMTP id
 3f1490d57ef6-e28937e34bdmr10657846276.27.1728398183626; Tue, 08 Oct 2024
 07:36:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240928094454.3592-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240928094454.3592-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 8 Oct 2024 16:35:46 +0200
Message-ID: <CAPDyKFpPOV2hAri77Yms3Y59NXS3_kM1eHJT10U81EtDSBCzgw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: correctly report success when obtaining
 DMA channels
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 28 Sept 2024 at 11:44, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> The debug message could still report success when getting the channels
> was OK but configuring them failed. This actually caused a minor detour
> when debugging DMA problems, so make sure the success is only reported
> when the channels are really ready-to-use.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sh_mmcif.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
> index 08b4312af94e..0e7fa3e9c9fe 100644
> --- a/drivers/mmc/host/sh_mmcif.c
> +++ b/drivers/mmc/host/sh_mmcif.c
> @@ -439,14 +439,15 @@ static void sh_mmcif_request_dma(struct sh_mmcif_host *host)
>                 if (IS_ERR(host->chan_rx))
>                         host->chan_rx = NULL;
>         }
> -       dev_dbg(dev, "%s: got channel TX %p RX %p\n", __func__, host->chan_tx,
> -               host->chan_rx);
>
>         if (!host->chan_tx || !host->chan_rx ||
>             sh_mmcif_dma_slave_config(host, host->chan_tx, DMA_MEM_TO_DEV) ||
>             sh_mmcif_dma_slave_config(host, host->chan_rx, DMA_DEV_TO_MEM))
>                 goto error;
>
> +       dev_dbg(dev, "%s: got channel TX %p RX %p\n", __func__, host->chan_tx,
> +               host->chan_rx);
> +
>         return;
>
>  error:
> --
> 2.45.2
>
