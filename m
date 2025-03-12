Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6708245015
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783585; cv=none; b=VwFJ9/+sPkJR93AXf1xoRm1KPGiKxf+kF8WW+7NgALHuILmjlKqeiTV4pW8ZS1+BzOMBOh+EjUsNu1NQrsfBtHqHvJ3kB4cxxaU0b650JLAzTskuSvMla+TgPea4p9reoCOT3CIow3nfXv9oWcr6OZ2G8Btmys+1DkL6z0mnBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783585; c=relaxed/simple;
	bh=rT44umO61lyoO9DXr5d6r9YQgIhVrLBNL/UeXtoUrIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Df/y76WJ8EVKSD3DGAHwgiQMahWIXRi8qlSBLNmljSGRETiZT0sngfKjr1CpuQaUSdfZZph1BCKx90abN76YKKdECCw3oYDAj/0fanFI7tNaXLZbb48OTyEvBYpqd+aawSPUMx3feKOZSYwW9jr4PvRoiNP7dWlnwUgrPjGhi7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBXkg9bV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBXkg9bV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fece18b3c8so39168857b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 05:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741783583; x=1742388383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sViwNg0y7WJ+KLoniXqlUQyEPHY29WVhHgQ81dAhe8k=;
        b=fBXkg9bVxiLbKt803cDZAyT2BivpWvDMKbfTo4aOYE58XTHZ+RaICPCEpwiTcGWI6D
         1oyLFSjMK7Gv7Y9sT+OIpQPTjMptna2UPe8dVpNipQEbtzK9C+YqQcc9/VVVnBQr7bYD
         RRXQO6XsS5vsBRU2S++FRVPatHvzJPI9b/BM8x6PxM/QMavc0L/NGKToh3hRZeilIDVS
         PD7q28EK1mL4VYHjDLCXmidRnerlHLXEQgNhrgMHpQxGs2cFbgB+G//Sbg81DEsjQUXh
         b8wQ+scBM0WjSf+uI1rROUr740cYwhu9TZKFtWa6YMl5LiNcQ+E9lbk2lDLDwEsJ6YdT
         zIBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783583; x=1742388383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sViwNg0y7WJ+KLoniXqlUQyEPHY29WVhHgQ81dAhe8k=;
        b=AtzypUHsPTln5CmQ9+52XzHj5s1Q+pDP8LzMEku9+UXoyL5ElMWKFztVAictxZcrv2
         bxExyRa+xG3WLfxqmbk9fgvNBTBGPgsav+UY9uSsdxLjgPpveUzmCRsF6GTIxZuLiWs2
         sgUBKOxnUZPJfb52Jc9YwRBSCLmybYKbeZnALK2rbVwvOFSpIyyvynm/sxfcPlmZkkJw
         MFU2mG9qwGBeMCTZ5VfLFYqtL1uS7dc9CL7HkCVwm5yk6+SobJ6RWn9plU1sP3YJ6vv7
         nT7ZKgeevEzAkTHc4Mn5BA1dGjWkzbZkQd/o9gn15kisZMclN23PgcA9cSJz2AQ0hngC
         A9uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrV+gKQqTfJQXGZp+Y2wondWVR2tOKuarOW7Vkmw5KHhUI1XpNc3GXVlaEFO5B3PySr2jd/kpbCFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyg/pKK/VkFadv2uKlEIOKyT3HHLrL2yEd8dDQlwmXF8w0iGs7
	muL3Y53vxCfHeIBEWiOQ/bVoE35W7pVkLkB5AJdT57F2uXvuOZbXQW4qf1dtMvtXFE3yP1mLral
	rOnwYMhZp5cj6Cp9mfc2QtJ/QszJAVM5WHbxuJw==
X-Gm-Gg: ASbGncsAeSrK90RALNfUQoY87GdTutR18sLEUckwEKzh891bjajLjeOfHhIJMYFVFU8
	lVNe8dR/3KWCUNLfV/wDRu8BKMRBafl9sKmmusZ4wPhkJTOgTQgJMOI2hi2Mwi1apCASiXcKBoY
	E3KRBgDPFM8PsMPsWoV1yqDeWxNxwiFoAZp340Xg==
X-Google-Smtp-Source: AGHT+IGiqudn7469ieWl0fYIyw1X/RrsRHpanX6PpeUzQpQMkBATHeep6tkZov6yC/rhVxxMPza+6xdWdKNiLVEN/V8=
X-Received: by 2002:a05:690c:6e0c:b0:6f9:aecf:ab0d with SMTP id
 00721157ae682-6febf3855d0mr286780647b3.27.1741783582701; Wed, 12 Mar 2025
 05:46:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922-b218821c0-26591b0a1008@bugzilla.kernel.org> <20250311-b218821c14-1185eb2dfa30@bugzilla.kernel.org>
In-Reply-To: <20250311-b218821c14-1185eb2dfa30@bugzilla.kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 13:45:45 +0100
X-Gm-Features: AQ5f1JoZ704oVPlplX-IdaUO-rTwZCcupvKIEbeBN4RARe8ffdvOevUsMFz33dY
Message-ID: <CAPDyKFoiYQAM5b+AGiebTbSW8GNs1ppjkYbAbs8mt1-kxX2GUA@mail.gmail.com>
Subject: Re: RTS522A fails with "mmc: error -95 doing runtime resume" on
 Microsoft Surface Go 2
To: Adrian Hunter via Bugspray Bot <bugbot@kernel.org>, Thomas Haschka <thomas.haschka@tuwien.ac.at>, 
	Adrian Hunter <adrian.hunter@intel.com>
Cc: ricky_wu@realtek.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 11 Mar 2025 at 13:54, Adrian Hunter via Bugspray Bot
<bugbot@kernel.org> wrote:
>
> Adrian Hunter writes via Kernel.org Bugzilla:
>
> On 21/02/25 16:55, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=218821
> >
> > --- Comment #13 from Thomas Haschka (haschka@gmail.com) ---
> > Created attachment 307693
> >   --> https://bugzilla.kernel.org/attachment.cgi?id=307693&action=edit
> > Patch for 6.12.16 which solves the problem on the surface go 2
> >
> > By reversing the bisected commit it was possible to me to build this patch
> > for
> > the current 6.12.16 kernel which yields stable sd card operation on the
> > surface go 2.
>
> I do not really see how that commit could affect the card, but it could
> be that it results in runtime suspend then runtime resume happening very
> close together.  If there were insufficient delays to allow voltage levels
> to reach the correct values, it could result in the card misbehaving as
> seen.

I agree, it shouldn't. Unless, as you say, it somehow triggers our
runtime PM callbacks for the SD card (mmc_sd_runtime_suspend() and
mmc_sd_runtime_resume()) to trigger too frequently.

We have the runtime PM autosuspend timeout set default to 3000 ms. We
are internally in mmc block layer reference counting runtime PM,
rather than relying on the block layer to do this for us. Could it be
that our autosuspend timeout gets overridden from the generic block
layer, somehow?

Anyway, I have suggested dropping MMC_CAP_AGGRESSIVE_PM from
drivers/mmc/host/rtsx_pci_sdmmc.c, to see if that helps.

>
> View: https://bugzilla.kernel.org/show_bug.cgi?id=218821#c14
> You can reply to this message to join the discussion.
> --
> Deet-doot-dot, I am a bot.
> Kernel.org Bugzilla (bugspray 0.1-dev)
>

Kind regards
Uffe
