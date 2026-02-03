Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2F32FA34
	for <linux-mmc@vger.kernel.org>; Tue,  3 Feb 2026 11:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770118129; cv=pass; b=JI4z1kh/0UWcHsXZeBBX0oZQphUfY8qEHDDCqJv2dq74PKEJbUq4+tuJ+P0Tswmtviw3ahIMPqZ5gMiyC9b2dvMccJBJd1u7GOn/gid9sOkEB18hYEL7Wvfbe6rIbQqTwuGU/qrUUIdww5RDSIioiySw3U6x7N6Ry5w2kKYWRyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770118129; c=relaxed/simple;
	bh=qO+VlD+Dcupkb73nS8UCEQFWzgnN1lvwsftTUEtez+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H503yBPXs6sq3R/t4dazK+O2tO37rmNmjqsM3cFZH4ofV7+GijRCcK0KwjNc0XZonCpHM4FOIKtuO+JLFuOmZ4dpvcY6fqSmJ0epE8+nc9f9K9JOHfm7YbCHNi4frc4Ykit8/2jgMkjbXCUY1fmd01Pxh0uVcOmPTjbvjrBZsfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PxexWSC0; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PxexWSC0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59de38466c2so6862687e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2026 03:28:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770118126; cv=none;
        d=google.com; s=arc-20240605;
        b=OuATzPKs+UTvJqzYf7pUnbbZiWuRV0F6fJ6mxtAzQxsCE/ew3Qr/wfR6d6chWoOiar
         f9NYv+Huggv8+eEnAtgKvfYD6oxttGr4L3Ym7AigzQEcDFfXFr4Y0ttzZt/HdaqZgJ6x
         nn/j/8RuZ7gEXc1D32zb0FQfiA1hw2tUgVhhvRijLDeRwJhFHE1xUEYbQvraIrhKiNXl
         n889LJrNMIfUKpo4TDd4Dv5ZAUFKgnQy2p508I5lYS7JcffIttZ2pMy4NS0Qg4B7CY43
         UVbJjDuIy9gk6wDOC7MssF9oyCY7W2X5eEE3bJvUB8e5KYRpxzXkSef+F3AcNsWD/7da
         NN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        fh=QAbCFToF8omJ6pp8f3DNRH5WOE9+dXH5WJ86Z8rRpms=;
        b=QCpDALR9FCOB74UfN4sH12DK5eXbnTh0BnAjWhM0GKd1X4g40Ds+kq2NhoRYumT21G
         nKCbkSPSxjg+HnoRRKvZM5huT3/YOcaDx6V+p7v4+CqOTSXnWV8OhAa36GPKbfh7fAcl
         dTIbFRAT8UxS4jy+TQbQoWYLP8NLElTboatpeEhNMaw6BfxS5kBRgGQE7Mlnvi265BJt
         JnZ5DjH3eEKhtMqBFWCyyZrY5cZaa19FpO2wsvBTA/v51dSz+PecBVZr2DeXXv5i8CZt
         2gQ1/DdvC612an2UYQBT+N4gXrn6i8vD0l5PytDR6ssyOP9ChxQ36b6GcCjHZiS/u4jR
         X8ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770118126; x=1770722926; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        b=PxexWSC0/z13MDyCyRh0UGS9AL22QN0LYJiYvDs9P0ASJOX9GkNLomJHrS6CXIEsEC
         22fQBN2EpAhj5vKNoQMRyYEnJqMXXjEWCnUissedyY00Ptt8O2gIjuxMy8Z8AQfQlt9m
         w3a21q6Wq6KUqrJPKe057V8tGv+SUQRh1U3x8KDapVG/Byi5muUJBIDO6YVlD0HXsdtu
         uUz71tYEuCSeVu+S/BzTfbAiRRLc4He97jvIx5VMBkFmBpa1+VXPgYXCGn8F4hTNPDg3
         1Ciu+ML3EPbzA4MpiGj6I9Wcjb3WVH+L/FEkoP2wqHPPD8Z5CYc1irPOXNW3NZhzl1VT
         6jrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770118126; x=1770722926;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2L7+eW6U0AtkWvkzxuzbmoQAqsnrr/k4qm/FKd2Usd4=;
        b=OtcfHanqmqi7U/4WoLHUfAqAPx+w89bdJ+J0xbXKMegcwSLfJG1QaA5hxZS1DS6O4j
         dhWHjgCQkRuqFtx1tNEgnP+2hu745h78msW8H+5gLvUiXpHrnngoRRctPaQkhNWKkBjr
         mkpSY8cnXn43uO3gFqEhCErUl8il8B+EX0XovQjHj430pdZMuCVWtodhVZZzyxgHhEiN
         50kAqJZvnK2qZUkPd5CVSYyfIwg7qJkHkmgCS/2UAAIBIUShbhPEIZiRWBWzyrtb423A
         YY6XQudxHphTHnNcLOwG5u88u3M9SvDfzEIY+qDD4Cj4DsfQ8jUoQ6eGQh8OjbS6YUFg
         FREw==
X-Forwarded-Encrypted: i=1; AJvYcCXcI7xj/ERo95j3rFAuJ9ORJBZnDNVLRaOneJxyOSvASnwKvf95R9xs5vnl14DETRQTiiwQxmOBavg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkH9aawhZdLF5oHagjj2I/1Vh1ctJaEbt7LBCZADxjuBR2Ymup
	4GunZ2UyeCbvoTBGKiDBbvumRlSL4RtUG8VzaAJKmJpRbl2XrsYufROJRzqOOw5b5Ht6bMNQIoD
	5bRB5jGB9UUDNiDkWZGVo5+eAHgxIcDuXh4QfMbGtNQ==
X-Gm-Gg: AZuq6aIddR7R2TY0wKClKIXtIeYR7wN5FG70ay39Oat1XfL1pn6bZ/tNuZ8cVR3xBnS
	ilROc6X1d7OXeAB/atx5ePDjtyUNeF1PVGF636Xl2zIC/3SLZhQ5sTXyFiSDCWgjnvzepRLMx63
	mt1vdVO7mwRgi1kWw/ZUZ+78ngDwbDMvsxcXYkfTlZCxOnx4vYVkK/WL4a3mxkoAyCJCOETTiQa
	vpEpIjRVXIQy068+6ckU+cpYxirtq2Z6JX1e03mLHq8AP/qmAeUIYpLjjIB2x18TlT1CHi3
X-Received: by 2002:ac2:4c52:0:b0:59e:340:e557 with SMTP id
 2adb3069b0e04-59e1640219bmr5409741e87.19.1770118125586; Tue, 03 Feb 2026
 03:28:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ff9a7c20-f465-4afa-bf29-708d4a52974a@linux.dev>
 <CAPDyKFrGpvjONrDmnNZXv+SME_NCNv-LK8J-Vo88RSz1fuD7rg@mail.gmail.com>
 <787171c6-0b9c-400b-8a95-b331b58e284c@linux.dev> <4777aabd-bc9e-4904-9444-892393aecb15@linux.dev>
 <9e362d5fa2604fb0848ea28866dc45fc@realtek.com> <47ed09fc-047b-4f98-8df3-d11d17678c57@linux.dev>
 <380f75c7adc04cbab38cfd2f82bd0c6d@realtek.com> <d46dcebe-ca58-44c4-87ee-cade2e478572@linux.dev>
 <4205fde06ecd4a7489b03ef25e5e4011@realtek.com> <CAPDyKFoC-dwzcsABNy9pA=GGirBWwcxQhNMeTSSStXHtXmWbcg@mail.gmail.com>
 <0b6fd99b-54a6-45f1-942e-94f707f2fbf5@acm.org> <CAPDyKFqic-rFe95g657MdZHtdPXTmFmYQG4ZSBV56S3DhMEF-A@mail.gmail.com>
 <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
In-Reply-To: <dc1ac2e5-1db1-49b5-847d-a10a611027ae@acm.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 3 Feb 2026 12:28:09 +0100
X-Gm-Features: AZwV_Qh3Fj46ISod4rA7hznVA1UsJLGD934Xsv1krBb6KpsuNXejyDCjwAzQWJ0
Message-ID: <CAPDyKFrNHc4FexuTbdWM-Kvo0mn9C51nJN5b=e0jZR8miFho+g@mail.gmail.com>
Subject: Re: [BUG] - Short freezes in gameplay due to MMC_CAP_AGGRESSIVE_PM on
 RTS525A card reader
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ricky WU <ricky_wu@realtek.com>, 
	Matthew Schwartz <matthew.schwartz@linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Feb 2026 at 23:47, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 1/29/26 8:30 AM, Ulf Hansson wrote:
> > Seems reasonable to me, but how do we distinguish that it's a
> > battery-powered device?
>
> RPM can be enabled or disabled from the scripts executed during boot.
> At build time it should be known whether or not the device is battery-
> powered.

Okay, so user space needs to make a decision, no matter what.

The point here from my side, is that the default behaviour differs
(RPM suspend may be allowed at boot - or not), based on the storage
subsystem in charge of the device.

I wonder if it would make sense to try to align the behaviour to
common default, between the subsystems that have enabled support RPM.
Or maybe it's just too late for that.

>
> > Are we considering UFS a technology that is used solely for
> > battery-powered devices or is there something else we consider?
>
> I think there are devices that use UFS and that are not battery-powered,
> e.g. smart TVs.
>
> > Although, a tricky part when moving it upwards into the more common
> > layers, is that those latency constraint values may have a very
> > different impact, as the numbers are platform specific, right?
>
>  From the UFS driver:
>
> cpu_latency_qos_update_request(&hba->pm_qos_req, on ?
>                                 0 : PM_QOS_DEFAULT_VALUE);
>
> In other words, if no block I/O is ongoing the CPU latency is set to
> PM_QOS_DEFAULT_VALUE (-1 or no constraint) and if block I/O is ongoing
> the maximum CPU latency is set to 0 (no CPU power savings allowed). I
> think these parameters are independent of the platform and storage
> device :-)

I see, thanks for sharing the details! :-)

I guess the question then is, do we always want zero latency, which I
assume must be costly from a power savings point of view. At least
during the idle period, while not serving I/O and waiting for the
device to be runtime suspended.

Kind regards
Uffe
