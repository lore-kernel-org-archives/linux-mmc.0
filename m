Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FDB20B33
	for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 11:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870902; cv=none; b=e4KwreOiTR6TqfI76eNpV7CR3qv1U/fW4qBNFlr9vb2ZYCuPDgSyeVfTcQ2UvbSsyk/Ia71eK3pRnb20ELgpTKJla6o2kEf6nRpF5Q7ml4wTm134G7YnjmjHkaZlRAu35xGkZmi0UFQnwYuALrcQD3zelfpN2isDs4qCogZ3Xr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870902; c=relaxed/simple;
	bh=TNrdjrJZJoILN/45rmpdSnLREc5EJdVy50gX9gqvhx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUVyFlGjyYvbRe/jlxKhtlp4r9ixFGlT+RIP37nov41zjkCQngxic2CyW0PtSpREaT6FRPu/Zq8V/tSgOkEAjmcsBx0dmk5FbuCHEhgWeTxPSxgqY4/gUqfpkWnQAZ89ftKwCZFUQb1uv4Kim/9i7oKsG4ABT3soJtB3s+Sys44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnvDqqKT; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnvDqqKT"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e69a51a33so4978600a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713870899; x=1714475699; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yB8dUQxA6JVlfeRf5lEPQexsRj7D/FW785VvLEls530=;
        b=HnvDqqKTh7j8SBkQfhYagzM+VdHL7aLApY0va0UnfyjC7pJS5P9ovUvQP5kVCFjPpZ
         0vvPTibs03V8CbHgtFKTOpBdG4UsrJLGTFmqYo0fe4UdkYgaD4IzTpiifqBU2CDLCWoP
         BNyHY+Z1GbOMCEMKiHyeNZDegVYBPdVVJL3zP/4UotJLPr1x6znmwnaUtHrgTMaiUEid
         0WhhyNYPQNi2j3XgNUIKnZCOA4zJJxQYOsL10izQXCEHO5gfj0ELklerk1jcsXZePB1i
         h5lKUDBPtitFliz4SzAHH+J+UbC0b8r6CmY1AvdzQjZCZQ/ZCbc6CuNFYvqtL5bp1fK6
         /GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870899; x=1714475699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yB8dUQxA6JVlfeRf5lEPQexsRj7D/FW785VvLEls530=;
        b=rRDXm+Rbw7XamAOdoo4a/fewmmjEYcuaxwcPjVqJbrcfIK1ZWSMD/ygDJKpXXTJ+OD
         A8KDKqo9EWJCWU/u5WbarSpkW/EdzJODVmQgkuTDe9//8fRiY69g/3M1lGucwjxKM1rH
         es8opP7evveC7iYRmIY+zTYRTmd+n69KsAZwtEEXaS+2x8qp4KdmbdsQvQOAGZxwJHvr
         5UPk/JEeKKwlKmTf4rHAQXNt61P9mQyDRc7mKDAS/0QEP5WSIKcxaVO6TbTZlbVQg/Ks
         lmp4zoqqzzF6Tmv5frhdvcxNsJKHrPmWxqK6d+5E/fM36q6Zx+xCCINGCc2PNHdhrM9t
         +OLg==
X-Gm-Message-State: AOJu0YzX5uMuNQzyEK3Yf61gngr+2wFspL1Cm9kBK/Ncs/2M6WNl8Xgv
	IhVFqAfG30Ysl0UEQuZSmnYHsc9HR9200SW/S/Xa1XIlHjnWi5tAoPyoM/NvRVNhN4utEJ0iecA
	6e+sYGaQPNx+QbAO+tVp2eVClELxxYFT2X4Q=
X-Google-Smtp-Source: AGHT+IHMK40y4nRLrObK995F6Bq0vqowl//pILEBiInKLTA4gA2z/WRNX55AxnhbjPehyAangSROKfEDBQ8kcvQ+CwI=
X-Received: by 2002:a50:9ece:0:b0:570:cd6:8ef with SMTP id a72-20020a509ece000000b005700cd608efmr9766946edf.29.1713870898862;
 Tue, 23 Apr 2024 04:14:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
 <CACRpkdbGQkVcUC920soft_CLSNiAjHd1QUfv5T=9Wvd3noAuLw@mail.gmail.com>
In-Reply-To: <CACRpkdbGQkVcUC920soft_CLSNiAjHd1QUfv5T=9Wvd3noAuLw@mail.gmail.com>
From: Sergei Antonov <saproj@gmail.com>
Date: Tue, 23 Apr 2024 14:14:47 +0300
Message-ID: <CABikg9zHfiTX3gR2qUWRTaeuu1FG4rvc7qhJWEj59ukns_-dDg@mail.gmail.com>
Subject: Re: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Apr 2024 at 20:55, Linus Walleij <linus.walleij@linaro.org> wrot=
e:
>
> On Sat, Apr 20, 2024 at 10:38=E2=80=AFPM Sergei Antonov <saproj@gmail.com=
> wrote:
>
> > [    7.018270] BUG: scheduling while atomic: kworker/0:1/9/0x00000002
> (...)
> > [    7.057443] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc4+ #=
225
> > [    7.064527] Hardware name: Generic DT based system
> > [    7.069677] Workqueue: events_freezable mmc_rescan
> > [    7.075121]  unwind_backtrace from show_stack+0x10/0x14
> > [    7.080930]  show_stack from dump_stack_lvl+0x34/0x44
> > [    7.086576]  dump_stack_lvl from __schedule_bug+0x64/0x84
> > [    7.092608]  __schedule_bug from __schedule+0x58/0x594
> > [    7.098320]  __schedule from schedule+0x74/0xa8
> > [    7.103368]  schedule from schedule_timeout+0xd4/0x108
> > [    7.109070]  schedule_timeout from __wait_for_common+0x94/0x120
> > [    7.115547]  __wait_for_common from moxart_request+0x278/0x468
> > [    7.121980]  moxart_request from mmc_start_request+0x94/0xa8
>
> moxart_transfer_pio() is called from the interrupt handler and
> should be properly atomic right, so the flags to sg_miter should
> be fine.

The stack in my message does not include moxart_irq() or
moxart_transfer_pio(). It is not an IRQ.

As a result of commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47
SG_MITER_ATOMIC is used in the context of moxart_request():
moxart_request() -> moxart_prepare_data() -> sg_miter_start(,,,SG_MITER_ATO=
MIC)
and in the same context down in the code a
wait_for_completion_interruptible_timeout() is called.

> The way I read it is that the completion does not arrive and that trigger=
s
> a timeout, am I right?

No, timeout does not happen. Function schedule_timeout() is named so
because it receives a timeout value as an argument.
