Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648B535CBB6
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 21:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770845404; cv=pass; b=R7QxR9Zt/Df3rBNqLCwaSgoPngMtOaotDitE/fb3RgGZiEGmilXE6R+Fsm8GYf61F8xlP9i4RTIW4QAwUg9CojLyA/Q27ElNR1VGXAYSt65cdRyTtfqjS8klbjGvfASsgI9PjY2gzFwqZASCQlGTLAoL7ii+6ErE01jo3CmjxsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770845404; c=relaxed/simple;
	bh=a+r7pWrWNtMdy1makopFQZui6FNA93QQryOTu898OBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYlsIL6ZDgMi7uUGtnPopUO2HTsDdnd+MrwliJ+LBJcG95yJA63wm/RLDQsYOvcEmLCUQLK1Dp2twTp1K572BDInqly3o2Y0pdCzLuny4C5a1bGwgmbe+44TIqn1mUdsF6PBg1mvadXUWk2tD9RKEDLBz9uSPXE8HkP4OdQd7Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OO1zhlCT; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OO1zhlCT"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd4bec4ecso2839152e87.0
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 13:30:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770845401; cv=none;
        d=google.com; s=arc-20240605;
        b=USw8Hj23OIBvJmHQWJw+m8RhpErVVwg4agXvdi6F8xXNvNrr5J3Ph+Z0HYl+2oGOCL
         olzFpnFC19ijdabPeQwaOkADTUmuwlOYSQEnp+b90VP+Gz+b6LMqrDtLy1tBYnUUitsO
         LLXea3b2Qjz5w408XgyoWGcazDilfbNxUGq0wkBw4O18m4XaquoPtzlheURrg36SHTfC
         DYpSZ3x+RmvWMQwKr3qf34+6jHXHPLsb7PbcZK/Wo6F2hhFinck68bXj5svT2gl1K5cR
         gEcNs3u1nU68ulg4vFSql8tV7ryE9/r1C0sBSBopVKRY+PHmZJ2tVibho0boZ4NgTRKL
         gC5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UnaQO+NPtyEE/urF0VeRvbGfYzacARpbb0HQoDG2lJo=;
        fh=jSR2SMmwAPRyGd7qX/6ieaKbiPhlfv5jaKLhtZxzwB4=;
        b=ZGRTFh+pm5fh7rnz3c7PErv9s3mKzSgtpVoNWBi9dSlFznQYQLIO67SPO+UotFPle1
         AF0fQOaMkbYiWDCaxj7IPAp/RKOMKlzur73KDILgT+j1O2aF3U9e1MR7stNEPDWARxJJ
         V+CSW0eX1DsV8+9y6lVQfalfnLjn5sceQqV7ym+NM0+6RpsjkNMACQ+DuyUH1SXyu3aV
         kotVOQC5lPRFrMTnlf2YkUU4yLWm6orp9ay4Q5XIbxCT59NvqoNdxeQBWJpozjG8lv0v
         SrlrWQkFeLNei9nW93JtHAngyRZQxfLtNwopjIBrKFBrtnTppQcrzNmyZ4Luu7NVTrfC
         Pqpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770845401; x=1771450201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnaQO+NPtyEE/urF0VeRvbGfYzacARpbb0HQoDG2lJo=;
        b=OO1zhlCT+IuQGypTwLfqmWJqUy4Cov6zV8rmVSAL6MAxOLModyKG8rzh224acD2UHy
         Y2oXlouFHo7X0XcP9kf2yRWpmadE3t//qdN0iW96s678/ZgvCQdMKUfjsfaDfbFDjVTH
         xhtUpK3BQrhYZtDojKCMhzl8IhzyCf3350Y8zDl6BdFuXk4vowtMZdosMQpYPP+0BFgT
         xnpa0yMkjrrOMvklveSUQKbKOEiIG4waVvFWWIvWZYsokMQbNGOiRDEfYZ4WnsQC+0Fe
         tAy8jd89Np8kZnm84c/b4OQxql+/7IzYdQIEiXF0QMo2ksPs/GRFSizRi/Qv7QatMaQw
         wodQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770845401; x=1771450201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UnaQO+NPtyEE/urF0VeRvbGfYzacARpbb0HQoDG2lJo=;
        b=CaeV8Z7TVyu+QLCRRLG+RBgsPTrEwyZxU13ELfqbF8tlR5nKJ3RO8vVtDnH8k/vHTc
         ib85B6VuvpfR/yGMC10Lo+q2vhbVNIjlqXHXClfoSh04x9P/7r/IxincBVOtpA5F8jyv
         EMEWzlSOsZt5Rq2kLMlBtwSGXzhNMS2ZjRrvGAGH51v6A2Pm49bPLAE+7rVJej81G0o+
         EQSgEhaxjoHduOtuwIBuSSW2ZD4H+kYWpFUBvEMx7agEfesGfhxiNzGArEz2l9hPnhpr
         8LYJUdKkYXCLnHKNyN6Wwnre/braE+0C/zPAaeRH9U5okbp4D7agpJbHhGzH59o6k55o
         x8Vg==
X-Gm-Message-State: AOJu0YwzhxZUyCn3UJTJ45lO2HmnJInQO6luqUyQ+EGC/luLjzpWVjwW
	M5dvpV+W0E2EFqmg7NHOTbBZ32TGQjn2+IlsZxKtSD3AIpDXqwckB+tyNLyZbzinR/67luWYTbx
	EAloDllJwB16rXLpAhOk6OEa/only617hYQz+u3AdMygxRV2lYUKhkw4=
X-Gm-Gg: AZuq6aKI0fUPt2lg8R4DnCdMd5f7YD3oxEKFx/lLAJ4QqpobrRPDIIg+I5Jqdw/FgOQ
	nG0fgWDJjDvdtvVJB//yp0Eh7U06eXAPAs8jab6gKh9+UZ4kO3EvLcKPlTUb3X6CDDzwY85H2nf
	W6jmLFxeTlX6eJfn1hReVTlUjnE8nKQSBVfnmYQj+u9mN58nojDEKeI7NnAdhCsZEY0dGcfp8Fr
	HSP5ZNIBtk0enY9I9dAgKuuwg27QQe5XEa9Oe2heheMGi4DSZcuZCbmYN+E8ZTRdW1GeiTzemCx
	EFuBsQuB
X-Received: by 2002:a05:6512:1155:b0:59e:5d0c:ce with SMTP id
 2adb3069b0e04-59e64f6aec0mr24845e87.30.1770845401350; Wed, 11 Feb 2026
 13:30:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260209133441.556464-1-ulf.hansson@linaro.org> <CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com>
In-Reply-To: <CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Feb 2026 22:29:23 +0100
X-Gm-Features: AZwV_Qi7Riy0wpHB3aTAjo6PWEysOHZOODWJvd1b5oD8d8ULHZ2U42rBbhLxhNw
Message-ID: <CAPDyKFrFez=tDXLqRmeS1qpnVMCUPi8POjYkbRGiwAhcT3shfA@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v7.0
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 11 Feb 2026 at 19:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, 9 Feb 2026 at 05:34, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Note that, this time I have picked up some changes to improve the mux s=
ubsystem
> > and those are part of this pull-request, as these changes are required =
for mmc.
>
> No.
>
> Those changes are complete garbage and don't even compile. It has
> apparently never been in linux-next or been build-tested in any way.
>
> When CONFIG_MULTIPLEXER=3Dm, we build that core.o file
>
>    obj-$(CONFIG_MULTIPLEXER)  +=3D mux-core.o
>
> but in include/linux/mux/consumer.h you have
>
>    #ifdef CONFIG_MULTIPLEXER
>
> which won't be true (because what will be defined is
> CONFIG_MULTIPLEXER_MODULE), so then you get a long stream of things
> like
>
>   drivers/mux/core.c:312:14: error: redefinition of =E2=80=98mux_control_=
states=E2=80=99
>
> because the mux/consumer.h header will have defined the dummy wrapper fun=
ction.
>
> In other words, that commit ad314348ceb4 ("mux: Add helper functions
> for getting optional and selected mux-state") is pure unadulterated
> untested garbage.
>
> I do not want to see a "fixed" pull request from you. This was
> entirely unacceptable, and I will not be pulling anything more from
> you this merge window.
>
> Stop sending me untested crap that hasn't been in linux-next and
> doesn't even pass the most cursory smell test.
>
> You can try again for 7.1, but only if it has been actually in
> linux-next and properly tested.

Hi Linus,

Sorry for the mess!

I queued up the mux patches on Wed 4th last week (which is certainly a
stretch that is unusual for me), but they did not reach linux-next for
some reason, which I should have paid attention to. So, I simply
trusted the build boots not reporting any errors to me, believing
everything was fine.

I already have a patch queued for the problem (we got the report last
day), not in the pull-request though.

Anyway, I understand your concern and will do better next time!

Kind regards
Uffe




>
>                      Linus
