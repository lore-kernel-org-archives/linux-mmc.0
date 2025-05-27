Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AFC225C6E5
	for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748355788; cv=none; b=l37k5ZfMOss79Pqligote5s5yQNaUAij0LaHVJgsIG9ColKsiHsSFEuiy5kuYbcnC7s2fQgSGMqzuCuv8q6JBpPGH6p3hfc5bfh0QBClHcrRM+G0cZ+4kxVSUu8BPdOTRd4vlqUg6VqNd0eEVQWaiUtzuFfg8L4VB4QIA0y1zFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748355788; c=relaxed/simple;
	bh=GeB62PA6t8IjCpMcu13Hcc0CWge31sKUx6kCXDcp0xs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fPOOV4FZskAxMWgu7+CjAO89I9JU0LVzcUrhssetnL0o/wu3DN9dtntuXDfivv+vEgz7qT48nNa8mGVp12RGzX3nAiD7k6PlNW/+H1gGEqhY8eoCOS+y/gAJzCNrmPDQmY6v4PWIb0o0FKiQA6TD5JVKUTMwK1Q38jBkwJOlFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KuEV+Mu9; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuEV+Mu9"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e7dcd60c092so376280276.3
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2025 07:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748355786; x=1748960586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeB62PA6t8IjCpMcu13Hcc0CWge31sKUx6kCXDcp0xs=;
        b=KuEV+Mu9KKe765my+JosExzT7MP3Qu3NxFkWyFpFbfoELseaQwqEysI6SZt6pmr0qH
         j6uhV+iXqrbMn30jvFP9vQtQaZpo9RLdWmmXc8kDVaCJSBCwpJR7H85nOuGQrmmR2kkd
         brWlXfTKdO1YlTWF0O6zdacN61AfQ6BK0yL2kpZybx3O/P6QYKdluku/CqU+YFRopTbX
         3zaVDd22+8w4U2KbtcXBPBcE4N5oFqHU7t5p6fJziEB4mV135wQCUAEL4L8ous8ZqF/x
         el60O0kuKsImZ0bSzvE8mb9lhZmy0JK3jPr0Met4OCAQ/K9UJpkrS7daCvmQDz1bqB5t
         U4EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748355786; x=1748960586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeB62PA6t8IjCpMcu13Hcc0CWge31sKUx6kCXDcp0xs=;
        b=mHFlDYmpoMUAJIKOp4iG2nrIgwRgrZImuxRgKIoH9boNGC9QlgjiZhyGWfOC8RIP5L
         AQXWOMMVsoDA9UTF2b75QXz2HXXOidzXW422sTgqmeMCXufCAfh1gXe95B9J/ZMjsste
         e3GunQ+dx2DaISamqzVIA9Y2siOPmfdcLTwqSPPllj4E6HiQuaFNPvD9KwH0yCD8JB7d
         KDFX/twMN0XQAHGM8VRzAlJ6Il8sp8YWYL0apJCE4g4S8W9qqDqijs1grRQ48LIT047f
         EM1OOkNFbr+z58t5LZf7DIwPONpcsg0EIIRd4S1MUSqkg00SwpvpVOdQxC5TPHO/FSxA
         GSLQ==
X-Gm-Message-State: AOJu0YwH4UJbIDKSXxABJa5pCTqh5GmyJS6cfSQvGoH2gxjI2WGkkMhG
	tdIXoPx+yiMH3+C34PiITMM9Xz1SdIPJzTV8ZK6/pNf854twafGtIq3o41smtxxYQYigC0AqQxy
	fw6FrI2Du9GxbMpAXCuVid5dWUZLxnjBC7HaC4+4VK5n2aeiwExnMfIA=
X-Gm-Gg: ASbGncutkG6wDJKmdFsSKHlHdjmZuMMqFFpV4pCcDQ4oMWxvqUUv7xGqnujbhc9gC+x
	oAT2s55VTpsw7j/vjndIv5GSNusBdt0W7Y8VyfaBG93VjBvLSGcgedfhKkiJG+rc8GDRjnp5Rfg
	Uo8CKJUqWqwbiQe+9xOeYzJnDYxNwQTU17aA==
X-Google-Smtp-Source: AGHT+IGdG13wbjfNkvb/R+LmaTJPj7Myx+iTsl0puM5AVsMSqytz8ICXBA0GvvrlgsdZY2OyK9J1gW/U7NQdPsRhzxM=
X-Received: by 2002:a05:6902:2b08:b0:e7d:6437:2408 with SMTP id
 3f1490d57ef6-e7d91d4b1f6mr14555908276.40.1748355786006; Tue, 27 May 2025
 07:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250510031945.1004129-1-git@thegavinli.com> <CAPDyKFq8evHyh_0QacZq=d36vXfrs3vFPsAuCyFdv3BKh0SP2A@mail.gmail.com>
 <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
In-Reply-To: <CA+GxvY4ByPW4HVJfww2v674f-y5kuqKmY=EB8mD5jnRcy+HmPg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 27 May 2025 16:22:30 +0200
X-Gm-Features: AX0GCFvVw5zx2ezgMVxOD0HqONpZolDYT8Ly-0SYWDxKVgt99n0SlW0ZZipno3M
Message-ID: <CAPDyKFrXnVkOatAF_adg67LxfU7YOqeR_49_u2mOQLntQcCBfg@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: rtsx_usb_sdmmc: add parameter to always poll for
 card presence
To: =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>, 
	Gavin Li <gfl3162@gmail.com>
Cc: linux-mmc@vger.kernel.org, Gavin Li <git@thegavinli.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 24 May 2025 at 05:37, Gavin Li <gfl3162@gmail.com> wrote:
>
> On Mon, May 19, 2025 at 7:50=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
>
> > Moving this problem to userspace seems wrong to me. We should be able
> > to do the right thing in the kernel.
>
> Unfortunately, I don't have access to the datasheet for the RTS5179 or re=
lated
> chips. This is what I could do to get my own hardware working, and it doe=
sn't
> make sense to revert to polling mode for all users if the interrupt
> mode detection
> works and reduces power consumption.

Agree!

>
> > We should be able to detect if we are running the broken HW and in
> > that case, set the flag based on that, right?
>
> I don't know of a way to do so, especially since I don't have non-broken =
HW
> in my possession. On my hardware, once the device enters autosuspend,
> inserting a card does not trigger a wakeup. I'm hoping that there's a way=
 to
> detect the broken HW via a hardware revision register or something simila=
r.

Yes, something along those lines would make sense. Let's see if Ricky
can advise us on how to move forward.

Kind regards
Uffe
