Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C77340A59;
	Thu, 22 Jan 2026 01:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044460; cv=none; b=TS129FSDP4lhh68L1h2bQSpPNMjsVk9h8m8R5PSfvPOQdSfRQ+1QrUJ1HcVAMQ6IW7I6LBBL9VaoVIljWasybFVivky2DU8J7Sow0E/P0wJW0SKO1nq5A8ZcDfmhYmf0il14/AEYAhDXn+KWc1aVGfdu+A478XOWo0Ws23a6bRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044460; c=relaxed/simple;
	bh=d59zNRUNMLT8BPT6z3gjhZhubH1Hy0HBNi71roTJtP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bf5axvNni/GgQPTdaFYDX/0KgeE5UIOwbwZrrOIMBzWVsKRCRVE/fN22Ya4dHiJNf524Piq2553C4fFzb1nkthVEpghe/Kil0xD/TIueEjmTyMBlBqIi6BqCHr3bzBkYcKn8BNgQUek3LsmQxsyuHVzs88Kw0KwXTCM/DwkwHPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2Roa1Wd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2Roa1Wd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F08AC4CEF1;
	Thu, 22 Jan 2026 01:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769044460;
	bh=d59zNRUNMLT8BPT6z3gjhZhubH1Hy0HBNi71roTJtP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T2Roa1WdGDdPjT3pCrMRHGj5lo/djTaqMZH1+M9iF60G1i1PW4BV17FwabMt8Pscb
	 s5sHJGMI+kXMOnKDEdOVHSvD3Pb1SYXHvPy3noCmhc5sm45qoEHpHrr2bKYqmtXHNi
	 DsS0AGOGxdZkHlqzHtZfJWA1wPHxFFEZFeOwyj3pkMUTfHLowRLE4rnC/OFD8yFccL
	 BtyB01E8oNCdf6kdzIswtUzHcWU3hr7nN+zS/50+1eFczSByAPR6iNSIPiFMlOhTsA
	 OW/gfkZs4h7ljkZ32AnhadbUDdJ6mfZtrMv8PfbNFDgTwEdVGHQ9UnfObFRM0u92HE
	 RdCLRKW8Qx8Tg==
Date: Thu, 22 Jan 2026 01:14:17 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, adrian.hunter@intel.com,
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com,
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com,
	quic_sartgarg@quicinc.com, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
Message-ID: <20260122011417.GB946159@google.com>
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com>

On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
> > diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> > index fec4fbf16a5b..a5a90bfc634e 100644
> > --- a/drivers/mmc/core/crypto.c
> > +++ b/drivers/mmc/core/crypto.c
> > @@ -15,7 +15,7 @@
> >  void mmc_crypto_set_initial_state(struct mmc_host *host)
> >  {
> >         /* Reset might clear all keys, so reprogram all the keys. */
> > -       if (host->caps2 & MMC_CAP2_CRYPTO)
> > +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
> >                 blk_crypto_reprogram_all_keys(&host->crypto_profile);
> 
> As far as I understand, calling blk_crypto_reprogram_all_keys() would
> only be needed for those mmc hosts that lose their corresponding ICE
> context during runtime+system suspend, reset and possibly during
> ->probe().
> 
> In other words, calling mmc_crypto_set_initial_state() from
> mmc_set_initial_state() looks like it's a mistake, as it has really
> nothing to do with the card's initialization, unless I have understood
> this wrong!?
> 
> That said, I would rather make the mtk-sd and sdhci-msm drivers to
> handle this themselves, by explicitly calling
> blk_crypto_reprogram_all_keys() when needed - and drop
> mmc_crypto_set_initial_state() altogether.
> 
> For the sdhci-msm case, it seems like the only case we need to care
> about is for the reset.
> 
> For mtk-sd I don't know what is needed, but possibly Eric can help out here?

The comment for mmc_set_initial_state() says "Set initial state after a
power cycle or a hw_reset."  I relied on that when I added the call to
mmc_crypto_set_initial_state() back in 2020.  In the following thread it
was also discussed that the code was intended to reprogram the keys on
reset, not runtime suspend as that shouldn't be needed:
https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/#u

If that is not what it actually does, it probably would be appropriate
to replace it with something else.  

- Eric
