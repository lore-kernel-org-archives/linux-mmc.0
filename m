Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C2B567D
	for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 13:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732540147; cv=none; b=cm/fDmVVMykTV0oihz76dkMNLnnRRY36lP5JarDiWbOaAybc1YaoMrIvCg2xVe1k0PGIdEWvjqEylAJ6wg9ywAE3eAFB3GMDYR1SNpU35vrGQnM2kn0+n/pdIPGZeAmrWbdKyreO3pTWP+7h+ykpUZgCQh+xFMK5wqZWZ//qM8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732540147; c=relaxed/simple;
	bh=VlPn8ENRAtequbTvdk1TY+7P5PTASYER46wU/7kPzKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qMwjgzooXH/JP9MTwsFXP/Z2NWxUZ8BcdC6OJTpO9ti8JIVGuROiAG/sDyTN6XZ2ymu7rZMYrRcjruaXxWc/15i7rCA9FZwRYuTAQ9UO0aehqNfNcwkbiS5/7HiC9yp8RzTGRigT6SnrHPTnqHGDrRhy14cK64uwqDxLeSt9FH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WXVfVPv7; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WXVfVPv7"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e3892396200so3693114276.2
        for <linux-mmc@vger.kernel.org>; Mon, 25 Nov 2024 05:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732540144; x=1733144944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zwW5X2yVuOQxgzZYA2AkwTQIodjDxTG3chKlKalzE/A=;
        b=WXVfVPv74gPXMeZD42iQAws+efNPkioosffFCfSY7eQ5A6m/IiyT9YWwQsNUJsDjQT
         67UoP9GOndiQbeOqVitXu1MZs64sVAWVEB9+4PWT8qNP7vY8VFtoosKXbnHS96FUUv3d
         1s+r1/I+9y992CXHY35bVupqHXtr1TJyMm+39UX2oSt8FYwCe1SlFB6e2pUCW8T00U9B
         sssDjyD2VWj60/7DxI5DZ8Qm6sY8IcrNQ8Dl4nU3Set/o6ilAjeMeQWTetpRMA8dxHxb
         o+nX1IVzwFqydPit/lXbeB4lzyqyCXyyBXdOg2mPpxxgEn+kQS8mmWtaFe2KOW+uAfpB
         HGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732540144; x=1733144944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zwW5X2yVuOQxgzZYA2AkwTQIodjDxTG3chKlKalzE/A=;
        b=kjErbER2VMF0bW5YveXbP6OIL9ivL7bmxBwfNiHWGcpLbg6Ja4h4nM3LS0wRlR9LjG
         lLJxFTdkS+njAfgU1VERSEIQgf5lnXkklXskYXzIAv2dRsLLUlXZ+DfE8ub5MRj4GU2Q
         +KQg2Pxdeyv6/oxSQL2MsE4N5s4v7VWcGoaPpELi3Xok/PG8TXDEcbrGoaB/YwnfCCfa
         OVuvmlyH2is9sLjuz3KhLaLUhHNoycIsXa/Sgb2KRnAfEF2pMWJ8JZfhagKI7GQtxPAO
         Jkv5rXh+pHju3Vy0f74sgQVu8TYfBwUf3EakpN9gr03BxJ0Tops/DJ6xWnKkRGbYyQ7O
         8RJg==
X-Forwarded-Encrypted: i=1; AJvYcCWwwqY37GKNy1voEK/cIgP/ltXXHvmKt0227H+ReWs5ZF9m+I/RDcV8Gs07JpnEPFFEwFF+4RdkfBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvb8WlqgATcHRlgysZ6aWdTxDtXbQvpyxEb8oI6AQVDfu1LDV1
	VmZ7V+X/qcfVGn1V1gVgc9bCoixHwPq081vuZ7u6nBNjOuDLs8LfqYcrGFtzIF/s4i3hq+/kAR6
	izE9LmVnz1pxyWn2gdpPC/RkpL9J4SBu1F0ZfUw==
X-Gm-Gg: ASbGncsD1V5WCdLCO6c8xdZ1LB/KMcFtymGksTyNYBJrTqeY4u2RWzp+/fL+JHfS/fl
	8wAMN7VmCXMg0/GrV1hiEPqNaYeNnlhSw
X-Google-Smtp-Source: AGHT+IEF6uaB71EPxvIZeVbVSPO+NaBbT0xZwtt8FC3so2FjgVG6CW+VGCBir21UFRKHNtvL6RUoiWhliSlp9tWY5cM=
X-Received: by 2002:a05:6902:1106:b0:e2b:cf75:2840 with SMTP id
 3f1490d57ef6-e38f8b0aad8mr10473196276.5.1732540144455; Mon, 25 Nov 2024
 05:09:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
In-Reply-To: <20241123071006.14294-1-andy-ld.lu@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Nov 2024 14:08:28 +0100
Message-ID: <CAPDyKFpr9KZxx4_-jW8ovqcr4BCfDcm4teHEVOgZ69GrUddJ2g@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: Add support for ignoring cmd response CRC
To: Andy-ld Lu <andy-ld.lu@mediatek.com>
Cc: angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com, 
	wenbin.mei@mediatek.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 23 Nov 2024 at 08:10, Andy-ld Lu <andy-ld.lu@mediatek.com> wrote:
>
> The current process flow does not handle MMC requests that are indicated
> to ignore the command response CRC. For instance, cmd12 and cmd48 from
> mmc_cqe_recovery() are marked to ignore CRC, but they are not matched to
> the appropriate response type in msdc_cmd_find_resp(). As a result, they
> are defaulted to 'MMC_RSP_NONE', which means no response is expected.
>
> This commit adds a new flag 'MMC_RSP_R1B_NO_CRC' to work alongside the
> existing 'MMC_RSP_R1_NO_CRC' for the following process flow. It fixes the
> response type setting in msdc_cmd_find_resp() and adds the logic to ignore
> CRC in msdc_cmd_done().

In fact, MMC_RSP_R1_NO_CRC is not being used by the MMC core. So, host
drivers that check this flag shouldn't need to. In other words, we
should remove that flag entirely.

That said, introducing MMC_RSP_R1B_NO_CRC as the $subject patch
suggests, makes sense to me. However, I prefer if we can make it used
by the mmc core, so please change mmc_cqe_recovery() to use it too.

Kind regards
Uffe

>
> Signed-off-by: Andy-ld Lu <andy-ld.lu@mediatek.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 11 +++++++++--
>  include/linux/mmc/core.h  |  1 +
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index efb0d2d5716b..5d669f985a82 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1097,11 +1097,13 @@ static inline u32 msdc_cmd_find_resp(struct msdc_host *host,
>         u32 resp;
>
>         switch (mmc_resp_type(cmd)) {
> -               /* Actually, R1, R5, R6, R7 are the same */
> +       /* Actually, R1, R5, R6, R7 are the same */
>         case MMC_RSP_R1:
> +       case MMC_RSP_R1_NO_CRC:
>                 resp = 0x1;
>                 break;
>         case MMC_RSP_R1B:
> +       case MMC_RSP_R1B_NO_CRC:
>                 resp = 0x7;
>                 break;
>         case MMC_RSP_R2:
> @@ -1305,6 +1307,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>  {
>         bool done = false;
>         bool sbc_error;
> +       bool ignore_crc = false;
>         unsigned long flags;
>         u32 *rsp;
>
> @@ -1329,6 +1332,10 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                 return true;
>         rsp = cmd->resp;
>
> +       if (mmc_resp_type(cmd) == MMC_RSP_R1_NO_CRC ||
> +           mmc_resp_type(cmd) == MMC_RSP_R1B_NO_CRC)
> +               ignore_crc = true;
> +
>         sdr_clr_bits(host->base + MSDC_INTEN, cmd_ints_mask);
>
>         if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -1351,7 +1358,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>                          * CRC error.
>                          */
>                         msdc_reset_hw(host);
> -               if (events & MSDC_INT_RSPCRCERR) {
> +               if (events & MSDC_INT_RSPCRCERR && !ignore_crc) {
>                         cmd->error = -EILSEQ;
>                         host->error |= REQ_CMD_EIO;
>                 } else if (events & MSDC_INT_CMDTMO) {
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 56972bd78462..076e1c71a07e 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -66,6 +66,7 @@ struct mmc_command {
>
>  /* Can be used by core to poll after switch to MMC HS mode */
>  #define MMC_RSP_R1_NO_CRC      (MMC_RSP_PRESENT|MMC_RSP_OPCODE)
> +#define MMC_RSP_R1B_NO_CRC     (MMC_RSP_PRESENT|MMC_RSP_OPCODE|MMC_RSP_BUSY)
>
>  #define mmc_resp_type(cmd)     ((cmd)->flags & (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
>
> --
> 2.34.1
>
