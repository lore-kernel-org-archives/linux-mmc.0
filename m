Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04619AD5A
	for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719239931; cv=none; b=tvGWLdzgeZn8YRBq+ErsX1d1OCJmgr5jtLh2KWns5KzZ3omlExqTEGkDurJ1l0wkWiGSKDS/wskX1jUCsB5CPorqG509T8PIfORogDn0q1cI01vNmPuFiQfTKdgiU3F8S61chpM/mII7B6a8r1VQ98k4iJvgRmkzrHA359Ic2+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719239931; c=relaxed/simple;
	bh=oRKALiFLGbNbRt30ag38bGBsAVNenwShpYyG66qM/JM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iLI0D0l/UgCJTmAajKVugCUEtzBrO1PvN+ry//YMFzq7FXMf6RNRWAG/PTw/RAII8aP+0H1N+ZtASX+FVg1E1TGyOB7VqwDDGTNoWVLoFo+vWW6ai0tWdvT65C37KKdKminrEgQyUrxJ93UMcBE/bGTPTn84vFurM2D408dDG+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JbFBAi65; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JbFBAi65"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso4199841276.2
        for <linux-mmc@vger.kernel.org>; Mon, 24 Jun 2024 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719239928; x=1719844728; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vmMnfd32jVoXr5W/j7cUFMoGzSIMEJh5cwe9OGAkiAQ=;
        b=JbFBAi65dsi1wngLW7gJK08pnX2HhVUw3+aMXCGPmm+u1ZFm6ufRvaUX3xr7oPrHkU
         I9kWvPrgP8cVNS6at+cMvG/Cd3+EEzusQdTc6Is+Rs7JqeMQb8IlAMYcQ8lqLFhTZoX6
         3iXgukQongvBD+rFwnI8aI4iXE/Bjiuq9IzdqDQ2AFuNwLM33K1Csf+gMgPmZQQ6hv4d
         JCFuaAkN6Ooay38gTNDB4bpPsF7bt/tzLSJ0m1xA6A/TCQKwErXgf8DLFaGIyuIFUaN+
         CbWHf6Bf2kSTNvQLvQuTjsjgtVT24FmfbmTKilU43WDf3e0YJeQ6egWodSctqjCxLpdS
         UMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719239928; x=1719844728;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vmMnfd32jVoXr5W/j7cUFMoGzSIMEJh5cwe9OGAkiAQ=;
        b=Vw8KwMqhJphPS1t/Z+u/tf9x4n+bV8eBzMeDQoAviFWsR6BzGCtELbmNRuE+/yEZpM
         4rhr+2h63AJHVYWr4gnv1K7hpkTE41NfQeLVj+0/PBAOKQpuwLYNnr/GkzN+g72ESLIV
         HgxR0ri7IQJUMI0Eb3RCr5HjQeZavhTQLFvNgEdp3fRb7aHIVo3DykO1OVavC4KlKEn9
         P2JRu3dvLS7XyaVnALg8Ur25u5zPm10/hviVOwAqSiRNpfBabaPNe+0Zmhkb7ktr44AK
         VTEBpEK8ndh/DYmtX/pWA97m8+R1oS1h/SxKXceBqMjt/QLerU4D+3EWKhPQlSvpIdMZ
         OH+g==
X-Forwarded-Encrypted: i=1; AJvYcCXgDWNaeUN7rS/NaP61cQzmPBfLGmOzNmlbG75eTbdrlK3qO35YDQOOuD/4jZuskBhROzugn9mU3r9AquFarTACBdFMMZfoXM7t
X-Gm-Message-State: AOJu0Yw+vXD3vGR2M5EaAV6mMuedHwDTTz4EhqVu/wqFnntBpCMIqrjv
	TCrDGtEIaQkymsUci+dgPj6BIAlCRDKBbWBuU8Tyce/7Gn/rjnRrKzyFrZ0ETQzpXNh99pRFA3T
	JRtIz93V4phNxXN06JbNmY78+LYGp8gTqrP+Idg==
X-Google-Smtp-Source: AGHT+IE/9NE30FYdzg/te3IbXAUnABFqsCL6nY9cqP8UhgfpAkBO2Zzgf3XzPDINQfT8cqy63IvhfFUGNCqohKUmsfk=
X-Received: by 2002:a25:8042:0:b0:e02:9b7b:8706 with SMTP id
 3f1490d57ef6-e0300f7c64dmr4992968276.30.1719239928611; Mon, 24 Jun 2024
 07:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240618225210.825290-1-allen.lkml@gmail.com> <gw6adkoy3ndjdjufti2gs2gnk3xdgylt6tnia2zha76hsgdwtq@dr3czbxjij66>
 <CAOMdWS+p4Dt2xDGWvwoXtWinsRZintLwPmADddbsmaEfLvRQkw@mail.gmail.com>
 <ay2rpumtfxtvx4qgkgal7a7z46dbtwjnq4ctik55neseirkhfk@gkylcwud6vry> <CAOMdWSKzd1nt832+FHtwcMLO1rtgEC99Xz-wvNWGtXiyA8uK7w@mail.gmail.com>
In-Reply-To: <CAOMdWSKzd1nt832+FHtwcMLO1rtgEC99Xz-wvNWGtXiyA8uK7w@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 24 Jun 2024 16:38:12 +0200
Message-ID: <CAPDyKFqwq59x1tsut0gQiAd_sOqJcFk10-ytFYD41gx=Wb-q_g@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: Convert from tasklet to BH workqueue
To: Allen <allen.lkml@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Jun 2024 at 01:09, Allen <allen.lkml@gmail.com> wrote:
>
> >
> > > If introducing the pointer is the only way forward and is an
> > > acceptable solution,
> > > I can send out a draft.
> >
> > My proposal is that I take over the SDHI part of your series. I know the
> > code pretty well and I can test the solution right away. Your draft
> > seems in the wrong layer (conceptually, technically it should work), but
> > I need to play around a little. Is that okay with you?
> >
>
>
>   Sure, happy to help if needed.
>
> Thanks.

Okay, so I have dropped the patch for now.

Awaiting a patch from Allen for everything but sdhi, which I then
expect Wolfram is going to send a patch for.

Kind regards
Uffe

>
> --
>        - Allen
