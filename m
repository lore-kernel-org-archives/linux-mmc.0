Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665F93016F1;
	Thu, 30 Jul 2026 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439533; cv=none; b=Pu7LzO9PDqR+VNNBnIfUQpJiygmlglc3xoUpdBCCrV41iIjlSOwqch3w4nQVYy3uMFc58hvH1qWNg1NwBdfRWuRX61BwmaLXzQ9fdj4TEhvHY89f5GE0FqrrJjSMj5k6xgOP6M2q6YPVAiPYsL7etkV516L2+d5tC2DJhh5fviI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439533; c=relaxed/simple;
	bh=ZYo4gt/Cp5FikglU+FBYuXTfkXQf+fV3BH9Fj3n6cEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEQKqYx1OX+klUdfjWuXvbL3myydVEkp8n8oZTRDhtjw5DSZOthae+gLXPet2ontMof5/R5Ym2lFhuRZUPdxDEgsr087JqolGVJA6oMJboI2Kl4ztHN3Im3EvV4qjkLZv1eKMnNpZdOp9QBWompKg6qIv5+o6Sj8Tb4G49uhoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/KTZczZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/KTZczZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9951F000E9;
	Thu, 30 Jul 2026 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439532;
	bh=gtMLKNFZrJT3gGOu/uZ3lsR4QIZzulOfoT9Jg7yrq/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J/KTZczZr7U+X+xmXYSMf4bwK1cvo/fPQPguzcjPhKR2WAOp+9jrw3oXamiSNXxAu
	 3iExrfjB0VKjGNufCeXxAiYxjF9j+/v0pvj9WHd3Sryq86NrJ4E25lsLjy0+zltzv5
	 PgcTSuwr6cfBLh/NEl6N0gvP+BDS3q1gnIoG/cvf84qAOhBJvpvbOHao0wOMh0+2DV
	 OU58XAprzflZQqCSniKGF/SbCgVI9q0xb/5vZvh6epXxx1VJki8DnMVyvnOqtvbBvo
	 ociV8mu0Jf3A5GT3urQ3llv5WhnsSgcPSYdqJ9Lyv3UlJWGUvD3hs81TASO3HBFoEv
	 DG++pPf+Lw0Hg==
Date: Thu, 30 Jul 2026 12:23:36 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 3/4] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
Message-ID: <20260730192336.GE3139@sol>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-4-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730140822.1976635-4-neeraj.soni@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 07:38:21PM +0530, Neeraj Soni wrote:
> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> 
> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
> needs to be restored when hibernation exits. ICE keys are re-programmed
> during sdhci_msm_ice_init() but it may not cover cases where the
> hibernation image is already restored.
> 
> Unwrap the pm ops and use directly in driver to add the call to restore
> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
> same state as before hibernation.
> 
> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 7d71dc6f388d..a4998e74a2bd 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2986,9 +2986,26 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	return ret;
>  }
>  
> +static int sdhci_msm_restore(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +
> +#ifdef CONFIG_MMC_CRYPTO
> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
> +#endif
> +
> +	return pm_runtime_force_resume(dev);
> +}

Is it correct to access the ICE registers before
pm_runtime_force_resume() has run?  Aren't clocks and power still off?

Also, prefer IS_ENABLED() to '#ifdef'.  However, this suggests to me
that we actually should just keep MMC_CAP2_CRYPTO defined to 0 when
!IS_ENABLED(CONFIG_MMC_CRYPTO), as that solves this naturally without
any need for #ifdef or IS_ENABLED().

- Eric
