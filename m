Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ECB1E48A
	for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748359271; cv=none; b=c5PAgHUuNZWXfWtrFd1J89taA6xmp2ZgQgFpPhNfJj98EdpXIvK/tlslvB1uYin3jNqGsoMAAV+c5TY7qyygIklZ9coyKp6qeRMra4/8xkI6/guDPRWZjtpqNKaMII/VtTggdoruvfav3WTNvPqxqyfoHfXVynWHOA6cv/83g1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748359271; c=relaxed/simple;
	bh=feIER1n2xpsKQNWpl7k2prOZxEPU3dBw7oweJY7flpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TxI3Z+Z6Ius5VewPDpI60Htb2vtQkTQGha31vTPmZipkMPuHBOueIrpOJYeUV/teysWueRVWAYfRQzMT8z6qrmnxkAr7Al6sjUDjPd92+4BbTRT3fHXWUMNb8ifbJaGlvr6TcKfqGejFKzlNco8BCwwlxcUBQXAFGa3FIcK70o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=darZk/+w; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="darZk/+w"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e75668006b9so2798247276.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 08:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748359269; x=1748964069; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T26QWxsDYRdwe+jygmvaCGYR4lil1tNS/Sd5gdRh8Tw=;
        b=darZk/+wewl644jbli4CtHccJ+9GocoWKZSJrDWbc5cF1+h48qxzTCdt7wjmS1ZHLq
         d0p6T9FaLyvo3zZoR4E/qRtTG9e5CA0JKOMfxOstaI3eg1LIuIIOBMpKVxWx5YAO6g6j
         eNEOIbTmGnK2RKngkHI8OtDogpx04I01BcPwWI0JHqdJqOHJrQ6Jolh00t9l2NJs19Oi
         PiEkvmmup7Dp8Y/0z0Omsu6imgiEZ6xmsidbDfuSQ+jUW9hyJvkbfvveFOL0D/tBWdt4
         M09+qnzmVnZYo1oztkmfs9hixO43fD1a+G5iiO9vCHzq1l9LCns+MBH4DL1fCx3a7clY
         C4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748359269; x=1748964069;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T26QWxsDYRdwe+jygmvaCGYR4lil1tNS/Sd5gdRh8Tw=;
        b=CadHukjQwhGG+gl7Qay2U6iqOqq7CHqBeJ9Tb0COn8li5wjXktrtF0cG2onRjSpYaQ
         YilOaWkMW2kku1NP7poXdb8LmJhSVjn+4r8Yn3GxIAIv91QbdRjpbFL5mmy+TkWrxxB1
         rB7Krob3+QwUjsCrhQiragdEMTqVcENiv3q1YFIYKDkDE+HTfLBEwllE3LZ2xAsXXFcs
         jBIYuCTVOGos9+YKB9mGIyfiQ7lvgjW2EFyJoX+gNW2udpAZMFRm+DWRNw39mxebo2iE
         LXhVr6KDZkiwyzsOXUIHnp4rFHgr/LLlvAbZNIlqVYcWyalT3HnouS2TPcq0uVpUVtH7
         9tXw==
X-Forwarded-Encrypted: i=1; AJvYcCVQkzAUfNADVYypY7jMcfwEXf5KOidAMvWllGdbROAJnM8QBGAtL/dUEjUbgvzf4UaCaDbiSlv/A4I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEkknxMBl4p46QQRUk2eQh4Smy3sfcXUs2bitoUpqtvahVdKjv
	QkNxOviBymr0RBW7ndu+N4Vc5hLxofqxQkGdp5J0FN/pmhrUL9DIh8tmIOPPHTYBuIlAbMm0Ikn
	g6E62T7ZjGrDLkxAWDUGEefD6JkWjbBlioAxoERAucT+CdVYVhHS4yJeK7g==
X-Gm-Gg: ASbGnct04JNZzSowB9AGWwpDp7vMCvEw+4aeZtKiF6YAdAGjfTpGsYz7nzCCdTdmjRn
	Tl2/FRa2Nvq3OvqoqB2zsjDu/CM+PhGJ818TjxI1RSyFYdTnWg+V3cUuUQ9ts0Lv38xuRb2dVvE
	UrtKjs/g45wVQct/FFMuhcEO5PCwMeiBTMVQ==
X-Google-Smtp-Source: AGHT+IH/iWKlaJIOwwRRhHBUl6rn1YTO9wfSe6HoJ7K+FHwMi4NybUGi3rIIMKVONDR+tqmdCwj/bwwpq7pLo5d6Rg4=
X-Received: by 2002:a05:6902:20c7:b0:e7d:d151:e556 with SMTP id
 3f1490d57ef6-e7dd151e722mr592915276.32.1748359268966; Tue, 27 May 2025
 08:21:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104060722.10642-1-quic_sartgarg@quicinc.com>
 <konkbi4hvd7qc4rhokwrymzqntroy7gijk3ndwv5rluswdrykp@xsafrtrjzmuq>
 <10c90fee-ce7f-4034-9028-4252f19cb67f@quicinc.com> <CAA8EJpoLLDXFQk-ViuaioKrECzMV0aUrcOj4v+Ufs4oHY53mrw@mail.gmail.com>
 <064d3eed-c2ea-4b41-85b2-d2a5a922f8c7@quicinc.com> <ehgjdszjr34xppmkrkicb4pnq326nor26tqu2ekop6ew2j3y3h@pm45aiipzuc5>
 <48c73675-a73f-46f1-81a9-f701a2cf00a5@quicinc.com> <c1ebdaf1-92bb-4f73-bca9-35246d7c10e1@oss.qualcomm.com>
 <ca83b841-aea0-4233-93fe-02a7b5985af4@quicinc.com> <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
In-Reply-To: <1a0a5178-fcf0-49b6-8e4c-1393c0f4f229@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 May 2025 17:20:31 +0200
X-Gm-Features: AX0GCFtNeoZFAdW7ml0tNasl6TrIjJWlidTZH10tWfMXfVPVyLDdbwWdfrkKgJc
Message-ID: <CAPDyKFo9gUOB0VhQn=zD0RDM0=8wO08=VmA6XkHv0EN7M89bjg@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-msm: Enable MMC_CAP_AGGRESSIVE_PM for
 qualcomm controllers
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Sarthak Garg <quic_sartgarg@quicinc.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_cang@quicinc.com, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, 
	quic_nitirawa@quicinc.com, quic_bhaskarv@quicinc.com, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 17:41, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On 21/05/2025 18:36, Sarthak Garg wrote:
> >
> >
> > On 5/21/2025 8:19 PM, Dmitry Baryshkov wrote:
> >> On 21/05/2025 17:35, Sarthak Garg wrote:
> >>>
> >>>
> >>> On 5/21/2025 6:25 PM, Dmitry Baryshkov wrote:
> >>>> On Wed, May 21, 2025 at 12:46:49PM +0530, Sarthak Garg wrote:
> >>>>>
> >>>>>
> >>>>> On 11/15/2024 6:53 PM, Dmitry Baryshkov wrote:
> >>>>>> On Fri, 15 Nov 2024 at 12:23, Sarthak Garg
> >>>>>> <quic_sartgarg@quicinc.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> On 11/4/2024 4:19 PM, Dmitry Baryshkov wrote:
> >>>>>>>> On Mon, Nov 04, 2024 at 11:37:22AM +0530, Sarthak Garg wrote:
> >>>>>>>>> Enable MMC_CAP_AGGRESSIVE_PM for qualcomm controllers.
> >>>>>>>>> This enables runtime PM for eMMC/SD card.
> >>>>>>>>
> >>>>>>>> Could you please mention, which platforms were tested with this
> >>>>>>>> patch?
> >>>>>>>> Note, upstream kernel supports a lot of platforms, including
> >>>>>>>> MSM8974, I
> >>>>>>>> think the oldest one, which uses SDHCI.
> >>>>>>>>
> >>>>>>>
> >>>>>>> This was tested with qdu1000 platform.
> >>>>>>
> >>>>>> Are you sure that it won't break other platforms?
> >>>>>>
> >>>>>
> >>>>> Thanks for your valuable comment.
> >>>>> I am not sure about the older platforms so to avoid issues on older
> >>>>> platforms we can enable this for all SDCC version 5.0 targets ?
> >>>>
> >>>> No, there are still a lot of platforms. Either explain why this is
> >>>> required for all v5 platforms (and won't break those) or find some
> >>>> other
> >>>> way, e.g. limit the change to QDU1000, explaining why it is _not_
> >>>> applicable to other platforms.
> >>>>
> >>>
> >>> Thanks for your comment.
> >>
> >> No need to.
> >>  >> I agree with your concern but for me also its not possible to test on
> >>> all the platforms.
> >>
> >> Sure.
> >> >> Lets say if I want to enable this caps for QDU1000 for which it has
> >>> been tested and on any other upcoming target after testing, then how
> >>> can I proceed to enable?
> >>
> >> Let's start from the beginning: why do you want to enable it on QDU1000?
> >>
> >
> > QDU1000 is one latest available target where we have enabled this and
> > tested. This has been enabled to save power.
>
> Isn't it a powered device? How much power is the save? Is it worth it?

Just wanted to share my view around this, in a slightly more generic
way. My answer to the above, would be, yes, for any battery driven
platform, it should be worth it.

Unfortunately, I don't have any fresh numbers to share for eMMC/SD,
but just searching for some vendor specific information about their
eMMC/SD cards, should tell us I think. In fact, this problem isn't
even limited to eMMC/SD, but rather applies to most flash based
storage (UFS/NVMe etc) that are used on these types of platforms.

How much there is to gain, obviously depends on the internal behaviour
of the storage device. Of course, the number of cards being attached
is important too.

That said, enabling this feature (MMC_CAP_AGGRESSIVE_PM) needs to be
done by taking into account that being *too* aggressive (too
frequently) with turning off the power to the card, may cause a
potential wear-out/brake of the card if we end up preventing it from
doing internal house-keeping for too long.

The current default autosuspend timeout
(pm_runtime_set_autosuspend_delay()) is set to 3s in mmc_blk_probe().
That seems way too aggressive in my opinion, so perhaps increasing
that value to ~180s could allow us to enable this, even if 180s is
just a guesstimate from my side.

Also note that, during system wide suspend we always turn off the
power to the card - and we really don't know if that is too frequent
too. It depends on how the platform is used, compare a laptop with a
smartphone, the frequency greatly differs.

Kind regards
Uffe
