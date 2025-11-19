Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C63C366570
	for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 16:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763569744; cv=none; b=BZtS25lmF2fsXrtcB2bdUklxUJwh3vNCG1aaG8vr64t/FYsxuNOYmUoG2lSuHiypu6kGRSezTa1jtRuwoqC1e9eRNivSWjKDDXTnUhIWzS2kq5nm/RiS1P2+qLOKUUVFXZLMoR6EbR33ue2P23m77C4a66bOTu/0MeIWaER1WOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763569744; c=relaxed/simple;
	bh=krS2zwvB1cIXdBUbAHpfiUxU/dm8qFPfJ2HQV4/oXFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgTit3IFy01e2odXG9+53pT+TPABLIRuRK7VffzmgrxL0kKZ/ivhMgmK2OAyesAOIZTazVerQOptdyDaLUuyyokpBbLDu0GlBBOllvlzYXdv6YKQi3DT5dxE2C9BeBY9Tp0TRLiQ+cDfYA0uPgjW1O5UAhwcKBqT6RJ2NiF0L/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DILhU4PM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DILhU4PM"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-298287a26c3so83883555ad.0
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2025 08:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763569742; x=1764174542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yltoxSOQjw0YgiVe7Fz9jUncJdJ3xjf8RjpjTmk2pmA=;
        b=DILhU4PMQ9s6DE9+Cc3xWyb1U/WYUnWCN5gSmUsEnCgPo8UxStQXdhYor7qOgLL79W
         O30dMV5eF0dY0JCTa1KN+TpboByJp6mPuoBiEguAdARDdVDg+9LV6mf0ZbQjYgDBUocW
         iCvTvCw+mXRqBCgt7I7JdQa27OOWwg0+uMsGo4Lx28e8zn8lTMEsDASOn4I+A6p6IlSW
         9L9DCM4dtNjSh4n5fZHQjRx6Ir1UPoOF6ynB4cA/0t9L1vPBzBYIgtRExDRfBHiKQJGq
         +TWy1A5tg4tDYfU5J+miUNNQQiuJw0YXSAf7IQMu7/RjO4Z7zVbtLDbq2VsKaygteYHx
         kOag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763569742; x=1764174542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yltoxSOQjw0YgiVe7Fz9jUncJdJ3xjf8RjpjTmk2pmA=;
        b=Frm7RRceU5sJuxwoIOcn5Bx0FKhqHgRcAysISFtbvg0vx/mRhywcSoxKb85tk5M1df
         hZmvIBnOhT38izNcsZrdj01rpePzUyr4q7ZEchr+iGiIMvf4tERgbVnB1mg8wd8Jo/1O
         t0aEKvUjqWyTItREcv+HN4qc5OX6gHEhzPwAuKKHtPmqPaj7ZHxbVVVzUJ+3ipI1DaqI
         QB+koDsgRvVBhmnfSCJ8Yam8h8Gsz4vOSB9J24CDOQtj/1HQARMVF3WV2VZKh56Ai8Bo
         8+wP7eUFe6xZ49PH3gYKK4IyNYyJlkW8TL9NYscByqEPy5afbQB3mmqftqKwGvW4HUoT
         Ji8A==
X-Forwarded-Encrypted: i=1; AJvYcCUcbQbrzIEfJRD/+QI0UzWdPu7jSh+uaUBxZAt6CaUqT5p+9xY7op+zzUZEkxRXdWg4Nno/6fLN98E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ7hBG73hqIULLfhwzaEvSjTTTaPeQOB4lvYfKnP1JSCKqmVNF
	MP2jmPsuaxccaQYfFvcz8Qe1p6YJAu6sw2shL9qv+dzTgHk9kkCS8D/x
X-Gm-Gg: ASbGncsZuYTRsvIw0Eoj6xqn232UfKgjSLuI4scWzezIuuhZ3dm3oA9SxNN4of80kaQ
	VLaiGqWEQkZhdQuZObPpxuHrtq8gxfZtBwKe24aqoE2d0VrmhIR0W95YXx0sgeg1yK3rDtNRP8w
	4Xmb38shd7riZrVTffNg027zN6zFIV+qrraFL17iZp5rx6rKNEPARkn0j6n4gV2wi5SWyL0cDue
	gJAwY1kDc4iAZJuGdJeYVVfB4aZLW5Bk/504yeNT3xxEu55Req3Nozndhb9osChJdIcRyJqTAha
	bojHjwptpZpbQidglpb1A2S3LKYUZYRPRKkxiUvOp7zAiZLy9rAHxyZy7ERk+AGxwjbVFEzNjKN
	yjIJnabmLa1Y9to2M+vIjSWnCfuu6dUn7c5T2VJ9uJwJ1dMp3IdFwbeNcaSXSqXeaGnfjuea9G9
	eWaU+gKMxLJsYc3xg=
X-Google-Smtp-Source: AGHT+IG1i3hJLHO5OeVzps6Exdjnn+jfSV4c3Xs21CET6+hpDpTaetyCzLXja69p1aS0APrPFCpnOA==
X-Received: by 2002:a17:903:1786:b0:295:24c3:8b49 with SMTP id d9443c01a7336-2986a75676emr227289905ad.46.1763569741995;
        Wed, 19 Nov 2025 08:29:01 -0800 (PST)
Received: from rakuram-MSI ([2405:201:d027:f05b:837:386d:4d64:c2a5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2345e3sm209890515ad.1.2025.11.19.08.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 08:29:01 -0800 (PST)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH v3] mmc: pxamci: Simplify pxamci_probe() error handling using devm APIs
Date: Wed, 19 Nov 2025 21:58:49 +0530
Message-ID: <20251119162854.6890-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: gp4ju4m3ypaijxnll4e5246e6qu2zk7towstua3exfazdvqj5n@5zorhuwucugk
References: <gp4ju4m3ypaijxnll4e5246e6qu2zk7towstua3exfazdvqj5n@5zorhuwucugk>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Tue, 18 Nov 2025 at 21:44, Uwe Kleine-König <u.kleine-koenig@baylibre.com> wrote:
>
> Hello Rakuram,
>
> On Tue, Nov 18, 2025 at 07:53:11PM +0530, Rakuram Eswaran wrote:
> > Shall I start to send the patch to remove the redundant if condition
> > check from pxamic_remove() function?
> > [...]
> > I can pull Uffe fixes branch to send the above patch? Any inputs will be
> > really helpful to start working on this.
>
> It's sensible to build on top of your previous patch, yes. If you do
> that by using next as development tree once Ulf's commit made it into
> there, or if you apply it yourself (and then use `git format-patch
> --base` correctly) doesn't matter much.
>

Ok, Uwe. Previous patch is already made it to linux-next branch. I will send the
patch for this on top of next. 

I will make sure to run this command `git format-patch --base` before sending.

> > Another point, I would like to ask is about the below discussion. You have
> > mentioned about WIP suggestion for clk_get_rate().
> >
> > Link to that discussion:
> > https://lore.kernel.org/linux-mmc/20251020183209.11040-1-rakuram.e96@gmail.com/
> >
> > Was my understanding is correct?
>
> I think so. In my understanding clk_get_rate() must only called for an
> enabled clock. (Though the wording in include/linux/clk.h is a bit
> ambigous. It says: "[the returned clock rate] is only valid once the
> clock source has been enabled." That can mean "The return value doesn't
> mean anything when called for a disabled clock." or "The returned rate
> is the real one once the clock is enabled." Some time ago I tried to
> improve the wording, but IIRC I didn't get relevant feedback on my
> patch. Assuming the former semantic is safe for sure.
>

On this one, I'll look into other implementation on how they handled it in
sometime. 

Best Regards,
Rakuram
