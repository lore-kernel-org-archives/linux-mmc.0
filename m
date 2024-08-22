Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E19219E7D8
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327276; cv=none; b=gSGsB5tgFx/VXejcMPeIJutR9MTS3JZsmprO8z+QKp8KVm/zxxpS8A7SGLm9CkhgMQsxzXaEsb8ByyyslCCoi0oWlJd53cSvTFQNvsto0qPU6mpWNZEojfElCclPBCxI7eFm5+Yc7AQap/t0DAsivPY6tSELUkAs0CY/eYM2v1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327276; c=relaxed/simple;
	bh=3fBJGCz+KtGOIjt/GUsfdIsu5LIwGIExENIyzQh2l1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4AXzf56ji48X3XPfEdX7thUJqznD9xPNoaC7M7eDJ8iBGzI0c1L8QPLT8tzH8BjoxULVgG7eOh1dwmAz9ecx96zm8wrNGfPYUHMUcCp3qBi3xvdwv6uzTdqv43jilP2qB/++Ymd2V5yqxhamzv7iHAPY54llU3grWQsrlLNvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2mVjxcU; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2mVjxcU"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso740419276.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724327273; x=1724932073; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owOsqEVUw4OeYUxzHuNj55dCE+QY9qdIg9fK554kWVg=;
        b=h2mVjxcU1whd4EKC2l2Qdcp2ywZ3Koe3yOfEPjzrmyn71/a+OZK59WmTP3WzNQCd8p
         8C1ScmjZnhFCqroR18h0PhIcTmXMGFBPXW+FhTo4zwXeieRDlUznoHNolfCMtBXPNC/K
         m+gXGCShfc+5/03VlfqBtVOydHDaNiLaH2kzqY+nwLD613tanqdHWiP5C0MURovhMFH9
         oGoYu3j7o8vVwz7qsibyEoACFTxvPRNBRM6TjsLBAWGxaLD3HPVr1nLMB+IqNONUUGhe
         Y3jhs6zQwbS90Vp7X5V56MbRGtqXgmdzeL+7kbyhJzRJg10xhXXpXXJ06TxdK97USkdd
         VHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327273; x=1724932073;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owOsqEVUw4OeYUxzHuNj55dCE+QY9qdIg9fK554kWVg=;
        b=eU7C2bdYvoGd2iu0Ut2zkJs+gxDnKw7VQ1AiRaJRff7QDgcqz8BPqBNXW+ZAtEcIQA
         ctQ73egvBTpNI/F+BekFpTccVw10aUk/oh1YUA3TH2tHE0qlz4Xs/cKDYY9A03pq4TFW
         EsXAf2190YrAvEoHXBIS6SXOU3heeo72C0BylWawAONqSVXQ+vaDIAD7isbwiWzxku+o
         yQIQnpmY6c5uRxj87u8n3rO2q2pVQ5UBHtdT0oJ6zDjC2jGHij5YLrPeom4WzxqKiTeX
         jvF2mpXTrDQ1oJwA0oDNEtXQ0/lbgrs6IB27B4W1b9txvsP1zJqlwykD9loqumVBj08w
         rKyg==
X-Gm-Message-State: AOJu0YyBHfLcRoxNZR+nuC9RlWdD0YFXPEYiIeJD9wCWj/dX4vMy9a2U
	PXd5z2uwi93Z5Jby2iVBBDAltO4oAbP0jjKXOESebyPxi/l8QpVAclb3aQkrQ9XWLX9iQYRWdEC
	OkZibk6Q7/4jaQ8nq4ChqLpXLLjHRkpjSWOHofGY2ZAYOkOb7
X-Google-Smtp-Source: AGHT+IEtRq9jXP3sA3EGu7t80/gg6fjRgjW1l/mSndAAEcfpgDS2Lp7bZkvWnFdgv5uTjplpZ4jmqs7LZeu583iL8lE=
X-Received: by 2002:a05:6902:1681:b0:e0b:6bb1:fba with SMTP id
 3f1490d57ef6-e166548db12mr6366071276.30.1724327273234; Thu, 22 Aug 2024
 04:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-3-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-3-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 13:47:16 +0200
Message-ID: <CAPDyKFrtHX_gK_HU4c5DM+KfG=L8C0rqBg1GkrcdEvLG5vMnbg@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] mmc: sd: Add SD CSD version 3.0
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> Ultra Capacity SD cards (SDUC) was already introduced in SD7.0.  Those
> cards support capacity larger than 2TB and up to including 128TB.
> Properly parse the csd register as the c_size field got expanded to 28
> bits.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

This is more what I expected from patch1. Perhaps we should simply
squash patch1 and patch2?

Kind regards
Uffe

> ---
>  drivers/mmc/core/bus.c   |  4 +++-
>  drivers/mmc/core/card.h  |  3 +++
>  drivers/mmc/core/sd.c    | 16 +++++++++++-----
>  include/linux/mmc/card.h |  2 +-
>  4 files changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 0ddaee0eae54..30763b342bd3 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -321,7 +321,9 @@ int mmc_add_card(struct mmc_card *card)
>         case MMC_TYPE_SD:
>                 type = "SD";
>                 if (mmc_card_blockaddr(card)) {
> -                       if (mmc_card_ext_capacity(card))
> +                       if (mmc_card_ult_capacity(card))
> +                               type = "SDUC";
> +                       else if (mmc_card_ext_capacity(card))
>                                 type = "SDXC";
>                         else
>                                 type = "SDHC";
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index b7754a1b8d97..64dcb463a4f4 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -23,6 +23,7 @@
>  #define MMC_CARD_SDXC          (1<<3)          /* card is SDXC */
>  #define MMC_CARD_REMOVED       (1<<4)          /* card has been removed */
>  #define MMC_STATE_SUSPENDED    (1<<5)          /* card is suspended */
> +#define MMC_CARD_SDUC          (1<<6)          /* card is SDUC */
>
>  #define mmc_card_present(c)    ((c)->state & MMC_STATE_PRESENT)
>  #define mmc_card_readonly(c)   ((c)->state & MMC_STATE_READONLY)
> @@ -30,11 +31,13 @@
>  #define mmc_card_ext_capacity(c) ((c)->state & MMC_CARD_SDXC)
>  #define mmc_card_removed(c)    ((c) && ((c)->state & MMC_CARD_REMOVED))
>  #define mmc_card_suspended(c)  ((c)->state & MMC_STATE_SUSPENDED)
> +#define mmc_card_ult_capacity(c) ((c)->state & MMC_CARD_SDUC)
>
>  #define mmc_card_set_present(c)        ((c)->state |= MMC_STATE_PRESENT)
>  #define mmc_card_set_readonly(c) ((c)->state |= MMC_STATE_READONLY)
>  #define mmc_card_set_blockaddr(c) ((c)->state |= MMC_STATE_BLOCKADDR)
>  #define mmc_card_set_ext_capacity(c) ((c)->state |= MMC_CARD_SDXC)
> +#define mmc_card_set_ult_capacity(c) ((c)->state |= MMC_CARD_SDUC)
>  #define mmc_card_set_removed(c) ((c)->state |= MMC_CARD_REMOVED)
>  #define mmc_card_set_suspended(c) ((c)->state |= MMC_STATE_SUSPENDED)
>  #define mmc_card_clr_suspended(c) ((c)->state &= ~MMC_STATE_SUSPENDED)
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdda50..28193a9b31c9 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -157,6 +157,7 @@ static int mmc_decode_csd(struct mmc_card *card)
>                         mmc_card_set_readonly(card);
>                 break;
>         case 1:
> +       case 2:
>                 /*
>                  * This is a block-addressed SDHC or SDXC card. Most
>                  * interesting fields are unused and have fixed
> @@ -172,14 +173,19 @@ static int mmc_decode_csd(struct mmc_card *card)
>                 e = UNSTUFF_BITS(resp, 96, 3);
>                 csd->max_dtr      = tran_exp[e] * tran_mant[m];
>                 csd->cmdclass     = UNSTUFF_BITS(resp, 84, 12);
> -               csd->c_size       = UNSTUFF_BITS(resp, 48, 22);
>
> -               /* SDXC cards have a minimum C_SIZE of 0x00FFFF */
> -               if (csd->c_size >= 0xFFFF)
> +               if (csd_struct == 1)
> +                       m = UNSTUFF_BITS(resp, 48, 22);
> +               else
> +                       m = UNSTUFF_BITS(resp, 48, 28);
> +               csd->c_size = m;
> +
> +               if (csd->c_size >= 0x400000 && mmc_card_is_sduc(card->host))
> +                       mmc_card_set_ult_capacity(card);
> +               else if (csd->c_size >= 0xFFFF)
>                         mmc_card_set_ext_capacity(card);
>
> -               m = UNSTUFF_BITS(resp, 48, 22);
> -               csd->capacity     = (1 + m) << 10;
> +               csd->capacity     = (1 + (typeof(sector_t))m) << 10;
>
>                 csd->read_blkbits = 9;
>                 csd->read_partial = 0;
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index f34407cc2788..f39bce322365 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -35,7 +35,7 @@ struct mmc_csd {
>         unsigned int            wp_grp_size;
>         unsigned int            read_blkbits;
>         unsigned int            write_blkbits;
> -       unsigned int            capacity;
> +       sector_t                capacity;
>         unsigned int            read_partial:1,
>                                 read_misalign:1,
>                                 write_partial:1,
> --
> 2.25.1
>
