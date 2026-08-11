Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E14F43FD2C;
	Tue, 11 Aug 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475335; cv=none; b=J0QT5vZZggnRTJsGIcW1Vhk+gals2JMf9Nt63TddcxVHANMrGTYiPn6FBsC99BE0bMR7JClY7UNRIT01OtsTsI8+korUDTZGgQhnyArd9wDP+5KfLTOl0ABc7vKc6asyetSPfMmrbZJ69kjx5ETH92sPVuxvCY5z9wgWPhMcyKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475335; c=relaxed/simple;
	bh=zetqG6U99pBPmrjaaXwYGfRxwdUixDTbLLzzej0lPj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCf18KuPr/Vu/bGT3PLnwJuqeulYwN+qFt3IMIJ4FTPGRPH+g+ve87gU4uW/oYrTqa2jXPtpWyLD2O9Qm+QnGJaUBt3DVtiwoc+0fN1VM3Y4X/sHAWombDU1CRjtTYxF3ZGLhbeR8EaQYOjD7YZWNEkYKeNk3KB0K1UxbIYShbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0/eZYwq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0/eZYwq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C1E91F000E9;
	Tue, 11 Aug 2026 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786475333;
	bh=XBbXyyEgEYp2CObXB/kIVFZ/46bDLyJh343oz0Pzbdo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=M0/eZYwqom4HzlWOvbeNevliiFETn2ua+lawSQKo3fhVxN6JH0aeKPrLiz2ELqXMX
	 xDbzq2WAHqZ4YE+WUZld3Y4YT39mXjBLuK0pHHR+zovLc+NdeiJ5xv1iFX8DU4+17M
	 e5FXyHCcqXMaiBo5/I085HMlzi75E08ernYWCmiw8KhX3lGUjG31hvqiOwSFPtQzjO
	 FkFqBe5XDRoWpigFMH/aaFnuMI8GRdh+Js4FdTVlxe9W7UnAyszcTuEf5PmYyq4gD+
	 nZJdMznTiXVkOlsKvV3UaNKoEEFLPSTVCOJwvTTC+dADhb20dzETFpYCzdMhSbVN70
	 ZMqjzTiPhLPPw==
Date: Tue, 11 Aug 2026 19:08:51 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v7 2/2] mmc: sdhci-msm: Use pm ops instead of macro to
 restore crypto keys
Message-ID: <20260811190851.GC2895176@google.com>
References: <20260811151759.1258525-1-neeraj.soni@oss.qualcomm.com>
 <20260811151759.1258525-3-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811151759.1258525-3-neeraj.soni@oss.qualcomm.com>

On Tue, Aug 11, 2026 at 08:47:59PM +0530, Neeraj Soni wrote:
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
>  drivers/mmc/host/sdhci-msm.c | 32 +++++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)

So with this patch, resume from hibernation will be the *only* time that
ICE keys are reprogrammed.  Are you absolutely sure that is enough on
every SoC this driver supports?  What about resume from suspend-to-RAM?
CQE error recovery?  What if the hibernation image fails to be created?

- Eric
