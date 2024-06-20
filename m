Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942AE1AC453
	for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 12:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718887151; cv=none; b=ptKMAEXBQwnvEzFiTujxNiROTbAug25yBW3fFDjyjy046D796NzfWN+Xz+Kxy12jceZMfr1fqp0uMQQa97b6duArxxE3WRNhOs7hG4eQIsdVZopsQyCwjhtivdm+RuwqBfp7O7YDm37xrhwckpBG4/1sXNlq0WzlQ16AmyAO65g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718887151; c=relaxed/simple;
	bh=+MKb0d6kGQXFAfTFxGeErEGjvV5X6Fkm4QbR7GkA4DA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeAifmGEDq2WQK+XLbEThFDRO66SP0un3LWYdtM3tWpbTzs9edcdsKH2ynjvskNomAaQhJLqfCWN4DLLG+gL0jZniFkGDFXw1TJ/tRlKeyaZ04bGRHN7CSEbs2CsGGH/HcGzeKUQuoKe53SosxGPW4EKG5uKCnH5sA3gToI6gR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Mb22D8YR; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mb22D8YR"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0272692096so787508276.1
        for <linux-mmc@vger.kernel.org>; Thu, 20 Jun 2024 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718887148; x=1719491948; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MXrsS2mpejDFsFEi94Ftqe+sXeL8FdVZSl2zE7uQvoQ=;
        b=Mb22D8YRuTPzJ5VOL8QVtTezWAOlNvo/yOxcuK7bRE4S5Yfh2dnSPSdKSH3ewLtpYm
         SIde8O1cGxCqrgqwuKTEHBwfL/7NYIIMx61WV4oaZpPcfgn/gqLPvmD0uNcZ/HgTxQXl
         Dm9XSGiHBFtRiTuHXZmV6rvc8E9Hw0FUHox0GG5N3BI1tyFi9u5Gv/wTA1106LfpE0o3
         rVbOp+W0glASHYdGqv8fjN2mLHxSN1OIcjgwlH3pAKLNoyZCoJoc65OCzYl41IZX6sVp
         tium8weJl+yTWxVah7BI9bHSaIyua7UoIAcHnY1nh2cjoJ0J5vVBr3716svOMr73QNz9
         fD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718887148; x=1719491948;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MXrsS2mpejDFsFEi94Ftqe+sXeL8FdVZSl2zE7uQvoQ=;
        b=T2h7GcO3qoHeyZWr37Zv2dyTH8YOLNa0oWHm0WLrh4gUm4m+pNJEz8SFP/9KxN3kMk
         VCTYQ2kpTn8O0Nw9JBULu+1wzF+r/FzPi+g3DgQo7tYeyu0Tmde9xp72aAyEou8t3Abz
         DFiQvRcFQ3wvhQKY8FhmHY/GV5i7BQKhQOnmmGRtLSDlN2r/JO0X5kZkT4+Ma5mc93pr
         AIq6mcWGMcftcoRr0VTTqrrc23v30GoEmd+FXtKhsHDPgE6TF14bpLG774RgRt9lAdX+
         l2iSQJP023gFoqXGpjENXJmXg1pBXNR363eF907l7kX9u4Oz0yU1jpjRtufKWOOc1o3D
         /kDw==
X-Gm-Message-State: AOJu0YwSto9CJiFhX6eOl+v4Y/RGiwJPkMruayzfSVLt1GxSzbrOosvJ
	RjL5IG2v851Z3kid/TxGN2MaFglNGFtAd2D5iYfMZbOy7IzfqJh/1EchmVMBA1VuSjE8iACZMOL
	ON8AIZlXWtBD/+BQhhb32BHcGfqAWT126k0+1uMRs2aozbzonlRE=
X-Google-Smtp-Source: AGHT+IGfsRIK8F1k8cecBYpiUgwdL4yHwEhbBpx6cYhEB2iRzrL7VfrwSoALfmBAfls/toiZCfz2rMSHqgmq0xwcXu0=
X-Received: by 2002:a25:b02:0:b0:dff:1a17:dcbc with SMTP id
 3f1490d57ef6-e02be0fc880mr5444939276.2.1718887148379; Thu, 20 Jun 2024
 05:39:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606131222.1131880-1-linux-mmc@danman.eu>
In-Reply-To: <20240606131222.1131880-1-linux-mmc@danman.eu>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 20 Jun 2024 14:38:32 +0200
Message-ID: <CAPDyKFpuJexp_1hgKhJ3b8VCx+PwwhAQscbJT5-44Re0xmbxrg@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: core: allow detection of locked cards
To: linux-mmc@danman.eu
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Jun 2024 at 15:12, <linux-mmc@danman.eu> wrote:
>
> From: Daniel Kucera <linux-mmc@danman.eu>
>
> Locked SD card will not reply to SEND_SCR or SD_STATUS commands
> so it was failing to initialize previously. When skipped,
> the card will get initialized and CMD42 can be sent using
> ioctl to unlock the card or remove password protection.
> For eMMC, this is not necessary because all initialization
> commands are allowed in locked state.
> Until unlocked, all read/write calls will timeout.

Skipping the commands above, only means the card gets partially
initialized. Leaving a card in that state seems fragile. What will
happen to upper block layers and filesystems when trying to access it?

Several years ago Al Cooper made an attempt [1] to manage the
unlocking of the card during initialization, by finding the password
through the "keys" subsystem. The series didn't really make it to the
upstream kernel, but overall the approach seemed to make sense to me.
It should allow us to complete the initialization of the card inside
the kernel and prevent unnecessary complexity for userspace to manage.
Perhaps you can have a closer look at that series and see if it's
possible to update it?

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-mmc/1433526147-25941-1-git-send-email-alcooperx@gmail.com/

>
> Signed-off-by: Daniel Kucera <linux-mmc@danman.eu>
> ---
>  drivers/mmc/core/sd.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 1c8148cdd..ae821df7d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -928,8 +928,19 @@ int mmc_sd_setup_card(struct mmc_host *host, struct mmc_card *card,
>         bool reinit)
>  {
>         int err;
> +       u32 card_status;
>
> -       if (!reinit) {
> +       err = mmc_send_status(card, &card_status);
> +       if (err){
> +               pr_err("%s: unable to get card status\n", mmc_hostname(host));
> +               return err;
> +       }
> +
> +       if (card_status & R1_CARD_IS_LOCKED){
> +               pr_warn("%s: card is locked\n", mmc_hostname(host));
> +       }
> +
> +       if (!reinit && !(card_status & R1_CARD_IS_LOCKED)) {
>                 /*
>                  * Fetch SCR from card.
>                  */
> --
> 2.34.1
>
