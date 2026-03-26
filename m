Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF951A6832
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528478; cv=pass; b=cuh1DOmh/+sSgLxaj4x1IJtvP4oMMfzpaRqkn+VdSv1U4RMTcAkKLwlKTrYvxvFiHGf7HAJAWTfWt/Txg6hAkURTV34VPjCgsc4sZLjwRWYCZn5bu1MiPTxjthJfN33OeuWQWO8myY5wAdbjqm7y/87EfwzgeQJH+/JiNG7n5Ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528478; c=relaxed/simple;
	bh=vKbutdKkB7cYgg8PtWY4GjrFMft+n09kmPg3iA2nEv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jMpGGNqHJOPlzgfmLceHnNIEX1SZE1Cxp6S2g9pnIQhJhjA0qa5z4ZaH+7fqw96iOJcuoVeavnjNvUBiV36Od4l3gtToNqyWulPh9QjlnHHDLbJyyQGwhEhJs2hFQqCDDPxGbuYRpEUrAeNUULLyfF61oMCUu74R8+Py5xl0eTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JL7Oa7vc; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JL7Oa7vc"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-59dea72099eso1090502e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528475; cv=none;
        d=google.com; s=arc-20240605;
        b=NWZrWOLnAJFgI8nRxlEB4508tp5YSOHJQ1OyT4bYRZPrpZqrFTyaNbEayULbkjCncD
         1QCp0Kzl6mDMlY/j0H+V/NMtwbSgMhcYw/zglzLNM18AqpX3tEK+mglQmARuGe1nMu50
         MkEml2leXhEiZGp24BS6RFncU/0xXu0umz2G2h7dU+ByIA5FN15vVg/QJFeoFHl78OO4
         SshY/W+A2zCaUj05HPDQboziDCHaUXTcXgvEd38kGgHMkQ2/J0FgJX33kQEEC1o0e87b
         HpglZeth722klZCT1WRApw2LfX+FiQs4mhtDv7WivoCi79mAXU4IFpaBa4Ic5eSyNE28
         KwPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        fh=l1I0WuCJ2piltHeIYbY+Nc/RCsq1tTb2uAouZe6TLfo=;
        b=bWIKR66dEVrXVm0tRL+FsxK8EGcO+IfcjjAdzvdxQhNAtdONXbASZBQdupd94EFsJi
         PsVJZPzRegvAJraXQroqxSUXGnwT0SY7yFROB5gZCFUcpsGdx13r1Pnjw6vl3wd8Oooa
         F+FvpMQRm4z95LcCx1QJakBLWOUtv4h0/42CkBSjHwbObrl4effFPCEl9ePpgSgTtDWn
         J5Ns284YsoCk1neJdZYmtE8+KkOJ8vTHo+Qpsn1WURkI58XYif8npRlgAA3dCBP8UNQT
         LN98MvXA4I5tB0gQGs24xt226K/j86KrCg9E9W8JQr/0TZsPNyczHikwuifn0aM+UNTr
         jmGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528475; x=1775133275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        b=JL7Oa7vc0gQP3LaU9EmY7l/Sc3kiXzVV2l4mvNsVkgnVDbpk6z3rcFSzBF+p6PLsaK
         xIqZlN/lFJO7ucuknZRX6IPGOVvrIS4sw27tR6yQ3o6EkNlbAE3NNC3davrhEXrHDF/K
         D/IGxuhh7kk0SEGtzkRneSgc6WGxXt+FkySAtdsdtZNysDglGBmg/7PVXKcReIu9pt/d
         e6dLSCw88Ct9Bjr2rRc0o+SAf2YLlfa6EzL1nTRXgLWVoqx0cnxuZugvr/kmqe9315rc
         jBpk4uJDAzLKDSvC3ps55265Y/EY7/3IYdyEJAuNmWRogs59r5VwtTPRAqipBit+zJcm
         xKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528475; x=1775133275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKfBZ3nUfK2TfojoC1M4yQGHYMzoN7cQZr4Vt9bR1fc=;
        b=lEudTvTmfK70uLHoJv0/NGErjfqeghEHEV4cw/65euA987SWgpcEhdgQTJHn6VOc2N
         /au/6NhzvIS9TSOGixcRazyh8XcruV0fCSqyT0iiLpKqXNmxgRnf0qIVe1YOPPppzr6R
         2lru1SaqltjrikFf9M6XRjpn0BJiPUdSlxHlNYkn5C6hHcBMGhbCCsXJKCIxvgfFepVH
         BzVgURzbRYoSt964H+aE++jgtsQOwwJSIQ+DMkQ4rVYydIS2Ys2wu6XZ8ISajrgOOnf9
         vT2GgMcSKWqPPN4w1rhTo5p3hCmFNuXhyBfkzt9lP8tZ0z04db1xdV/fuiJolnhXn5Un
         qQxA==
X-Forwarded-Encrypted: i=1; AJvYcCUvfEViVh/5iG/NwdeBC8W1/u469sS78rPYOugcluPR/wwtwQqq1V4KIec2x32kgss0IxRIh+aKkbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNqk6+xBjyqNR8/pfBTAvuqmFj6JvfyAR8H3ACXgtwZyVUn9i8
	z28tEHO5+nUJ/lPhq4h5YjLl3v/oXsYHUwk/AT/qDfU/o4wXJrMSRLZ/iYfnyOKjl3djUwnuuYG
	imsCLjaxo8WXjsw9zVq46qbBCo+W/crIA6xX/e04g8w==
X-Gm-Gg: ATEYQzwadwZxuvH/2G+sBcxUqBUnrRCAwkfyL1OEBBRBpJFy9ZxislJwUZzJGEq/AOp
	AdBnyzzWG+eGSEuHDHwCjW7ElAnMbGREsxyRf3xBmshc5rD0vfPRj7XRUIo0Lq6+T8D3ZEsze21
	7BxTHhr+N/hIpwHSfTHfhNe8NwPCD8xzJfie4H0SL03cIKma1u0ozl1EHgYfb8hS1frJzx1Rrvo
	VMxSaXkA1AIw2LXy1ihyNeOWpKXxit4eHh81OaCEN0V5RFySc5DjfLY2Id3wZGq3RtDzgZO9UYs
	SF6sMhU=
X-Received: by 2002:a05:6512:3ca1:b0:5a2:8636:6150 with SMTP id
 2adb3069b0e04-5a29b977f5cmr3510136e87.10.1774528474999; Thu, 26 Mar 2026
 05:34:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324143448.2631888-1-b-liu@ti.com> <20260325134947.2799552-1-b-liu@ti.com>
In-Reply-To: <20260325134947.2799552-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:33:58 +0100
X-Gm-Features: AQROBzDsSu0isFOTp7LFpErPbIIJz9mwTZMH7T_NJkSfkIxfgjxejHieQax_j2k
Message-ID: <CAPDyKFq42GDC6V4WZpax_tFM69JPafB9_UOAsfkJN1ZxAP7LeQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk, 
	shawn.lin@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 14:49, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> With i2493, the MMC interface has the potential of write failures when
> issuing multi-block writes operating in HS200 mode with excessive IO
> supply noise.
>
> While the errata provides guidance in hardware design and layout to
> minimize the IO supply noise, in theory the write failure cannot be
> resolved in hardware. The software solution to ensure the data integrity
> is to add minimum 5us delay between block writes. Single-block write is
> the practical way to introduce the delay.
>
> This patch reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> [0] https://www.ti.com/lit/pdf/sprz582
> Cc: stable@vger.kernel.org
> Signed-off-by: Bin Liu <b-liu@ti.com>

Applied for next and by adding a suggested-by tag from Jens, thanks!

Please consider sending a patch on top, that decreases the data size
of struct mmc_queue_req.

Kind regards
Uffe



> ---
> v3: move the flag to struct mmc_queue_req to reduce the scope
>     cc stable@
>
> v2: add errata details in the commit message.
>
> link to v2:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#mb201075c9c466a78b58dbb0bf1f39139f0928591
>
> link to v1:
>     https://lore.kernel.org/linux-mmc/20260310160408.3976760-1-b-liu@ti.com/T/#u
>
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  drivers/mmc/core/queue.h |  3 +++
>  2 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..db8c99c73a61 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>                     rq_data_dir(req) == WRITE &&
>                     (md->flags & MMC_BLK_REL_WR);
>
> +       if (mqrq->flags & MQRQ_XFER_SINGLE_BLOCK)
> +               recovery_mode = 1;
> +
>         memset(brq, 0, sizeof(struct mmc_blk_request));
>
>         mmc_crypto_prepare_req(mqrq);
> @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>                 err = 0;
>
>         if (err) {
> -               if (mqrq->retries++ < MMC_CQE_RETRIES)
> +               if (mqrq->retries++ < MMC_CQE_RETRIES) {
> +                       if (rq_data_dir(req) == WRITE)
> +                               mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
>                         blk_mq_requeue_request(req, true);
> -               else
> +               } else {
>                         blk_mq_end_request(req, BLK_STS_IOERR);
> +               }
>         } else if (mrq->data) {
>                 if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
>                         blk_mq_requeue_request(req, true);
> @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
>         } else if (!blk_rq_bytes(req)) {
>                 __blk_mq_end_request(req, BLK_STS_IOERR);
>         } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> +               if (rq_data_dir(req) == WRITE)
> +                       mqrq->flags |= MQRQ_XFER_SINGLE_BLOCK;
>                 blk_mq_requeue_request(req, true);
>         } else {
>                 if (mmc_card_removed(mq->card))
> diff --git a/drivers/mmc/core/queue.h b/drivers/mmc/core/queue.h
> index 1498840a4ea0..c254e6580afd 100644
> --- a/drivers/mmc/core/queue.h
> +++ b/drivers/mmc/core/queue.h
> @@ -61,6 +61,8 @@ enum mmc_drv_op {
>         MMC_DRV_OP_GET_EXT_CSD,
>  };
>
> +#define        MQRQ_XFER_SINGLE_BLOCK          BIT(0)
> +
>  struct mmc_queue_req {
>         struct mmc_blk_request  brq;
>         struct scatterlist      *sg;
> @@ -69,6 +71,7 @@ struct mmc_queue_req {
>         void                    *drv_op_data;
>         unsigned int            ioc_count;
>         int                     retries;
> +       u32                     flags;
>  };
>
>  struct mmc_queue {
> --
> 2.34.1
>
