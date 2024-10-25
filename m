Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F571D26E7
	for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 08:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845797; cv=none; b=S8jM0CyxqW56X41MJn/Uuo4hf7J4cB9UbUs8NriqRg3EcdEm6tGne4cmUAmDRIA3vxnBguEcosMl7rhtL/keqw4CT72NkW9A25R/ZKrelZDQV05oENG8xt5WVXa3u/8XseUHFhmGrIgJCnQhVVSH5SB5cXBh1Z8Z77QsKohZxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845797; c=relaxed/simple;
	bh=gqO6H9f6wkA2+S3L9LFbGLXMmbD0O/wXTCeVxvKUAQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKSLcnB4CRUGke2bSaYibMIjrcFlfJV1xFN6DpcZ/+UcvVDuvE0LlkMSixpXIrw4zFNDUyIImX9NakKviWhzgR9j3sPPnHfMWBc3BhIEzR/GuP0ipKQZIbbbHIyflt1ADiXCljL4lJRMdwirOELgTX/TTEgKM/DvyRFAt+KmFEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XTinhZ2Y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XTinhZ2Y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e5a5a59094so16820277b3.3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Oct 2024 01:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729845795; x=1730450595; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GC+qtopUK4oSW4KGo5gKXeaDDfYPEvj4E4F8hcqDrxw=;
        b=XTinhZ2Yle0mJw8ae4h4/NlZ42xApmKgqWq1gH+Na2cVGM8J4dJy5PT3XFmHcO4582
         +bH6+ruN/lKpr1chM4K/7x10RCyoMr95xOvNmiqfwfu16msNh4WZkP7/C1tAsVF9LAqk
         EsZqnb7PgLWwMv1BvByNSrgJWEW4a4SWc1EAIeIhE0CKrVS3RZ9sA7GQZJZAx5/xVP+O
         N8tui2e/oq1IR2XnEe1qJeEM2+DxyqVf0r8sLiybKpal9o2zMFa7zT6n3yHS6gPqhQTq
         4XDqhSwAByMSSxvYYOdsQdQQl4IxYUU2ivT+sS0cvY5aWydEv4+inih8M4IxH9WNhc3p
         5xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845795; x=1730450595;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GC+qtopUK4oSW4KGo5gKXeaDDfYPEvj4E4F8hcqDrxw=;
        b=LwkjYU1dn+Jqr4wcEocVDrbjtnajrzPdzQXyByWUE7ffpibNEFNy2gJytFIJCEGCRo
         YOWyybtqrEU3ylBP6OFOV7dzuI8b2FHBfXNP4XJo/+M9ZYJp6NJCrdz/FQqcFyhjRBV4
         lUJfUL71qd2KKpRR73K4iGWMj0fvVbdG130MMPuhVo/DRICTGRyKX6iOafaKXdGgYY58
         1UewIYcT/wbykrXbui4n7iTXcxbU6AGp13aspg8lVKl+IhYJSqRIor3guXnWq+yu1/2H
         K3EPcM9mtZfdBfOrmxcZ3puvP3ALuXws4JkBp4GxaQXQ6Nh7uUcGsAqXGnyuCAI0dCAb
         9Q/A==
X-Forwarded-Encrypted: i=1; AJvYcCV9UnMx2MApc0rMstbfZ0g7OCOnWaIHS9cdNGeFfb9kF12Hs0rrsGBSmMf/Qa0dQkJK9o+hVbmYubE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNK2bD2rELJVgKKsulWTMmtJxOZOkTu1VHarQ7QWEHWAWe926L
	ov8B07VenFlKH92CtPz2ckLqfnvPec0lca5ENkddJFcFaTAHpppwdzmUm4mA+JTIAPcMWpa7q9R
	prMYsR9pdfRd+HkMP/Ar2CgBrpzYlz7RhN0FXzw==
X-Google-Smtp-Source: AGHT+IFrRXdZkgGxH0j5lBC5M/B8Et457P+nj+I6ZhAqPxt0MfCx1n+REAlyGGvq27rvvYwVe3tTniNTFUNptx7YNbM=
X-Received: by 2002:a05:690c:4a03:b0:6e2:446f:422c with SMTP id
 00721157ae682-6e7f0e4735emr106087327b3.21.1729845794711; Fri, 25 Oct 2024
 01:43:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006135530.17363-1-quic_spuppala@quicinc.com>
 <20241023213134.GC3736641@google.com> <CAPDyKFo05Hyw9gdEBx7zQq_6P58ittHHsZQLuqmeR1AChyHSHw@mail.gmail.com>
 <20241025025628.GD1781@sol.localdomain>
In-Reply-To: <20241025025628.GD1781@sol.localdomain>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 25 Oct 2024 10:42:38 +0200
Message-ID: <CAPDyKFo5EijkL5Y+MZ0=ZWyGdLfDdSdqTOC0eMsTVY00KP+RAA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] Avoid reprogram all keys to Inline Crypto Engine
 for MMC runtime suspend resume
To: Eric Biggers <ebiggers@kernel.org>
Cc: Seshu Madhavi Puppala <quic_spuppala@quicinc.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_rampraka@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_sachgupt@quicinc.com, 
	quic_bhaskarv@quicinc.com, quic_neersoni@quicinc.com, 
	quic_gaurkash@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 04:56, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Fri, Oct 25, 2024 at 01:07:18AM +0200, Ulf Hansson wrote:
> > On Wed, 23 Oct 2024 at 23:31, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > On Sun, Oct 06, 2024 at 07:25:28PM +0530, Seshu Madhavi Puppala wrote:
> > > > Crypto reprogram all keys is called for each MMC runtime
> > > > suspend/resume in current upstream design.
> > >
> > > Is that correct?  I thought that similar to what is done for UFS, the key
> > > reprogramming happens only after the MMC controller is reset.  I thought that is
> > > different from a runtime suspend.
> >
> > Looks like Seshu is not really worried about the host's runtime
> > suspend, but the card's runtime suspend.
> >
> > Perhaps there are some out of tree code involved here that makes use
> > of MMC_CAP_AGGRESSIVE_PM, which is what allows the card to be runtime
> > suspended?
> >
> > >
> > > If it's in fact triggering more often, maybe that is what needs to be fixed?
> >
> > We could extend the runtime PM autosusend timeout for the card, if
> > that makes sense.
> >
> > Kind regards
> > Uffe
>
> The keyslots are being reprogrammed from mmc_set_initial_state(), which is
> documented as:
>
>     /*
>      * Set initial state after a power cycle or a hw_reset.
>      */
>     void mmc_set_initial_state(struct mmc_host *host)
>
> It's called by: mmc_power_up(), mmc_power_off(), _mmc_hw_reset(), and
> mmc_sdio_sw_reset().
>
> Can that mean a power cycle of the card, not a power cycle of the host
> controller?

Yes, that's correct.

Well, indirectly the host is likely to be power cycled too, but not necessarily.

> The keyslots are part of the host controller, so that may explain
> the problem.  The keyslots should be reprogrammed only when the host controller
> is reset, as that is when they are lost.  (And it should not be skipped entirely
> as this patchset does, as a host controller reset is possible.)
>
> I am not an expert in MMC or in the details of how Qualcomm ICE is wired up to
> the system, so I might have this wrong.  But let me know if it sounds right.

It sounds reasonable to me, but I also don't know the HW well enough
to be able to tell.

Looks like we need some more input from Seshu and the QC folkz to
understand better.

Kind regards
Uffe
