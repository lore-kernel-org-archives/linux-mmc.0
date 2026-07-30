Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D192EBBB7;
	Thu, 30 Jul 2026 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438343; cv=none; b=Ej90BhNv5cYxHp1eSAnX/EudJm7tvCYB76AJ7UaOIaXbf3CvGAGCgv3gI4Cvq3y2N7iGrnMccxMdsGk3LlvqS13g/I8cIxzKQBp8ZSqnFNip1c9uPUb0wJpR+J8b5KQ2qkRAhkAjYdgRnY0/olWsTWEJyrqzwBAsXZlLZ7kk//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438343; c=relaxed/simple;
	bh=Ujp3VAFuTyzpFU9KzpezyTZ384SezX2k0/rSpip/DUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OFfbI3SicndGRyjfQ6P/DQevAKRSUIG7MlCjAXCdxjzKm2w4jeirN39ZkgQ28roR/tDs6WvfVmhDVDQGFHFNmAPZvGlm2MMfhuMwl1spsKQ/1YotySxk/BCbUfJ8Uw4NBvH5l/Duc6E3KmZ1YlQijZ8w/hkt9NeTtNiSWs5QMv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAUzGC9V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAUzGC9V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3CB1F000E9;
	Thu, 30 Jul 2026 19:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785438341;
	bh=Fle69hvKCPxP0nxUbtDlJG0LgyWs/TigBb6GgJwmPiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAUzGC9VRzAgjo18en6WezDbPFsYdsWoI6vX4zDE699B3Ek/JlNYx4d4wInL/Jc7s
	 +ayma3ZZhqiu5TeOI3JYJNglUKnrx9v4I3hvmrymBnNUG/ohMb5YDItv23QOOyq2Ln
	 QEdmMQZ3t1lmcptGipezUcHV0fOJuQ1/e6aPhrPlJpP+FB8Vhr28N+IMab9RFdaYDj
	 zExoaUYIJLQYcjzX95hCjZiOt7Iap8zEGLupilkNyJjQFfF2cdJCqLaEp/f4vUF33w
	 4ToReKG71egPPZUkOXgHak/gYnXhvj9ocLn1fZsXXMZB6adE66f+GWMBo7rdSD76Cn
	 cBvctu7pKDNpg==
Date: Thu, 30 Jul 2026 12:03:46 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v5 1/4] mmc: Allow host driver to control the
 re-programming of Crypto keys
Message-ID: <20260730190346.GB3139@sol>
References: <20260730140822.1976635-1-neeraj.soni@oss.qualcomm.com>
 <20260730140822.1976635-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730140822.1976635-2-neeraj.soni@oss.qualcomm.com>

On Thu, Jul 30, 2026 at 07:38:19PM +0530, Neeraj Soni wrote:
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index ba84f02c2a10..83d92fb64417 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -457,12 +457,9 @@ struct mmc_host {
>  #define MMC_CAP2_CQE_DCMD	(1 << 24)	/* CQE can issue a direct command */
>  #define MMC_CAP2_AVOID_3_3V	(1 << 25)	/* Host must negotiate down from 3.3V */
>  #define MMC_CAP2_MERGE_CAPABLE	(1 << 26)	/* Host can merge a segment over the segment size */
> -#ifdef CONFIG_MMC_CRYPTO
>  #define MMC_CAP2_CRYPTO		(1 << 27)	/* Host supports inline encryption */
> -#else
> -#define MMC_CAP2_CRYPTO		0
> -#endif

I'm still a bit confused why this unrelated change is included.  If
you'd like to make this unrelated change, it should be a separate patch,
and the mtk-sd patch would need to be before it (not after).

- Eric
