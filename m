Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6514A4E0;
	Thu, 19 Jun 2025 02:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750298705; cv=none; b=hKy9gA1NoY7mrrd+b0uAhbUCAhZesXyu6ENl+eJl/g6KNVPo5wbD66BZ3PIVmsHHae3/lbVY2896UVKPd8gZrcyUTLabf/igYb03o2RdT8Gl3nReptm0vra2LgSPjf//3/ManFzrVqntmBUDDNyJmDkvQPXgg2ngTxOoqBsKBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750298705; c=relaxed/simple;
	bh=IaaiI3fACwLbpIQhogak7uQ2F0Ezj93eSfpcTZk4TrI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OCfRTFInDRdwevyvhQpsQ0csKU1r9quEL6kkPHxc1Q13RekDSFUEolP/S8smicHX/B5JSDEdtfOqrfZqZQzqdgARUK0vAvHPcmHSakuZ1FRoCzutl+Hpyd/NXpEWYh58Ot7SretzROrHVZvV0dAKxAoWChi7dikpmPOU2cBeK3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Grog+5XE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grog+5XE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60D3C4CEE7;
	Thu, 19 Jun 2025 02:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750298705;
	bh=IaaiI3fACwLbpIQhogak7uQ2F0Ezj93eSfpcTZk4TrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Grog+5XEBJHGCI51zuStDEkFp8RM1HCmINdY01219b1EEKBT2nw5uj+0FmSeCETc8
	 KzGh/RsgHSPtkplC8O67EOFTyF3E00D/bUCdMnh6+teLnh173B9aqWELetBmzx7kPD
	 5cPMrZyBjngoXOF2wjZsD2r7wyMTn4CsXIlhOyjV8JXqNBR68Z4oTqjk7Zaig3hpB3
	 QJvKbfpXbTJH2jMVXO/YGHjnj+MfNzOfEd4OEhrJBPe/alfAunJXMctrid3sz5zlWD
	 We1rAxhU6ecokfmAdeQZjYhdTmaq2GDQFa4FyevqnhytrGbT7aLC/ea74ettl9pHq9
	 BPb/ZEfBMwI8A==
Date: Thu, 19 Jun 2025 11:05:02 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tomasz Figa <tfiga@chromium.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
Message-Id: <20250619110502.be536151c664cd4ada7d1ca7@kernel.org>
In-Reply-To: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Ping?

I think there will be another bug which leaks the resources
to cause this failure case. But anyway, without this fix,
if DMA preparation fails but runs a DMA, it will overwrite
the previous read buffer memory.

Thank you,

On Thu, 12 Jun 2025 20:26:10 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> If msdc_prepare_data() fails to map the DMA region, the request is
> not prepared for data receiving, but msdc_start_data() proceeds
> the DMA with previous setting.
> Since this will lead a memory corruption, we have to stop the
> request operation soon after the msdc_prepare_data() fails to
> prepare it.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  drivers/mmc/host/mtk-sd.c |   17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 3594010bc229..56b4999fe58f 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -834,6 +834,11 @@ static void msdc_prepare_data(struct msdc_host *host, struct mmc_data *data)
>  	}
>  }
>  
> +static bool msdc_data_prepared(struct mmc_data *data)
> +{
> +	return data->host_cookie & MSDC_PREPARE_FLAG;
> +}
> +
>  static void msdc_unprepare_data(struct msdc_host *host, struct mmc_data *data)
>  {
>  	if (data->host_cookie & MSDC_ASYNC_FLAG)
> @@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	WARN_ON(!host->hsq_en && host->mrq);
>  	host->mrq = mrq;
>  
> -	if (mrq->data)
> +	if (mrq->data) {
>  		msdc_prepare_data(host, mrq->data);
> +		if (!msdc_data_prepared(mrq->data)) {
> +			/*
> +			 * Failed to prepare DMA area, fail fast before
> +			 * starting any commands.
> +			 */
> +			mrq->cmd->error = -ENOSPC;
> +			mmc_request_done(mmc_from_priv(host), mrq);
> +			return;
> +		}
> +	}
>  
>  	/* if SBC is required, we have HW option and SW option.
>  	 * if HW option is enabled, and SBC does not have "special" flags,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
