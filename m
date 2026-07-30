Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A717D35C6B1;
	Thu, 30 Jul 2026 19:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438748; cv=none; b=fG8CkOIZ/bWhch2xwPgIMjNc4LF/gBqu1oPggd4zrHv2IOBIayJg37JX4uGzRtl/JfjFLATMUG3kURQ/rQNys7C1t71RkazprsRuC0pK/nvegHMckP65fhUpox9CW/fCN9r5vq6sSnJA2e3j/HOMf8+lGur7LUNhcuMXqxFqOG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438748; c=relaxed/simple;
	bh=PPrTWkytK5iH58wqoe1Gs+vr4s8nFdo6g8ux6wtdNFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hygMgBnxKzNX5bZDJirXTZrzRdyJ9awe+ovcigCrIWqpaztcMt+bSlufO12sc0jEph66xY+0YKmyda4Yg5xKAbvOD7+xJmelkRcFmSWm4G16lGQyUUHp8ghvEU5C+Of+1OfjEcUVvov+z5106gj4jUHJYmxbWsoixLEyIFQio9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RAo7Z3eE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAo7Z3eE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2041F000E9;
	Thu, 30 Jul 2026 19:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438746;
	bh=ttozWw676yvL/fA7vpvA+Q/hEfMpSEDSW7KUbOiVrz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RAo7Z3eE709nSaZx6Y/De/p8znXHgAiRlSIx0axFAbZXC5td0b+EwbuajYS15XY+P
	 +N9w0pw9+bVYzidXuLM3l1fQiEfFbZ5aJuIkTOgtu/j/S637yrddCr00qaBNt6mVKo
	 Kfn7FBAYhIyi68zm7ub0x5iSqKzisdurhj9S1INF4YdKjJ7SGkvuHNkaJXkA7nkVGl
	 5RUY2cKi/mX0ANEWCz2jQnPunsB4ciO6BUUdei6wcsPKwln5YdTit5+1LXTT5X8n2K
	 mLvQAiTvFTITFbHXhH0k7+oPYy2OtSJ9PSU+Wq7UQq8rsO/TOtP6RWwNhIdL5Nh0R/
	 5rqNG5SbFH+0A==
Date: Thu, 30 Jul 2026 12:10:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 4/4] mmc: mtk-sd: Protect crypto capability with
 crypto config
Message-ID: <20260730191030.GC3139@sol>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-5-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730140822.1976635-5-neeraj.soni@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 07:38:22PM +0530, Neeraj Soni wrote:
> Host crypto capability can not be used if CONFIG_MMC_CRYPTO=n.
> So set MMC_CAP2_CRYPTO in mmc->caps2 only if CONFIG_MMC_CRYPTO=y.
> 
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/host/mtk-sd.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index 01ea3adbdf3b..c415ed97e3c2 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3031,7 +3031,11 @@ static int msdc_drv_probe(struct platform_device *pdev)
>  		if (IS_ERR(host->crypto_clk))
>  			return PTR_ERR(host->crypto_clk);
>  		else if (host->crypto_clk)
> +#ifdef CONFIG_MMC_CRYPTO
>  			mmc->caps2 |= MMC_CAP2_CRYPTO;
> +#else
> +			dev_dbg(host->dev, "Enable necessary crypto config\n");
> +#endif

host->dev is still NULL at this point.  So if the log message were to be
actually reached it would show '(NULL device *)'.

But the message doesn't seem very useful anyway, especially when it's
logged only at debug level.  So maybe just drop it.

Is there a reason to even enable the crypto clock when CONFIG_MMC_CRYPTO
is disabled?  If no, then the 'if' condition above could just be changed
to:

    if (IS_ENABLED(CONFIG_MMC_CRYPTO) && !(mmc->caps2 & MMC_CAP2_NO_MMC)) {

- Eric
