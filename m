Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4601F184529
	for <linux-mmc@vger.kernel.org>; Thu,  1 Aug 2024 11:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722510109; cv=none; b=bg21qBIP6fLuwyyrwOod14NnBFzutHTEC31S/5e+Cf3dM896C2oTd19uMfsad9vmg/Ofk4TM3oEv6WTTCIITwbDOkNHX6KUTyGEbAwvHCejFnWqLkqUlCN2TV9uDoNCnjgadSZJFxoa+EIURVVQ+MUNyAF5gU09qnGNpfUlP0qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722510109; c=relaxed/simple;
	bh=o3DMQQxGo3x39I7djsSUQeIpjlb4LUUbCkAOfJFGf1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7mmdqkUVJwivL3FmmwWj9icr64t8Tfl6ftOSOQXbr2fk9JxjGRxhlRds7rQbtk/xaxQEMRmEgS5uspajJphvYGpnpQYZriISmE1iIGIXkB/KB7OUqCU3T888VdPnG4FPpBLbQ7560qukCu58RzSJNRbzTv/8H7vSbtKPJums7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=guHNDVh2; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="guHNDVh2"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0b2d2e7dc9so5594544276.2
        for <linux-mmc@vger.kernel.org>; Thu, 01 Aug 2024 04:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722510107; x=1723114907; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m/lBUEuHtZhYH9hMMltxd6FYM94een14SRBxxIIu5uM=;
        b=guHNDVh2d+8xwoK5wKYC/qmSDhV47aQFbaYcr5OE+wD0dEbADgpfGTWClpKyIChpMY
         ct6LU4Ib6SnPWw8niFnl6AYLwwjM3n0yG+uuGgIcHnWv0FQsG8fdOafq0qnNGygHoxjS
         SYMjNoMI1NLjqDFZ87ED5Uhb5c/65OXRBuG061P7Aj7Z16PRISing8OyzyBxRf6gbcR+
         wVbwpgAnEuTCBD3GBV+36kySo9+J0vptSFL3r1ZXTpgrswEQVdf9clANi5S0eK9b9vFF
         mniW3kz38ZDs6Bt8OCsGNC8K00JmSuCTu7V8dPAZEWei36/wjKhL5cTBkH4dCAtr9U3v
         vnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722510107; x=1723114907;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/lBUEuHtZhYH9hMMltxd6FYM94een14SRBxxIIu5uM=;
        b=H/571pZa89SXycgknLNSOWGCu0OQ17B2h7LC9h2XLNKVKCBiq2v2sZ3T2jm+h6XbI3
         sXwAdomORMSBUf7jTVGu7jZg5u4qbS5XUQBtzeoRe1HJvigXTHh0z2wJ3mr+Fmz7vsg4
         6JHqykMi+EJ6SUX7iQCQXT4x89p2eHZqMHnobPYv5EjQumqfct0OBcl15YbazfLuv7Xw
         G783JpX3w/y3Ka/fkzkV7XUDImtU5zNeY8UbV56rthDq4E5DHxO7/3Mcd1mNGCUiz8Sk
         T33Q1HSo7sNE7ozn8KDQeShPZlFvp5YtFl/qmW+zIJR7+ZC0A+D6pDLUGNRjO/HDuwlg
         vIaw==
X-Forwarded-Encrypted: i=1; AJvYcCWDD9KzVoPWEjxo7N0exyGPQa4mKwS7jD0asp12X9WczppOHu3S+rNnOqJ2NwiaXz/K+mk12DxkXIyzbKn7s8eXh29KJ61Gud8f
X-Gm-Message-State: AOJu0YzC2js0d1zFUwfPSozVaoGz35XN8rTesinJxfNLioUbvjbfzhEH
	1FJ/Ac7/Y29MOpLfVRHWHG9mQ6xQuZCm8AHVVkP0SCBRNxA7V0A5bmKag4EoCOyw6wQfAlcfurd
	K5Mh4eT5yMT27cmweFRA2KHqHn8impc+HZe0ptQ==
X-Google-Smtp-Source: AGHT+IFNMTUyuraUOe17RSwLCsQl2Heh5eaqrtk7oyS7ocUH1DnCdcUeW8y+TayZq1Ii/rIMs7hczcO3KQE8rJP/Pyk=
X-Received: by 2002:a05:6902:1209:b0:e08:6055:9f3c with SMTP id
 3f1490d57ef6-e0bcd2b587amr2051515276.31.1722510107179; Thu, 01 Aug 2024
 04:01:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240716013704.10578-1-mengqi.zhang@mediatek.com>
In-Reply-To: <20240716013704.10578-1-mengqi.zhang@mediatek.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 1 Aug 2024 13:01:11 +0200
Message-ID: <CAPDyKFqK7CwGF2CitFtHUE_8hRxMr92KmWQzdO4kWRa7kYqHuQ@mail.gmail.com>
Subject: Re: [v1, 1/1] mmc: mtk-sd: receive cmd8 data when hs400 tuning fail
To: Mengqi Zhang <mengqi.zhang@mediatek.com>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, wenbin.mei@mediatek.com, 
	linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.stable.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 03:37, Mengqi Zhang <mengqi.zhang@mediatek.com> wrote:
>
> When we use cmd8 as the tuning command in hs400 mode, the command
> response sent back by some eMMC devices cannot be correctly sampled
> by MTK eMMC controller at some weak sample timing. In this case,
> command timeout error may occur. So we must receive the following
> data to make sure the next cmd8 send correctly.
>
> Signed-off-by: Mengqi Zhang <mengqi.zhang@mediatek.com>
> Fixes: c4ac38c6539b ("mmc: mtk-sd: Add HS400 online tuning support")
> Cc: stable@vger.stable.com

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mtk-sd.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a94835b8ab93..e386f78e3267 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1230,7 +1230,7 @@ static bool msdc_cmd_done(struct msdc_host *host, int events,
>         }
>
>         if (!sbc_error && !(events & MSDC_INT_CMDRDY)) {
> -               if (events & MSDC_INT_CMDTMO ||
> +               if ((events & MSDC_INT_CMDTMO && !host->hs400_tuning) ||
>                     (!mmc_op_tuning(cmd->opcode) && !host->hs400_tuning))
>                         /*
>                          * should not clear fifo/interrupt as the tune data
> @@ -1323,9 +1323,9 @@ static void msdc_start_command(struct msdc_host *host,
>  static void msdc_cmd_next(struct msdc_host *host,
>                 struct mmc_request *mrq, struct mmc_command *cmd)
>  {
> -       if ((cmd->error &&
> -           !(cmd->error == -EILSEQ &&
> -             (mmc_op_tuning(cmd->opcode) || host->hs400_tuning))) ||
> +       if ((cmd->error && !host->hs400_tuning &&
> +            !(cmd->error == -EILSEQ &&
> +            mmc_op_tuning(cmd->opcode))) ||
>             (mrq->sbc && mrq->sbc->error))
>                 msdc_request_done(host, mrq);
>         else if (cmd == mrq->sbc)
> --
> 2.25.1
>
