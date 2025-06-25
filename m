Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172BF33E1;
	Wed, 25 Jun 2025 04:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750826578; cv=none; b=JnrgnSRZbRGK4+vSrycJrhEvkf6Y5O4SJJLf/3YlPx1aTY9Aq4RBS3C0/y5LoLjsODRlHj9f9uwTKExiOE3dD2TDyvcj/ZAi5uibvnJSElCP/ziFmAkNI2wVu2w57/cUzkxO6HyjPtq2uJCHtd3wbH1o1rmQ34JIBPOc5tki0MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750826578; c=relaxed/simple;
	bh=s0Uf4rDKwjy1dsp7E1aDOpTFmlXsypuC2uqpLNZ5DKY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AkGlpHHE1J4GcTEJvM5fLQfrKXJfl5kx0sYfUMoNoBhhufsJKJGcitOeHg/Emf3XlaDwvNTOPJOox4JBOmk+jvTLMEb8gnJfKy9UmBTTCJpaK53LFXTigqsqtV5rA4eSvvnsNK9Xha4E7Kbjh5OUTPtZ8JDfHBQtcNqQtoMTHvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpr1HQMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpr1HQMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28CA3C4CEEA;
	Wed, 25 Jun 2025 04:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750826577;
	bh=s0Uf4rDKwjy1dsp7E1aDOpTFmlXsypuC2uqpLNZ5DKY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpr1HQMca3yxYzZRwgASl7KM9m5QByPLHuYDp8quWxFse6APaNTIh2d/R6GX4wQYF
	 zlMCV4rLSly8vPfih+25aD7oiEhIKwj+FtCtQHmXTIFp/SDYmrq3xdM37PQISvprY4
	 W07TOosv3dtwmSUeVemySj27HYVuIaTmksNRRLbD+Y44sPaK7s+/fycu6HqutouwWu
	 +07mC9cMZ/h8A0LObzrYf4Z4Ajq874qs71LWj6KJVM0EM+aoy95qk7G5Q5tQoUD3We
	 D2uO5L/oFgb6+hQYARDgkC7Xy8ugK+EpTVHaDrCI3hgXWr0GBaCRKCdXShDgD37cWK
	 R32u0jXlYYLNQ==
Date: Wed, 25 Jun 2025 13:42:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chaotian Jing
 <chaotian.jing@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Tomasz Figa <tfiga@chromium.org>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mtk-sd: Prevent memory corruption from DMA map failure
Message-Id: <20250625134254.7cbd72feb80d8d050f2f005d@kernel.org>
In-Reply-To: <cifhvofebjuanprzcs2duv6r22r5reibzm7nub4xfya3h3rmwe@ujpf5wadwh3c>
References: <174972756982.3337526.6755001617701603082.stgit@mhiramat.tok.corp.google.com>
	<kgxqtfdrlc5m5kgprjajt4xtngken2u2locauzhsxm7kcowusa@44ncy4vhy5vx>
	<cifhvofebjuanprzcs2duv6r22r5reibzm7nub4xfya3h3rmwe@ujpf5wadwh3c>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 13:13:18 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> On (25/06/25 12:56), Sergey Senozhatsky wrote:
> > On (25/06/12 20:26), Masami Hiramatsu (Google) wrote:
> > [..]
> > > @@ -1466,8 +1471,18 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
> > >  	WARN_ON(!host->hsq_en && host->mrq);
> > >  	host->mrq = mrq;
> > >  
> > > -	if (mrq->data)
> > > +	if (mrq->data) {
> > >  		msdc_prepare_data(host, mrq->data);
> > > +		if (!msdc_data_prepared(mrq->data)) {
> > > +			/*
> > > +			 * Failed to prepare DMA area, fail fast before
> > > +			 * starting any commands.
> > > +			 */
> > > +			mrq->cmd->error = -ENOSPC;
> > > +			mmc_request_done(mmc_from_priv(host), mrq);
> > 
> > Do we end up having a stale/dangling host->mrq pointer here?
> 
> Something like this maybe?

Good catch! I thought it is cleared in mmc_request_done(), but not.
I agree we need to clean it up since it is set in msdc_ops_request().

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> ---
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index b12cfb9a5e5f..46bb770ace41 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -1498,6 +1498,7 @@ static void msdc_ops_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  			 */
>  			mrq->cmd->error = -ENOSPC;
>  			mmc_request_done(mmc_from_priv(host), mrq);
> +			host->mrq = NULL;
>  			return;
>  		}
>  	}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
