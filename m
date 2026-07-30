Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CD46984A;
	Thu, 30 Jul 2026 19:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785439220; cv=none; b=sBZNroY4wIceH+SfvrLuDACgjpeWrvAvcEidp1l/bsyIH8r5nrZtjj7iCXmSwsKhwuoTcYKsfLTw7aaU/wPOectQwh8aT4//070Y67APPT7n/QliEPH+idNN1jt9HTvfYZWhVy+RNKRb1YIdnQPC9aUEegNLbgmmSgFnqLh/duk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785439220; c=relaxed/simple;
	bh=nnQUjNO4MsukXzb1epLIp9lkKegltnzVf8MMKlRJ7Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLLEkAVDf93Xd4V0paEBaN8+SeFmF1v4s0zmfCVoHobjK0rMJTVXE9IWgfLQjeYDo4ssGJlLe6rWHTblhTBrKajIkGrT30A0wAmRN2wPxQcyuAD6HJpkcb24TNuflhKgTYov6cijz35hVJXO6QjvWg2GCxZu7QeLtrAEExdvEv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHI/oWNH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHI/oWNH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8331F000E9;
	Thu, 30 Jul 2026 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785439219;
	bh=9MPmBguCgRKWpaMThY+gSwrAPGCo4Mvj2d1HIenjEBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aHI/oWNHIxD5z3kVxl6VF8HWEYnKBT1OXV+ysmZg/cO9fbNFyCtc8RK9luDNJGfbb
	 ohD8LkGEXqNByFO53W3j2cN66fVW9LIFPpev8Y23hIc6s1dn2iHwkOUeQXp+y/tmhj
	 mruibq0e9BEm45RoEVqn101UKfJPmJGsa0p9OZNgyGDvgMpEQs47fu1PZsLjNTa1tx
	 Jas98iMIhXPIBi21YQAFaW/xMttvmcGQuClCBgo4clb3sZW23d2ssML7hEoZvRa7tg
	 MVgSWgN7MlqtxoShYWBae3GqpWxWWfor1ypor8d38PiBH4OJxMUCle6pn/NSe4WCbF
	 9A/wMBs3Ddc+A==
Date: Thu, 30 Jul 2026 12:18:23 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mmc: sdhci-msm: Reprogram crypto keys during host
 hardware initialization
Message-ID: <20260730191823.GD3139@sol>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730140822.1976635-3-neeraj.soni@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 07:38:20PM +0530, Neeraj Soni wrote:
> Host looses the Inline Crypto Engine (ICE) keys during hardware reset.
> Re-program the keys while intializing ICE to ensure that ICE is available
> in the same state as before the hardware reset.
> 
> Also set MMC_CAP2_CRYPTO_NO_REPROG to indicate that re-program of ICE keys
> is not needed during MMC runtime suspend/resume.
> 
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4aff965f0e2e..7d71dc6f388d 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1958,7 +1958,10 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  				cap.sdus_mask * 512;
>  	}
>  
> +	blk_crypto_reprogram_all_keys(&mmc->crypto_profile);
> +

This still does nothing.  The crypto profile was just initialized, so no
keyslots are in-use and blk_crypto_reprogram_all_keys() does nothing.

>  	mmc->caps2 |= MMC_CAP2_CRYPTO;
> +	mmc->caps2 |= MMC_CAP2_CRYPTO_NO_REPROG;

This seems to be the actual point of the patch, so let's simplify it to
just this.  However, this is also broken because this is ordered before
patch 3 that introduces the actually functional key reprogramming.
Please drop the no-op call to blk_crypto_reprogram_all_keys(), then
merge patches 2 and 3 into a single one.

- Eric
