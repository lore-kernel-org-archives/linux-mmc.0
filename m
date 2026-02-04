Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BE32E1F08
	for <linux-mmc@vger.kernel.org>; Wed,  4 Feb 2026 14:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770215636; cv=pass; b=hjJm+1w97UNDUHIvqUiFNOX0FBvl2PC6ZERnLzF6aNhiBzw2XgaEuZSSR52dSYybPjNWJQZ2bx8+NeZcXM5C951R09N34CjhG31lsubMQrciXnVydo7hybWx0wSIopTuSjgu/y83xXGfJecukCAOw+ZEZ4Q+uX8rOXD0NjT/65o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770215636; c=relaxed/simple;
	bh=EYXRe70f0VhAsUwZXbYgNsIOmrBCn09wFHpU0kQzeaM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5K0l5ViyOl79bvMo35b/rXe5/znwKIhR5MDcyOOlvPpVJxukfAaLtnviG+xElZdk3LmaiKww6WvSReEx8ePAkEAsmbybAwsNRvQpjoGALlCf/mZLBylNJrosnfwb9fpTGAQSMG/YcEqN4XoOJdFxkHhIwHNMgOPyBowNxQJpJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eu21RlCl; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eu21RlCl"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649bb5a0c3fso3985113d50.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Feb 2026 06:33:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770215635; cv=none;
        d=google.com; s=arc-20240605;
        b=POQBksKhxdBCF2lVUJaDFQ14U7cozqqUGh5XOwpZX+VMB6Q32Op740yGUaGYxkKUQ+
         LFHzw4fPgpiI4puGeIYO6og6dYyXrw0d9AQVPtN1UNV0oxbWwXW4sROJ0IIZFUuiAI8m
         J4XLbG7ZUbKlXen7JXoQp9bAm1vcbWGESmZYUWoUb8Epf6NjyKDmzdJf1mTxSTs1JxGY
         d3mQ/RlQkZcY9uZmXdB4KVafk4O5PuVmhdE/yraJKHb8NDH8a3E6vfCImVJwOJ5Endua
         MvwZAZ+i6IXuQmxLqCnkYetDxXPrlkAJ2sw5eDzd+/wisS+iWmDpymowYgf6mm0M86sc
         KDAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        fh=H44iIizTVNH+vwYhWs9sIcjKcuCFmlWe0VLUfX1p8FQ=;
        b=Vrt3h2PA4N2/nZO04HXBhYU343Po7BaSQOoSv4SRT5djgdAx+gtgcO5p+jonT2uz65
         mbcpX9WOUABFOo528E+GnjJcrAThzc0Wgfbq+gHvjob5SILtaHh/rG9q1nMBCzbpM4WB
         D73VFhYCIknDXLkA5SDZNU6UT79qS178JVTqh6mqopA/ZSPZfeJv50VHLgXYZCFHSaOk
         0SwrYxgnZGNsAZ5iFc6oWXGv0nnmRSNno5S+s5vz75Mqw56J38cqmLXtMkMf/de/tUoy
         kF+R5WFoGhP4B23kRHsg4UfbWwe5QK9s/mx2Jf+hppAKSjY3a7o8Fk0Mivppy8dO1FrJ
         pZmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770215635; x=1770820435; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        b=eu21RlClGiIiH1lIvxhIpgSvXmR1oYucAYPiecNulSM3r1w9T0H7mRPfXs7pV9wTH+
         O6/kXNOBp1e3VuzRJCZRU9O/qMKP5Yf5+acCsIiy2X2FeuB3jhfxgUPWlv+dtRG3FTnD
         Ubw2WsKVuWeY+wGaeSCxX0F2siDwOQFShZkKNEU+9M1G5YnN7d3SzPxmS73JLYvzirBK
         sUjwZyFiOYi7N2TC2iYX9k7lhlTrhehqlyguUq0pndN0NpMmcoLyhuLcNR1ILMLjYL4q
         aaavAZWrFpQLCeyF/PlR9S3Yv5bq8IZMwWKKav73bkMJKvK/9QZJNbqe7N3jFsXRoDNb
         0nOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770215635; x=1770820435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8AAMIJsoWGn8x1NtmyKbgTrFaMWwEU1ewpQmfJpncU=;
        b=jwuikVlvyRUQG2kCdinlVtY/Y1Nwr1iqoIlrgTdujyjav1p3h8GMCYEnqNpytpTtaz
         +T6diBlt8J192de/ZPNDP4x50t8kvW6qGTIt7km6ZnSBY253SGENCkveUEqlHxOPSbQ6
         7G1dmvBP3rlm8zh2a5l3RIwAf4oiekP5pln/9MNee4UyFPkv7GTWeKTYfhpLOEe5KT9w
         bzdiIoAU2hHUL63bbGwE5WtQuq64d32/V8SYZPM5AGOmnN/2PuzIVYEDmel5m/cy4EAV
         wXW0eUMNQjmOG8ARFOauj6levX5TUbiS+JEeZxVo3QWAamPxK/tqiAIHH3lgAqIfJsYn
         LlCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV7LIJvf2exko/czlbOPATBd0+yLQRgcu/1gCcDPwXki8rLqLXodAgzkVU0MoGemZOq261NJreHIM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/aWY6wDzv53bsRmG++746OG0QFulr+uNmau5dx24pLh2o0Vd0
	yLkdQM/7T8rlXREPWZJ5OLg/ZIx/sKsCgo/ELs7jiPfTrJdJ0ZPp/powLMG4xfT4R9UjKd5fmnf
	I/dtx5TpEyGKl2jYQ6ITjjF5zbkbBsnLQ4vt4NvGAkA==
X-Gm-Gg: AZuq6aK9kl0tpmrzaBMaG8zi9MYqT1Ee6sO7Ey5jTbAp2oMVwkbIjl0VSLIfMLDN6Wl
	k7D5zmXQiV8FRsdWeUcQacJoiKJCXz1ltCRpEihsauJ9tPBz0HXtqljLS4xowLMPy4R5KKYm2QH
	aPbz5vDVbj+UiD0t/1CK8DsKxzzUptpxi7RyjYwhHI1FYlnvvXAXEeaM71l85jg0lu6/JiICaIm
	bMW5nmsK8K3kIlZzWV1mHWVOHkrNn6EX6CCZTwp12XiWK4Ip6MkbcPJi8OTblp93us86JVu
X-Received: by 2002:a05:690e:1205:b0:649:da44:78e5 with SMTP id
 956f58d0204a3-649db4e3aefmr2396467d50.95.1770215635430; Wed, 04 Feb 2026
 06:33:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204034003.2961402-1-ziniu.wang_1@nxp.com> <20260204034003.2961402-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20260204034003.2961402-2-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 15:33:17 +0100
X-Gm-Features: AZwV_QjdaIiuyJLYtm5HRUl8trj1dPtvjGw045l2G2FIxpBa3pt8KtgU9SUnB38
Message-ID: <CAPDyKFrnbvkp2_WP837-nsTZN5vatKifETihn-y+YQ1=DjbADQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] block: decouple secure erase size limit from
 discard size limit
To: ziniu.wang_1@nxp.com, axboe@kernel.dk
Cc: hch@infradead.org, linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Feb 2026 at 04:37, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Secure erase should use max_secure_erase_sectors instead of being limited
> by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
> REQ_OP_DISCARD to allow each operation to use its own size limit.
>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>

As I said before, I don't know this code in great detail, but FWIW,
feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Jens, please funnel the patch1 via your blk tree. I have already
picked the mmc patch (patch2) via my mmc tree.

Kind regards
Uffe

> ---
>  block/blk-merge.c | 21 +++++++++++++++++----
>  block/blk.h       |  6 +++++-
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 0eb0aef97197..fcf09325b22e 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -158,8 +158,9 @@ static struct bio *bio_submit_split(struct bio *bio, int split_sectors)
>         return bio;
>  }
>
> -struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
> -               unsigned *nsegs)
> +static struct bio *__bio_split_discard(struct bio *bio,
> +               const struct queue_limits *lim, unsigned *nsegs,
> +               unsigned int max_sectors)
>  {
>         unsigned int max_discard_sectors, granularity;
>         sector_t tmp;
> @@ -169,8 +170,7 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
>
>         granularity = max(lim->discard_granularity >> 9, 1U);
>
> -       max_discard_sectors =
> -               min(lim->max_discard_sectors, bio_allowed_max_sectors(lim));
> +       max_discard_sectors = min(max_sectors, bio_allowed_max_sectors(lim));
>         max_discard_sectors -= max_discard_sectors % granularity;
>         if (unlikely(!max_discard_sectors))
>                 return bio;
> @@ -194,6 +194,19 @@ struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
>         return bio_submit_split(bio, split_sectors);
>  }
>
> +struct bio *bio_split_discard(struct bio *bio, const struct queue_limits *lim,
> +               unsigned *nsegs)
> +{
> +       unsigned int max_sectors;
> +
> +       if (bio_op(bio) == REQ_OP_SECURE_ERASE)
> +               max_sectors = lim->max_secure_erase_sectors;
> +       else
> +               max_sectors = lim->max_discard_sectors;
> +
> +       return __bio_split_discard(bio, lim, nsegs, max_sectors);
> +}
> +
>  static inline unsigned int blk_boundary_sectors(const struct queue_limits *lim,
>                                                 bool is_atomic)
>  {
> diff --git a/block/blk.h b/block/blk.h
> index 886238cae5f1..a6b1de509733 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -208,10 +208,14 @@ static inline unsigned int blk_queue_get_max_sectors(struct request *rq)
>         struct request_queue *q = rq->q;
>         enum req_op op = req_op(rq);
>
> -       if (unlikely(op == REQ_OP_DISCARD || op == REQ_OP_SECURE_ERASE))
> +       if (unlikely(op == REQ_OP_DISCARD))
>                 return min(q->limits.max_discard_sectors,
>                            UINT_MAX >> SECTOR_SHIFT);
>
> +       if (unlikely(op == REQ_OP_SECURE_ERASE))
> +               return min(q->limits.max_secure_erase_sectors,
> +                          UINT_MAX >> SECTOR_SHIFT);
> +
>         if (unlikely(op == REQ_OP_WRITE_ZEROES))
>                 return q->limits.max_write_zeroes_sectors;
>
> --
> 2.34.1
>
