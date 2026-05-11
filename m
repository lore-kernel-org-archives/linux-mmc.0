Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CD033986D
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506643; cv=pass; b=ipVRDM0yoXM1sjlavl2yLVAEUULpxOsM5aoIMOFLV9oiJcGMOVCiQa3+E/BR2ZuiKqgwZJ5xU01RrgVJEaJtLy8tQTgGQw1Tx7Ry7hlzt/NouRINlqmERbdzy0+fHdf2VOVDmz7mzyYNlec1NBoJWe+KwOgbinm03IIIgWOVSa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506643; c=relaxed/simple;
	bh=9xN+3SdEB+VvRWpXXB+neshSI2iYDuL+rPjbXcC3DEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMVtg6er6RwNm6C78K1S9NJNI0KwjnE4K0fdqoF/kfPE1HdWYLQf4Ydc/p2EtKVrUx2F7UHTNw9wgpjiHrDuDQKvlPTYz7To9Qwu+YE6atFmNfPmVhUUNaoxLX9ZIukjgQ6PYEum9dm2IkpZ+kSb4Dd0Dbc4sYmBmavqQD+LhN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fc9j4arL; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fc9j4arL"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7b41fdf9de2so32635777b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 06:37:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506640; cv=none;
        d=google.com; s=arc-20240605;
        b=HfmqptNzI1UxzAZgAoUno/J6S/bhtteB5SlDrVz61cefbY8Lnj3lRY0r1FFQw2cyfw
         Opn4Wi27Hn5Teuvla6seGQ3j4rDlbvJYhpP6zhe/pc2miVEKh3Pu5tL0xN+C4g74Zdbg
         batdO+84cOLyWfpiR5xTei6HRpsKW6zilrRBe5+ZMBWj6cNQsStrHMnKMXaqAYkQNiJM
         xO/a+joPv7zrAouf4EuokEvLnpavOsJd2yGe7o9zQBs38xHkARgOUTo8wR9PRGYqnULv
         OAUu8SJ6y7BMmbTnepptBW+xwtztRxGJJxHpo4+slwI+eE02syGzCKc7M4bM/ahFypq7
         yZ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bRQH+NoTtGalk3jiWtQHJM+0X+sC7AjR4EA66f0munc=;
        fh=ZGO/mCY3Zu+5LsmA+1r/Pzbs+Yfq8lQDOrEXm7lECeQ=;
        b=i8p2g2xo+GCyfasX60LzmPY/ebvrnG3r7M9d2aQ2ZVlF1rN7sVqo7jlpTQtyaP1SCg
         47LYJA5+UWqUFSTVGqT7lN9O3chQC6rtKi+90QYwhFle0pbTxLZIUvnE/hchfWdeDOGb
         6zWOW4gBdhyUTv7j9A9wbGXxkg6zh5vJwR8TUqt6s3PnShacqzZb4GypgBf/2F8yxq/6
         f1VadTgkjk/wLERvLcHZrc1QnlWHoUF7FiZErv2TiXaKa3hyR2L78YALqRrUBlPm0NYD
         mSgygIUGitNI1zWhAwznLvAB3UrkgWCtb9PqxckYcozUVa5v18UZpNxXDM6068+/bYHT
         ei2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778506640; x=1779111440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bRQH+NoTtGalk3jiWtQHJM+0X+sC7AjR4EA66f0munc=;
        b=fc9j4arLsYb2aOtSBuR3aZUiMfzXepEDUqloQ/k89zv9v4C+FgI9w8Vfme0e9XAev3
         X6UEGiEupHzySfUuTyG+ViFnpBNqXryy35pRqpfjl1tGSnbihv4y5JeTlMn1wS+3wptc
         xyAZ037Y3ERhKRgsAa25U1/kUV5aUu/9x/5LyFreKXrBljUjNjvccCQQJaCCEg8LcTXi
         oV50QtkLlIliDnS8vA94D42Ou/aANhrT9ks0/+46pI2WrHCWIxEgJLy92dLkaU4HbUNm
         Ro52xUkfIspr4gXFVKQJicUdttamRdCwJtJS0IO8RyNPOS+LMMzpH4P2Z9EQjfgFYkoh
         jEXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506640; x=1779111440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bRQH+NoTtGalk3jiWtQHJM+0X+sC7AjR4EA66f0munc=;
        b=FP0JzKJz6spyOXF4LdFHiOsU2EGGXm9yCh6IVM0oI1P8iMD16DskuPCHsEiQGRnciU
         JteUx5d74BCJEQKHr2jkqPWku+BOXd+GX0VWccdTglUMfY/8ulQ+KSGRlQcDwatr/IXO
         BNqxu41q4+xc/s+upAJBnJYdY8daw2rC94/WVmCzSz9vhHVybBbIpu7yYO4zsrlMto9P
         M8hx5v8ZXlygd9RrZVQkkjYnnKpquKP4ovxCoVfU5BKfcyRIzilQwZGh6se6ZaYn11gk
         Fet0Q12riHufZT9r5PS7U/+RyHgflXgtAELe96IABoujaaen1Pm1bS9o6MjnVHbKxC9I
         IBQA==
X-Forwarded-Encrypted: i=1; AFNElJ/9rIdPgX5l/NWSgulNHu7OWTR/gVti6hC5LpkWdRI48GOy+K1+WE3SNthn7q3AAeJ3NDHgX2vRnY8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1FZJb5D1+fdU265dUfZZCSxLhUQ1E8N0bMoHBg5Pm+MjA3zlj
	EPm3LyMreMffYadzXVHge1lGmNxuqd3IMtjeP+cMdP2oIyWNtQmlep2N6sybFNBJaSZSndfY6iK
	McP1KcYQiPpQDCfNUf+97hbTzt6TfJZ/X7R8pGvGJgw==
X-Gm-Gg: Acq92OEUDbLH6GxeyVHuH01lcAOpWgXSXN4TnRd20RE2ckqRV/rc1xj4ScOeZnpqFNI
	ak/ow5QqVE6CnoJbQEPTzfcWcnzypFBMtKAwWCUaJB8NjaMUXac1JDMZESrqu/anUm+lPRC7vSG
	Jf9hXLT3pYdlJM2TrQsxmEKSADh9tYbLEmv2rSb8MWgFkJUpvHArUFsd5aQVnm79Ttk1WiBpjkU
	lFEL2t3iC+PWVhwcIMfWnkj2L0LZNqynVCT2/VJTRyBDT/vZ0auAw9CkX3IJeVIUm45wDnbnDcZ
	rMuRPojYuuhSnemWKbg=
X-Received: by 2002:a05:690c:97:b0:7b3:6c50:2e8f with SMTP id
 00721157ae682-7bfb9f8eccbmr141364877b3.41.1778506639692; Mon, 11 May 2026
 06:37:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com> <1775720894-97901-5-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1775720894-97901-5-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 15:36:39 +0200
X-Gm-Features: AVHnY4IBLMqs8MQWt7ZZGqapRjXsr3Uuun2gDTfRtWUtXXb4F-tesDInSjd0TKY
Message-ID: <CAPDyKFoihN-MiKi_Mbnojx+K6iBugg7nJb=AKMMT0e6bORwjiw@mail.gmail.com>
Subject: Re: [PATCH 4/4] mmc: dw_mmc: Convert descriptor ring buffer to
 per-instance configurable
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 09:48, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> Replace the hardcoded DESC_RING_BUF_SZ macro with a per-instance
> ring_size member in struct dw_mci. This change provides greater
> flexibility and prepares the driver for future configuration options.
>
> Variant host controllers can now override the default ring_size via
> the struct dw_mci_drv_data::init() callback, allowing them to tune
> the descriptor ring buffer size for their specific use cases. This
> is particularly beneficial for improving performance in large-block
> sequential read/write scenarios.

I am not sure what you mean by "use cases" here, but generally, we
should avoid optimizing by tweaking buffer sizes at the host driver
level.

Although, perhaps if you show how this is intended to work with a
user, it becomes easier to discuss?

>
> Empirical testing shows that increasing ring_size can significantly
> improve request efficiency. For example, the block count per request
> can increase from 0x800 (1 MiB) to 0x2000 (4 MiB), as demonstrated
> by trace data:
>
>     dd-706     [004] .....   106.017566: mmc_request_start: mmc1: start
>     struct mmc_request[0000000066f43a37]: ... sbc_arg=0x800
>
>     dd-697     [001] .....    15.227953: mmc_request_start: mmc1: start
>     struct mmc_request[00000000d82bf187]: ... sbc_arg=0x2000
>
> While increasing the request size improves sequential I/O throughput,
> it also introduces trade-offs: larger requests can delay other pending
> I/O operations. Therefore, this configuration should be balanced
> according to the specific workload and not hardcoded globally.
>
> The default ring_size is initialized to PAGE_SIZE in dw_mci_alloc_host(),
> preserving existing behavior. All buffer size calculations now use
> host->ring_size instead of the hardcoded macro.
>
> No functional changes are introduced for existing platforms.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Kind regards
Uffe

>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index df6daa6..61f10e7 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -50,8 +50,6 @@
>                                  SDMMC_IDMAC_INT_FBE | SDMMC_IDMAC_INT_RI | \
>                                  SDMMC_IDMAC_INT_TI)
>
> -#define DESC_RING_BUF_SZ       PAGE_SIZE
> -
>  struct idmac_desc_64addr {
>         u32             des0;   /* Control Descriptor */
>  #define IDMAC_OWN_CLR64(x) \
> @@ -493,7 +491,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>                 struct idmac_desc_64addr *p;
>
>                 host->desc_num =
> -                       DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
> +                       host->ring_size / sizeof(struct idmac_desc_64addr);
>
>                 /* Forward link the descriptor list */
>                 for (i = 0, p = host->sg_cpu; i < host->desc_num - 1;
> @@ -521,7 +519,7 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>                 struct idmac_desc *p;
>
>                 host->desc_num =
> -                       DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
> +                       host->ring_size / sizeof(struct idmac_desc);
>
>                 /* Forward link the descriptor list */
>                 for (i = 0, p = host->sg_cpu;
> @@ -653,7 +651,7 @@ static inline int dw_mci_prepare_desc(struct dw_mci *host, struct mmc_data *data
>  err_own_bit:
>         /* restore the descriptor chain as it's polluted */
>         dev_dbg(host->dev, "descriptor is still owned by IDMAC.\n");
> -       memset(host->sg_cpu, 0, DESC_RING_BUF_SZ);
> +       memset(host->sg_cpu, 0, host->ring_size);
>         dw_mci_idmac_init(host);
>         return -EINVAL;
>  }
> @@ -2954,7 +2952,7 @@ static void dw_mci_init_dma(struct dw_mci *host)
>
>                 /* Alloc memory for sg translation */
>                 host->sg_cpu = dmam_alloc_coherent(host->dev,
> -                                                  DESC_RING_BUF_SZ,
> +                                                  host->ring_size,
>                                                    &host->sg_dma, GFP_KERNEL);
>                 if (!host->sg_cpu) {
>                         dev_err(host->dev,
> @@ -3185,6 +3183,7 @@ struct dw_mci *dw_mci_alloc_host(struct device *dev)
>         host = mmc_priv(mmc);
>         host->mmc = mmc;
>         host->dev = dev;
> +       host->ring_size = PAGE_SIZE;
>
>         return host;
>  }
> --
> 2.7.4
>
