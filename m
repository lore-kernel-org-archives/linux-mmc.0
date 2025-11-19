Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B49C341051
	for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572593; cv=none; b=rjyiCPDsJFS3tEbmAS4jLR7/kPedkpSUtEGZtbZIojLlUQLqpyveKEvoyPnE1/6w9HClJrZ2SXP9kpzK6m9b4D/symmbdj0qAfAMdeA4m7oPdfqUilHyLrZKj9MDcvLQl+ERsTtK6homAiwfWEim7nVz9cIGUGIB7pdkkZJpHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572593; c=relaxed/simple;
	bh=/JqEuKhBHMI5iHyyK46XY6A5LLVOk8KrFHw4B06AGpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UCUJbt9BTymHeHZjW+Z0Bgpf/FXbOK3L4ZPJCGXzkBkiraxMcPnmf6VqOy+z4a3JHbN3YK3DAaUO6ynh9ZndmG1GeBQ97ex1sqi+bEmoVC3/DPDFZdspTndt2tCuce2EjUj2JzvRt7/7/4GCJ2RBlTwboqZzSh7pJNSYt80Hmmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=htLByv0X; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="htLByv0X"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-787d5555274so70329647b3.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763572589; x=1764177389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JqEuKhBHMI5iHyyK46XY6A5LLVOk8KrFHw4B06AGpA=;
        b=htLByv0Xy7riEn6zYoZizivKaNdcvobrRwoATritYefyhzqk7P0/ohk3DzCi0TZwAI
         Reh5azd9L+cI3EUwI1hdwQhijGg+kBzNdwMK3rRz1TuWFXtONzssOfqYHoPYUH2XSDLp
         ZEFdxDqWotjfnBASrXNlJZW2PYZBsP/87L8GTQIF8f8hgfvLBO2f+WC36tkTVnGePY6v
         4denyG++0CQZQi/wzdnhFXFWS0z7TGS64JJLSseO7XwtI8QUAk7g/KRQ0aYKW5FSIsG7
         ZUeKGyeuMWve+GDKZi+AslCF2VqLCobet4ElLlG0hwqaicQECZW59A4G9D7DdGFB5PgU
         l1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763572589; x=1764177389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/JqEuKhBHMI5iHyyK46XY6A5LLVOk8KrFHw4B06AGpA=;
        b=Chz5MiDByD5udGZQuL/8+BqE5H6MmeMOLzoH9S5wFlOiWH25l5oPPiNiuH9vaTkE5w
         oMlh4JqeOeP7F+SxaXHkihIGwgCyc5mFBznl9Sl8ihGYni/zZRFgpG9gGKVijUDI6p+I
         MNd0tt7JO71SU1ax5FPRQQa1+ZXtUZTZ0LmnMxbF7ufB44pV3D0UwP8wqnlGRSNOKA8s
         JYmQsnAGbz7HULe/CcVH0hXhc1+gyqiCfXaaHOEnAEk0dQ76HvqDVcfCAL01SahAgkp2
         3JVD+2Mb9C6XpzQMgUWhWiFkYBAiDUa7VtydcZVKlF2gqHuA8moGNCJsiFEoBlmTQhsH
         IRwg==
X-Forwarded-Encrypted: i=1; AJvYcCXUVZDMFT8JuqmouRbjXEfCl4TIPPodJSs/1Dhds07C8FMoFf2gFPaJhbwz4Hbu6ZEilNbfFBuMe9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm6y6hTUs+ZSL4SSwqEM1U3/oFCVk7Y3wf7rlU6Sp7WCWS5mtZ
	f4Iky+rKMDHcqvuzC2HMqi/AgV0qft/W8P3X+mQqyvrdnPcjn/idLrgz1EGO1Q7S/XaObCrvcOM
	p8eIrY3pI7DR4po2JqRtydGDCVMRlI++xPP44p7bkbA==
X-Gm-Gg: ASbGncs8ZgRcND00jKT0xgxmhiNBG6TE6ukzSeNWnvkavkZT+fvjtUq6ZQzZMsT8aWo
	GWTc/nmStKhHCdrdSsd3AIqNCjodIkzbdskvD6CATqto5yhOq8mPl9nPH6+Z7ImLCkxyv/33xLD
	IF5oZlMrA2DCzheqFYTROQVFMrfGSoro+ucblS0OPDDPb+cnbEXCLxxsxKCS56n7zCZQObE/1u1
	TRTcCO4wzSkwpkbCxm4RErrk/K5cSiNzRtaDFfUmM3o/hiyerekomHBeWh11016C9Tj0vw8
X-Google-Smtp-Source: AGHT+IEpedBv5d2DL2YREVHAUjmFZmdbmdZiGBqyD7+KhezOuMIBtjpTYxHvkHct6URF2wTl+5vKP3L+h2LpToUMJLA=
X-Received: by 2002:a05:690c:a87:b0:786:506c:3cba with SMTP id
 00721157ae682-78a79560985mr1376947b3.13.1763572589257; Wed, 19 Nov 2025
 09:16:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <gp4ju4m3ypaijxnll4e5246e6qu2zk7towstua3exfazdvqj5n@5zorhuwucugk> <20251119162854.6890-1-rakuram.e96@gmail.com>
In-Reply-To: <20251119162854.6890-1-rakuram.e96@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 19 Nov 2025 18:15:52 +0100
X-Gm-Features: AWmQ_bm1rfV7RvTaoV3JBx67K6Dl8wwUM2Xtv6ayXDITCTKNSUd4WWwYUDacXsk
Message-ID: <CAPDyKFq8jSp=JPULtKRV_fVZUh4qCvROh+MniXUhTufBWwRRaQ@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling
 using devm APIs
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: u.kleine-koenig@baylibre.com, chenhuacai@kernel.org, 
	dan.carpenter@linaro.org, david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, lkp@intel.com, skhan@linuxfoundation.org, 
	zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Nov 2025 at 17:29, Rakuram Eswaran <rakuram.e96@gmail.com> wrote=
:
>
> On Tue, 18 Nov 2025 at 21:44, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@bayl=
ibre.com> wrote:
> >
> > Hello Rakuram,
> >
> > On Tue, Nov 18, 2025 at 07:53:11PM +0530, Rakuram Eswaran wrote:
> > > Shall I start to send the patch to remove the redundant if condition
> > > check from pxamic_remove() function?
> > > [...]
> > > I can pull Uffe fixes branch to send the above patch? Any inputs will=
 be
> > > really helpful to start working on this.
> >
> > It's sensible to build on top of your previous patch, yes. If you do
> > that by using next as development tree once Ulf's commit made it into
> > there, or if you apply it yourself (and then use `git format-patch
> > --base` correctly) doesn't matter much.
> >
>
> Ok, Uwe. Previous patch is already made it to linux-next branch. I will s=
end the
> patch for this on top of next.

If you are working on mmc I strongly recommend to base your patches on top =
of:

git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

As is described in the MAINTAINERS file.

[...]

Kind regards
Uffe
