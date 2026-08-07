Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC5F306498;
	Fri,  7 Aug 2026 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122011; cv=none; b=MMnpSnZCqkqOsCKxT3NSKgoeAOadHuJi2QHPgEA4PAKTseGngD+BDKOA7Pt37QCLeCmgnPoBTwzU7Ac81HOGESuvVhTviyN3WFeh+KBhc0k17P84EIzVeXHh5dLycBJAGHLpRtc8T5G2a57l9cC7TQcX5ojJXKsKBgcWd7Ao5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122011; c=relaxed/simple;
	bh=bzrvQBcKr5tk55Zeln7fwDtblFtZyeWiVqzoh0J3uRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0Y6XEpXCDhGvptwwEwW3a/EYlXLfQ51Zb0Sk6xQmYZdXKAYjhRk+wbkByvH/8v7/TsJrMlbFo9JWpWUKY7agoCfUGC9ky8xou7W4Wu0DmL/+vu6YT3CkXRpN/NAFAyFPswyi0MLtJPBpi+mKujeR16QoKXmkdxO2VJv6BXS0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMcFf9ql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMcFf9ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BA781F000E9;
	Fri,  7 Aug 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786122009;
	bh=xf9nrKmqN6amn15zNQh/fXJWbnKTrIbR0c/qS9OnmKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YMcFf9ql4ZnU7SC8wZUt+6LBOfKh4MqOR1tsKwFOXJCYkuPi+6N2TScbDEFj9W3PD
	 ucOgr+DA1EQvcEQN3BLTII/Pooyv/VRoFSWwHefjV9zX4XXuXg4ScPCfIyR6KQNHwM
	 eVVmQ5ifbkIgCKCAX42KrAn1Nbj/iSSU5i7h2xHCHBEU8ki8Iyf6FdrrBP5kh6FXl+
	 VcjTIl3DLDBFcom7twYgC4e8EiwYHEBTaOHlmFuT3mX4LDlpI7Tyln112FGbpKNX6e
	 zi/OUdkZ5d0wuMxYfSvgZzq/yQvluaDUZfCNsbdkQtZCE+cUZQzNB+jcJ/X1GupSaZ
	 X9OKjlPWX2rVg==
Date: Fri, 7 Aug 2026 17:00:07 +0000
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
Message-ID: <20260807170007.GA1172969@google.com>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-3-neeraj.soni@oss.qualcomm.com>
 <20260803201803.GB63318@quark>
 <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abe31a1b-e34c-d5b6-4bc4-3733acc56e98@oss.qualcomm.com>

On Fri, Aug 07, 2026 at 07:49:24PM +0530, Neeraj Soni wrote:
> 
> 
> On 8/4/2026 1:48 AM, Eric Biggers wrote:
> > On Mon, Aug 03, 2026 at 10:01:23PM +0530, Neeraj Soni wrote:
> >> From: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> >>
> >> Inline Crypto Engine (ICE) keys are lost after hibernation entry and this
> >> needs to be restored when hibernation exits. ICE keys are re-programmed
> >> during sdhci_msm_ice_init() but it may not cover cases where the
> >> hibernation image is already restored.
> >>
> >> Unwrap the pm ops and use directly in driver to add the call to restore
> >> Inline Crypto Engine (ICE) keys. This ensures that ICE is brought into
> >> same state as before hibernation.
> >>
> >> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-programming of ICE
> >> keys is not needed during MMC runtime suspend/resume.
> >>
> >> Signed-off-by: Ram Prakash Gupta <ram.gupta@oss.qualcomm.com>
> >> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> >> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> >> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> >> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> >> ---
> >>  drivers/mmc/host/sdhci-msm.c | 23 ++++++++++++++++++++++-
> >>  1 file changed, 22 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> >> index 4aff965f0e2e..f64788a70309 100644
> >> --- a/drivers/mmc/host/sdhci-msm.c
> >> +++ b/drivers/mmc/host/sdhci-msm.c
> >> @@ -1959,6 +1959,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> >>  	}
> >>  
> >>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> >> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;
> >>  	return 0;
> >>  }
> >>  
> >> @@ -2983,9 +2984,29 @@ static int sdhci_msm_runtime_resume(struct device *dev)
> >>  	return ret;
> >>  }
> >>  
> >> +static int sdhci_msm_restore(struct device *dev)
> >> +{
> >> +	struct sdhci_host *host = dev_get_drvdata(dev);
> >> +	int ret;
> >> +
> >> +	ret = pm_runtime_force_resume(dev);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	if (host->mmc->caps2 & MMC_CAP2_CRYPTO)
> >> +		blk_crypto_reprogram_all_keys(&host->mmc->crypto_profile);
> >> +
> >> +	return ret;
> >> +}
> > 
> > Sorry, it looks like this actually does need an #ifdef because the
> > crypto_profile field is conditional.  It doesn't need to be a new #ifdef
> > though, as you could add a function sdhci_msm_ice_restore() within the
> > existing CONFIG_MMC_CRYPTO section of this file (along with a no-op stub
> > in the !CONFIG_MMC_CRYPTO section), then call it from here.  Similar to
> > how the existing sdhci_msm_ice_resume() works, for example.
> >
> But MMC_CPA2_CRYPTO=0 if !CONFIG_MMC_CRYPTO so crypto_profile field is
> not accessed if !CONFIG_MMC_CRYPTO. Does it need encapsulation?

Yes, because 'if (a & 0)' just makes the code under it be optimized out
and able to "use" undefined symbols.  It still otherwise has to be valid
code and refer to declared symbols and fields.  See my suggestion above.

- Eric
