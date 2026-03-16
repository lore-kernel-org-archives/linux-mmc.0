Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C3239B96C
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673343; cv=pass; b=DpzKLuLSWKoGd8y40F88e3rm26UrMRXk7B1lHAe/lGabgepmiGRnF5tn2j08q7Mn3mSUbd5W3UasfmOtlxjPi8lIyw8RdR5gWMrx5mGlVnvJVYO1eCL+fLF02L/CW8aPISlIANmawcQC1mKp6fgazPEYgPSgnuPv+dhFTeGzGX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673343; c=relaxed/simple;
	bh=aB1BhmwfaYDhk9Ng1L6dfOkJ4tW5IumC6VwMJNkiH0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSQYddGQXz3WNx6xpuh+UcTqmgR3C5sNCLFdhoQgEGF6tBqHo5z67SqT/Ks4utO94x8y+d5IumOzy3YCKib5nAYBXesnUThBVtrUG96S9RwqTX0z+w1bwPvMCk8C8Q0owNQKTN5H8HOdK6C5pdTcgISVzl7RQbHVb9DExv6/ifA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrpER0b3; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrpER0b3"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-389f9895c81so44990221fa.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773673335; cv=none;
        d=google.com; s=arc-20240605;
        b=DnJOujHK17qKqt9ftsECBNWJYl2/6hGyzRrraUepA6n5DmCV6Ez5e8heH6uf05wbDG
         px5xu667se1LYFSZIi522O4MeIU7nGIVaBFFZQd/gZuqo2xd7k7NqoQYtoQ/GhiGfoxl
         W7TTnVPKAr3EOcA7MfC8YS2bBPWXZXSVrCXMxUkTnJZKAA3UA/xp4DRi0eUgn81PU3AT
         LrMRW05Dj3Jo+t6ISZiT7zOdb8kasMIdpE0Ikb6tgrA0c+YQ76y8PcqQ118N1rLc/J9G
         KKFBI0Iu4mBD/VoUmK1B95tpFD7RmVzIlveix1r3NDb9/Auai5tnTXL1UPFcTupGkJt4
         uOVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        fh=zVl2A+a9ttICsHvvB/cc/xfPTHOsHORAD+F2gqFiTL0=;
        b=E3n0uIRaBfmW4X9q45l1qwENjRUs8SpKq+nFmVDvBIr9Any3yta/jGKO1+ckEKHWPL
         gpm1t5Le3Jx+kj1byzN+Uc8lDbP/vvYkQY2U8ddYwe0I6qgTLsMbxb3YYldNqrHIA3yG
         CfedT1p3Q8nJpG7id7OyvEkyXktRdpe844hBJIh3DANdjbGVfgSuMxF03Rt04WSXn2l0
         q6zi1EnSu6m3F+DqZCS3ic3wtq6Nk0RUpaHN2UPqDAHrX/67nQvu5ZKMApwc3iTABrQf
         RD/WSChJOVl8ZjDuOio5v8jdKtCBL6YLHxUvyscAS6J2aF49+rToX0dTxBub3DQRsmQq
         a45w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773673335; x=1774278135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        b=rrpER0b3oQsl6qd2wTfTEp8KCyKWgEh9CHFbHkgrXLBuvYmNT5Y2mxceUIujR/vcsD
         +Bhng7syUXf0SiOomcKMZE763J18jXLbfTU64FUJIQxmEEUs+WtiA6tXvfIMF9scfvH3
         ZKPxuxaHtsVgFGQprRYhFAYlC8Ttzo2unQA4yhQwv7yfK6xbl4F7KXul4Ergno712TLQ
         dDWFHs784BFXDfdUDOip2Qb1tkXYz/nL+Ijrvd1W8q0+bthVUzVQoA9YWaRGjNMFIN4H
         YZf4diIt+XMOMusyeDcqa0PmJdPk4LjOB+SFNMTqBX3kD+dLhP/fu5pSaybhlGKPFZ8N
         SOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673335; x=1774278135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        b=qbVrgfzk9GlPG1nYDJnK3XOzQcMRT7/uSPOF5UAWkJGBQ6gCOsppDHIyMqZAITx9oK
         UlNl/LW9V2Kn6FaHs5F7mb8fCsNWxX1dJb/G9yejRLDseFwZSOMBOukVTDA+68G6+48/
         JscDnFT+6TGoup0dMKIt6w+vG6YhPn8af7Wh4L/YK6nMtWX+P33aEIfx+dqWwgM+tWMl
         Ihjp9At01OJ/jiOTdAlotfFKbOHnj4aiHFSYAHljvsPRQst83F89ZAaWka0dJs9quyjx
         idBBycxI3ShFz5/bBtntz/PiEYn8vLZ0M/OYMVqi/tyhgwD/mCF2t0TjTfsprGPUFKwt
         EHPA==
X-Forwarded-Encrypted: i=1; AJvYcCVVSnK+GEEzVkGmUvA/RU12ohAt3SAICJE/9IMJ4lObXaAIQxoBasd7BawOTDB8gz2Rn9lxkg5m6gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwluecRU3J95pjATbtqcYQvlgg4exhSrbwcLNxkNlEpIqXEGbwY
	C16OwA/fgT1SXG1jNzvC8w1ppIZftgWB8/ZCu9am7j6thy3dLHwDA3lpKVpOYKHFgT1ZpHIvA/r
	EwVa+BSFNh2AKoa2PphRYRdDcpZEg/auwhRnQ7DzavQ==
X-Gm-Gg: ATEYQzwnRWgJGFnjpljIf/kKWsqEQlhgEuNacpw1td5KJWn9+NknnCDlbxVRVXQpyrY
	qHgEe+Sz+0FJuqfO5N4tcUOYv+KV654yNqS3XRJIiyTvLNyQW9+DPsYuqP7dd6RPSL84j7mDgOY
	D2hA4CJkSwqpBdgJ+BD1fQROG9pxW5j1Mk8fqFt+hz+EL8LWScHWo9SJg9aGil//bMZ6wr8anPu
	0NMNpU6BGACuF/snwvzcfaPZcEA1Ek8dJsQt+VwjDtbrW2fj6wtlCu2O3+EUZJex38yJ4x+D6v/
	Mc1nDB6Q
X-Received: by 2002:a05:651c:198d:b0:38a:6acb:eb1d with SMTP id
 38308e7fff4ca-38a896a74e6mr48932831fa.12.1773673335310; Mon, 16 Mar 2026
 08:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com>
In-Reply-To: <20260310160408.3976760-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:01:38 +0100
X-Gm-Features: AaiRm53DmLZQRz5smLYrt90KUkm2n5La6ui90ypON_Qi-KmDRDlQMD2Uiw4Wo1g
Message-ID: <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 17:04, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> This patch reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> [0] https://www.ti.com/lit/pdf/sprz582

It's great that a link like the above can be provided, still it would
be nice to explain a bit more about the problem in the commit message
too. Can you please do that?

> Signed-off-by: Bin Liu <b-liu@ti.com>
> ---
>  block/blk-mq-debugfs.c   |  1 +
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  include/linux/blk-mq.h   |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 28167c9baa55..5f97d07fa3c8 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
>         RQF_NAME(ZONE_WRITE_PLUGGING),
>         RQF_NAME(TIMED_OUT),
>         RQF_NAME(RESV),
> +       RQF_NAME(XFER_SINGLE_BLK),
>  };
>  #undef RQF_NAME
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..00016584d70d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>                     rq_data_dir(req) == WRITE &&
>                     (md->flags & MMC_BLK_REL_WR);
>
> +       if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> +               recovery_mode = 1;
> +

I don't get this, sorry.

Under what circumstances do we need to fall back to using "single
block"? Or is this just for debugging?

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
> +                               req->rq_flags |= RQF_XFER_SINGLE_BLK;
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
> +                       req->rq_flags |= RQF_XFER_SINGLE_BLK;
>                 blk_mq_requeue_request(req, true);
>         } else {
>                 if (mmc_card_removed(mq->card))
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..06b6e1c4fca3 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -64,6 +64,7 @@ enum rqf_flags {
>         /* ->timeout has been called, don't expire again */
>         __RQF_TIMED_OUT,
>         __RQF_RESV,
> +       __RQF_XFER_SINGLE_BLK,
>         __RQF_BITS
>  };
>
> @@ -85,6 +86,8 @@ enum rqf_flags {
>                         ((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
>  #define RQF_TIMED_OUT          ((__force req_flags_t)(1 << __RQF_TIMED_OUT))
>  #define RQF_RESV               ((__force req_flags_t)(1 << __RQF_RESV))
> +#define RQF_XFER_SINGLE_BLK    \
> +                       ((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
>
>  /* flags that prevent us from merging requests: */
>  #define RQF_NOMERGE_FLAGS \
> --
> 2.34.1
>

Kind regards
Uffe
