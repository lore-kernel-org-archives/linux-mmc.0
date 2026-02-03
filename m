Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F32333A9CB
	for <linux-mmc@vger.kernel.org>; Tue,  3 Feb 2026 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770119756; cv=pass; b=kQbnQrVwSXcGmrH+Ic1T9/KwB5mCcNVjnsvkHvVULy70F5jdBfGnXwEbNDcePgzjnDm35ykkxYLqo8jXSWqu0xdFv08FZmqB/VmAoIB6HWEdLSpOdpSX3k4WE2moKUDpvi7lU+f89/jid3Pn/+xPBdurXB5eUi1LHv90xVUFtKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770119756; c=relaxed/simple;
	bh=7Pxv2L8BpJWyfUqSmlz7ojW9DgUGKLJAcrIJ+nffUVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBgbtwaveh/nsR4QEKKfuG3gWnoW2fZTUZ47sOWYqRCQKo5m3xqhECOV7oh/ejiw6tJl89ctM3ESXR2Oix2gmJGBvoGg1Ew/27DZwlTV4837VZ9bxgLXBK48cyB82vPDfXDuwcKIDqQIklzinhiXO1OevVE0bxmk+XfpKCe4MN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eg2r5Dcm; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eg2r5Dcm"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-385c6c727fcso52255611fa.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2026 03:55:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770119753; cv=none;
        d=google.com; s=arc-20240605;
        b=g1qcfrBWv2dQp76uyt93dZMOisPrDScJrVQdBPh/ouHlb3D4wflDrdh8UI2/noJqbA
         +ZGhAgtfCUzIk6STb52jyzKRmKRE/ETwjPZKVY2ZZMxC2BQRlH62OSKf0vyi6ql3Ohqx
         eujoq415SwUrngticmW8dMKZiMdH058cHrb19ExqjxuK0fa+xhbiAhQzSGqJ/xWDxFK1
         LxalN0DQd4uv/CZytz7p859wHlnvCK72E23xz2uZatStc9uDHnAzaY7Mh9zwKnCyG+bW
         FCulQpVoBSsI5LUE46p02eKIKUkHJ3Wsn5qmPxbzFq3aXn3vGkwJpS75HZsG7tF25QWO
         a1zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        fh=/ypA6jesJW+72ZM14J0MAQiP4NKlzD0lGXRKbpiHeaI=;
        b=GPEnNZNUUOIBprNS6t8LiRjVnHWGpWYUwznPCHZ7my6el6YoB5V8GkBjwMqOKtAFmV
         K8Jo+qEi0FkhgpgQubM8w4TmzBleSJq07eLF0qxB2hIc/Bt7l/D+J0mU1rqQz/TqRcLM
         /PUgSkuv5pdC2MjwS6nwhrmT/6Yzq0k1gtCwoHk2pS5Iq9xVU7HOVBCRAGxJ1D3IXHcf
         84VpBewtfWL/YGJDAE80IKXlGa72OL2QzuVhdyc4EjeN9CJBw6MXMeMlA+rmduj6zSt0
         ctQRXW2SCf5j3FjOgo4TCGvw8x/qXWKrAaCxxto8BJF9/czsgav8+2NM4PxoKINJj0i9
         DlcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770119753; x=1770724553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        b=eg2r5Dcmt0fsJPNi07Fc2zVkUyPZwNdlgD6lJMWDOOnjAfR3HVNlsbAqwup+KkCzbj
         TIKKsmgEUPG7IfSnO3iVfMBi6CtV16uf0MtsMx8zuNQRQkw2Gks0Z8tJmLqd0eRJ4Uak
         Q9hloPRePxIOFVZHoYLIlWmiXyDYvb9cC6TwniegNy2jjjtjKmMhRstSNsXqSgkwIU2Y
         a8qhxS/6bM+0W/yLQuEDxRmlvYVwCFVBhlBbHiflO6uFmbM+ZVj2ugf92owpzuxrNsxa
         6OlMfx/YnEEIc+Roq5eUoLOhveC778hQ1b8BZ/i7O0kzM+liNqMJsQc+a/5w2vM+4b7z
         9Ojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770119753; x=1770724553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDE0sCrdONDLnFFACkETJtEg6lOLX5zuUsL6oiXslhA=;
        b=JghJolnsElLLF6hLW3AInokxYOtS3rgvpzsP1VzKx/6G80qrORscsFSj0l/ouSXO2Z
         80a5aY3YMWjeJ33Z13wgO98JTe1eZoYkvQ4ZknHABGjc8dF0LeDvJbeGVYWd2ec5vvIP
         DvZdqjr7Q4DC1yo0JZthiIFu0aqvNj9c/BHiIO9pEvkPm8bP7xnLmil2lhaLG05NCNST
         4iZjyKJcankbM42SEVHrjKNq1K8JoSEkyU1+idQuwcbY1PDD1adH+AiU0pWzBNGEcZlA
         unJnhUPVHsGPjHoW7bh+wP/NPziy0l8QvtxW/qW4sscunQWJV9wux/8V1WPAFgNaMTRa
         AC/A==
X-Forwarded-Encrypted: i=1; AJvYcCU4K5S+8/6nJThotpKGOtq8JT9EzE2yhyDDFZO+48kS76Y0hXOAj6U83tvhKbAlsgCoPSesrDNOG64=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBPTA/g7nicDDsre8FU8jc9MU3HqxCutA/k6d/wDHcPTro/inO
	/U66gbLxlzDXMWRqR9oX0qJyEZ3i+TbVxokjGpvQh9+nP1uKxQR8z0VemCg78RukBrYoea9Mu//
	VZxPYON3keGcB4c0nmTM7VqVWPdp/3o6c+CYjLCny8uv9FFZ/RsXWdFcxmQ==
X-Gm-Gg: AZuq6aIv1xeAB/9sdFjvSWDtID77bp6oucCAsBDGc+pHr6M7uf20AM13FjOHsK+Krvd
	rzCIfGfnUJoLGYMAt5uCDPJRJ1HaKuDk8YJGdhnCLH15ndpYvbEPx7lfZCfY6Zy/3GXrqtaxzLn
	RJOaMFYWGYv9KQhgfIW2yU7x7Mp/hJ+f+oK9ZzqUqEQCqUz2kEeUC3mbw0TKxs0+wAHO8eOMaZM
	mF5xaOwk12CVdVuKbD1O/T8+PLnshUB3gNb2lsweAc24aWQqfDRxH3eRBV/PSwD9E+EQzQhdNAo
	Zcvy9es=
X-Received: by 2002:a05:6512:3f25:b0:59e:17b:f4ce with SMTP id
 2adb3069b0e04-59e1644a0f1mr5248014e87.50.1770119753362; Tue, 03 Feb 2026
 03:55:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203102903.2953660-1-ziniu.wang_1@nxp.com> <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
In-Reply-To: <20260203102903.2953660-2-ziniu.wang_1@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:55:17 +0100
X-Gm-Features: AZwV_Qhy5FVK3X1zDmepaoff3JHzpQHSqhwDgipwjkDYIj5M4Whz8OPbSR5lqkA
Message-ID: <CAPDyKFpu6BEqJCg+=E3VDH1DutEy0C-bobtvEXucRBd6JvRbVg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] block: decouple secure erase size limit from
 discard size limit
To: ziniu.wang_1@nxp.com
Cc: axboe@kernel.dk, hch@infradead.org, linux-block@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 11:27, <ziniu.wang_1@nxp.com> wrote:
>
> From: Luke Wang <ziniu.wang_1@nxp.com>
>
> Secure erase should use max_secure_erase_sectors instead of being limited
> by max_discard_sectors. Separate the handling of REQ_OP_SECURE_ERASE from
> REQ_OP_DISCARD to allow each operation to use its own size limit.

I don't know this code well enough, but is this change really sufficient?

Don't we need to adjust blk_queue_get_max_sectors() as well?

Kind regards
Uffe

>
> Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
> ---
>  block/blk-merge.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
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
> --
> 2.34.1
>
