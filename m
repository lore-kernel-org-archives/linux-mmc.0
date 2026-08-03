Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6571630AAD8;
	Mon,  3 Aug 2026 20:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788292; cv=none; b=MjQCfYh9igaDTfjUzXsMjNA2JiyQU/xnYx89nYaJ1W95NG1Kk7YB4q3Uw/bmMIP3uSKRT687QOkbIgzGAOUnLsmwCkoqnPHojTexYILlsUjSl+5bOuPK4BtsUQO3z/yHkQOvxlj7cgdf+B+HyNV/SyI39poDUNz7iK4NMc9Ywd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788292; c=relaxed/simple;
	bh=BXEduQogSxY0YRCOpPsMnNU5CIoRhv1e1OuF8pP1WUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gVr2LbcT0YlUB7sHFwoRYZ9AYqkORaf/uQReQ/EsRAd+RlY1GGT73bYy757ccWeZ2ACt+e+lehCUqkUKS0U/kC/KSdgtEO2Zc3vM/6EIghSfAECRXQNZtXlqer7zW+h2zpARU3sqJ/LDzJpDuTPHYzJk1XxFum5t8ehcbUuIET8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW71eh8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW71eh8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75FFC1F000E9;
	Mon,  3 Aug 2026 20:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788291;
	bh=/XQHauEhFbAY1xUTUPdKDwoJjw2c56eGJ0uD7YlH1ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lW71eh8IoNexrF6yQLqmZSd0oje+kHUJx1Z7loK7tA3lCAkQ2zwvfNZFQNRfPOcnj
	 DJ3fBP8e0awRngXbBPoKOasBJgTWrvh1pXNMEYEAkmz4cQcNrgCcT+NTnCt/Op9l67
	 J8WExLoerPLG9mL/K8GTJSEkCAUJOKq9MIrwTyue1qLWHBHFEWJ/eKGScWUaycmY+M
	 sTZbHtRSymbc2R3fBCUE5yeM7Ccd6Swto65S2K8ZndqQ+Kwp3KKZcKSQ1af3zUkhab
	 X0//ANC7oy23ZmojRpW/cslHGJ0TaaXtB3OldBNq9RuvAMOhObPLlbSw0qI+emAGUT
	 ZuHwbkTa52PaA==
Date: Mon, 3 Aug 2026 13:18:03 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
Message-ID: <20260803201803.GB63318@quark>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>

On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
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
> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
> keys is not needed during MMC runtime suspend/resume.
> 
> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4aff965f0e2e..f64788a70309 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	}
>  
>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
>  	return 0;
>  }
>  
> @@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
>  	return ret;
>  }
>  
> +static int sdhci_msm_restore(struct device *dev)
> +{
> +	struct sdhci_host *host = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pm_runtime_force_resume(dev);
> +	if (ret)
> +		return ret;
> +
> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
> +
> +	return ret;
> +}

Sorry, it looks like this actually does need an #ifdef because the
crypto_profile field is conditional.  It doesn't need to be a new #ifdef
though, as you could add a function sdhci_msm_ice_restore() within the
existing CONFIG_MMC_CRYPTO section of this file (along with a no-op stub
in the !CONFIG_MMC_CRYPTO section), then call it from here.  Similar to
how the existing sdhci_msm_ice_resume() works, for example.

>  static const struct dev_pm_ops sdhci_msm_pm_ops = {
> -	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
>  	RUNTIME_PM_OPS(sdhci_msm_runtime_suspend, sdhci_msm_runtime_resume, NULL)
> +	.suspend	= pm_runtime_force_suspend,
> +	.resume		= pm_runtime_force_resume,
> +	.freeze		= pm_runtime_force_suspend,
> +	.restore	= sdhci_msm_restore,
> +	.thaw		= pm_runtime_force_resume,
> +	.poweroff	= pm_runtime_force_suspend,

Should these use pm_sleep_ptr() to allow dead code elimination when
!CONFIG_PM_SLEEP?

- Eric
