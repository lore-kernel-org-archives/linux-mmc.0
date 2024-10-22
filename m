Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7F319D898
	for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 12:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601000; cv=none; b=eT1Cer9C97tl/0OC9DUPbETFqL0UK3iQNmX/bjcxuKj2hW5Yyf+bPG4J/h6zpl85eZkYHlFqOFxYVO22Ib/JEjzEH+bfnvcd7k36Q+qY1KrFvkn3lNrReRg1XG6F2wrp4DMYVdefjcEyUcrA/PURb4NyWDV0P3HuE1C4qVbe2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601000; c=relaxed/simple;
	bh=n182y8nWJul8CKXkhxxnsz1hFzVx0xF9GJjauPoJ5as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sp8mQwzq2Siqw7GPJVc3J2MjNxmmGQ85FVzKWaTFd5iyljvt+a1xEIobXeWD38I4vIRmLBFD1v/TYShcGvJV5QtSjYvx953dsO/RCkTfoe5jlmzHhCEEEOz8QzxoWBYseCOsxMJBk7/OxTls29cUD2ZKYqZBauyaDPWNWxn5MBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dgwRdPxM; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgwRdPxM"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e290e857d56so5632001276.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 05:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729600996; x=1730205796; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SaOXu7NaxTVENXCsAQaNxc71DXxVkPqm5aNi9pXqVVY=;
        b=dgwRdPxMombofqsZb5d7UNsV2tbwQvJuk66jsYSu+UkTzjetWtMxL7LevusVaVY9IS
         ux10hyFMNHQhSDR32s05IXiK50Ear8qiQOwEnJCvWJ7n+g6Z0ZC92ItvoGuB8DoXT72O
         fpDLK+REbDvvSRJOA2iqOIMVn9N8NbDTjkYnsqAt/l0vd561mxoI43n0z78vYwqnTNMZ
         OzC+v8Wmgw3N+KeFd9cpMZgKrnULiZZdQj4Z4cmlLU53k7izpWIWUtg+6oi6zBIwvtUm
         29RCsCofH8EdyYGtzNLTn9cGYWGMNnAOV82G2Bo+nKomMEmgfzMxbBV8T6hqolWcVjEM
         oD6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600996; x=1730205796;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaOXu7NaxTVENXCsAQaNxc71DXxVkPqm5aNi9pXqVVY=;
        b=rOktOQ+bhqvAFdt5cFUWeGC0u3WXULNqFg9BS39H5xuFsVo2G+vP32c3SBru6j6vX1
         LC/CAjg0dNgfRBnW9w5FQzMIulEaNmdXuEWB0j2+kDAzrfaWntVF9k0iaC4dpL5Ieb5l
         +CElXA1eo2eVxLgE11DQik+zsLIvLew7Pzd7r2fYy8yRi0ilKpa24GbPzs4C7JsWFlJI
         f/REO6d5Qp5Y/TN13YDO1nOAVC4tQlgPMKGiw2UIGJ2+Czvng0wJGFvmP1nJWcf/Y7eI
         FdwwMumlgzBM8wfWS9OU4JtXKivNDbGrvgXEk8QFPzOm6jMjzBUSudMQKt2a0GXxV+Iy
         tLcw==
X-Forwarded-Encrypted: i=1; AJvYcCX4L+OhIKiBwAbRn37tECM2m0zXeEQ4T1JOmFFiIQ1NQz79puczxIjaiBRYDPZp8Xja9njPJynhqAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnZU6S3om1bbFVP5bFYVNFYBvETTK3k3iTsAq01e39PajSx6+
	UFjXAB60r8L2zRzWie8fcJcd2q5ri3KhrsJ2Rul8Croqn2alC82pSfpIFwUwqEW4ePqjRkKar3m
	HvuZs+WbH85dVS27VZC90ywwsurOTtUTMPVP/uQ==
X-Google-Smtp-Source: AGHT+IEjUOeNvCGfPmX5CA7E6xqtR1WdLOVX8tlGLznwKB3j619LMDAn9ejkibYgLTVRmf3S4wJdL9yK3QWSPiysYzw=
X-Received: by 2002:a25:8545:0:b0:e2b:d0b8:576b with SMTP id
 3f1490d57ef6-e2bd0b858f9mr7059774276.17.1729600996120; Tue, 22 Oct 2024
 05:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241020142931.138277-1-aurelien@aurel32.net>
In-Reply-To: <20241020142931.138277-1-aurelien@aurel32.net>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 14:42:39 +0200
Message-ID: <CAPDyKFoQsf89NeX28ms7FtM0QWNqYQ5xtt2=+G1JNCVi2z9=dg@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: take SWIOTLB memory size limitation into account
To: Aurelien Jarno <aurelien@aurel32.net>
Cc: William Qiu <william.qiu@starfivetech.com>, 
	"open list:RISC-V MISC SOC SUPPORT" <linux-riscv@lists.infradead.org>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, 
	"open list:SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER" <linux-mmc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	Ron Economos <re@w6rz.net>, Jing Luo <jing@jing.rocks>, stable@vger.kernel.org, 
	Adam Green <greena88@gmail.com>, Shawn Lin <shawn.lin@rock-chips.com>, sydarn@proton.me, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

+ Adam, Arnd, Shawn-Lin, sydarn


On Sun, 20 Oct 2024 at 16:30, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> The Synopsys DesignWare mmc controller on the JH7110 SoC
> (dw_mmc-starfive.c driver) is using a 32-bit IDMAC address bus width,
> and thus requires the use of SWIOTLB.
>
> The commit 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages
> bigger than 4K") increased the max_seq_size, even for 4K pages, causing
> "swiotlb buffer is full" to happen because swiotlb can only handle a
> memory size up to 256kB only.
>
> Fix the issue, by making sure the dw_mmc driver doesn't use segments
> bigger than what SWIOTLB can handle.
>
> Reported-by: Ron Economos <re@w6rz.net>
> Reported-by: Jing Luo <jing@jing.rocks>
> Fixes: 8396c793ffdf ("mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K")
> Cc: stable@vger.kernel.org
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Thanks for working on this! Looks like we have managed to mess things
up. Besides the issue that you have been working on to fix, apparently
there seems to be another one too [1].

Unfortunately, $subject patch doesn't seem to fix the problem in [1],
as has been reported by Adam.

I have looped in some more people to this thread, hopefully we agree
on how this should be fixed properly. Otherwise, I tend to say that we
should simply revert the offending commit and start over.

Kind regards
Uffe

[1]
https://lore.kernel.org/all/CAC8uq=Ppnmv98mpa1CrWLawWoPnu5abtU69v-=G-P7ysATQ2Pw@mail.gmail.com/

> ---
>  drivers/mmc/host/dw_mmc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 41e451235f637..dc0d6201f7b73 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2958,7 +2958,8 @@ static int dw_mci_init_slot(struct dw_mci *host)
>                 mmc->max_segs = host->ring_size;
>                 mmc->max_blk_size = 65535;
>                 mmc->max_req_size = DW_MCI_DESC_DATA_LENGTH * host->ring_size;
> -               mmc->max_seg_size = mmc->max_req_size;
> +               mmc->max_seg_size =
> +                   min_t(size_t, mmc->max_req_size, dma_max_mapping_size(host->dev));
>                 mmc->max_blk_count = mmc->max_req_size / 512;
>         } else if (host->use_dma == TRANS_MODE_EDMAC) {
>                 mmc->max_segs = 64;
> --
> 2.45.2
>
