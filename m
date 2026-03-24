Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E78F3F9F46
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774358051; cv=pass; b=Uxd7u1ZNbZapGh+QSHyT35TmPmPHF6BuB7EiHvX/suQ9+ZFwheuvGYLLLfn8lSruaHK6GlxEF6Kz5MbxHcSiaueolY47WtUrczLCdpuNYpTCBlGC7qQrGVVU3Y/zMkUpzFqe2nWZ7yAgcO3btl5OqWPC9PJCiKZzIuzeC4lvR/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774358051; c=relaxed/simple;
	bh=BpY3bIwpj/TqfSrlXWVaqbuLGbM5rKgZ5VO4dJwLLkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZSD5OTyN4qVbmNKtQjxSroIZ+fWR3QDmJF/NrNkp8rz0Bpkf00Mhgw5Y9qIoTJ5GgZa0Z9XQcsxZjOaT4IbGk8COJqdXQr3QkGV2nT7J00qA6++E/At6Mksf1OWnI5preEArh3xUQy+L9/P/qyBQf5WeTMNN7iOoyd5yKqOAdnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b=nqFxaSSB; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20230601.gappssmtp.com header.i=@starlabs-systems.20230601.gappssmtp.com header.b="nqFxaSSB"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64ae222d87dso1258072d50.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 06:14:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358048; cv=none;
        d=google.com; s=arc-20240605;
        b=EKCKihSGaa9u+mjVZK0lKuSlOTJj1/jVnvih9HnL0OukUssKdw4OayP+XwxVpqLu6n
         8x3ZmnYOYF4shd3xE2D/dsJZUiGXV9GWumCA9d8GhyaYYj1lJJK+3ooYsp/UoW5Jzpru
         szBsyesTwVIh+eYqmSuWDzewYe8Z1c/HdIb4P/yly8Pb9iZY8gOk5Fv6NA6GivqD8CwX
         7ZlixcB9CTKjRwjo61LOHRZ7MW29BEVsvsV8Tw9pwBC7G23MCCAvGXc3uHjDB0wdQPEW
         gfMEs9Wh6uvu0K3qlhKfZMGBwIQcigjGKSXY9OpXd16yyTeMgg+KyVDJU/gayS/l0SYY
         XUtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BpY3bIwpj/TqfSrlXWVaqbuLGbM5rKgZ5VO4dJwLLkU=;
        fh=bObg1bWwiZMZAkgUO+jynknERWalymcR+ZE8UW+5KEs=;
        b=icy/Kzs2xVxDgL6t3xSZmlq/z5GwWIrbaosqGCOUm1e0hLRaT1CvnzmbuoDe6IMUL6
         g28zKvg7GsuyfM25I96EUHUthwmoN0odg2WM2jivHkC9z4QHAMTlJfEHhjbiX9TLyqM2
         nRHsuyeffB5CuAWEw7JQ5l5kJeCJymAoPYxj6SUELGh8UT7jw8qp/L38NgEbyFKo+Aqi
         QayaIjAlCUKvM30VfWrwA30quqs067WzinA87vO4uYsqhkq6RbH1VAiaE7Y4DG65S0hC
         2GCmJQTasoSx/qGZkoLNBI//phCm4AMUc4MtPOfq61KcbWWY4RXzhAYLnHASw5yG0MOF
         0w0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20230601.gappssmtp.com; s=20230601; t=1774358048; x=1774962848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BpY3bIwpj/TqfSrlXWVaqbuLGbM5rKgZ5VO4dJwLLkU=;
        b=nqFxaSSB7YmEd7eg+TbEEb0kHN3PxiJAzJicPGLiPqCc69BGDrXYWwhto84LHt0xLO
         x4SCRAB4PXjTFeoAgrOajrUjvAz1XXpMz97KAljAxrPuvOZmpCmxBBOuE6MBv68trKYK
         Yec3KOB2J352M6PN308k27r7g98joy5Ph8EME/Y8nReRVhQUF015iuUsSHSv7rHCjoge
         z5T9BeRGKpkt0zQ5i3p902CCVwSdEmpgmNXjZQRIKGWxdxufwyfQLMMOjXjMp9VQ8MkM
         0Nj2JHW3ATInOsrGatFaBFfc4D0LvNN3KYHOPHDWwQAE7bDOTRLrvQc1UiCiDKtSPHvf
         tagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774358048; x=1774962848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BpY3bIwpj/TqfSrlXWVaqbuLGbM5rKgZ5VO4dJwLLkU=;
        b=XqGpW8hw0R4BInpEaJGQ902ECFPP8zoiiCLWXRGR2k/scDrIkZ7inpWsFy/NZX+BUA
         i/vmJfZ4ylNKfnmjGOTlGtmgZrcS8flY0cD6mmW8ojiLnrdNcp7bBfvtxMGiZU2KERU1
         52iRb1TofGj6zaondXZCdWjWIlOj1+DOOOyXpDNjepjiISNlyMoXkxzv2d+YSoG7oVlV
         vCK4TsWbcgJH0uza9phcfvKJ/UzFwvCh5m1Vo0RL7ifPdvopTuKO3c6A/GSg0TDPAvML
         RwSbMF5yGgqxuOVq96NhgALSU+25g17w6btTam9LaCos+qbgaeevQKedpdWvlVEcf1Tk
         bN6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXCG3wWFt9zWDTWJn+j2bsKF8FzZn1s4Vfh2t5wV/17BIqh/ypcoNxCOqcZxMqtSC/sYngwsTPMdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszCh8iJ+D5wTYxFUZGgyzHug5+0moOkMVmToPzIAPfJE0hCCV
	jQWr1Uuq9I0SRrCNi65m9Fb5VMFauw8GVVfujeAewkzfZ8DI/SijFXNHQ6r+x0Loo8k8aTMaGu6
	H8ROF5md1kaWhBVaHuxU1OcY/yme6R7pzuQeXwhy7
X-Gm-Gg: ATEYQzzu5sNxpT6QfbzyW8uEIdIL7hzqMKn6JWA8JtleuKLSC2SZA8YvLIEuG+yma2y
	xrq3oBz9z19lxtOMWeXf8j/DNt4iQ4i2MDEI/DXK5a5KPpzvtO2CtsrW15Dds6loyl3NnB8KIAi
	6GqzaCNONMK9WixfRHOsDZq5qfrG/YCLMdfQRdp4UKCQnALY2Yol10nFHxTuaT9gOs/qdVN/nPa
	JdsQu8ZW4VGDTSOSBkmxlNOllU0gqx4IiS8mbMIrk/ae3btku7ec5Ob5W8eHwsU6qBAlcCtTGYU
	7XFV89FC9reWL2XUez/SVakQOxyk4ZawafkY+1XO
X-Received: by 2002:a05:690e:1189:b0:64e:8cd1:3b8d with SMTP id
 956f58d0204a3-64eaa88eb36mr16264679d50.80.1774358047949; Tue, 24 Mar 2026
 06:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
 <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com>
 <CAPDyKFrjhNj38dvvf5AGjCxSKkX02C-B6h4+dX0iOxyOc+Hruw@mail.gmail.com>
 <CABtds-2DjtJ=8GzNdi0ZOLPdBfGWdfeXX790o_gvNVE=d9+=Pw@mail.gmail.com> <CAPDyKFqi_Ayc3kffNHvhTmNSxjMhSAa7wr4rQuP6060ifH3y=g@mail.gmail.com>
In-Reply-To: <CAPDyKFqi_Ayc3kffNHvhTmNSxjMhSAa7wr4rQuP6060ifH3y=g@mail.gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 24 Mar 2026 13:13:57 +0000
X-Gm-Features: AQROBzB8LfS6U5dsc4lUEzBjUMz0p6W92MhE9WsgIxO6u8vijqtEdWAfxEaCcrE
Message-ID: <CABtds-3oovV9jP8uaQ7_=T4_BA7oEpkfT-tbDW18MEs0eLygzg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 12:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 24 Mar 2026 at 13:30, Sean Rhodes <sean@starlabs.systems> wrote:
> >
> > On Tue, 24 Mar 2026 at 12:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Tue, 24 Mar 2026 at 12:59, Sean Rhodes <sean@starlabs.systems> wrote:
> > > >
> > > > Hi Uffe
> > > >
> > > > Thanks for the feedback - to answer your questions:
> > > >
> > > > > Would you mind elaborating on this so I can better understand the problem?
> > > >
> > > > SD_CD is used for presence, but that's asserted by trays or blanking cards.
> > > >
> > > > > What prevents the MMC core from handling this correctly?
> > > > >
> > > > > Don't some of the commands time out, eventually causing mmc_rescan() to bail out?
> > > >
> > > > It does bail out, but SD_CD is still asserted, so it tries again. The
> > > > main thing this breaks is S3 entry - it's either slow (like 100
> > > > seconds), or never gets there.
> > >
> > > First, please don't top post, but reply in-line below so we can follow
> > > the discussion.
> > >
> > > It's the mmc driver's ->runtime_resume() callback that calls
> > > mmc_detect_change(host->mmc, 0).
> > >
> > > It's sounds to me like the mmc host is being runtime resumed/suspended
> > > over and over again, hence we end up calling mmc_detect_change() many
> > > times when it's not really needed. Right?
> > >
> >
> > Correct
>
> So why does the rtsx usb card driver do that?

I don't know; I'd assume it was just a shortcut or done by people who
didn't have the hardware when moving the driver out of staging (see
00d8521dcd236d1b8f664f54a0309e96bfdcb4f9 which works flawlessly)

>
> Could it keep the mmc host runtime resumed for a while and then we
> could add a debounce period to the call to mmc_detect_change()?

I might be missing something, but wouldn't that just make symptoms
less obvious? We have bad detection - why not fix that?

>
> Kind regards
> Uffe
