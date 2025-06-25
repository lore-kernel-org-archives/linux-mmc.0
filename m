Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAC415A86B;
	Wed, 25 Jun 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750839780; cv=none; b=rdxHWFfkov2SULOf/0aL/pB8e8nFb+5BVUZ4+6KQXdBu8Kl6VVym3BwTwLJSOGJ+nenBnKIz1DlSWzoDliEBes8Laq7fq3a2V3x111tfvsBBU6GwQtbOeAxFqYWgLhCebSm+4z0LcZq2YiaSfdHPqLqiCreSP+Zxgd2v/cm30Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750839780; c=relaxed/simple;
	bh=VeZL0T5SuaIibrGFk1LXnvbTdunYAmG3W+kPplU0veI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=s7nvX+q1H3ggW7Ow4ECNG8hZlRVYSAqF0FzujotUADe7HiUBGZsbBB+DM+BUh/fIXPUTbvJlN1qG7zZNcrQJYLNMH3VjzaJHAQ0hb3Pz/Szl7AxagWWDHWTTauJC8cFYkOHjULAW15R23v27VIakUQB3O1Au/ajnzWYjG58kAts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESRW2xlt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESRW2xlt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CB5C4CEEA;
	Wed, 25 Jun 2025 08:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750839779;
	bh=VeZL0T5SuaIibrGFk1LXnvbTdunYAmG3W+kPplU0veI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESRW2xlt9O0+HzOhPdTdieAtEx/EA7iERTdIRSPeiLHQXOmchfHoYmMXhIedTKd3P
	 UtNqMDKH9W9S2a89E1z0zZGT+T4vIEnxF63XXs094R3YMlyAlUMYtNYvm3zmuxRJMS
	 c1aovPMRwogf4KXp7HqSy9xSF+UTBzvE2/azuNR8J50Jp/C4+Vm84eGZ9Dd4TEK1l3
	 33NVZ8vANgqBc0GsxCEXQWYMNwVeYx707m689MAAN/OYsXiSC6A2NdcVd51isPwhVO
	 9H+n0oBhnbNKXuIpBMUEHkRUZr9Gbycvtj5XNS5XiaWg+yYmH5SIMVW6UEWhbuz/mY
	 w3ZGQgaHW1bJA==
Date: Wed, 25 Jun 2025 17:22:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Tomasz Figa <tfiga@chromium.org>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtk-sd: reset host->mrq on prepare_data() error
Message-Id: <20250625172256.d1b4948e018fac55e575a49a@kernel.org>
In-Reply-To: <20250625052106.584905-1-senozhatsky@chromium.org>
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
	<20250625052106.584905-1-senozhatsky@chromium.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 14:20:37 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> Do not leave host with dangling ->mrq pointer if we hit
> the msdc_prepare_data() error out path.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks for fixing it.

> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b12cfb9a5e5f..d7020e06dd55 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1492,6 +1492,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  	if (mrq->data) {
>  		msdc_prepare_data(host, mrq->data);
>  		if (!msdc_data_prepared(mrq->data)) {
> +			host->mrq = NULL;
>  			/*
>  			 * Failed to prepare DMA area, fail fast before
>  			 * starting any commands.
> -- 
> 2.50.0.714.g196bf9f422-goog
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
