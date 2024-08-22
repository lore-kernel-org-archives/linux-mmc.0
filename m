Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049B71E4B0
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724330042; cv=none; b=oR5R1B/hI/ESNjBZ5eMXGiDl8DQYAfsfzhRIPd6app9LQqxhAPXO/MxRYieIg7I+FgTgvys7q+khTejTV9S9BU+LuID0hNj9hH+EgCq6tDAnoDLS2lmxozz5emQvm/oMtHxkA45NiDrCBRuqvag+G7UTxzCvFDUzqr4tuletXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724330042; c=relaxed/simple;
	bh=SNIi5lBGmnQU4EtELt/Wm73I+EhOTNUlChDJbNrpByg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UxT4U4+WV5FrcZ55wiLnMak5tV1RR5S7wk2xpReB85QhO1g1rMxpF+2j5AdWgulzA6YQ4gEDKNNG/mUErXUwNJdwK8P4Dj9cPI8E6QHbtjTV8gThYTXkaci6r/hehKs93tmypHIPNg/WFCcp/Z8Mz/SkzIVkjIH8P5uQFMv+P5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W/BICZhW; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W/BICZhW"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e117059666eso744156276.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 05:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724330040; x=1724934840; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wgqlp2ZmjZubc8lNmN5oEdnU1ESwtBp7C9ycSWeFsHA=;
        b=W/BICZhWvNQZYnrn5g2hebREyTbiU5gkekDq0QS/zIuG6ooV4RPqr+8MN90/MPn+I7
         HTx3d8ez7wdn1Thope+sojQSb7PLzysyh2DQvvsMxbhO1+JINv/S/lxOc8KtwLeAQxow
         Ak+HYtY+YlUnRaYZCcZ3Eqvueti41w/xcgXeqE0biq2wIWBxewvTLrgJQAUduSgxDO01
         kDKsr2XACjOUYm/0PPuouFrGREk2G0bh7sSRNAJ0kMsYuI9wiJRNjmRSxP7Ii/0P3Jj3
         WUdGgwZ0dJ1Vyveu696o6gEKMk6R85ZedVll+WIQYNuDK1fIzGtjW6CsAKU89Fi05/7u
         UOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724330040; x=1724934840;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wgqlp2ZmjZubc8lNmN5oEdnU1ESwtBp7C9ycSWeFsHA=;
        b=AZioRtjqF77BjxJg7X5O2j41z/mdh2xonhv2z3s1jZdwKvJHXHRdayfUeq8Ubwxll3
         sIMq+wdgK6KB/VqN/xLMYCXTuiccVtqPiU18lJyptkh5T+Z/ayW80WZVOhEuveCptbT1
         n7Nykx6/r+IgQJkNcHNhb20F5IwR6WIzxZCFyZf+gLBS4y/HhtXa/x21LFZveslp/b65
         tw15TLv6CAGAoArLwDfmGVZFikykp3QSSXSOupKJxum9WOFW27enYXc66ZfkdohlhTyp
         0HBz175H4E/CDZL4pP9odqdLC7bnixZqHsogcs1v2tM48+VL42UcxAWFQLLFYeoYH1Uz
         aqgA==
X-Gm-Message-State: AOJu0YxkUpaDmae+Ix4H5k705eLe9s87DsE+eQS/W8cSD10XfceKutR9
	jP+Svcu3/D0vP/HCKdtPJ0i0QQP4gsvC+Lh2fcg5fX24vEim5zjfNIIWH1Eokyz2IBlxvQW3hKo
	vazGYqPffKgclpD49YNcTiiAM/hOoXtdWIa1ITSgH4nOnGDxqBsQ=
X-Google-Smtp-Source: AGHT+IGcYVzIpHvzvXaK4QS8sO5atH4dX1l8oPWvXXXDa8xFY7GSGtPeUnAyC3o5pb7+YeTxR8DDAbuJN02KVVVZO7U=
X-Received: by 2002:a05:6902:15c4:b0:e0b:db13:76bc with SMTP id
 3f1490d57ef6-e166542a143mr5941339276.12.1724330039946; Thu, 22 Aug 2024
 05:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-6-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-6-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 14:33:24 +0200
Message-ID: <CAPDyKFpD75pagXXq6GTvY-P8h9MuhZH00S6NjC_OVZM99C8xSA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] mmc: host: Always use manual-cmd23 in SDUC
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> In Multi-Block read/write, CMD23 must precede CMD22.  Therefore always
> use manual cmd23 so that we'll be able to control the sequence of
> commands.  Also, add an applicable mmc_command member for both
> mmc_blk_request and mmc_request to accommodate the address extension
> command.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/queue.h | 1 +
>  drivers/mmc/host/sdhci.c | 4 ++--
>  include/linux/mmc/core.h | 1 +
>  3 files changed, 4 insertions(+), 2 deletions(-)

Please split this up. The core changes certainly don't need to be
mixed with changes to sdhci.

>
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1498840a4ea0..7e191d7f0461 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -40,6 +40,7 @@ struct mmc_blk_ioc_data;
>  struct mmc_blk_request {
>         struct mmc_request      mrq;
>         struct mmc_command      sbc;
> +       struct mmc_command      ext;
>         struct mmc_command      cmd;
>         struct mmc_command      stop;
>         struct mmc_data         data;
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 4b91c9e96635..f62b489c9e9c 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1399,13 +1399,13 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
>  static inline bool sdhci_auto_cmd23(struct sdhci_host *host,
>                                     struct mmc_request *mrq)
>  {
> -       return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
> +       return mrq->sbc && (host->flags & SDHCI_AUTO_CMD23) && !mrq->ext;
>  }
>
>  static inline bool sdhci_manual_cmd23(struct sdhci_host *host,
>                                       struct mmc_request *mrq)
>  {
> -       return mrq->sbc && !(host->flags & SDHCI_AUTO_CMD23);
> +       return mrq->sbc && (mrq->ext || !(host->flags & SDHCI_AUTO_CMD23));
>  }

I am a bit worried to see that we are going to need updates in host
drivers too, to support CMD22 and SDUC cards. But if that's the case,
so be it.

In any case, at least some more information about why this approach is
needed would be nice.

>
>  static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 2c7928a50907..5560e70cb8d4 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -142,6 +142,7 @@ struct mmc_data {
>  struct mmc_host;
>  struct mmc_request {
>         struct mmc_command      *sbc;           /* SET_BLOCK_COUNT for multiblock */
> +       struct mmc_command      *ext;           /* SD_ADDR_EXT for SDUC */
>         struct mmc_command      *cmd;
>         struct mmc_data         *data;
>         struct mmc_command      *stop;
> --
> 2.25.1
>

Kind regards
Uffe
