Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54C231281B
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762947968; cv=none; b=Xfl8pgDiR5LsruqFw/bAl0BxQzjSU2ZQ6OUzrrDzv118bXnCTMtOQxLUyiLYVczPaW8bo+atkerGat+FgOrGWCLAcYAMM2OqK3513O6/9uuAs3K8jr8Flxac+dtMkrlfU3iUEQ7Xvjl3NtOvKtOdQIG+o5rQkdMQwbsNmItEBfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762947968; c=relaxed/simple;
	bh=vZUWSCQIpZTxI4lRbngolIKzMpkUCMfsbaQVmPwJkik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cy9t/aeJV7bAKu6wiNzhXWQZ0mLlZhR2EndoJPX+kpcjF0N/7y2tAB66DbVYrym/D+3oCY/Ysc+zUdWALGTJgYCkNx8Z1A1rW3UK+J3yQbOGthMp9wHBDWA2BwEpgoUEGPIfx7OwgHnI9LIzszjtv4fP7Y41mWuh+dPuy5VKG/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tfFkJwF8; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfFkJwF8"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-787e35ab178so7602587b3.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 03:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762947965; x=1763552765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2qMZBPGj+h/uNpt9ZMgHu14uO1vCueIFHkFnzkVCS0=;
        b=tfFkJwF8pXIv5X9YHMmjgwSoMB7pmYPH+ZLYIqOhmhzYZvNBTFgKQU9xXH/HNYx869
         dQ6Lp0hMzw0dJtjfUTvjmVC9svaoFqeqH3xF/usEV4+YwIycXP1owT71Z+xQntUZey5x
         F4Ozk3/8Xx5mNLA2ZKcNhFU1o8bGiLJRQU092TyVI/22lqJSHfEZL55ouSHUxF2iOmS9
         Cn5QGWFAGujElfv9uln/cImXUvCJ4+ziB4KsGXwmH6RgMSSKtE41gJAnCIZWNrJRNaAZ
         bVm1QUwOxBNQtOyKnsi+81tIk0A2RzXTzdXaIwD0C7AV9GJwKMWuMpRL4su94LazFLdB
         +SpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762947965; x=1763552765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2qMZBPGj+h/uNpt9ZMgHu14uO1vCueIFHkFnzkVCS0=;
        b=cpfPQpmPgxdf/8mSrGlWwXQZZews+SNxmSGkqB3RDST5Dffe5gqQjwqjhvChB1/izR
         wCIsEkNswsiQ4SXPSExTd29kUcv7xdOt++Xze0ekUJOyZjmWWjjlUTKuG0bzj6R+ZsRL
         iHlTT1sedbrmIPVSerQaNkUloCzuX4Pw9inliWKPeYRoykxpTNF0TCwB9mbS86GzGbay
         vWfQjxbrbumBkkOYPxXwPex+jE/jL4rolFT/t9EXeeICYLkLFwgFeugu+x6JiYakw70o
         UgZuXIDhqC6zDN9sO6iUqY5Fjb/YIIM1MaTBYv/+H+S25+Bje5JULigcwnxtiGRmw3Vc
         4anA==
X-Forwarded-Encrypted: i=1; AJvYcCWxZl1DbS2mvZRLepdlb8fIpKjxHNqY99P1hIoh5HMQ0MFiRDJJV0oQkctrsco1tTYA8xCp4MVKz+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYaFO4Gb8Jp2vHqeeOycYv+Bz6qe7nvREUCBg9IVBqnFWRh6Q/
	NIxoKfi/K7eWVdGQVclTbJMkY/Lk7uapfBPyY3crSd4U2urFsZFAZcjDYAr7yBFgsXuB1cKWxvz
	lGo9SogjBNNNrWj70gM68jBbvQ6+7rpuOM2jrxwD/7KERcMOFl8Rn
X-Gm-Gg: ASbGncugTyjn0akj6qvzuJrcbkSByuxS0582ksBwFadTcKKZAh4fGGJnltWEUPROkDv
	q6O1fCqBom1jJluDi7BAV1UlZfAfR4KZDD97ZprhoEM4gl+S/jfa0VMpc4ZqfK5whRpIkhIT2Rs
	t3K4EcsMCC+mATxgDbx3bxrV7skGmtb7MpG1P0ApDukz4ICReXNDyYUwPqutcKg/5gQL6M6pAcL
	1oz8UcuJdO6Y+hBOvNiZRdtFas2xMJnPmjMqbHQvmU0M3g1CQcvlbHTpCkEKQ==
X-Google-Smtp-Source: AGHT+IGkn+N5zQyXYEQGDK4CC2hGaCbuvbo4Sq23RcQDAxvsmQHt5AlzKM1puzMz/T2iHx6hMSx1jVKyy02rK8jCvkI=
X-Received: by 2002:a05:690c:905:b0:787:d456:2e80 with SMTP id
 00721157ae682-788136e00d8mr21345127b3.50.1762947965608; Wed, 12 Nov 2025
 03:46:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141654.226947-1-marco.crivellari@suse.com>
 <CAPDyKFq46qON9W5akWh7CV5fiGSLHV=K9F_Uj6u_g1g08DPV=g@mail.gmail.com> <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
In-Reply-To: <7e99c811-2081-46b8-a089-19d6e1778cc7@intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Nov 2025 12:45:28 +0100
X-Gm-Features: AWmQ_bmN2O0wWXlbNMIvk6Sh1olsnCNZ3MtgPCuyWboPHhZCXxqncRDHta7XpjU
Message-ID: <CAPDyKFp3wBv4Kk5TXjQ49CxUjV1sd3uxreX0mOKpD5Gk=OiJrQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: add WQ_PERCPU to alloc_workqueue users
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Marco Crivellari <marco.crivellari@suse.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 at 07:49, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
>
> On 11/11/2025 19:12, Ulf Hansson wrote:
> > + Adrian
> >
> > On Fri, 7 Nov 2025 at 15:17, Marco Crivellari <marco.crivellari@suse.co=
m> wrote:
> >>
> >> Currently if a user enqueues a work item using schedule_delayed_work()=
 the
> >> used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
> >> WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies =
to
> >> schedule_work() that is using system_wq and queue_work(), that makes u=
se
> >> again of WORK_CPU_UNBOUND.
> >> This lack of consistency cannot be addressed without refactoring the A=
PI.
> >>
> >> alloc_workqueue() treats all queues as per-CPU by default, while unbou=
nd
> >> workqueues must opt-in via WQ_UNBOUND.
> >>
> >> This default is suboptimal: most workloads benefit from unbound queues=
,
> >> allowing the scheduler to place worker threads where they=E2=80=99re n=
eeded and
> >> reducing noise when CPUs are isolated.
> >>
> >> This continues the effort to refactor workqueue APIs, which began with
> >> the introduction of new workqueues and a new alloc_workqueue flag in:
> >>
> >> commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_w=
q")
> >> commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> >>
> >> This change adds a new WQ_PERCPU flag to explicitly request
> >> alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified=
.
> >>
> >> With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND=
),
> >> any alloc_workqueue() caller that doesn=E2=80=99t explicitly specify W=
Q_UNBOUND
> >> must now use WQ_PERCPU.
> >>
> >> Once migration is complete, WQ_UNBOUND can be removed and unbound will
> >> become the implicit default.
> >>
> >> Suggested-by: Tejun Heo <tj@kernel.org>
> >> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> >> ---
> >>  drivers/mmc/core/block.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> >> index c0ffe0817fd4..6a651ddccf28 100644
> >> --- a/drivers/mmc/core/block.c
> >> +++ b/drivers/mmc/core/block.c
> >> @@ -3275,7 +3275,8 @@ static int mmc_blk_probe(struct mmc_card *card)
> >>         mmc_fixup_device(card, mmc_blk_fixups);
> >>
> >>         card->complete_wq =3D alloc_workqueue("mmc_complete",
> >> -                                       WQ_MEM_RECLAIM | WQ_HIGHPRI, 0=
);
> >> +                                       WQ_MEM_RECLAIM | WQ_HIGHPRI | =
WQ_PERCPU,
> >> +                                       0);
> >
> > I guess we prefer to keep the existing behaviour to avoid breaking
> > anything, before continuing with the refactoring. Although I think it
> > should be fine to use WQ_UNBOUND here.
> >
> > Looping in Adrian to get his opinion around this.
>
> Typically the work is being queued from the CPU that received the
> interrupt.  I'd assume, running the work on that CPU, as we do now,
> has some merit.
>

Thanks, I get your point!

So, to me it seems like if we want to explore other options, it would
require us to do more analysis to avoid introducing performance
regressions.

BTW, do we know how other block device drivers are dealing with this?

Kind regards
Uffe
