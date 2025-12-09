Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE1F291C1F
	for <linux-mmc@vger.kernel.org>; Tue,  9 Dec 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765280605; cv=none; b=Ys+li3qjCqrVKFXpSPpdt9K6GcjfxdQnUnhRWQ5uqqcvnsNjpRtHeIoneAMOTQeiAoPeufffL3niRvrJISsj4hNT3aPzXoGdLql9KtLeg3gf7jKx3nBxQB6en30QSzRt0BLm198Ka0DXIulDbb0+doxzyO20N1hXOivBpzrP698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765280605; c=relaxed/simple;
	bh=zhrnE87agIhRlNwPWhwyYiQob26t8gOjkPLGUmWZPc4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=idWVEaYLyAZ9RKrUO1RcgYSfezXZ17Qaz4Kj6quZFJXbrE8dzCmf99b6PIjvMUf0SnozyRLEL6SqcDsNv/OJrvfNGqitykx/uO3M5veYs/QuTsH6Ojr1bCvTcAzYJCIi/2yEPXb6NLJUkIg+Nmqxf5ATLRWZr4rlLec+lezaB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fY4YjkSo; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fY4YjkSo"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6443bc360bdso4577694d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Dec 2025 03:43:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765280603; x=1765885403; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zhrnE87agIhRlNwPWhwyYiQob26t8gOjkPLGUmWZPc4=;
        b=fY4YjkSoJgnKc+FPS1XwHuMoe/XiYBSoNosimG560xAEPylpTnNZcxI0mLgG0Bdjc2
         Nh9ESjqO2uOO4/sT2F+9zXdXJ0mRWVtOMaMfLv44T4tGXzabtAokmb8NPXtF8Swh+9Fu
         4fMoyKX3SSGlj3FGUq4UHhWHvnWAfXuK9Zy2/oUbr8RsFpyz5vjhBu9Db/hU5HU26kAT
         vYMDUr84dknqSktxc1HzckZVRYGShHMk0F7bHAVK5/q3wHqtDDkKFBqNV2COYZPWB4CT
         ZNEUu/VZdilB3X4ohf0MaTisjuEEJEGt/UaGGQGkpuIaBZwaWOvSvgh4dkrmBqbQZSOP
         sKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765280603; x=1765885403;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhrnE87agIhRlNwPWhwyYiQob26t8gOjkPLGUmWZPc4=;
        b=mPehmuGx1Ru5+8Xw8+xzXDSPLuq05ygCU5vxIdUVK4tydTfwp3W4A4RRQuxPwzzsGM
         VmTAEf93Pfh3FhH5j5vgI4wEHoJVoeJpGFCgHZ6sTE+9s6fibOmiQDDSFrpSZ1VtAAfG
         cqxEcYUpxLtBuPSvMAwJ0mdht1dogasxFWe4egxZbmKKdJ0suFdrG68ZRPv2hl1Zf/eg
         NvUpOUDGJsjfDkXj7VVgIc6wiAhnkN4+xxIUJ6ESFoGAOcwsY1xjhIY6x/iN5LOpSEMg
         7tHmXOYDtcGj+fZm2Lw4AVJHNorEIUWjkdP5ZxDdyibZhqrdylAetWTQzRn+J1whwE19
         Z43A==
X-Gm-Message-State: AOJu0Yz4NGS7w62iO+aHO2CFEX2/YFVlIzfunFUqNIkmOmqDXgwdCfFQ
	I7ljFkfUL95dMpr41HH+fnhzjoCWsddVqefwKN0VuyU7F213ggbg5+zi+KDkjrQ4ViEyoZisKkS
	x9srL5Lpp6wEyoMIxpIts7weGTwUQ2lJf+LnVpwZUDw==
X-Gm-Gg: AY/fxX5I32nSsfeQ8IrYcaNFtZQV4HWMBkGA+zHDLDoedMuIfQSv3KDoJIQbnHJycc8
	gpdGidJD7AEGZ0YcBwNFbFRBBFoi4Pr7A6c38lxcra8NNTmI/vNWdWai0sX3QSX3FPezWuZjMYC
	5mxF11Ujyg2RhJr1SVGYkxYpXqEZxB4Y3RxXW3Pi8SVGyn717vkBWUJ6Kz5INBILy7gentATtlX
	qVeKR3K2L2MEW2Jj0HrgcxhTousUBlUcsRCV0gVXCAmJd+fcqWi5LKgIZ5SPrU1XrdK6fFG
X-Google-Smtp-Source: AGHT+IE8lMdwrg941EMEL7pSogOTLxSAzJjcVdEiKqXJTuUS4u3HbWyIwU7nE1/3VyTz06Ab2Bs5QhxGOlRsmbodEtY=
X-Received: by 2002:a05:690c:f8b:b0:78c:328e:eb2a with SMTP id
 00721157ae682-78c33b68e09mr210939537b3.24.1765280602561; Tue, 09 Dec 2025
 03:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251128052011.204735-1-avri.altman@sandisk.com> <DS1PR16MB675383ECC94C7BB9882B58F2E5A2A@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB675383ECC94C7BB9882B58F2E5A2A@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 9 Dec 2025 12:42:46 +0100
X-Gm-Features: AQt7F2rY-iVW3nMONsHfQX_PFmCz5v_59mMNF6WojjnZJ58vjGLUo7SZp-GDxl4
Message-ID: <CAPDyKFqzbDzhVT0aKaAPw-ioc_fj4nz0uG2cnPNV7sjeL5WiTQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: core: Extend manufacturing date beyond 2025
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Dec 2025 at 10:34, Avri Altman <Avri.Altman@sandisk.com> wrote:
>
> > Hi Ulf,
> >
> > This patch series addresses the upcoming exhaustion of the eMMC manufacturing
> > date (MDT) year field, which is limited to a 4-bit value in the CID register. Under
> > the current standard (EXT_CSD_REV=8), the representable years end in 2025.
> >
> > The first patch implements the recently approved JEDEC standard update for
> > EXT_CSD_REV=9. This update rolls over the 4-bit year codes to cover a new 16-
> > year period, extending the range up to 2038.
> >
> > The second patch introduces a quirk to handle vendor-specific behavior.
> > Some eMMC vendors are not yet updating their devices to EXT_CSD_REV=9 but
> > still need to report manufacturing dates for 2026 and beyond. These devices re-
> > purpose the year codes for 2010-2012 to represent 2026-2028.
> Ulf hi,
> Would appreciate if you could look at this before year end.

The series looks good to me. I will apply it as soon as we have the v6.19-rc1.

[...]

Kind regards
Uffe
