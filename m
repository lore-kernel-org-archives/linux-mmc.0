Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887D22EFB
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 23:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768212; cv=none; b=bVN1sxa4ZqnVPrVLVqR0wFdMi08GViaFRyZTfy6Rt3uT0jf3NQvkOVn1rLm/8gOWgVd0BhKZR+VZKXNwK2JyJJ0n/TYVpLEcqo2BpfZIPj+NM0DofBq9o4gAYl3DXDB5ywb6ZEAtItnnQMv1csgNSXJiiWxR63/ra53Vy+iG9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768212; c=relaxed/simple;
	bh=+Nx50Rnz3/XlK68LVUNUHXjbzKpSnQZRHmH74zypZtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCmXRsokp0PL7+rWMFddJHu8SuVdjF2cWytu1jvxjvnKFHwAHwokvF4W4+9Jg4BqGHLHlIEVQgucTQ/MnJoMLAk3di0gBiIZtlB/qTUCWj9x8/S7JPoeoaDZAN3nT9UN5bZ6+aun2hSZpREIHaMlkvRzXqYs1uD2D2mKYAUrLlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xRbB9T79; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xRbB9T79"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso253381276.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 15:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709768209; x=1710373009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wpPCiCH5cmwsa/faM+4qtvxNPZ93fb+FSCJztY7spGA=;
        b=xRbB9T79BbpD9HOviY1Quww4okCcuL94pvvt1yRqSUbCq2LdN1Y59BDikmtnPLSCaC
         EGMMn/5SVmMC9AwyUClYCN0bZQiqVJW7iA+yWGzVMdo8e+Uy34b3tY1MjgrIU1e27lqy
         ZCOFgsTltPAv8QLlE2hMlB/fKBefdoQCOZoQhPV/hvU63F+6O4FaCXZUJ7l+4dlz+utS
         neYtxU3cpeIBfxktl0XvlygATJ5zpBR33IEQTd9Xsx+3tENo8RhfdxSB1nTeGl+T+xbp
         PBJ2BhreOP2XKXBacoT2Fb8Y1ZRBJksZxZxei7pyQxjXnFZxieRYhyNZTtVysTsobtpZ
         7Gqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768209; x=1710373009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wpPCiCH5cmwsa/faM+4qtvxNPZ93fb+FSCJztY7spGA=;
        b=xVS9Hm5K9+pgylDkEwG0yLszrUCiLiSzMc/m4zSDH9ttMEuRx90IMX0OV74yDykM0L
         UUiBeN1Qn/N63mr0rdBLhcQ9NQkJvpPFT0ubtq1hfPDXWNfX0hckqdwixh1RDTWKwN/p
         b0n9dg4rorvs2PHFYbdw2VJ7jxSKVEAr26QmVkBaADWI8Z+I4j1J0VTKrzi/9F2Bxqrh
         7M9aPX2v5W5dqd3Ot5WzPPnM86iUY5PVqx66mrDA9V/CwEMR650mISI/FLILX+VaJEUH
         F90ih6OR52EdE9yyjgHtw9c0vQY9+gbmrxsghMeQbBDGHYVJvZkgC9sZH0jEHBd3Qygr
         Hzdw==
X-Forwarded-Encrypted: i=1; AJvYcCWKEvhH+5B00kWTwPNaZDMUrY45VtY6ZXsT4N2yvK8hfhMdmE2g3Wif6VcOdROaFltdLYHD6OPJzcMV98vqT7A6R1kyYY+M/on9
X-Gm-Message-State: AOJu0Yxvr+J4+V8vgTDJ5HdH0KXsRlJrT5VAaQpjjZdAEXuybB8WGF2a
	brCOUkKaNUH1K+9EY9nsOvvriM3lShMtWWKXz+5l7egrhZ12hyBrXouqxSgkLeaeFxVApMaH+IV
	lil3rscSEGE4Lb5le6/c7HKdHrsAR3SmOboHBPPH/yefm5/mz8XI=
X-Google-Smtp-Source: AGHT+IHxdBBSeU/FWJXQoU5bYG6J5Znkxe2V8jpauvmmd8v3jfVHkDn5L/goLsRDrRyEdQX+qgOtS/LXCu5NgOFa8hs=
X-Received: by 2002:a25:f30f:0:b0:dcd:6dea:5d34 with SMTP id
 c15-20020a25f30f000000b00dcd6dea5d34mr14988569ybs.36.1709768209672; Wed, 06
 Mar 2024 15:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <d5c07950-6f42-4ac9-b0d8-776d444252ae@app.fastmail.com> <CAPLW+4=T1eGrWQcEJWvOcHgq9tnRhfi=AH_=qj1022k2WHmEhA@mail.gmail.com>
 <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
In-Reply-To: <CAPLW+4mVTvPBW0hd9pV6AsSezxPAhwPByq3WmGpprtseTgy-wg@mail.gmail.com>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Wed, 6 Mar 2024 17:36:38 -0600
Message-ID: <CAPLW+4n=7ND_Jijfxzi018QwACGhJe4UX2VAuDUd1tuO97OHfw@mail.gmail.com>
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204 blk_validate_limits
To: Arnd Bergmann <arnd@arndb.de>, Jaehoon Chung <jh80.chung@samsung.com>, 
	Christoph Hellwig <hch@lst.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, linux-block <linux-block@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, open list <linux-kernel@vger.kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 3:18=E2=80=AFPM Sam Protsenko <semen.protsenko@linar=
o.org> wrote:
>

[snip]

>
> Sorry, just noticed I commented on the wrong line. Here is the change I m=
ade:
>
> -               mmc->max_seg_size =3D 0x1000;
> +               mmc->max_seg_size =3D PAGE_SIZE;
>
> for (host->use_dma =3D=3D TRANS_MODE_IDMAC) case.
>

Just submitted the fix [1]. Please review.

[1] https://lore.kernel.org/all/20240306232052.21317-1-semen.protsenko@lina=
ro.org/T/#u

> > [snip]
