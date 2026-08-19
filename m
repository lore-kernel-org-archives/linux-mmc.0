Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E838A2D7DE9
	for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2026 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787150023; cv=pass; b=BtfsObydnK641BG2xMjteIP4PCugtkSlTyrvkdghD1wMU04QU/38L0ISQCXd+B2STXoWxPnK34WszDQgTfAUN5TqifJU2mEAcP0D0dQOyyHtDZdzrEmFUaR4+MJNAAAKrcaZ36BNPgZNEsCAgOwE1R2nEiRUkec7DOnxqdAv0F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787150023; c=relaxed/simple;
	bh=71ybj3J5oMv8gnAsFJwnucxiEQA5mI0LVBfOSfWmgws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJObD+8py+Zfw8NFSxP6VinHXYtGf9A6au59ID5hncSg3GVHUE9dIzAqkGqXySAuVy+qxxRmC/tRXhwn1hSWQmG7WgV8ZT+sx8d4rcyH0WJeNB/7zAzPm+hBbLwjJWyEBaGItz63+HpXSErTic0a7cmZSOnO92MddUT6qM8GKRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqqimmtn; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqqimmtn"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso1886365a12.1
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2026 07:33:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150020; cv=none;
        d=google.com; s=arc-20260327;
        b=ibzOIuf88oPy1drCISiTW0dxPQ8sY7sV2VYizxB48jB2ffMmqyo3tTVIBDXAleotEH
         BZLQdn/mc3hwxhaFEI3qcgLCfowSzxwHAkmZ6frEOF1jHSPrBA8FKIWszJJLA6nG62MI
         hHW43p20AmIIhdbrtJoLReUMrfbDxk5stbE/OFH4XoEgWTlEQpZN820v0NnvAbJMtDjj
         kYVsRyBRHbJxJEvDt8w6FHw/4w3sjZ+fqjdDb8IGW9XA6kXS1eOMim2HcIc3sHEjY0y7
         Yr6vv8TQhT9ffHxYPHbbXoXQb2R1xgNuixtB2mb0wAS3FasZVakjjSg4EdI4Agmb40uJ
         ioHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        fh=wltirxOJBPYI/yltuuK/9uPL/e1z3y4RJF2kE+AZSbQ=;
        b=XTItBmnTMOA0oEp06L+WouBkeKA2Ik4Vgyn4misN+SM34Zcm8tOUQClFu7OOIELquZ
         /Bfdp9dlrpLcS5+VuLL80TjFT+6RhcIbGSVTsvpvP30EJHXRX5wa74qH+f8MTQJRoIyt
         McjaeugvZeZAAWBWkwEqv58flPqzoLAIWTElF21kU+4WgeMcO2wlrZMnJSPQz46hLeWV
         H7vwemGnZcWGwfEwethW3sumLVqQW1bQ28S9k7dJqWVUBGDk9EorwspIAqD0wtd8+37V
         Yaj3cyeyqpphstB3jjiaIC/15Na83AVxFzdJDc3YEhUv0hyH0zbsDuEpl0DRSREmIwLo
         3Zng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787150020; x=1787754820; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        b=iqqimmtneQwNLwcEPud3BJWbpUeCTQ7VUL890NGB5o0r7TkqRcl7JAWJZiIZXsCfIh
         LuaDMncNAgiy54/RSzREq2W174cjKvfdN0aZcvyQVZ2t+//Lt5Hue4atPzc8rUOiMWb6
         vpucteoHoK8WSa4x/DGJVqi67PM+fdrmAFTAeb04nuL1QmmdAcD6dP8pyBKnw04aKp9i
         Mkszv+00bVe2nb86JINBanK4IcByheXsqG1L21y1fOv7ECQQSzlVRQmHOebbMA3Mijon
         WakqCTuzHiAgO7jIS3oTVp/uInd6BfvxpV28ZuIqhjxo3WWodf6r9wj1d+174nFQUEm/
         VXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787150020; x=1787754820;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MAp55mMLGdj4NQRUlCWpenDN+bi6NWCNXDNRlrNgoy0=;
        b=O9ue9qg0IHTzc0mQAuh+nCQGuBDG5YTyhlBKzdrTPcRJ77/L7uFo3pHlPJHN32Dnf/
         YzUAsBsqZK5gzCB5viS7lCJnm4i40FHrm5n/rDef8ItsIZ3OBJR7hIECV8UwuA+5juEY
         k0rplKCkEEiz4mxwb7lhE7euyTNSVwjoIP51frDYkB1kj1OUlNcpSlevfWzttJnDGw3o
         orU8Az3+dxjTq3HNw6jXZ0N1eF67sJqi5yhUvzgaLGpiLtXydI6qoi10mZTMRvdgyGeE
         7zcIclhGiQhghLe4s6CHbnG+rqMCC+TqRbJ6CXWqoyEINeYvDax2tlKydBFwArJvjy1/
         roqg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5y4WJynOPvq4q/GoVGegre9pTfGq5bqTPX+J3oTaE/gUZtmdItGBfF/VbyM9a8s4uRT/ub/WO7qY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVzQh88OO+B4zl5o7wMZQpmh13tkqI0GzXJ/x23sOSnI32iAzX
	zlBRQkGiPnUgYg5s3QTa59PJU5Kc/7ZEczjzG7HF8TnS14aLWEk07lB1JRJAmJMM9Vsu1MG5M/M
	ydf9opfWLtTtF44W4UDShOwje9pVA+60=
X-Gm-Gg: AR+sD13HEmEEMy6MY+tdWKN1tUYbTC47eGKxEyCNgPVw5nprbgJvge5CrQ42j2s5/+I
	JtNi/yzwrljVXqKRh/tFpoFErEu3BLsMM2XnZOn23xWh1NDeW7uLhXlXuHk3fuCkqf2D/vCgYxf
	jz1mISbpyVSnaqFC5B8YqWmF9erYUDowDvjFxQrGCT5TxAcs4CSNmR1xEw7d15eiqpB7kw9/nPC
	M9c+DtQLpAp3DD9MhJW/fuQUSRxd0gZaR/LQ4tK90PfLW8+XfXWadV6IyX3qkxvnJ7eZVkR0Zdm
	fQNJgILss+10VGrVsA3twfuUHPgKcZm0hrJ9U4pu7sG53CY4PwLh3AoXCDVhbPJOiS9EkfGFS5x
	wo1mwG2OrCbiya9EVzl2CfzUlxgo2kp5G9z0N5wTv7sw=
X-Received: by 2002:a17:907:d506:b0:c21:792:8257 with SMTP id
 a640c23a62f3a-c242e364b6fmr405411966b.15.1787150020054; Wed, 19 Aug 2026
 07:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818210322.53266-1-meatuni001@gmail.com> <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
In-Reply-To: <aoW7iR8Rp4hUCtHq@hovoldconsulting.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 19 Aug 2026 19:33:25 +0500
X-Gm-Features: AcwNN1U2NqsKGE6UtzZCK8YAN1WJvKH2WepR77b6ZIJOP-mGimuqt2krQdAHeEo
Message-ID: <CADqcGB=ZbfAkM_90ty7=_QD3eqJd8f7urXKvTnagdv09U9RRAA@mail.gmail.com>
Subject: Re: [PATCH] mmc: vub300: fix Use-After-Free of inactivity_timer on
 disconnect and probe failure
To: Johan Hovold <johan@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

You're right, thank you for catching this. I traced through
vub300_probe() and vub300_inactivity_timer_expired() again: the
kref_get() taken right before add_timer() is exactly the extra
reference the timer holds, and the timer callback releases it itself
and stops rearming once vub300->interface is NULL. So the UAF I
described can't happen with the code as it stands.

I should also be upfront that this was flagged by Sashiko, and I did
not verify the reference counting closely enough myself before sending
it.
That's on me. Dropping this patch.

Sorry for the noise.
Muhammad Bilal

On Wed, Aug 19, 2026 at 7:19=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Wed, Aug 19, 2026 at 02:03:22AM +0500, Muhammad Bilal wrote:
> > The vub300 driver arms inactivity_timer during probe and acquires a kre=
f
> > reference for the running timer. However, vub300_disconnect() sets
> > vub300->interface =3D NULL and drops the driver's kref without shutting=
 down
> > the timer via timer_shutdown_sync().
> >
> > If the timer expires after the host is removed and vub300 is freed,
> > or if concurrent work items re-arm the timer,
> > vub300_inactivity_timer_expired() accesses the already freed vub300
> > structure, causing a Use-After-Free.
>
> No, this cannot happen as the timer holds another reference.
>
> > Fix this by explicitly shutting down inactivity_timer via
> > timer_shutdown_sync() and releasing the timer's kref reference in
> > vub300_disconnect() and probe error cleanup paths.
> >
> > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
>
> How was this "issue" found? Are you using an LLM?
>
> > ---
> >  drivers/mmc/host/vub300.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > index 8e45dc1a4a12..9f84bd1531e2 100644
> > --- a/drivers/mmc/host/vub300.c
> > +++ b/drivers/mmc/host/vub300.c
> > @@ -2350,6 +2350,8 @@ static int vub300_probe(struct usb_interface *int=
erface,
> >
> >  err_stop_io:
> >       vub300->interface =3D NULL;
> > +     timer_shutdown_sync(&vub300->inactivity_timer);
> > +     kref_put(&vub300->kref, vub300_delete);
> >       kref_put(&vub300->kref, vub300_delete);
>
> And this results in a reference underflow.
>
> Johan
