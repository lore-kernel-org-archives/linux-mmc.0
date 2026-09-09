Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982F73002B9
	for <linux-mmc@vger.kernel.org>; Wed,  9 Sep 2026 07:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939525; cv=none; b=XQ3u1PKAZlIIMITnVP+iih36+guLbZS3zCDldW3QjJ5AO8/4Ib34VvnMGFgd+U9UGhHSXESZwuIwrn5/qS9Fgb0+GE3mS37bl4feQ5nMu4NzphUVHsQXkOQzMoQtyF/MFsLXViwin9U5Tacfq7g0NyAAfYc1LaCJGQNMiWyipWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939525; c=relaxed/simple;
	bh=oLrKovMvI6vEuEPm9DSdmFXguG3Eq58Sk5UpeIaY1ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bf7LsKohxt6Fa9e5YeHgLE+N8O2gkShdRdv4GsNZgj20sEX0LGOyFlQ6OEIM4XPt28E+NOzjUzjzQjp3Ctx7f8BU/nl+bIQa2iigHoQ4r97em30ejX2sAibZ+WtVzeYOzRWcDIkJ/DKVkomyFQ0Eqv5g8v7JoMaoNrFg/fCf1+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cf78d1a2so567523666b.1
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 00:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939522; x=1789544322;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jPhA4Ya5/PqW/e+rBC5ClbUaQ0FR7NY7rHjANc3fz2w=;
        b=B/qNtJULk7jbVj8qaTLDDKSjkN350IP9CjtMCaDphHEYVaya5tvWRZcCDoT1i6mZu4
         27fLyka41oMGz39L0BJZbgZXmIJLHqgkeiup80qiOzGa5LlLIf1GCGaiZcxtrB/h/s4U
         dYNJTdKYdlt/QSK9gShMJH800F8kVLi5+vuj9+dhpP6wUe4z3GDXURFWmWBpyfpTQAX/
         iOdx0rtyBO6tdFKcrDfr93jlAKsqcfrL6qQQSQcNG2qCouql01PtEmROpVMlrVkH5VLr
         Swspfb3mNv4vzWKoc4exuwvA93ID+f5/0TpR2DLWgR9lepwOBSAj5ZToAsTXSH0cfilV
         YwIw==
X-Forwarded-Encrypted: i=1; AKwUvBxuhMEtez4IVkXVU2WgEiXWLJTsBkwiMNJayDRrquzd2cA8hp3TyupgHmVnRkrLCBUwWcKBepKFlBc=@vger.kernel.org
X-Gm-Message-State: AFuF++ktVgdXNw/MhcMjoqUx6TZCCQQQ+ZdMZfVCLC7zkJJShsFgVkGt
	aWE2hoA0z35Fs5fBvMwGQQDiJH+ehX9xRE1SUBTZzThH9g9LsumCnClRbXGBDWQwutE=
X-Gm-Gg: AYBFou0iHFVNwBYQ6BjMaKcIletufDNV+5Gm6cQVBFNdxOc5IzM+tP9nfL83asgXHtn
	TuCSUAxrhEWMEAUh6vD9Wgdio8ckbq20o3YP/f2J8A7Tzv0HRmH+JEDK4AGMtk4TuD18VN9ozho
	YFqf+JGIeD54/PE8d7K3MLhnX8xgsAhsXupU0IUHLHIoCAkx9Mk34tyx+DlgXAgeq2NwmCKhaqo
	kPRACoKbklc6oA7Atg1fABQY7wheZn7pR1bDvD03AkBOBvzrpYyLZsCV3ONDiWPeMR2fP/EFZIg
	Q8hS0SW2cCa6UysAz4D1F8xujel/SPFsxLSO2OkcYDwmK9375PasG/IZiag/aqPVbtNRVu6Ys1d
	qcNoJ5Qe608lJ5A4nUHmzPZneR8lAP9QX+4CyU0x9yUe9hL+VZ0zp10697Hp5Af2wP4seyZGxNH
	+cvM0eSDwJt/BmJr4BwevoVfWP8Ek20ljtT/2s7JzlG0o7fiuwBHfDE1ae7h2Y59r9unzVQZVGP
	hH2XhyP00fPrRVklyFwMoOWLQXrX3WbGfyu
X-Received: by 2002:a17:907:c609:10b0:c29:3838:dd65 with SMTP id a640c23a62f3a-c293838dfb7mr30161366b.41.1788939521724;
        Wed, 09 Sep 2026 00:38:41 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d03644bsm722153066b.6.2026.09.09.00.38.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2026 00:38:38 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso7964811a12.0
        for <linux-mmc@vger.kernel.org>; Wed, 09 Sep 2026 00:38:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxdE53tuKf7qe0Ri/MfH103kcph+JV/SIC2sdGn/RGoX6JoH6PJ5ZRrpoQe9Yd8MCU0ntNFqBv8AkU=@vger.kernel.org
X-Received: by 2002:a05:6402:a0d9:b0:6a7:ee56:615c with SMTP id
 4fb4d7f45d1cf-6a7ee5662efmr10229032a12.30.1788939517892; Wed, 09 Sep 2026
 00:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816153809.7067-1-jakovnovak30@gmail.com> <aoLCr8JEYaYxcJcQ@hovoldconsulting.com>
 <CAMuHMdU_Rx4ZGi9SsNxKUDyYmV-GbD8rD9NMVzYginBMXdZDMg@mail.gmail.com>
 <ap7CaVj82BJZgjf6@hovoldconsulting.com> <CAMuHMdX6JfqpLMGDQJSQ8E8XNobRwr16LOzuphPt3Afs-OZdJA@mail.gmail.com>
 <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
In-Reply-To: <aqEDb0THnCM-Q_Vy@hovoldconsulting.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Sep 2026 09:38:24 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWK8j200+Of062ghV1E7b0BYWsufEAop_4+3Bhmi0sxVQ@mail.gmail.com>
X-Gm-Features: AcwNN1XBeNCcZxFqMVOeNqjjdkhhsb3Z-uWNgAulmw7oFiph_1tBNYwccdZmiJY
Message-ID: <CAMuHMdWK8j200+Of062ghV1E7b0BYWsufEAop_4+3Bhmi0sxVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix sleeping function call from invalid
 context in vub300_inactivity_timer_expired
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Jakov Novak <jakovnovak30@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	Guangshuo Li <lgs201920130244@gmail.com>, Runyu Xiao <runyu.xiao@seu.edu.cn>, 
	Shuah Khan <skhan@linuxfoundation.org>, 
	syzbot+1ee4f3b9228e35f14677@syzkaller.appspotmail.com, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Johan,

On Wed, 9 Sept 2026 at 08:57, Johan Hovold <johan@kernel.org> wrote:
> On Mon, Sep 07, 2026 at 04:48:00PM +0200, Geert Uytterhoeven wrote:
> > On Mon, 7 Sept 2026 at 15:55, Johan Hovold <johan@kernel.org> wrote:
> > > Sure, but should you be scheduling rescan work before all resources have
> > > been set up and the host has been registered?
> >
> > I would like to defer that question to the TMIO experts.
>
> Are they on CC?

Ulf was from the beginning; I had added Wolfram in my previous email.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
