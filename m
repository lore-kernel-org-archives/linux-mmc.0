Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AC713DBBC
	for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 13:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372754; cv=none; b=AZAf5mLDvFOPPv+UhjI0Dzs19/4BY1CKbrACfR1JtdeK1Xi7RImJMxBI6+ma3iZTAeVYfsM9y7a574h8zyiayB4n2/1XlMddXdFPE5R0VpVQL7AjHUj67juBLNtuKQCxjurZxoSCY/SJTULU7K051rtx1PcoTBpCBMuc+euVcQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372754; c=relaxed/simple;
	bh=gAXmZJZ7JPBYyLYvwXEjCgYPbJ+nziJz1EoVZFfYBxI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QYHmYC6Mv/UnE0ctLA/YIL5ynNyT45cCUj//ugQTzblOjPOyOPIi7u7IH0vmEx2j2AJyFdCvEQi8koMlM1FUeKnjZ78EB6GHxZVa2UqXHKAsD2MPlDilP5RcGIrw0SVzP5EQpdqNZ0Mac4E9hqU0ZfUhyM0CAaAIapo/akkwWfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bEDmjmWO; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bEDmjmWO"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd045349d42so3694451276.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Mar 2024 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372751; x=1711977551; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FRJs/xxex33QkTbsCV8od3MYvkVpVGCKzchYiYGgxF4=;
        b=bEDmjmWOdFzt6qmzyF5yUupxP98K9Zf3Bj3n0pI3jJ7D1ApN4kNu44xnKJ3uI6UqzP
         4iCHOduFs85wWvPc389bDbwu5TsY/hmJ2XmoyIn0/QcMw3tzc8I+zMujUVRBwH5PsRAD
         UHjUAip5pUFiChSfpU+i/3fRedVjOSQCxWCgfjYZj+i7NlvaJFHcdtVDD8iLVeBOhCp0
         ctEB6gcSmb0keG/4TWFivGKAgvbxT+yRFoU694g4jO0CUdJJtgHi2EBb8jo1/JqIdsn1
         WPZvvjwDyS7SWosnesE4l/hoCDMo7KUd24JuyZ/f2PF4SqCkhm2rvBsNI/OgFe8m7nAa
         S3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372751; x=1711977551;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FRJs/xxex33QkTbsCV8od3MYvkVpVGCKzchYiYGgxF4=;
        b=k/qkluKNK/oFLhF9Kdl5E2s/SxrouMR3vlN+pzxQmAlOtLa7FLb2tN4pI/7pj/ATW5
         xzuuYuMe3625PP57upV384DpDX5iVe0Ht+KWe7dML5DWc2D+vKW2SJ2XhM/C48rIMy5t
         Q7HmGCBwsEF55oj8IUQmN2ROVTjWT93yJjsdtOQNO+2sl970GSrzAbys2bPkCtPnLjxc
         JVIU+BQGR11gL6PFiXBAJxurwOs4+1xekReB/Tcl7cOmIGF87Fcc+Mjn1+U4quIZW+hg
         cOXCNpHKBQaKIyuBLb8pK6STgT1xhQaU+T1JU9uf1otvzl7Zb7ly9Q70UxdJHj6UQzQ5
         G+IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVLiDAy/+hW5xYMIB3TlJnUkycffwPlMN/VRMjZ5sM9U5AUscim08AbEdcjaaLnQ4re65ZPW69jJFsNuvSGj0ovm+MVdKQ14rp
X-Gm-Message-State: AOJu0Yx5hPunbmuV010bXi2jYB9he4CPK+4GFzDn6j73Eg4pIKwle1W4
	obeFcQa2SfS1GFjD2E0LwleMBRhDgKLL3eoZjb66pW3YU/K5+Am4twet5B72/qyD7GMVFf5yh8u
	YGpKwTOxCrV2dM8dzlfvSx1noMeYQf8FDJY8ZWg==
X-Google-Smtp-Source: AGHT+IG2xBt6Vvh6SED5qGZRekkF3bhfFw7W0QPkk8DRIa7/EdrIKglIsJQC7D4muCETLEynNq4MclW5IGDlO/oijkU=
X-Received: by 2002:a25:8381:0:b0:dcc:ebb4:fdc0 with SMTP id
 t1-20020a258381000000b00dccebb4fdc0mr4315085ybk.65.1711372751176; Mon, 25 Mar
 2024 06:19:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307145013.2721326-1-usama.anjum@collabora.com>
In-Reply-To: <20240307145013.2721326-1-usama.anjum@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:34 +0100
Message-ID: <CAPDyKFqE1bEPfye7PSLXALE29XoTT3Y4UyMLDUWorLuKCbSG5w@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, tianshuliang <tianshuliang@hisilicon.com>, 
	Shawn Guo <shawn.guo@linaro.org>, Jiancheng Xue <xuejiancheng@hisilicon.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, kernel@collabora.com, 
	kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 Mar 2024 at 15:49, Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> The err is being set to 0 and replaced every time after this
> assignment. Remove this assignment as it is extraneous.
>
> Fixes: e382ab741252 ("mmc: dw_mmc: add support for hi3798cv200 specific extensions of dw-mshc")

I don't think we need a fixes tag here, so I have dropped it.

> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Applied for next and by amending the commit message prefix to "mmc:
dw_mmc-hi3798cv200", thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index 61923a5183693..6099756e59b3c 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -87,7 +87,6 @@ static int dw_mci_hi3798cv200_execute_tuning(struct dw_mci_slot *slot,
>                         goto tuning_out;
>
>                 prev_err = err;
> -               err = 0;
>         }
>
>  tuning_out:
> --
> 2.39.2
>
