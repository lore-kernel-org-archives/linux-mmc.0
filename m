Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8C6196DA2
	for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 12:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729600119; cv=none; b=r1bOgJP5sdVtvvpT5zjXUJ25KTMH8nrS4GLdv9yxBhs3B3prDjiZgHU/GbSCpHMBbULUOMpvr7IKG0yF8rhKzdR7f7WXIoswcq4DLWFB99Sf3uCuc2/+FY3UsHL6dYTaG2jp5lAKj62/iH1GBjJLoQdy8THTEsfrQ1lShQXCgm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729600119; c=relaxed/simple;
	bh=qWIjXmIEmAmE3Cr1lHs1eWeZDZtAM7mr7Y3/sudwq7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfKr0jQ4HZAateehT7lJCF7iNnYkZPa/cXT89Rm32L5n2Wn9MdKhgG31DN+1LydYRUmrnnysSebz83Ekf0Ly/NnD4eeEYpPBKTalTj8QMNJMR9awuI+ClAkYyp/Wxa+51dhVp1/5p358EVDoNh/gSN1b72QIXUUWEUsa3M58ySU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m1TbBCqz; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m1TbBCqz"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso4731286276.0
        for <linux-mmc@vger.kernel.org>; Tue, 22 Oct 2024 05:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729600115; x=1730204915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ioL3U7Maz0qLUYZXpZJBEClR0ZOLVSgH8k832uiTky8=;
        b=m1TbBCqzC0VghJZKTo/K7l6rQj1R7B9EQlRnTIIadCq/DrQtvcsW+UCe7Xtm+7F44+
         cKFMygPdQBsPotcnXRpRgS0/Mz7oCkX73T514ccBQlrxe1MggwTyR/RCDP+JXRxCw8OE
         6iBbjil3JyAEtZ3bJXjMdri7E9cWbBoJqFtNZJyM7f82H3NOOKdD1AAhn9yaLeZYo+jo
         6iBN91Znjc0lkvNlAbybZUP955HZPz9PMFX1KnUjWLXV3HDhvqaO9mhoPcq8Lvp+yssZ
         RKZQUWWOL/QHAQoVnYUonOx6Emv0fNzlCgCfUimTDTfao1+aDq5izz92Rfa8BU83Axo4
         nFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729600115; x=1730204915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioL3U7Maz0qLUYZXpZJBEClR0ZOLVSgH8k832uiTky8=;
        b=GFu4/LHSSq2daUT3daQ33mkMwp0gQns00OFnhL6R+F/XDJDN8bVg6Jz66dmvOSAelI
         4gLk2reSC16WbvINaEuA+SjztfIhao7wMKj1LRF43Hl4BE360k+36tDu/ZECuB4zoQqh
         HNy5StIYNLFpVEu0tHBI0gMkYHuEGFor1hCR9cFYRl2zMt8G/bMnTsb2PB102Rr0sNmA
         JZA79EToLf5XEG9ttQVrvWfwV4OmRuS4bwh01TDoALc1jeWJuJ1jJiNfu1DhON0TRfP5
         dt40Ibkacma5BA7YNVI09vd8HXG14SU2fZo34kmIG/0aqLcEgfughS9fjkxsQYrGIOUQ
         1D0g==
X-Forwarded-Encrypted: i=1; AJvYcCVomoWqhzcYmhthugqji14/DX4vorE9pNPm29kl3g5+5n0bsuA3YVaDFwjbJnG1FTyFTr4xVh6mQDo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFn4/CfOEPKY0Nwg/rWgiXbo7H4tEF4r9VHbz5J6UFRkE+jt+K
	AVZZY1VCFbLSfcjhx3oaT3NIWW8XwsYnj6uNHQ3m+K4XktPFRa0YTz+vjg3or7zIwt+G5PLteU9
	r0/8T2g1aWckrut/3ZRVEtHzrehdCfylmuh4+9w==
X-Google-Smtp-Source: AGHT+IEl5bYcUxKZc8mAfmMEAjtQp84RugZvAkgPtQDGOp24lN77bPuSBEw3ulBRwyVTZHLzGUlZyV8MTZyrDSygndg=
X-Received: by 2002:a05:6902:1027:b0:e0b:5b37:d0c9 with SMTP id
 3f1490d57ef6-e2e22eb8ca4mr3538840276.14.1729600115527; Tue, 22 Oct 2024
 05:28:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com>
 <20241006135530.17363-2-quic_spuppala@quicinc.com> <CAPDyKFpXh0vZrK6PU2V+y92Q_+y6Q2+VUEONXiBrqAp_qqp_jA@mail.gmail.com>
 <e63f8862-5e1b-45c4-9815-95deb70f72b4@quicinc.com>
In-Reply-To: <e63f8862-5e1b-45c4-9815-95deb70f72b4@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 22 Oct 2024 14:27:59 +0200
Message-ID: <CAPDyKFqhUKuwUs9ySZnDvp8WZLNZq2K6q-S-0DjQvFU7vuvHoA@mail.gmail.com>
Subject: Re: [PATCH RFC v3 1/2] mmc: core: Add vendor hook to control
 reprogram keys to Crypto Engine
To: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	quic_rampraka@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_sachgupt@quicinc.com, quic_bhaskarv@quicinc.com, 
	quic_neersoni@quicinc.com, quic_gaurkash@quicinc.com, 
	Eric Biggers <ebiggers@google.com>, Abel Vesa <abel.vesa@linaro.org>
Content-Type: text/plain; charset="UTF-8"

+ Eric, Abel

On Sat, 19 Oct 2024 at 06:55, Seshu Madhavi Puppala
<quic_spuppala@quicinc.com> wrote:
>
>
>
> On 10/8/2024 7:30 PM, Ulf Hansson wrote:
> > On Sun, 6 Oct 2024 at 15:55, Seshu Madhavi Puppala
> > <quic_spuppala@quicinc.com> wrote:
> >>
> >> Add mmc_host_ops hook avoid_reprogram_allkeys to control
> >> reprogramming keys to Inline Crypto Engine by vendor as some
> >> vendors might not require this feature.
> >>
> >> Signed-off-by: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
> >> Co-developed-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> Signed-off-by: Ram Prakash Gupta <quic_rampraka@quicinc.com>
> >> ---
> >>   drivers/mmc/core/crypto.c | 8 +++++---
> >>   drivers/mmc/host/sdhci.c  | 6 ++++++
> >>   include/linux/mmc/host.h  | 7 +++++++
> >>   3 files changed, 18 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/mmc/core/crypto.c b/drivers/mmc/core/crypto.c
> >> index fec4fbf16a5b..4168f7d135ff 100644
> >> --- a/drivers/mmc/core/crypto.c
> >> +++ b/drivers/mmc/core/crypto.c
> >> @@ -14,9 +14,11 @@
> >>
> >>   void mmc_crypto_set_initial_state(struct mmc_host *host)
> >>   {
> >> -       /* Reset might clear all keys, so reprogram all the keys. */
> >> -       if (host->caps2 & MMC_CAP2_CRYPTO)
> >> -               blk_crypto_reprogram_all_keys(&host->crypto_profile);
> >> +       if (host->ops->avoid_reprogram_allkeys && !host->ops->avoid_reprogram_allkeys()) {
> >> +               /* Reset might clear all keys, so reprogram all the keys. */
> >> +               if (host->caps2 & MMC_CAP2_CRYPTO)
> >> +                       blk_crypto_reprogram_all_keys(&host->crypto_profile);
> >
> > Don't you even need to call this once, during the first initialization
> > of the card?
>
> The first card initialization is done during the boot up for qcom socs
> and the kernel keyring contains no keys immediately after bootup.After
> the initialization of the card, the block i/o operations to encrypted
> folders will automatically trigger the corresponding program key calls
> to the crypto engine since the kernel keyring does not contain the
> required encryption key. So, it is not necessary to explicitly reprogram
> all keys for qcom socs.

Okay, I see. I have looped in Abel and Eric who worked on this
feature, just to confirm that this makes sense for them too.

I assume the reason why you want to avoid the re-programming is that
it adds latency when re-initializing the card, right? In that case, do
you have some numbers of what we save by doing this?

Kind regards
Uffe
