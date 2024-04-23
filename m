Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FBF12FF94
	for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871958; cv=none; b=oNBZki1+qeSsduqXxna8vJH12SLfRMUHEMf5OdWZaV50UHOJDqpUwMlFiVTGUFk9a8CkcPgeNoLxHypvNRhAGKxbo/ohuacwV7RzAwZ2D2Sl9gwhT67roKW2eomfeMHV9JYygq0jdvwKpWzmVXmymD+9ApODHWVbp4/WnUNLcWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871958; c=relaxed/simple;
	bh=6JSkXikC9phwVSWaDiu6ynYlQdgKUl8cQ/ISIuFOuMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muBp8D8rbGqDyGGIrVDH3XOx+0v2gh0nSC3a3nh4egPQhEl3J9VTnqw0YoZ1iPPUiTxmL7OHS3Vhocf8pvrE3ciqJMtySkc/eOlDKjTmJPAuQ/6bmSMzqjI65FfveUlvqO+L50LwcsGLTpTEKsKjJIQkkkKIB3Cful42JP0L0Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QJ162+XQ; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJ162+XQ"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-de45dba15feso5585400276.3
        for <linux-mmc@vger.kernel.org>; Tue, 23 Apr 2024 04:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713871956; x=1714476756; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Et2zyWRxhdaNlGPfinvNaQNk16nd2FcOtU6ILlCc+p4=;
        b=QJ162+XQCqw0xvvc45kuuTzIwsIphznuO/ordGGF1GRQjMit9e5Y059OC6cFdhNp/u
         CavBITt0a9dCs57H9gsBm8x5vPBrK8sthTDf7nF5uWvw1hRpcNTIjRX2Ou9G7sfF5m3W
         A1y2MwXMuz+wzGqLX/9/rDXOxRLSrwFm83DZ4JXxWWKUkk+UG0cGzjp51srPLGlWvJsf
         9qXI2rwm6fwO47Y83KKgNI5BJIu7u7yNlkr9dGsRd4qTQ2ylj9bOj2geSlVxFnz8Tt8d
         JwjRlsxi2qhQuGowVqR/ArGlEqX5dJpEQof4dhjF6ydAqY+y6LvnFR8TiYFPBuNH5gsh
         +EpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871956; x=1714476756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Et2zyWRxhdaNlGPfinvNaQNk16nd2FcOtU6ILlCc+p4=;
        b=nSZvcWRC9Mx9Mf7iJaFzW1UZ/DPaPtmmMJmcISUgmstVwaBkjQNCazOHh3Nyu9uTfr
         dobKEGyII0pTiqtuVoeOn3GEDP7UP7QdVlSKV8Pt8ImHsouYHgsRqxZfoH2TFNzKqC4f
         1cza6P6aPL9mjbk+ItnZKb8F0xSynWpPAopc3/N5M/aruGqh/nTs481PbAD9U60S5cHI
         BIM05z/0443SAioD473Vka4r/WM9abewHUwPAq6DX4y8nAWczzEcZqwdI+i039r0m+qw
         etwYph91Bm4dC7MaVN5yfGdpE/+zNbgaSHzkfp9QPsy3uetRDEAi6ZHp9iCWcGWSLtlW
         NTRg==
X-Gm-Message-State: AOJu0YwFQF1WlznEhS10P6BL+6+FnDsAvHoqPOO2JbNFAVlHQNW9c+sr
	df8D7h35OZIdkLES7YXqIa2qRKRfy7ubX0po2DoWUV89p5zydgAqeI/663ofTOAFxxQ2QeDs2p6
	DJJxTqtXDqnhGzFAkthUD24LxWE8fnijIu7N5LcmnGvcRsSePsLg=
X-Google-Smtp-Source: AGHT+IE/RhH9VTMneQ8oGJ5LGvjil8CRg8sdcJNNohAvUzNf0okh3mIY6SjCpEh/jV76cheiXYuSl8nPr0m0lpgji7c=
X-Received: by 2002:a25:9c05:0:b0:de4:5cfe:855a with SMTP id
 c5-20020a259c05000000b00de45cfe855amr11710868ybo.33.1713871955742; Tue, 23
 Apr 2024 04:32:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABikg9z9NqFwJ5VGtHhtZY9_gNAAoSbAfmAnTHcbp2=b0M3LcA@mail.gmail.com>
 <CACRpkdbGQkVcUC920soft_CLSNiAjHd1QUfv5T=9Wvd3noAuLw@mail.gmail.com> <CABikg9zHfiTX3gR2qUWRTaeuu1FG4rvc7qhJWEj59ukns_-dDg@mail.gmail.com>
In-Reply-To: <CABikg9zHfiTX3gR2qUWRTaeuu1FG4rvc7qhJWEj59ukns_-dDg@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 23 Apr 2024 13:32:24 +0200
Message-ID: <CACRpkdY60cQYOC_-dbs7xgW5OH7oCRO2Y5PEDgiS-9V=4pBj_A@mail.gmail.com>
Subject: Re: breaking commit: mmc: moxart-mmc: Use sg_miter for PIO
To: Sergei Antonov <saproj@gmail.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 1:14=E2=80=AFPM Sergei Antonov <saproj@gmail.com> w=
rote:
> On Mon, 22 Apr 2024 at 20:55, Linus Walleij <linus.walleij@linaro.org> wr=
ote:
> > On Sat, Apr 20, 2024 at 10:38=E2=80=AFPM Sergei Antonov <saproj@gmail.c=
om> wrote:
> >
> > > [    7.018270] BUG: scheduling while atomic: kworker/0:1/9/0x00000002
> > (...)
> > > [    7.057443] CPU: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.8.0-rc4+=
 #225
> > > [    7.064527] Hardware name: Generic DT based system
> > > [    7.069677] Workqueue: events_freezable mmc_rescan
> > > [    7.075121]  unwind_backtrace from show_stack+0x10/0x14
> > > [    7.080930]  show_stack from dump_stack_lvl+0x34/0x44
> > > [    7.086576]  dump_stack_lvl from __schedule_bug+0x64/0x84
> > > [    7.092608]  __schedule_bug from __schedule+0x58/0x594
> > > [    7.098320]  __schedule from schedule+0x74/0xa8
> > > [    7.103368]  schedule from schedule_timeout+0xd4/0x108
> > > [    7.109070]  schedule_timeout from __wait_for_common+0x94/0x120
> > > [    7.115547]  __wait_for_common from moxart_request+0x278/0x468
> > > [    7.121980]  moxart_request from mmc_start_request+0x94/0xa8
> >
> > moxart_transfer_pio() is called from the interrupt handler and
> > should be properly atomic right, so the flags to sg_miter should
> > be fine.
>
> The stack in my message does not include moxart_irq() or
> moxart_transfer_pio(). It is not an IRQ.
>
> As a result of commit 3ee0e7c3e67cab83ffbbe7707b43df8d41c9fe47
> SG_MITER_ATOMIC is used in the context of moxart_request():
> moxart_request() -> moxart_prepare_data() -> sg_miter_start(,,,SG_MITER_A=
TOMIC)
> and in the same context down in the code a
> wait_for_completion_interruptible_timeout() is called.

This puzzles me since sg_miter_start() isn't doing anything
that is atomic, such as kmap_atomic(), which is only done in
sg_miter_next(). It doesn't even look at the flags, just assign it
to __flags in struct sg_mapping_iter.

I.e. calling sg_miter_start(,,,SG_MITER_ATOMIC) does not
need to happen in an atomic context.

Yours,
Linus Walleij
