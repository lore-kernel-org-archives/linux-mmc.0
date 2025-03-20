Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0723922157F
	for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 14:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742480235; cv=none; b=h9ewn0cosgpZrWdH+GPZd66SxM2ZTBhLw7qe2Kmm1Z0zCrFVMfZzD9Ngx9MbHkYoZ3NseetjAAQBQLdbRp8UsGTiwikW5LcHVTqdUdQn/Mu/S7TTJ1Ndr3bjcTfh+wrbBes7Rs5fgxvQ2cIvWhtR5rGfMFtlF8s/2GL2FPK5Mmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742480235; c=relaxed/simple;
	bh=rPTqBrER8bbSohUQihrKPzzyTRkgcKTD4rDojxLaHY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4oY6GA3BALbNmUe4QAvFUf3ZMUwqQUSmJEZsVS91OviT1BteET10/aGyFkFPhDdKIxD1gW4HMc4ac9sKMvS+UGXrGQUwnnVsYUxNGBUWSsxi4s8J0Alm6ebgjxJd41YDJY9U/CyImRnH/Mw3vus8A/6ITNG2dNxb4dXMIhFSm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kxMuf85N; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kxMuf85N"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6ff37565232so7548567b3.3
        for <linux-mmc@vger.kernel.org>; Thu, 20 Mar 2025 07:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742480233; x=1743085033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mSPzEa06K6xbln7BcUoZDUVAsWR8NylwhfXoE3kbxbk=;
        b=kxMuf85Nyq8Uz0khjQYHHM7l0K4ur2oB0K1KkA0Qp7GFH24It/cHx2HZhyGPB+9bDY
         FqP1I0gkk8GVY+jqMAjkGDoYPR9r4H3yuj70Qo78pYFalxfAeX00/6mWYU+bkfHXWHAz
         Ob4aDHjRuGHkOIN0KFI+/5lo8CKeVNDZdCVt4UU7qSnq8shfuc3wSLjkE6jKEXaD6vUL
         7g+VUBSQE27R0yBIff7won6qzM/xazrfeJbyl0d/RTJHOf8EzapJqY2/HzKLFE3XDaoz
         PrjSYT1Lxc0/M+dB4oPDGy07DYhshyTn25mlhOm5meXMhdh3g/OJtRpMfvVDDK3qnaib
         eouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742480233; x=1743085033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mSPzEa06K6xbln7BcUoZDUVAsWR8NylwhfXoE3kbxbk=;
        b=hY5bzMqByRrWEJcIs8CixIQdN3bwUfe3Smdp+91HmAoOOxl6AITOu3T1cuOhUGDnjM
         cLmfO8JzS+0kBABTocgxYZBd5GgaKFBaELfYzpmOgdz+Bs9a5qtPOh2OB3MpSpKXSUh0
         scqGAA2gEl349tiO8i6BxrXDlFoLY8J6rKPaNDe6gdsUZlX5gMAwdJmqDAgKbzfBLe15
         DQaUg7lt/OkMCknIMq4Z+FqijbKOw0oqnHmIQh0bXbyeWqrPbSY5W/nSuC/K5NqE5Ilh
         mEc7XJeqkxnIkqBNJSLNmzUj16H64Cv/hqRXSyTfTZBCManLTW+Ia3H5YK8In4YZ0NxT
         0Y2g==
X-Gm-Message-State: AOJu0YxibQxqmZcakYdlCG3L3FHzkWlmotJiFt1hycFaLXC9f7ouwBG5
	qOnQ64R/ub9w9hWMNwGGzncsw22nM9DJs7E5KV7WRIElb+H7hk8GhumFkwWmjRqJew5UkstGx8d
	NSYkvGrVVNZ3FqDW4NFcrBnFZQO85uVT6t2FksQ==
X-Gm-Gg: ASbGncuK5RjavOvcP4kTU0FRULq9TBXq3K8b7ZU/38Gu7vbZSVq0ZqXvw4uvoTPeglp
	yDC9DxSQ5ZeMcOURN4FrPWpB0Ruy25kerHaTryOGpvn7TXn70toE1il3N/s3rO8CljU0AfDs0Nc
	PMGrx2ceLiuT/AwVJpgE/b6ZgTUS0=
X-Google-Smtp-Source: AGHT+IG58zn3muxJcPC+CSbnOeLgLEZllcxv2SWaiofzXtAltr+aJzIZ+XhCtcJ/WCReayeozh4w0Qa7xV3hTEf3Uk4=
X-Received: by 2002:a05:690c:4483:b0:6fe:bf9c:e7c9 with SMTP id
 00721157ae682-7009bdc409amr96138787b3.0.1742480232765; Thu, 20 Mar 2025
 07:17:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250319203642.778016-1-avri.altman@sandisk.com>
In-Reply-To: <20250319203642.778016-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Mar 2025 15:16:36 +0100
X-Gm-Features: AQ5f1Jr0LX6LnuxYjCAx_FqKpGJP-YCB_R_IiZF3pkzjYfxo5MdP8WREX6o8sd0
Message-ID: <CAPDyKFrL26tCKoeM4RzNiWuMA8FqBWj6GhN_zx=vmfGRDMXWfg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Remove redundant null check
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Mar 2025 at 21:40, Avri Altman <avri.altman@sandisk.com> wrote:
>
> This change removes a redundant null check found by Smatch.
>
> Fixes: 737d220bb2be ("mmc: core: Add open-ended Ext memory addressing")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/linux-mmc/345be6cd-f2f3-472e-a897-ca4b7c4cf826@stanley.mountain/
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/core/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5241528f8b90..ce08e0ea7fc1 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -335,7 +335,7 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
>         int err;
>
> -       if (mrq->cmd && mrq->cmd->has_ext_addr)
> +       if (mrq->cmd->has_ext_addr)
>                 mmc_send_ext_addr(host, mrq->cmd->ext_addr);
>
>         init_completion(&mrq->cmd_completion);
> --
> 2.25.1
>
