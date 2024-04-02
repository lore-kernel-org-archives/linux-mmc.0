Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025695FEE6
	for <linux-mmc@vger.kernel.org>; Tue,  2 Apr 2024 10:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055455; cv=none; b=Zny1oS0FEG+QSrCj/F+M4b6DLWV1iNxKuIb7aOIiAJCoQ0tYwA5licyb1d565K3dADR0qbBRy16nugDbaqc/5TB9FYx/AVoTuT5UOkPyR0CWlTYyrjT3mRwHzGHPe9Y5iLWVtW0us2KMmqeAWMw/wlBqUvikwliA/UL5dVZEmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055455; c=relaxed/simple;
	bh=vqO89eEBR/ktnLPEQMdwBobaFGHWU1KaYv7JeHQaYdc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pS54Twb6emcprtydlJPMtq/Yl2ysmmDasq7sWz3mD0FOpM8oWMdc33aPYV/WA8gXhuYGNcRcCak2r3oAJPSS9slwxfQ6lDG0EOOH4jOfavEM57hM8/oiu3iM7cuDoLX0yqbyhLUnSoBEraUOOkdYfN4DeP1IWtrwAjEJtrva44o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uobyZy9N; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uobyZy9N"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61471853539so15232787b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Apr 2024 03:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712055453; x=1712660253; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yVXc1Bs+lpB1RIEnPb5YwNz2pgwy6ujAacaSwqfyeHo=;
        b=uobyZy9NKaUBGNXzkFnGopX75NrEOqO0RCxYx4AZ1qb2gkqq+3CraffwwXEEydaQhh
         /GTsKkc6WrT4DcPj2okLoCJ+AWCVEx0NhXhFcuD9hgzGm+WSx8S4WrqnmY6lSq4kuKwH
         xWRtsjPZXvoZrG8b0FD54YwB/lzq06pQrgwM2I+8wyGr4Opu9/DRvfAYmw7S3z+x2Ohc
         +UScUOIPfZvS7sAsjzdcEPtusJQ574hE6sxr+8KgXggJX3uOU+5HM8fhZ6ruuYkiuON7
         cuweW1ZwypaJMR7kGuRyJCy06QsdDEdgcH3yrHxKmmySukiHjtDV8X3Zie9awVYOhz6O
         /ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712055453; x=1712660253;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yVXc1Bs+lpB1RIEnPb5YwNz2pgwy6ujAacaSwqfyeHo=;
        b=NDnQTC7FFgrMcJOR0Dk0tGHmUaQgOqXZOl1tpYBUed5O3mEeOLK82pjcIkcdQ+i5FK
         sucIiubl1ZTMogcQ9qxSRIyWQ1R+zN/+edEeRtoNcAHpgcyloc0Ufk32JvYrqX9ZFsva
         Cu9TBZuYnj44Ki8AwGhSXXlakhMnh+/WfNP1qYpSafllItU7PixT+xNsC2a/8kTi7Xkk
         xh8Ts6uxLmA/ly9ViodIntouMlbKUIi9xOie/Wh/4FumiaBc+FffFSgl4YmFFXhNL4T1
         WcLQBHQqApxG/Cb/x0piz6OyGWhAlepfGyMoQd/XDR69+yEpYKkzxmO/CsMbXNkO07nm
         TuAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkjn3Du9AnGUSeeGT18yubTzfFzqa9W5+x3e6LR6PDINk7jqRerCEUkt1pycjsmY5SSsh+03qLMbh9ze+HOVmfn3i8Z1C54mmU
X-Gm-Message-State: AOJu0Yzptd13faL+YPUCg6SKMyYxnF9WQnnJPzUPS8wg053jgiPd9Ikb
	r46G5Zsh8oTTHSKVkfehBBn7b3pfYZTnciZKvjP7SMzpQBtBuKvE14HtIhykW3+nvVd2Ba7jNqP
	DDZ15RRClQdR4c+k39jr0M6LY1Xs1UL8Rlx+5OA==
X-Google-Smtp-Source: AGHT+IFg1hu4FwOjpqGBH/SGeVvovCBllWh1O5bBs6IVNCKUcnc1PpAomYGLskhTJ+VShxhyKPmS5NFMVCtcej5YTDQ=
X-Received: by 2002:a0d:c145:0:b0:60c:d22b:8541 with SMTP id
 c66-20020a0dc145000000b0060cd22b8541mr9859110ywd.49.1712055452835; Tue, 02
 Apr 2024 03:57:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326094215.212930-1-r.czerwinski@pengutronix.de> <20240326094215.212930-2-r.czerwinski@pengutronix.de>
In-Reply-To: <20240326094215.212930-2-r.czerwinski@pengutronix.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 2 Apr 2024 12:56:57 +0200
Message-ID: <CAPDyKFpUkAOd3h_s-zCArPWBhxqGHJ=dS6K6Bv+b6t0norMMeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: debugfs: add card entry for quirks
To: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc: kernel@pengutronix.de, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 10:42, Rouven Czerwinski
<r.czerwinski@pengutronix.de> wrote:
>
> This is useful to check if a quirk has been applied for the connected
> mmc card.
>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index 6dbab860e453..f10a4dcf1f95 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -389,6 +389,7 @@ void mmc_add_card_debugfs(struct mmc_card *card)
>         card->debugfs_root = root;
>
>         debugfs_create_x32("state", 0400, root, &card->state);
> +       debugfs_create_x32("quirks", 0400, root, &card->quirks);
>  }
>
>  void mmc_remove_card_debugfs(struct mmc_card *card)
> --
> 2.44.0
>
