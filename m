Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5F717A5BE
	for <linux-mmc@vger.kernel.org>; Thu,  3 Oct 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970478; cv=none; b=RBFRAjhlMJ8qRrCnoygJ3YaQZn1ZOpGePyt5qG+kIuNJN9/PQt7n43oVnjGxfMHKKiYNYhn1Z+YPI8s21reWbp9IhBztCIUg94712SV86F4Yehzs/Rntg9G0tnQnhDMwYfgcQ3XdiPhzqLBLj6JuQNetqvAwuT7IxQZP8Ek1o18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970478; c=relaxed/simple;
	bh=ailSh2bf5oDg9KFrtQtxH8T8pqURNzgSEkf5J504rLQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d3Llaw6xipdXetkei9h61BV+829iP2Dp4bAK4pfHmXh3U+EAw7gUCJZyvJ/t6zqFYqzI2LR9fuqlB1YLmruWIDdC8+SBeIxknRCUqZ1dLylgS4IqqlNGuVQuahMiGgA/ZIuWgrw+kU3ZUZwdWBJBYOVkLvP6AfLVp6wJTUWyvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pCMFUW2w; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pCMFUW2w"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e25d6342837so982663276.1
        for <linux-mmc@vger.kernel.org>; Thu, 03 Oct 2024 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727970476; x=1728575276; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=i86c0Zu34g68hgAiI3hz8DordENkKtlkKrfu6zFNhHs=;
        b=pCMFUW2wuCXuVPwAkc1JsUuDfylHRHifKBUOWN603FoLPJO6oxPftJSYSRbKm8Ihx0
         3dd8NNPXHqJn580JBf2c5dYn92RJxKgERNAD28UyxOMre9LNptkaJ6gPJd5CgNxTQRXj
         D0Jv85dczxT3CzPbMVH2isTZWDp4HLp0ZTt/QenZo9c8dWkvyIJFrjuTlZmvNXtEzRGR
         8In2MUlWKMTXrztSNS8GyJ08OF/mlgGpAfNWS2T4Q6CdBaMAFdZy1qeZP09JVSqnyeSI
         AholJhasm6szucAdAJLvR8tqaYifdw8o7hAe0v10im4PMgrt40AKEYRZOzmMCFAuxINl
         nAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970476; x=1728575276;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i86c0Zu34g68hgAiI3hz8DordENkKtlkKrfu6zFNhHs=;
        b=HLiGkXSTkqCcq7/o/lSyFufOgEx1WBnD3yw9GepnfftHLhq72A/idFzemJuFY9vP09
         Yb8lVaMQ2rDAMa6yyGZpsJJcBfeznYo/68w80FkInBB57QJgh05EQMbKMkNIy2qC8Lp+
         wLSW1aDHTnP0JH/GxxkyQ3GJAbvMd1ykoFEP+1EBMfxQ+3iFO/VnNLPWV1yBDNmTFo4V
         tx+pOXJrDEt/PfBDRu9knnubdMm0tQXHrup/vaAQqad8wlwMqS+7pBZzID5MFY+Jig8P
         NxlIWBUBojqq5qccIi278wf27pM1N3u+qS4lt53HE7mCyTPZ7gKuFmeV6jT3l8Av6r8v
         /E6g==
X-Gm-Message-State: AOJu0YwSqCo/0yM6/+cdo+kCn2SoxLd4orUt13NLdJJHlvMY7VWyvzf/
	yHjHvrjrYzDeTpAQZHqU14Z704mT/Q4S4seGbnAPIJKuyANztsVF3FIiNoGFyznjS2SB3H9G1Zf
	JSYaWtcJQLZSrq5JvAh0TEHGWNpwLZHeM0tqA8g==
X-Google-Smtp-Source: AGHT+IEovo9Tqi9Bsn9YOav6+5z5D6GdLvHmBIPBDXYqQAxYTQDLMdtb49NX99cJ5gR4BngyVX8kDvJsT/4RC47LMVE=
X-Received: by 2002:a05:6902:1241:b0:e28:6945:5588 with SMTP id
 3f1490d57ef6-e286945583dmr4400105276.27.1727970475653; Thu, 03 Oct 2024
 08:47:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908102018.3711527-1-avri.altman@wdc.com> <20240908102018.3711527-5-avri.altman@wdc.com>
In-Reply-To: <20240908102018.3711527-5-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 3 Oct 2024 17:47:20 +0200
Message-ID: <CAPDyKFqE2SZ1NcsYGpuL4wYW1r6s5Di_4Vrjbkk8uPP82xpoCw@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] mmc: core: Add open-ended Ext memory addressing
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Ricky WU <ricky_wu@realtek.com>, Shawn Lin <shawn.lin@rock-chips.com>, 
	Christian Loehle <christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 12:22, Avri Altman <avri.altman@wdc.com> wrote:
>
> For open-ended read/write - just send CMD22 before issuing the command.
>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/block.c | 5 +++++
>  drivers/mmc/core/core.c  | 3 +++
>  include/linux/mmc/core.h | 5 +++++
>  3 files changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05a7745c2a68..ba2ed413be5c 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1759,6 +1759,11 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
>                 brq->sbc.flags = MMC_RSP_R1 | MMC_CMD_AC;
>                 brq->mrq.sbc = &brq->sbc;
>         }
> +
> +       if (mmc_card_ult_capacity(card)) {
> +               brq->cmd.ext_addr = blk_rq_pos(req) >> 32;
> +               brq->cmd.has_ext_addr = true;
> +       }
>  }
>
>  #define MMC_MAX_RETRIES                5
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index d6c819dd68ed..a0b2999684b3 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -336,6 +336,9 @@ int mmc_start_request(struct mmc_host *host, struct mmc_request *mrq)
>  {
>         int err;
>
> +       if (mrq->cmd && mrq->cmd->has_ext_addr)
> +               mmc_send_ext_addr(host, mrq->cmd->ext_addr);
> +
>         init_completion(&mrq->cmd_completion);
>
>         mmc_retune_hold(host);
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index f0ac2e469b32..c86df8443a88 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -96,6 +96,11 @@ struct mmc_command {
>         unsigned int            busy_timeout;   /* busy detect timeout in ms */
>         struct mmc_data         *data;          /* data segment associated with cmd */
>         struct mmc_request      *mrq;           /* associated request */
> +
> +       /* for SDUC */
> +       bool has_ext_addr;
> +       u8 ext_addr;
> +       u16 reserved;

I don't see this being used, at least in this patch. Perhaps move it
to the patch that starts using it?

>  };
>
>  struct mmc_data {
> --
> 2.25.1
>

Kind regards
Uffe
