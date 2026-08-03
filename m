Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56263909A6;
	Mon,  3 Aug 2026 20:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788035; cv=none; b=gNxEX4LxBJ5urYMXy0DxbdrgSCuj7fv+F1a+JtiJJDUa9+rnqSvEaLg9u2swnw/BEaYshMNvHzqBnq8JURUDkDWsP6lrRytosAkSWIrAMG6NFeBRKNaDmg6ksARe1H8xE50+tlGeOgOflHHaUhzaTYCZq3TOebt/dr3xkf9aDtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788035; c=relaxed/simple;
	bh=UuYWRqdCYdbMuocxLgRVCA0a2aYiytG9IPmh8HbPcQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IerO6i0G2wzuB5/e2eUHxg3uimDNoUl47D0vwQpKUa0smxWqMq842mVB0+m02EDlZfb8txGP6cS33nb19g9ZR7GRcJtJXczYaYgFD3tSndD2j3+I3J6MzQ4UTgHlSpelwS0XlvUa39WBx6sFiVEMoZdCEwW0UYst1uAhT5GDdgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUUZpwRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUUZpwRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2731F000E9;
	Mon,  3 Aug 2026 20:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788033;
	bh=kVPlX0Bw/NQGQg1L6/+e+ChGDM5e3ZB0rpDyVXsQWVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUUZpwRU89HyFUkxeOaeHgEpRMWtN5nsELYTjaJUEkoD452etQs5WRrOvOi4wlnsP
	 D5xRgbqedfXWo07dMzU/XpcnAG52hrMm5aukbDkiRA4xxdeGYGxgTIqP+IvLG7oX5E
	 JhKrMkLLKULUwnwrOqJHu17xQbBvr5JHrI/GsF8p2hmgNtTPbn3xs8rHjWWu1VkW6D
	 CoH9eVfjNUbFCnhjG819CwEp5ppW51XSkTdPXNkGk0POo79gg5RJcM7zBuHdq74jII
	 wduzBYrVM3MdaPBKryXmuNtMvTCLq6KUqqpgsKb+NJuAlDDGyo8+Z02UCWKuUz58WT
	 0Lz+mXuywxE1g==
Date: Mon, 3 Aug 2026 13:13:40 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, ram.gupta@oss.qualcomm.com,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v6 1/2] mmc: Allow host driver to control the
 re-programming of crypto keys
Message-ID: <20260803201340.GA63318@quark>
References: <20260803163123.1802005-1-neeraj.soni@oss.qualcomm.com>
 <20260803163123.1802005-2-neeraj.soni@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803163123.1802005-2-neeraj.soni@oss.qualcomm.com>

On Mon, Aug 03, 2026 at 10:01:22PM +0530, Neeraj Soni wrote:
> The register context for the crypto profile belongs to the
> sdhci/cqhci host and not the mmc card, hence re-programming should be
> managed by the host driver itself.
> 
> Add the flag MMC_CAP2_CRYPTO_NO_REPROG as part of host->caps2 to control
> reprogramming keys to crypto engine for SoCs which do not require this
> feature.
> 
> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> Co-developed-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Sarthak Garg <quic_sartgarg@quicinc.com>
> Signed-off-by: Debraj Mukhopadhyay <quic_dmukhopa@quicinc.com>
> Signed-off-by: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
> ---

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
