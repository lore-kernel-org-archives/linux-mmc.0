Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7033D6F2
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076888; cv=pass; b=UT0oBL1e7ccC4MJCAi5MzpT2hEkp2+6NvLpCzKW+uO5r4lmGQvD2nRHwqxomO3VMHzfymz1Gwwx7Qd6nB7YLbSBHPDd8i+am/GCbeaeXoP4glWAUITGbONRjZBE03nTain2LENVf2vKgGOepPcNzqlzsrAT7Kj0+JmDcefSKGb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076888; c=relaxed/simple;
	bh=Cu3pdIVEfPdjTaeNYZyDRLhQfT3kIup9uEOtljEl9TM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bVV5lksWXK7oe70aJS2eN+oX4rxBv9SaYQ0O3llKEGLhmDAOHdutZB3Cbx/w8D2jQpHZsXrD2jSnIbw1nh7J2vuwMvHkCRrlw/e/5JvR8jfyh1QaaRmpKx9qJWHZ9cPPCe3X4Kg0deIynXX5Q/4hWha9Ypp5IqWfV6p/wiOyx0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X0ZNhErN; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X0ZNhErN"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59b77f2e43aso2497630e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 02:14:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769076885; cv=none;
        d=google.com; s=arc-20240605;
        b=DBMpm00qegh/Cz1ZuTflCQA70QV4KPtG7K0YtOz3PyRG6mcoPuIx4d7pFhEx9xSiCk
         mbfp4BChRt+4LEtZ1VdhCPh+1CHqD1ezrokHZRFEeXbVZZoo/MjTkNeJ5TAmM2736TFM
         VNeq0wdIWd2Qzy7/w58gWlWDCBcAiSnetjygjjadYKXC3EfSE5Zcv5CqolWBKagWUwa+
         2XFgkNFBLYB+KODARvWumNGV/TxqaBMYUMlpw48w3vvuXq2l9JYXph6q1sNuVjQWjWLD
         5wQPitIrorT/3ur3uXbFusiNmJwTMiBM5YnkCWcU05xVpHXchhBXCD5EVyx5ZSBAzMWJ
         f/1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iFxgYJSYl0l4H5knWMT36IYuoddICbrhUa++V+YA7GI=;
        fh=bGhB5NYKos6tRauMX6IzY++LJFSnpdJPe/xDgxG/E1U=;
        b=OJy9Yb3tiJyWt3vTdt9mdL2SP+LSBI4HijsJXYgdiu3YXHufSao7HKDpj7GZEs0amc
         Wid9zg2Qc6zQ9kC0P0rpZt0jrlAG1xnWEQmFPHuMiiFb0vqd+SeTAfKDVE1qIa0Xee9X
         wOFsad7gtXLPowM0F41KBP5ILsfu62Njko2vvJxL5vZzuddQlHaT0HWAvFbG0QJfaKGE
         ANGx/IQT1PFu6OIXSroxDuW9qs0b8R6EDNFnUbA4bC+fMHCP9WYFiWV3mdqCTMJPq/3T
         YM78avrjqGH2xQrnLZDQ/MSxhF7UU1cjWJJwTmdC0mztHZxJPpJTgEfEMPd85E0+7I4n
         01kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769076885; x=1769681685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iFxgYJSYl0l4H5knWMT36IYuoddICbrhUa++V+YA7GI=;
        b=X0ZNhErNjENapoQqj+sT/QD4QA/GsdZGuE1eQnXIVKj4VKWrFtLaO8eVoeB8UxPJYu
         1Dy/d2/YimHx1LlQgBAI1D9ZpYROJhEIKi1MuPIPLitk8M1cmnnraJL5kRRka50JqN6/
         7EINMj5ckBYJWRbgdvPoQKjp+FhJLQbCQnHKtxbd7YpMR4f6UPXyMlcAo6dPz5gy5++n
         yOk+v/6ri5chW/4eCNkvyoeNMuMNTllaObficuF2O4qQFoROT79Iu2tgHXIS6689yCNO
         Bk9kxOf8aL9b8tqvuKa0NGReEAgocLH1zMRDTaPMgsrvEMD48uCSwmr7RkcR5K1d+17z
         9Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769076885; x=1769681685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFxgYJSYl0l4H5knWMT36IYuoddICbrhUa++V+YA7GI=;
        b=cMJI82V039gNg7r0URxjbxJ5nidobXVwk/zJnIYdZfcy8393oK9Rry1Jdsr3SqECab
         Hlwsinj4LnZmMo/QC/E0bcUjNV1oHZfft+tRF/FQlzmIlsMMXQlLrIS211K2sOSYosqb
         iXf5EE/qZocyEKpz2mYJBrefa4JBgbv7xr0O9TNh2WSty9BgVBN2DfvDHoFMlO2D03V9
         bd8KEhkrklqjp5pOwKHxyvcmdX/Tz5Jxlblfe74vtlYs6gdfML4vU89uj3VIWoM1tdnY
         gsspBZbxdUdRfjXUBM7xyoLmzSHNXAtv6FqqbYDnzKvPmhevZaP/bBxKwhWYSMDkrFBv
         a0ug==
X-Forwarded-Encrypted: i=1; AJvYcCXpQX9jdlMxWwQd5pVirXO4oMxVi2eChw/sqxd1NMrnMtnYTeGnnrA1p0KxcEDpRT/lCi/lKRenz6M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2nhd1kub0j/jE2+cmF10SAGNF3wfRBf9YZ3mWan9oApYoOdja
	XSpVp2Wp13rezfVLWV3IHiuEreLAtDdTWQm1yfWQ2gBcz1Yi2KDqenwKG2SeVQEhAAlk7Yf1Ojl
	Obg/o0e6NCkDcEKAuDGIjMoidVXniLgIJxRmmZjMnwA==
X-Gm-Gg: AZuq6aLWKAD8R/S8D0CM2n0WKN3VddUz2Tq+zzSL7O2Fy9LZYH+EUtohGuC5qrb3sKA
	+06hL0tjxs/ySqtnyEoZeYQ2bmw2ecEMgVxPdoO3WBjEVZSkC6GJjCynW62vtfQ9HFtjxuTY6sV
	VPntFcl5VvVRkTz01OBV2kOSB6EE+tJ8i5J95PNYuZSmNdwqU9BSf/DwcIxtSoFN1IxAZTmwCts
	AtQwNPfb0iqLMWuHnkWyCGIVcncxUiVxLOj6ffUseKIvarAMYleOvg78BOP8DN5aklaH6Kx
X-Received: by 2002:a05:6512:104e:b0:59b:afeb:fcbc with SMTP id
 2adb3069b0e04-59dd7bdd715mr794653e87.2.1769076884744; Thu, 22 Jan 2026
 02:14:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116121004.1829223-1-neeraj.soni@oss.qualcomm.com>
 <CAPDyKFrOHqStZbsye9Quk71UGkzUxOkwG9yAGYFVvt+=nMJSyw@mail.gmail.com> <20260122011417.GB946159@google.com>
In-Reply-To: <20260122011417.GB946159@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 11:14:08 +0100
X-Gm-Features: AZwV_Qhr-RztpM_calQdXu3awF0X3dzGBOat8oVtDLbE6D7-FrCI4oiiBe5LWnc
Message-ID: <CAPDyKFoPVeu3xe7ZAxBTNFfHmf=f7OZ3iUG=pRG8mD=UOGNVPA@mail.gmail.com>
Subject: Re: [PATCH v4] mmc: Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Eric Biggers <ebiggers@kernel.org>
Cc: Neeraj Soni <neeraj.soni@oss.qualcomm.com>, adrian.hunter@intel.com, 
	quic_dmukhopa@quicinc.com, quic_rampraka@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_gaurkash@quicinc.com, 
	quic_sartgarg@quicinc.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 02:14, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jan 21, 2026 at 03:12:43PM +0100, Ulf Hansson wrote:
> > > diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> > > index fec4fbf16a5b..a5a90bfc634e 100644
> > > --- a/drivers/mmc/core/crypto.c
> > > +++ b/drivers/mmc/core/crypto.c
> > > @@ -15,7 +15,7 @@
> > >  void mmc_crypto_set_initial_state(struct mmc_host *host)
> > >  {
> > >         /* Reset might clear all keys, so reprogram all the keys. */
> > > -       if (host->caps2 & MMC_CAP2_CRYPTO)
> > > +       if ((host->caps2 & MMC_CAP2_CRYPTO) && !(host->caps2 & MMC_CAP2_CRYPTO_NO_REPROG))
> > >                 blk_crypto_reprogram_all_keys(&host->crypto_profile);
> >
> > As far as I understand, calling blk_crypto_reprogram_all_keys() would
> > only be needed for those mmc hosts that lose their corresponding ICE
> > context during runtime+system suspend, reset and possibly during
> > ->probe().
> >
> > In other words, calling mmc_crypto_set_initial_state() from
> > mmc_set_initial_state() looks like it's a mistake, as it has really
> > nothing to do with the card's initialization, unless I have understood
> > this wrong!?
> >
> > That said, I would rather make the mtk-sd and sdhci-msm drivers to
> > handle this themselves, by explicitly calling
> > blk_crypto_reprogram_all_keys() when needed - and drop
> > mmc_crypto_set_initial_state() altogether.
> >
> > For the sdhci-msm case, it seems like the only case we need to care
> > about is for the reset.
> >
> > For mtk-sd I don't know what is needed, but possibly Eric can help out here?
>
> The comment for mmc_set_initial_state() says "Set initial state after a
> power cycle or a hw_reset."  I relied on that when I added the call to
> mmc_crypto_set_initial_state() back in 2020.  In the following thread it
> was also discussed that the code was intended to reprogram the keys on
> reset, not runtime suspend as that shouldn't be needed:
> https://lore.kernel.org/linux-mmc/X7gQ9Y44iIgkiM64@sol.localdomain/T/#u

The comment in the mmc_set_initial_state() is referring to the card
and not the host controller. There have been some similar
misunderstandings in the past for other functions in the core, sorry.

In any case, I have been trying to understand where the ICE context
really belongs and recently Neeraj answered that question [1].

>
> If that is not what it actually does, it probably would be appropriate
> to replace it with something else.

I agree, the comment(s) could deserve some clarifications.

>
> - Eric

Kind regards
Uffe

[1]
https://lore.kernel.org/all/e1f689d0-523b-5842-3a6e-10b431d617ce@oss.qualcomm.com/
