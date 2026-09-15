Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0193F39D8
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 13:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480057; cv=none; b=FuevMzynPvgeep/BE2FdXSvxDUwgjQq6n/BINFz0o8LwOqNGjV9eSyy+FDzK5Ew4NBfTWxGBfhr682BdC7fb2/OHfF8PJZ6n03opovVzRA5fg0KR/Zf0bys6d4tt4s1CpqurNKJfhlTlJaQcybZfhUK5+8e4Zd+8VtFoItBtgRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480057; c=relaxed/simple;
	bh=av0lgor5Cg046CEuwDXRsvCISYUzls8C5RMRjdAXTEM=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:
	 References:In-Reply-To; b=F6lpkRze3DMDfSyMLtC2SjXc9Xs5lgIjSMKtI8bEJNcQWfVTyFyGbmPOS2r579nkm2IGT5jpDgNgeiDzbUAmY4j+YKzY3LwMHposlR+9OvRCgJu3OkD6UAMC0zuZTqICIuwffnQB9JwKX1wlOtvRig51fKj1Mzpx+IbwcedzeDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NioF6exv; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NioF6exv"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b91369d18so2365475e9.0
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 06:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1789480054; x=1790084854; darn=vger.kernel.org;
        h=in-reply-to:references:to:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LnO/RFtPTLTuh551bJsP9vEYVlo8+tuse5zqKBb/5X4=;
        b=NioF6exvopxGsojoMEm0OlrZOqzF6ZfDNNCXhzp709UAdQHWIhKYSS0Uw66OD7mQEL
         nZaJ5Qxa1c92k1ty/VTCdMQzC/RXq6qHp2GkrcVK7OqtsGNUWLaeRaX9FuRB8ShpY5hP
         TJARwo7RvSrxM6FBFAq+ZkfiIgkKuot8pKhOrhHKwJyFVya67sprobbWIkl3xDtac6Ca
         6Nywz5SntDU92Paoec4OPtSXrL0/vdcyLz3gIrrAM0QcGTDNF3Qy1yw/koYPE0mgn8gJ
         hOITYS3pd3T3BvrW8tKqkxEWui3lSPuOm3O6HYp2i7CUk++8QlBKXUhdOOV3U6OKb5yy
         x8yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480054; x=1790084854;
        h=in-reply-to:references:to:subject:cc:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnO/RFtPTLTuh551bJsP9vEYVlo8+tuse5zqKBb/5X4=;
        b=zu9cMI6xGpRJVwcd+ehvRCg4B6A0OwpIt7bKQugnhLZgRBFiLy1z1Qpib0n4xm5Evu
         gbj1q/L+B1+2AAXuRWtG89mPh4dBUTokPQ1llaODEsrNvjh2/FgvJ9OlkEEs1awzw96R
         OPPJdCO+D2rP7N1LMGViQzedM64oLX9rHIkpetV7Z4kTP+mWfj+236ySF6+ATDcQJeey
         hJXFaQAuOrNS+z0cb4DbXpgHneRSW/Nw3A783CudDX7UVd1KFCcCVMUBGfv4PG3K5QkY
         jjWBByv+zxGbXZASeCMEOFEPbrKSI7JhZfEGYuzZ4EKbuf3XA6vW34mHXwfP7vNstYJS
         Iniw==
X-Forwarded-Encrypted: i=1; AKwUvBwAjZFwT+fRkBHueSjXvUPrgZN79IlBN0IRm1KLd0Tag+jNuXuwbET+mbfGb+ZypZNKBc1/4EM+eAk=@vger.kernel.org
X-Gm-Message-State: AFuF++kzRo9vf9ZyKbjW9XNeVnzxTuIlKtEq0ZZ3Z4LTH1rf2gYCgSVt
	2UfOdy4yV0ezRcJ1G221FxOL53mWulmv6cFyif0LlCjOf4OS2j/jKv42dgLMqDTdt9g=
X-Gm-Gg: AYBFou2Pfi+zE7R02253yB1vVzQAiQibp1zMgyioD8jRmYurEOeAQXKK87hiKm9Ee22
	DkNcsySe1k87kM3kD5/gBK9O0VlNOWGUahwAugDZ3bFCTprjK65/E51d7biEjTZy+xfXlTADTCY
	LXaSn1dAdzUVum5B4YH8gOeh7TFbDBdApwO3/6g2dDSp3E8JpWFW/n34qlNUO8O9zpW2dsmlgIc
	SFbS7D1Hm1unbVcmHA7up6kSf4Q/JsvlAS9MODMMOQZ2Mq3vebQFsAbmHJGj1q2Or8hZA9qzxmN
	O+IkX13yJ+tvB3gAspflJbxT40HYa7Ktqdfqqk8+5a+r4u4T8dpUfB7YzzmU3lagAd/kh4aLDVP
	c/ATQg+WkK+1H13wa5wR6AEnnqwrkxlOHR8TeuJXV09x4Z5EDf17aeUhBcnNgyhkogZQnPF2wOs
	Datr84N9hbfB0OiqjUums9+EacZBBSJDMdKdnlmDFE6zxG44hd4rdmHfDZd298UomySFZrxgJDR
	lp5UAxCEw==
X-Received: by 2002:a05:600c:b85:b0:49e:6bce:b0f9 with SMTP id 5b1f17b1804b1-49e8228f49fmr15817015e9.16.1789480053858;
        Tue, 15 Sep 2026 06:47:33 -0700 (PDT)
Received: from localhost ([2a01:11:8f11:bb70:17d2:d825:e2b8:2e8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef6bc50sm67382035e9.3.2026.09.15.06.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:47:32 -0700 (PDT)
From: Rui Miguel Silva <rui.silva@linaro.org>
X-Google-Original-From: "Rui Miguel Silva" <rui.silva@linaro.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 14:47:31 +0100
Message-Id: <DLFXQIQX6Y6W.13CBS3NB0BTI4@linaro.com>
Cc: "Rui Miguel Silva" <rmfrfs@gmail.com>, "Johan Hovold"
 <johan@kernel.org>, "Alex Elder" <elder@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <greybus-dev@lists.linaro.org>,
 <linux-staging@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] staging: greybus: sdio: Convert to
 devm_mmc_alloc_host()
To: "Ulf Hansson" <ulf.hansson@oss.qualcomm.com>,
 <linux-mmc@vger.kernel.org>, "Ulf Hansson" <ulfh@kernel.org>
References: <20260915132052.273212-1-ulf.hansson@oss.qualcomm.com>
 <20260915132052.273212-2-ulf.hansson@oss.qualcomm.com>
In-Reply-To: <20260915132052.273212-2-ulf.hansson@oss.qualcomm.com>

Hey Ulf,
Thanks for the patch.

On Tue Sep 15, 2026 at 2:20 PM WEST, Ulf Hansson wrote:

> From: Ulf Hansson <ulfh@kernel.org>
>
> Simplify the code by converting from mmc_alloc_host() to the resource
> managed devm_mmc_alloc_host().
>
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>

LGTM,

Acked-by: Rui Miguel Silva <rui.silva@linaro.org>

Cheers,
    Rui
> ---
>  drivers/staging/greybus/sdio.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/staging/greybus/sdio.c b/drivers/staging/greybus/sdi=
o.c
> index 3952f3d225db..642d785fe918 100644
> --- a/drivers/staging/greybus/sdio.c
> +++ b/drivers/staging/greybus/sdio.c
> @@ -767,17 +767,15 @@ static int gb_sdio_probe(struct gbphy_device *gbphy=
_dev,
>  	struct gb_sdio_host *host;
>  	int ret =3D 0;
> =20
> -	mmc =3D mmc_alloc_host(sizeof(*host), &gbphy_dev->dev);
> +	mmc =3D devm_mmc_alloc_host(&gbphy_dev->dev, sizeof(*host));
>  	if (!mmc)
>  		return -ENOMEM;
> =20
>  	connection =3D gb_connection_create(gbphy_dev->bundle,
>  					  le16_to_cpu(gbphy_dev->cport_desc->id),
>  					  gb_sdio_request_handler);
> -	if (IS_ERR(connection)) {
> -		ret =3D PTR_ERR(connection);
> -		goto exit_mmc_free;
> -	}
> +	if (IS_ERR(connection))
> +		return PTR_ERR(connection);
> =20
>  	host =3D mmc_priv(mmc);
>  	host->mmc =3D mmc;
> @@ -835,8 +833,6 @@ static int gb_sdio_probe(struct gbphy_device *gbphy_d=
ev,
>  	gb_connection_disable(connection);
>  exit_connection_destroy:
>  	gb_connection_destroy(connection);
> -exit_mmc_free:
> -	mmc_free_host(mmc);
> =20
>  	return ret;
>  }
> @@ -863,7 +859,6 @@ static void gb_sdio_remove(struct gbphy_device *gbphy=
_dev)
>  	mmc_remove_host(mmc);
>  	gb_connection_disable(connection);
>  	gb_connection_destroy(connection);
> -	mmc_free_host(mmc);
>  }
> =20
>  static const struct gbphy_device_id gb_sdio_id_table[] =3D {
> --=20
> 2.43.0



