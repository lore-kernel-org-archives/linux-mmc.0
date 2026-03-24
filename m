Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1C3F7A86
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355043; cv=pass; b=iJFcXgtuSXjT5olMJlBeYTimP9hKxsRZXzyDs3Ri+LAsSPxqeJ41Np1NCfI42IGrxx38NocueNlsg0wV9qqrlswp/H+7vaBycWWLIeM0xDSjFxrxS5trfXz9rYL52yxAWLucQHNF55/o34vsK4dWdpIKj2Ecj71bg5Td9qU7LF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355043; c=relaxed/simple;
	bh=ieyc8omX4/gg8yYj46gen2DdgnL8uKB6zkD2F+pOxsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U15Zl/8uoZI91yEf0Crle7s+limDadbnfNoWq38WC29LhWg8d26er7rzOAUYxkP5l7oPZCE65q8amiplkyrHxH17rm9rTjCX08T/DhjOcAKy5C1TBPn0sJIBzA87reFBZ/aP1ZrD+qF3PDdAOzWf42b2tESMQi7MzGEk9BZYIc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nzFV9Upg; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nzFV9Upg"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a27dddecb0so7276916e87.2
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 05:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774355038; cv=none;
        d=google.com; s=arc-20240605;
        b=KB5sIdgnTAxD6GWwkfzdn0qMOvrYoAiZcOsElwynSq55/sbxTHW1/BTluXpyzhlIK2
         viTvz/ltDI8J72cfcT5fy7j8bW1Ha2ppMWxBYzkJNbt4RvW/YQJaipbziidYyAw7AuHp
         BC582bdinQ2bA2YYF1fP8Kv0BDKMX8nfgyQeBBJBLRlhSuSMk7uM8pcdcJGC+Jb9XSyn
         kXJ6jcOY2Ea6JEJl+d69g5nZi4nKthQBUxND/JyKgnEJZSDGnG3no/aNBYQM4uoG1WMj
         0u1disEpZgV88iwEYnkEGfSokD3RcdYWZ2QRygMKP7ZhuHuq3nmIKo/44o+VKRpOaTMw
         obug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ieyc8omX4/gg8yYj46gen2DdgnL8uKB6zkD2F+pOxsM=;
        fh=RqjU+aKg6d7FDMxf/RHt/YgElujEarGODhVhCSGPBhU=;
        b=gvs+q9bE/zyCcGcQ3lPKw33K0GTNmEwYs141vI3fPvkLox+gkYauQlR2sLr3nQ2eZP
         hAKYdEIsRiC+whoE3hmTQz6/8/+jbjNqX0f26Qh8VEEsm8O1349MRCSclaYRnZ51P+I1
         vpIeijrtuuTfQvIkS70t++9qjcuRsQCfp3AXiJY/wl7gb7l2s5zS5biAU8AyW5XS8pRK
         sKmcfp8LQ80ALiTxtHr6AyC0kXSXnsh5i/uESt/2MHyVqF1u5lbjWlwKMgjvVjyzxKgE
         xqM1lvEuHtHvXXPD7KFXUsBERCnDv37P9dQN1f2tWCtLT5rMz8OmZ+lAsJPdg5wK6ruI
         zOPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774355038; x=1774959838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ieyc8omX4/gg8yYj46gen2DdgnL8uKB6zkD2F+pOxsM=;
        b=nzFV9Upgu3yNgqQ7eyTH57i4SBqG7MYbxytmQ+xyDA+CNM9EOXvHe8z0UQpdvaG5eZ
         uizc5Dd0MQXdmj+z76sANCeL5o32BZNVOhUgsfTn5ZvBHM2FM8g8LkKQlQEgPObZcJP8
         nhrObpISUHdulyVPTUpTPu6Vy+ztcE2VV0G08AqMGw/koMKfE4wUsYmaYiqm/Me9tPaE
         gsyeWYxUeVGy+JOaeJ9wBAt8wzSlUxhHUxvHihBqpSU6NVAmF5XuHjpxkEKYz4JsS7ug
         SGWv/iyVeTZJyh8C1tFGRy2pFjhWAZMR0GQT2TO4uSpPHcKIWZpj98tJ8dlLstXSa/me
         bgWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774355038; x=1774959838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ieyc8omX4/gg8yYj46gen2DdgnL8uKB6zkD2F+pOxsM=;
        b=I+qrNFIIlMFLGawFA4bY4GskR/D6zCy/lTByPjoGqzMSd+Tp9pCfNrqtaIiAmeG3T8
         m5jfaSctQLdnhCAcFscDTIbVfEc4pbFFfxv7BDHJA0T5UuxbGqwTwfSq5CkqiiXOwXZy
         VuGXpBQnaCeOIKA0QyLYVZd2gh/09LXW5RYCxrEmDnve98ukkPuZj+NoNVdrOYUTDAvj
         FispiLFBRNITwtcsklbqCMToQPAf/RHbU6Mu4aKZ+dQJi2NOLRY62EFfgj3227fXhoZF
         7dfKSobCs7z4iSJPHUI0ihgxDnWOMq3wSIuQtt/3USsuqfNxVSU04mxq8Mkdl1QnodNi
         c+tw==
X-Forwarded-Encrypted: i=1; AJvYcCUK0mag9tVQDeflLLgFv/PVQJnhpTZNtuTZazaVbZk0047AoMvy7S7z27mnd2UqQX7KbJEbTaQd4L4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIyFkrpBrlcIC4v2rW3XmTdVFNB9eRqQD/h4v3KPLyZSdGlZF5
	vBAaNUHskIlSoYm4KPYm1fY/lBJGqJLWkTr+OQmy9ACjbqweyZGNctaCVS+w64Ar36VNUikT2jA
	H6ok8NKmwVz8c/P80wQh9rNIH0Qtmq7ZNeVCWZlHBFQ==
X-Gm-Gg: ATEYQzyVZi8YsKyJQbXiDYY/at4qEM2W5n2lojjrZ7TRUvlLnQlQ8zmWLTkEavFI/ks
	q0/x5QoS3zArr39t7v2SmsoSA8uLFXOLJEetSIGVwWIsn2woaxPT7F+bOW4pLDyHj1dGlhH5dMJ
	f5FW3aT83C2zvInFyMr8Ho9goDRZFIGxWIi3++YDEkasOyW6Xplr5Ve5Va8I/6HVmCIpbqrjGJD
	ol2aAvgrlfHFDyBmDeWZrhiFKpfxavfjfEH4yXMONeDN+04iUy6laLQOTS3QMs0LpPOCrz4vzNI
	LKsqy7vR
X-Received: by 2002:a05:6512:158b:b0:5a1:22c7:b667 with SMTP id
 2adb3069b0e04-5a285b67f4fmr5744670e87.45.1774355037520; Tue, 24 Mar 2026
 05:23:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260305194052.5120-1-sean@starlabs.systems> <20260312121559.19197-1-sean@starlabs.systems>
 <20260312121559.19197-2-sean@starlabs.systems> <CAPDyKFpueaHyaOGn5Fn_JdnD4kPeBsDcGx8ykgnuyJ=CFPyxyQ@mail.gmail.com>
 <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com>
In-Reply-To: <CABtds-26cuCMZbRhAaioOOCcX=w6J_mpCxgxahjwz7QJEZqe5Q@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 13:23:21 +0100
X-Gm-Features: AQROBzA1ufZV_pwSc0w8MoBrbbgIFMDMzADi6QwT3YhT3LLcK5KLLsi5gYVS1vg
Message-ID: <CAPDyKFrjhNj38dvvf5AGjCxSKkX02C-B6h4+dX0iOxyOc+Hruw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 12:59, Sean Rhodes <sean@starlabs.systems> wrote:
>
> Hi Uffe
>
> Thanks for the feedback - to answer your questions:
>
> > Would you mind elaborating on this so I can better understand the problem?
>
> SD_CD is used for presence, but that's asserted by trays or blanking cards.
>
> > What prevents the MMC core from handling this correctly?
> >
> > Don't some of the commands time out, eventually causing mmc_rescan() to bail out?
>
> It does bail out, but SD_CD is still asserted, so it tries again. The
> main thing this breaks is S3 entry - it's either slow (like 100
> seconds), or never gets there.

First, please don't top post, but reply in-line below so we can follow
the discussion.

It's the mmc driver's ->runtime_resume() callback that calls
mmc_detect_change(host->mmc, 0).

It's sounds to me like the mmc host is being runtime resumed/suspended
over and over again, hence we end up calling mmc_detect_change() many
times when it's not really needed. Right?

>
> > I guess one key piece of information I'm missing is what happens when the mmc_recsan() work tries to send commands to initialize a card, when there is no card inserted?
>
> They fail, and we use that result.
> On Tue, 24 Mar 2026 at 11:26, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Matthew Schwartz
> >
> > On Thu, 12 Mar 2026 at 13:16, Sean Rhodes <sean@starlabs.systems> wrote:
> > >
> > > Some Realtek USB SD readers with a tray can assert SD_CD even when no
> > > card is present. This can make the MMC core believe a card exists and
> > > trigger unnecessary initialization and suspend/shutdown failures.
> >
> > Would you mind elaborating on this so I can better understand the problem?
> >
> > >
> > > Debounce the CD signal and validate a newly detected card by probing for
> > > a response (CMD0 + CMD8/CMD55/CMD1) before reporting it present. Also
> > > treat SD_INT as a removal indication even if SD_CD stays asserted.
> >
> > What prevents the MMC core from handling this correctly?
> >
> > Don't some of the commands time out, eventually causing mmc_rescan()
> > to bail out?
> >
> > >
> > > Tested: Realtek RTS5129 (0bda:0129), tray inserted, no card (2026-02-24)
> > > Tested: Realtek RTS5129 (0bda:0129), tray + SDXC card, mmcblk0 (2026-02-24)
> > >
> > > Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> >
> > I have looped in Matthew who recently worked on some similar problems
> > for the PCI variant [1] of the driver. Perhaps he and Ricky have some
> > input on this series too.
> >
> > [1]
> > https://lore.kernel.org/all/20260105060236.400366-1-matthew.schwartz@linux.dev/
> >

[...]

Kind regards
Uffe
