Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425CE1CB515
	for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 11:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732187030; cv=none; b=sA/YyqRxKu0O1YiEbR0i+OzR6oMb7FcjH7t1mZjX+A+Hxd70pyVSoZ+4XIldoVdg+ciH97Et4eDAQeZ9AWdQk07iP3uuL4y8EjFIFjcPyFGFKopwAUyv9yIJCSE9vbFKFadVRl5uPKMCfht6Rl+DW7VRoMvuCIO2UhVP7sJhDb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732187030; c=relaxed/simple;
	bh=7PVx9sFZRrAihAdQ/yUnR6p8Gj46dp5SH7888wIWc3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3kSQqq4iTr8G6vd00WipEeulu/w2N8TaBJLL9sSjww4S0EWAem0gsP/BlyGCW7C8oh7G7W1eQt07cggMtgsanHbX1Ga7sMBU1QilbWQf9vFL/UQZC+apMi+UTTFv/yJFT6OEvBqUkaYDjwqZirHNvACRGHmMHOnl/7ZNiD3wuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfwg01Cl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfwg01Cl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e3873c7c9b4so726184276.3
        for <linux-mmc@vger.kernel.org>; Thu, 21 Nov 2024 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732187028; x=1732791828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HnmX5TqmpI0tRkOweTa1/DhIzHunTTWi3NrhaxtEZZM=;
        b=tfwg01ClTD7JVknLKBXOVgp/r6wMpkfqVhNpQz2juqfJt6fiL1bjfLQ121b5lNEsco
         jUDa85f+labp/Tl5NWXIJDqDZyMege4bP2evJgvTVfSKtJkSoWp8UuAkR/vYIuphmmAd
         SXPVkYGUOQuhbrBOUs3EtVIJfyV/EREIS+R8SLMdhuD2MaKxYbE4AFem36ucwbT0aEKE
         8dxrRYttvACv1XwrDZEGb0iv+CLsOBoIS/x7VQputLAgMTY/kR2ShM2VuIT1XEWz7CYq
         TQ/dEQPry/oslWEQd8oxI3inK8tckt6EohH7/iKueJRUXNS8O2Dj8WJJNPv59XXj5p7t
         hVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732187028; x=1732791828;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HnmX5TqmpI0tRkOweTa1/DhIzHunTTWi3NrhaxtEZZM=;
        b=RrzepuwjJgjBdBv8w+Lz3KOF95zJN4T3iaF6SqZQQ23gScJ8yYfW/XHfpdp5JHcOaE
         gELaZuFIqsuzK+W8ePWvDlbSFqystDE4LUez5ZWokhcdaYm+wks28vKl8p3AvLRJQ1UQ
         c2nsw2lm+cPjSmF1KyYYALZe3m912mTMbjon+mwO/uiQgrlO8mqVadH0rd5PqR0wxyCA
         2z2SYtF0TUrTVoreYTfHCJ53wKWZ7rX5b+u5Ffe5NG1fpvCGN6MT9NRgokyOIJQylbim
         PI8lEWZDw9zILWNKjs0Q7sH7aI0Ffh42F4xheIlMJ/XlEv2g1a+sG03NjeWOG9/54Ezz
         1G1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPS78k4RadG1Iog6XsoZplE9/swNlphAD/gC/1mDGMwYtvXYin+rspofBzW5/lx3pEoT87IFuSlY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2iJj9RhcRTheVcLJ/MErRi5I1thvOB90fsXmdZ0a6Y4UHKB3D
	9pHNVw5Rad5Wo0nzrkIYYqSkF1StW0BapDB+FSDIXLnl4y6zEYHnkyAurk4+gwWJDuaGHuUevBn
	IqEs8C1fCqjMDJrjAkwRYsfiE5u87hBloGmKsyA==
X-Gm-Gg: ASbGnctUtOOeWGcDdaJlQet9d41Bis39lKeYwBAZPEKv1Du0do1QU25fqZsxmYIBRLj
	yT5A9GV7E0foDko56yISfdc/81xa8+7TE
X-Google-Smtp-Source: AGHT+IHThgwC/2AN5VCX26+izVDudjEqWF+s/Kp+cAGqMDexA7+s1nCPpNNrlrMFSnqiN8eH6D0iaXXY9h4nOZXblmE=
X-Received: by 2002:a05:6902:1004:b0:e38:d1e5:c247 with SMTP id
 3f1490d57ef6-e38d1e5c514mr5266672276.19.1732187028290; Thu, 21 Nov 2024
 03:03:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com>
 <20241023213134.GC3736641@google.com> <CAPDyKFo05Hyw9gdEBx7zQq_6P58ittHHsZQLuqmeR1AChyHSHw@mail.gmail.com>
 <20241025025628.GD1781@sol.localdomain> <CAPDyKFo5EijkL5Y+MZ0=ZWyGdLfDdSdqTOC0eMsTVY00KP+RAA@mail.gmail.com>
 <c41839b9-36b1-431e-9031-4e57f62b50c2@quicinc.com>
In-Reply-To: <c41839b9-36b1-431e-9031-4e57f62b50c2@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 21 Nov 2024 12:03:12 +0100
Message-ID: <CAPDyKFpKnofrut7pbWTJSrZP8uHCWO9omr=bNLp27JH6aP8q7g@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_neersoni@quicinc.com, 
	quic_gaurkash@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 21 Nov 2024 at 06:16, Seshu Madhavi Puppala
<quic_spuppala@quicinc.com> wrote:
>
>
>
> On 10/25/2024 2:12 PM, Ulf Hansson wrote:
> > On Fri, 25 Oct 2024 at 04:56, Eric Biggers <ebiggers@kernel.org> wrote:
> >>
> >> On Fri, Oct 25, 2024 at 01:07:18AM +0200, Ulf Hansson wrote:
> >>> On Wed, 23 Oct 2024 at 23:31, Eric Biggers <ebiggers@kernel.org> wrote:
> >>>>
> >>>> On Sun, Oct 06, 2024 at 07:25:28PM +0530, Seshu Madhavi Puppala wrote:
> >>>>> Crypto reprogram all keys is called for each MMC runtime
> >>>>> suspend/resume in current upstream design.
> >>>>
> >>>> Is that correct?  I thought that similar to what is done for UFS, the key
> >>>> reprogramming happens only after the MMC controller is reset.  I thought that is
> >>>> different from a runtime suspend.
> >>>
> >>> Looks like Seshu is not really worried about the host's runtime
> >>> suspend, but the card's runtime suspend.
> >>>
> >>> Perhaps there are some out of tree code involved here that makes use
> >>> of MMC_CAP_AGGRESSIVE_PM, which is what allows the card to be runtime
> >>> suspended?
> >>>
> >>>>
> >>>> If it's in fact triggering more often, maybe that is what needs to be fixed?
> >>>
> >>> We could extend the runtime PM autosusend timeout for the card, if
> >>> that makes sense.
> >>>
> This change aims to address host side feature by not tying it up to card
> side flag/feature.
> >>> Kind regards
> >>> Uffe
> >>
> >> The keyslots are being reprogrammed from mmc_set_initial_state(), which is
> >> documented as:
> >>
> >>      /*
> >>       * Set initial state after a power cycle or a hw_reset.
> >>       */
> >>      void mmc_set_initial_state(struct mmc_host *host)
> >>
> >> It's called by: mmc_power_up(), mmc_power_off(), _mmc_hw_reset(), and
> >> mmc_sdio_sw_reset().
> >>
> >> Can that mean a power cycle of the card, not a power cycle of the host
> >> controller?
> >
> > Yes, that's correct.
> >
> > Well, indirectly the host is likely to be power cycled too, but not necessarily.
> >
> >> The keyslots are part of the host controller, so that may explain
> >> the problem.  The keyslots should be reprogrammed only when the host controller
> >> is reset, as that is when they are lost.  (And it should not be skipped entirely
> >> as this patchset does, as a host controller reset is possible.)
> >>
>
> This will be update via a separate patch by invoking reprogram_all_keys
> API from sdhci_msm_gcc_reset() API
> https://github.com/torvalds/linux/blob/master/drivers/mmc/host/sdhci-msm.c#L2363

Okay, in that case, please post the complete solution in the next
version. It seems like $subject series on its own doesn't make sense
to us.

[...]

Kind regards
Uffe
