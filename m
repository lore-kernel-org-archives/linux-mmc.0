Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15B3FBEA5
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774359337; cv=pass; b=kUazXop04axqZ2+26ea5vHJZDX4F2jZKegB3yxQmxprlqYFFBnEVjfM2pK1QogiaY4GwdS1+ZIgNWQlu3UPv82A+zz9nnKYvWov7NoaB9hgpcRIw4yhTJTcHfMlhzCSl2u+yabOI/yR5Zcav5ctYL3kYT4dLRNyXYghtMjAQLt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774359337; c=relaxed/simple;
	bh=gtXm3EEFVzQNA6/1bMSZpfoVvZUrGL4slNdIVBnFMLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g70oO+cPoFnaks2iSw3iHQhPGa2TteUImOZj8dXZzjv24h8nYiWqCBx1s41eaVsIXj8ymYyQfF9RziizOWKKD4lZ2/Ej2cRGFOrE1CWLkm8AL+lubUQRDyaOx9c5xEgy5myDBPgJqhnPfMfa71p14I/qrPLyahNaZw0o5pdzNJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NSVR6v80; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NSVR6v80"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so1363243d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 06:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774359335; cv=none;
        d=google.com; s=arc-20240605;
        b=AnKF8qcVgtIXMfOQPvt/vU4vz8UhVZVLnRfZ3KSyVswZnbbuqzBgjMANIQ5P06E6UL
         PlmwizzaLhabB/fuZw4N3epXQJnCq7DrvGdwHFCEbpjA1raayZ/ueTWIMBA5JAHbp6v8
         eVLEENhabdasr7wQb6b/71pHkFjs00jzLhqv09JrzjXa15fZ8MoYa4jKN3rDVkmjamHz
         FvaPvTF4GaNYboT+8yqrZ8vSlu/dyZ0UWZDve73JHWxDL9HywpExsk9IltTlubVn99WX
         CUklb9vCm9yVFRSsaf+6uyXcbYhDfwKMvIRdR88oipgNVGDksf45wCRfRQkIHqi8AK8a
         MttQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gtXm3EEFVzQNA6/1bMSZpfoVvZUrGL4slNdIVBnFMLI=;
        fh=MBnPHCoxHwlmOypQJbBDLONdp/SI3Z/MXb3FKXIC9HY=;
        b=A4/yGuiL3YaovtvmKg1psTXDLjZkBLGQFmxeRaDwnw0S6Ap3v9bRkDltLk73rZDnyE
         6tDEynrXJ12MIbyLhg/Rk78jFAPVTDVH142rESJMMonOzVI7EUcO5vqolOKDhLuSpQzA
         I73ayct7qstOrKaYSsnswTd338nOoT4nu0d1i9l6Mo8CUTdVN/+Kbh1GSVFIUqERsQsy
         oPJMR+bs/NWMmk9AnR6X9+qdOlibGqKVnRiriZr6r7N8wt2RNGFtjF9rlpr3Eh2OCM2h
         +0c6+7HJSxY+Rk9m10qUYlWgyDMKtq4ViZsoNrexyErKBF5f1xdtIJTS1aZJHAlzr4cW
         h8SQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774359335; x=1774964135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gtXm3EEFVzQNA6/1bMSZpfoVvZUrGL4slNdIVBnFMLI=;
        b=NSVR6v80wl2tPV8BFpE/eZ4foAEX3kbjlT9rqn5bXs96E1Ms9RePFO2gNoGqTmVRrW
         66jWyrnaiF9IlE4UcUfckAoCH0qNiaMkkSQFBCXHx9ZTXAhe7EDSlMg5OyMBDVvBYA6h
         w0LJ4FylSgCR0NtyFWlFAXEy4+ktb0XPjOZMxMk46jf9PSmCdGUtuV+O5NrSE4GjWYgW
         vPxpkWJ5tY1XEjvBJpc9OoIVJAP2QGvNzGXTSKG3el49WzxMWP/hyTyKM0kWtf+9tUlU
         cgHuXY++L4/IFwtPONNLZZaUukn4w1YRDmqxB2Bpjr4vhVHnywQKSifH3r2Zs8EeHYdN
         S7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774359335; x=1774964135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtXm3EEFVzQNA6/1bMSZpfoVvZUrGL4slNdIVBnFMLI=;
        b=oUFI5bQ2KIe/oSTgtJV/9GV2hvW2UecXHnvjkK7efokZ2oejSmJMj+bql1W5MHVCQF
         R4haye42RabUgLibRi8jNJNKWnbZFo0dkoH2S0zyNouNNXYfJW5lzHRHp27b3MPzLnnS
         NiWkfPgcUMd8BzZ4vIusoknZaGbiKK33icac1iX+ogrT3+633E/9q4wx4NmoysbmCOXh
         kd3wZJvTpoMf/TM+JKlVbAAm48A97WX6nvZVGXW0xFgymGJDJBNKdITeu/ktLTT+j1Vj
         Ci7txNhsfEYJ9O8FE5jFL+6TU0FrfKmK2WC+ocG4fEo4+Mif1zsIvOlMVfatFg5BrrrE
         AVeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKXou/7bedEFl67w+eP9kNMQ3hRCaLI+qfiB2Lqj2u/tIMFAQXcfMgyiU4nEenp9+seR3esHFJHoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1RTrPN4XhLffPzv981bhKxDOuNSX3TAaX1sUcG7tY7X/s333N
	qAF0ykOoMVAY8RQDI3VAiJvaxQbx0jSrkYnzhjGPPPmUvGTVDOpicD5gKDjxMr6NYF9I26ROZF8
	TwN5Q4GVKaAoa3jy9dbu8NYjFVSxVt5/NXECu5SVd803TDU3gQ07k7Bo=
X-Gm-Gg: ATEYQzxusqPmLUBV92Ot/trdfuaUkgoPSxb+MYOBVrp15UZox2i1q0L/ysGl4k2h7uP
	1WLQzYS/PIcLLsS6dn+eSrCfr3EWMo5TJ4VQr7jCHVKZ58sSIipI8k+Hw+60od0sUcOPT5IdpTe
	xx9D4120GluIZv7oq53gQLIs7xF4KHS4nPGD8+6Ufcg2zftx+9sQvqV0WnlEpJoCu2dUmMgeehI
	g7uPCVQgcYU2rqBfmV+yh2c1cBDySmg7J3oqpdqsAa+PrqySfPHgXn26ExxVVEJ8QictrVnHFHy
	Twk2kQ/h
X-Received: by 2002:a05:690e:1188:b0:64d:29a3:ebbf with SMTP id
 956f58d0204a3-64eaa698267mr15292741d50.16.1774359334760; Tue, 24 Mar 2026
 06:35:34 -0700 (PDT)
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
 <CABtds-2DjtJ=8GzNdi0ZOLPdBfGWdfeXX790o_gvNVE=d9+=Pw@mail.gmail.com>
 <CAPDyKFqi_Ayc3kffNHvhTmNSxjMhSAa7wr4rQuP6060ifH3y=g@mail.gmail.com> <CABtds-3oovV9jP8uaQ7_=T4_BA7oEpkfT-tbDW18MEs0eLygzg@mail.gmail.com>
In-Reply-To: <CABtds-3oovV9jP8uaQ7_=T4_BA7oEpkfT-tbDW18MEs0eLygzg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 14:34:54 +0100
X-Gm-Features: AQROBzD2a_FHN9MjVu-g1ewrOJhKICIAzy1jUvJv2zNlImfcKhbsji3sxOpNUn0
Message-ID: <CAPDyKFpb_6LtCMQv2LzW5W9ib=3KoVJ3XLiRCGPAcPKv_unnfQ@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND 1/6] mmc: rtsx_usb_sdmmc: avoid false
 card-detect on tray readers
To: Sean Rhodes <sean@starlabs.systems>
Cc: Ricky Wu <ricky_wu@realtek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 14:14, Sean Rhodes <sean@starlabs.systems> wrote:
>
> On Tue, 24 Mar 2026 at 12:58, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 24 Mar 2026 at 13:30, Sean Rhodes <sean@starlabs.systems> wrote:
> > >
> > > On Tue, 24 Mar 2026 at 12:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > On Tue, 24 Mar 2026 at 12:59, Sean Rhodes <sean@starlabs.systems> wrote:
> > > > >
> > > > > Hi Uffe
> > > > >
> > > > > Thanks for the feedback - to answer your questions:
> > > > >
> > > > > > Would you mind elaborating on this so I can better understand the problem?
> > > > >
> > > > > SD_CD is used for presence, but that's asserted by trays or blanking cards.
> > > > >
> > > > > > What prevents the MMC core from handling this correctly?
> > > > > >
> > > > > > Don't some of the commands time out, eventually causing mmc_rescan() to bail out?
> > > > >
> > > > > It does bail out, but SD_CD is still asserted, so it tries again. The
> > > > > main thing this breaks is S3 entry - it's either slow (like 100
> > > > > seconds), or never gets there.
> > > >
> > > > First, please don't top post, but reply in-line below so we can follow
> > > > the discussion.
> > > >
> > > > It's the mmc driver's ->runtime_resume() callback that calls
> > > > mmc_detect_change(host->mmc, 0).
> > > >
> > > > It's sounds to me like the mmc host is being runtime resumed/suspended
> > > > over and over again, hence we end up calling mmc_detect_change() many
> > > > times when it's not really needed. Right?
> > > >
> > >
> > > Correct
> >
> > So why does the rtsx usb card driver do that?
>
> I don't know; I'd assume it was just a shortcut or done by people who
> didn't have the hardware when moving the driver out of staging (see
> 00d8521dcd236d1b8f664f54a0309e96bfdcb4f9 which works flawlessly)
>
> >
> > Could it keep the mmc host runtime resumed for a while and then we
> > could add a debounce period to the call to mmc_detect_change()?
>
> I might be missing something, but wouldn't that just make symptoms
> less obvious? We have bad detection - why not fix that?
>

I don't think so. Assuming the host gets runtime resumed at some point
again, after we failed to detect a card. Not sure if this solves the
problem, but should just make things less noisy, I think.

Anyway, you may very well be right, but I don't know how to fix this
properly on the usb side.

That said, we might need input from the usb maintainers on how to
proceed. Perhaps if you make a new submission (RFC), by describing the
problem in more detail and ask for guidance from the usb folkz?

Kind regards
Uffe
