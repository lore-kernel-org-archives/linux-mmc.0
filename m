Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E263EC2C4
	for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 13:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506363; cv=pass; b=cZQ8smcQRLdqmnspchra+6ivYangzHy+rh4G1iyt2MFJ1EwqRL1tnFhff0/AFUE1+i/oUXiIFte5lKfkENvM2UBPJtsK7OmkxAa+aIzbyuv9b+BqdfQX0Pr75MbSmV2gq7fUMlXl51OfwQN+G6Gf6WSn9ay83je12UuMOigDqj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506363; c=relaxed/simple;
	bh=1ByvReWqDCoFL9lfsCkhBG0/+DjY5/C+3t6uauXWYYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e9+2byWLI5LosxnjNzUn9fvJNg/Y9qro1Vpx71P18NskZxT5zkVQd2Yek98hGZJeR0mdzlLIv15kSmL/KmtFX2tQpBrKfiW672290aRYtwqbbqs42mGe/xCBT8n3ilDQo00ViPbMhnAb/i/UEIoQuNrfx1VMIqvF22vtSAwnb8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C3oqrRAI; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3oqrRAI"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bf02533706so37679457b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2026 06:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778506360; cv=none;
        d=google.com; s=arc-20240605;
        b=YqTfacrMlv4mlXkY1vt3NbYZDw2+RhGxr4GWUqsBD0rEHUXtz7Wj7qr17gMQOfQHmf
         1sQO5Z+VVfZcno2lLDvo12d+huqthJ9rHDSifyAKEzoyYMPNkewM4y6TKLsTKwY9Osyd
         MlR9InVmnjGhB1CnBoHnRSdzYadCSqfoigaIJLbTzPEmUOTRArLbSg6g9c9l6uqwVrZ9
         KXHIjtJqcihwJFdJggNzBQpHhiy2xguR0SXNqrqsv3qScpkWwXjhJR0JHFWyJU/WzJgs
         9Z/1JjlV+FiOGLSvuyih6RMKDok2io0BaLmi7WuP4KHcWyN7pQg8X4W4dAO+Go1IyZMW
         p6Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3kNnLF+2p/vpstsJsZcDCjmueT8xbGo2MfOzM9P3fwU=;
        fh=VjPdG3+ECMiNp50hgp1PrTqfFRcA9ODFdyc7rbBXGFY=;
        b=Xj51Sw/eDrrfe7UrxjS8Lwg+qCatK8D/SW/2MiOG6IG+VkJ5f1llOvX0YOF6VA8Awh
         quCax1n7F/EYgjXIry2NJav8ncHD76Elv4WPw5cyDzZHUSLy/FD20r851ehJ6WLY/lyD
         Sf65rkVP8ZnuCOdGIqUq291r2S0LZw5XMi30VCpUnrNFAjHAlGQ/37dalAw/KJ5erfHQ
         J8+B4MTFLEJrPzCkZB7Fe7McNt6mQIVPJnTuHHZlrQHSDa5tK+8pT2OquM/p687Sw1Z5
         vzdpqYj0+Dve+ZenRi7eKu2ApxWqNah1Rz3CDhqjE4BjqmU4XLoIgCa0BXzJ4P9vzSIJ
         jSFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778506360; x=1779111160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3kNnLF+2p/vpstsJsZcDCjmueT8xbGo2MfOzM9P3fwU=;
        b=C3oqrRAIxOjiEqXofSQ3bmbKeJPDOgmbjPa8lOzHtPA3dlBXl3DhdLT0sT5s2ltfPD
         MjpRtZPqcm95fUrq/WLKLni1/oC3cF5ozDG7lsK0HO1T5ZWz3cj/FApgpxNi82g/oGwZ
         zDnitx3zmJW2wBJI94H+NXOF6yiKKS7xiynHbVHv9JHiWhTSBZc8V21dFOgB+eWKw/rd
         3Vo1WPgKeBheyjqLFVPN01dechQY13ovJ3cpItMqCMIMu0+gyO9xb6jaBbG73hxpqgdv
         kRGseC8ymwbMi/8M5XTvAmu4F48MYab/8N502CH0HXqEGZKowDJRlH96k9Q4oTORrPsb
         DpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778506360; x=1779111160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kNnLF+2p/vpstsJsZcDCjmueT8xbGo2MfOzM9P3fwU=;
        b=SF3diPGo/tvpXf5ckCrnYctCs7Ce+pw8IP1qNNcAFPZFC5AlklrvFj61DKzZJhmwEX
         MSp/BZqqjahQ8J4axTrfGfE6H4XPGS7Q4fmBceDYtLWs4edAilu4u0wGc5qdo4DCa/Ts
         LNdZFDY2YTGOrHjUnOQ8dD3YX82qyM/tu4UKiv0Wd1KUNuEUM/1/H3lcS1aCgarpgPFB
         CTMGHfUyIOVkJhMlOPQ3HzklulTXWq1IATFjxCIbnME5PTa8+xb0+iXbFgbddGTKjjzn
         XeMmi5NHbTF6clRV6ckQXLRPiNdO1M42z+8X8PDoRhKvBMvJNGlmDnZk/SHgILki0UkM
         E6AQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3mMuiMEEmeCRrK8/ThDeNWlY/aim/JNKqiyMB3XTe48euhnmldwldAHrevhG6zNSgMqJ7YdRGzgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVgp2OQevdJpQqv5WzEzz4mL1bfj7Gg+pePYpooKYwaBqPdf3+
	oOSjBb0RZk/XjsaRfVEW/jUWAZUbhhzTMPyXc8Y6cVOhI8+QVC1yhtfE5ineNeDTwq6XRa8UFve
	/B0adAJv+XUF1LVNwZVfOMqf3PrzABZ6ulsW9nsPJcg==
X-Gm-Gg: Acq92OGNaJWl9MMy5Vo1Q6+bqOQKVK5jZNY6BF47SSjuyUfhv+KXyD0d9l2mXSi7i8E
	/C236WWUeo+sJmIBROzEm9MB5wf5q6lPNCocM41l1JV+XkdJXTbsw36NblWv9McrhJzVZlmsIFq
	QJqNHL9S/jueubl312dW+8+MYrSn/Wl+fYdyZIBS0ekceKKmf7A4tmZPldjdJpNX+qpi2Kt1OBp
	h9QUieHN7X9UmME1uhmamiYJIVvXFNt6d7UX2ferotq5q7iyhDEaW6C6AvhsOk5vgXvX4uhT5oq
	RJRn23U4
X-Received: by 2002:a05:690c:6101:b0:7bd:95d1:ed51 with SMTP id
 00721157ae682-7bdf5e9bf09mr254580917b3.28.1778506360395; Mon, 11 May 2026
 06:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1775720894-97901-1-git-send-email-shawn.lin@rock-chips.com> <1775720894-97901-4-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1775720894-97901-4-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 11 May 2026 15:31:59 +0200
X-Gm-Features: AVHnY4LvEXWu95Gh6wocTKdc3h3pdGiDHVq0Zvt8rmPPBiDm4Id7zGut-ogHsU4
Message-ID: <CAPDyKFo=Yuhbsa_8vKRCvZcyN-xo0MxOQOu5XGBQP4AXwdN8DA@mail.gmail.com>
Subject: Re: [PATCH 3/4] mmc: dw_mmc: Add desc_num field for clarity
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 9 Apr 2026 at 09:48, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> The ring_size field in struct dw_mci is misleadingly named.
> Despite its name, it does not represent the size of the descriptor
> ring buffer in bytes, but rather the number of descriptors allocated
> within the fixed-size ring buffer.
>
> The actual ring buffer size is fixed at PAGE_SIZE (or DESC_RING_BUF_SZ,
> which equals PAGE_SIZE). Within this buffer, we allocate either
> struct idmac_desc or struct idmac_desc_64addr descriptors, and
> ring_size stores the count of these descriptors.
>
> This naming has caused confusion, as it's also used to set
> mmc->max_segs (the maximum number of scatter-gather segments),
> which logically corresponds to the number of descriptors, not a
> size in bytes.
>
> No functional change is introduced by this naming-only patch.
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>
>  drivers/mmc/host/dw_mmc.c | 16 ++++++++--------
>  drivers/mmc/host/dw_mmc.h |  2 ++
>  2 files changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 20193ee..df6daa6 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -491,12 +491,12 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>
>         if (host->dma_64bit_address == 1) {
>                 struct idmac_desc_64addr *p;
> -               /* Number of descriptors in the ring buffer */
> -               host->ring_size =
> +
> +               host->desc_num =
>                         DESC_RING_BUF_SZ / sizeof(struct idmac_desc_64addr);
>
>                 /* Forward link the descriptor list */
> -               for (i = 0, p = host->sg_cpu; i < host->ring_size - 1;
> +               for (i = 0, p = host->sg_cpu; i < host->desc_num - 1;
>                                                                 i++, p++) {
>                         p->des6 = (host->sg_dma +
>                                         (sizeof(struct idmac_desc_64addr) *
> @@ -519,13 +519,13 @@ static int dw_mci_idmac_init(struct dw_mci *host)
>
>         } else {
>                 struct idmac_desc *p;
> -               /* Number of descriptors in the ring buffer */
> -               host->ring_size =
> +
> +               host->desc_num =
>                         DESC_RING_BUF_SZ / sizeof(struct idmac_desc);
>
>                 /* Forward link the descriptor list */
>                 for (i = 0, p = host->sg_cpu;
> -                    i < host->ring_size - 1;
> +                    i < host->desc_num - 1;
>                      i++, p++) {
>                         p->des3 = cpu_to_le32(host->sg_dma +
>                                         (sizeof(struct idmac_desc) * (i + 1)));
> @@ -2858,10 +2858,10 @@ static int dw_mci_init_host(struct dw_mci *host)
>
>         /* Useful defaults if platform data is unset. */
>         if (host->use_dma == TRANS_MODE_IDMAC) {
> -               mmc->max_segs = host->ring_size;
> +               mmc->max_segs = host->desc_num;
>                 mmc->max_blk_size = 65535;
>                 mmc->max_seg_size = 0x1000;
> -               mmc->max_req_size = mmc->max_seg_size * host->ring_size;
> +               mmc->max_req_size = mmc->max_seg_size * host->desc_num;
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 14fb2b3..a05100c 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -80,6 +80,7 @@ struct dw_mci_dma_slave {
>   * @cmd_status: Snapshot of SR taken upon completion of the current
>   *     command. Only valid when EVENT_CMD_COMPLETE is pending.
>   * @ring_size: Buffer size for idma descriptors.
> + * @desc_num: Number of idmac descriptors available.
>   * @dms: structure of slave-dma private data.
>   * @phy_regs: physical address of controller's register map
>   * @data_status: Snapshot of SR taken upon completion of the current
> @@ -185,6 +186,7 @@ struct dw_mci {
>         const struct dw_mci_dma_ops     *dma_ops;
>         /* For idmac */
>         unsigned int            ring_size;

ring_size is no longer used beyond this, please drop it.

> +       unsigned short          desc_num;
>
>         /* For edmac */
>         struct dw_mci_dma_slave *dms;
> --
> 2.7.4
>

Kind regards
Uffe
