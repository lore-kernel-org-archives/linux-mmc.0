Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931AC26AF6
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 12:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724329443; cv=none; b=M0WgwU70Q4n3B32+suHQSBdFkFM0e5S++vhCQXm5njPlauIq9njYZwZ+G7GxnPZ3YTVgwl+Z4+nsa/JjWeNltOWE9RPN6JS8iLzwkvvz5raZaFMm6ZXwE+OObE8cbGoXa8cNe8XAb99mn3CZ1Ss5v1KFGeuaqWaJXpot0fzpSq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724329443; c=relaxed/simple;
	bh=ybhG4ImimEgIuGWcMaLhWQ3JJz7eDGdejVmihNSIaTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YJVajshSfwLmcwbtqh/gsblPLeI7MDrUfV25Tv87qhcNR9knjNzwa4M3DSScISh7XMRJoXqmC5M2JStBgh9W8ZVvWzH62OuAGxybxGsQk38uA6JZrh1W7GRqKD3CzgZQi2M6e1wMRXXUvypAo27/syIuQoBTnPUvWeMcRYLvw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/pshPjG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/pshPjG"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e13c23dbabdso733405276.3
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 05:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724329440; x=1724934240; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5yYPsIY5Ub0GbvKRvMFn/0esYiLu3y7uZpwj3JsMvkU=;
        b=l/pshPjGPQ50witDhv3SrkP92ZePlyc3Ybheb0Z1UV+Sm3pzVhSPIJ+Rx9tBaGZXww
         c/m2Jxx+59oGWHcNx9+PmcgiM1fUo8MsmZ7ldOgnfvaLIxJnU33t9Kc3Fd+0/aXa/Mt0
         t8vHcLLHCgCXowN9pink+eaBDJj0XajDFroEIJ5PF9gl4BbqBTSnve7aOYNoDGnsY38B
         EU/JhtezMcie9vqEClEFyO6ou7q746hqiFox+rySHygaNZyeiOLzOU7Re4UKLRxAZAnL
         T+kbjhU05V9pATdAQWDGFNyIZnHDLWr7CXuE7L+d50pgbFWs53L1f+uDqwGlVK0VIuOl
         QJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724329440; x=1724934240;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5yYPsIY5Ub0GbvKRvMFn/0esYiLu3y7uZpwj3JsMvkU=;
        b=S8P2i8FCNayq3FvP/RdnG09BtgNNZcmWGVW4/7Ify1y0TEZrTZt4YpcHum5tkN4ThY
         El4++rqn7mxWtpDSnvEHoApKOzbXvclfJtQHFSwl6pLVZMzBwJivQbzFrzVdBRUvZRZb
         URXX6RRtU6nbb9lQlFEKjTTnnQHK37jZpXNck1AhKVIxMXgCXQgP44GDBkWB6e1RGdon
         WtQRp/8x1Z5XsXgrXsGP9r8ALGkDuXmgaJgCg3trM2IiRca6h7xFkAe3mLlIB19+I0J8
         S+EqLaMH/8rjGBV6/nD31juDEpc6RIx3guzBWQjHcEQdj6IcRxXXT+sMD6ITITCOV0fj
         TdPA==
X-Gm-Message-State: AOJu0YzQJXCk1SSVwRognfeo/1IQNoGW1ExBGhX8hjM9P5PE1IsxMdlR
	MBaPT42Hrs0o5gBQ/qjRaR1H6zO5vtlDugLafTq1pKlkCAtRIRHBqjEMPwZX03pJ4DoyFdf43Fr
	/JenB0jY6ssnzXukBD8xa0GVhmDedc6Zp+f7frA==
X-Google-Smtp-Source: AGHT+IGkIgTyCOPIqV7+GNGW6MoebXPmVC8K46j+rl5z7LKJe8liLfvw+oUc7uu0weOSVwnULsIzBTa4sC0bKtRmzxE=
X-Received: by 2002:a05:6902:1b81:b0:e0b:b2d6:f551 with SMTP id
 3f1490d57ef6-e17903c78c3mr1798038276.37.1724329440565; Thu, 22 Aug 2024
 05:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-5-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-5-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 14:23:24 +0200
Message-ID: <CAPDyKFpNCZi6biSaCLUFKaB-Xc4Kg4Z1NjzjW5vcY4TeLKDD4g@mail.gmail.com>
Subject: Re: [PATCH v3 04/10] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> For open-ended read/write - just send CMD22 before issuing the command.
> While at it, make sure that the rw command arg is properly casting the
> lower 32 bits, as it can be larger now.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 2c9963248fcb..1129f4e1a268 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -180,6 +180,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>  static void mmc_blk_hsq_req_done(struct mmc_request *mrq);
>  static int mmc_spi_err_check(struct mmc_card *card);
>  static int mmc_blk_busy_cb(void *cb_data, bool *busy);
> +static int mmc_blk_wait_for_idle(struct mmc_queue *mq, struct mmc_host *host);
>
>  static struct mmc_blk_data *mmc_blk_get(struct gendisk *disk)
>  {
> @@ -1664,7 +1665,7 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>
>         brq->mrq.cmd = &brq->cmd;
>
> -       brq->cmd.arg = blk_rq_pos(req);
> +       brq->cmd.arg = blk_rq_pos(req) & 0xFFFFFFFF;
>         if (!mmc_card_blockaddr(card))
>                 brq->cmd.arg <<= 9;
>         brq->cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
> @@ -1712,6 +1713,9 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                         (do_data_tag ? (1 << 29) : 0);
>                 brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>                 brq->mrq.sbc = &brq->sbc;
> +       } else if (mmc_card_is_sduc(card->host)) {
> +               mmc_blk_wait_for_idle(mq, card->host);

If I understand correctly, this means the async request mechanism will
not be disabled for SDUC cards.

Maybe this is the easiest way to move this forward for now, but it's
still a bit sad if we can't keep using it for SDUC cards too.

No matter what, can you please elaborate why you have chosen this approach?

> +               mmc_send_ext_addr(card->host, blk_rq_pos(req));
>         }
>  }
>
> --
> 2.25.1
>

Kind regards
Uffe
