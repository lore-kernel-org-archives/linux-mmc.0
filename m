Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3443AA502
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774955059; cv=pass; b=ifPjxaCcbe4nTZqu2buve9SkAZ2/y1YOKkMqZpQfIy0TPXwQjoYtrvbpMbITmgP16XH1+JfDpdbZlEj1AqUJg1uqzQYlMvjR4qaVH6nwhVuT3Ia8d2FthO/mHfWLYk+v1NUFdXzm6Z60cH6qggdeIdWdPFhVpI9iqeRw+uW6JgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774955059; c=relaxed/simple;
	bh=+q0hBdBFS9L+ZjH5fY/IXXzHbz9h9o01OcmnbZ0EUCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENpSDN+VfgdcNQLXfCbLoDl1tX9ZyZwO4+yGA5Utn7o1dYYgD3Iz/Ui22O12UQtNfa7VyyYRzU3lKAvMCC92ukboZipTsBnYiwEaX5dJvj55AcjcUIfeuLvonUqGCxzAYh/H4ZYQJRteYL1Mpjns6s5nr0kxem9RACZyBZzLU5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VyGtxGJE; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VyGtxGJE"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a133b686f7so6441754e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774955055; cv=none;
        d=google.com; s=arc-20240605;
        b=lLjkNg7BlRnGiQO4KFZi+nYgJGO8omRdmYcDUqVr8Av6kfkKtTwogKdt6Sagx/SAAQ
         yrRBCdlQX7Px9G5/ymYKlahHloWM+d3hRiqBMuElVZk+O2z8sQJ6JVfXvqY3PCTDvRV8
         R9EiVz011udA2/iIUuGS5mZINtlEW7RWFfpOpbWInFqOJ+hfrhSYikzx9Z9yMFBixkW4
         Nvi+pvD/rUggeGsPbl/3VQGn/+q8Nk0J8ka+xkBg/tWRkjquPwwQO3/hUvWs1GpNZD+6
         Jp+qCDU87PkM0tEaH++lpGpOlvPmE+FdA5O9d5o7mffoS55XVCHL3PalgrW7B3QetcnZ
         QlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        fh=6V54VY1pZjU7PwX0NVbw8/vH/OQCIyL/CxCqsAkH/+0=;
        b=KgC0VEsdj+6qQPOsKN+svV/0Bw4xHwfc8vlBX4uWt7pBnMjkP7t5+Qmav2mOm3/msk
         bGGosHEnilYV3utAA8t+n/J0+ENR9HcRK7UqNUTcC6R/T4ELu0nNHGPn7zPeTa2rx4sC
         5ZM0jOiM1Pj+rCDpxrxw3b8MI0kIQLUrdvybNVDMDmRMgjdAKdehP9KIVTMNpoiVh1/c
         Sqg0SDKw0T2kJlgBXdPVr0z5alyeBL/tL4hLR2qMRMv+2c4udfF1FRLnuCqfGLcu72xk
         apxFaJgklIb0P/siasRy6bCnkUCXfXabDmsfklH/eiKdy5AfSBEZQRTdpOGT94YYpzHm
         G3hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774955055; x=1775559855; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        b=VyGtxGJE62HiYHuY7u5eNhF/MSGRhy2cuMIpz+sSVNMhgf+4W0XIDAIqOxwMLV5jl9
         ZxKEC9yq6bVp9mBtsvZ1CMbkfFLbuPSU9CwEtitZuAl2dS0E5mdlXmdWH74pX7PGKxEa
         IFBvith4UoEHepcHbJlja7jkJbnemI/umoWeQnlb7+ma6OaZW65JyPa3uVYX8LGSrG77
         200rNJvn0hp6KufARQw9XBeKFxGzSI3GqYZ7NNB8OM28Jt1iENge6qG/dRncIE5wgWxt
         zqOKXzFhclbYZPM0/LMEOdEmx+rObGq6KBSmr30fzOQvTxxVa2H2GRM7/quwVVzp41fX
         ZJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774955055; x=1775559855;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYyC5Bmz8Oh01Vq9Hljyc6MoUHIUJ6A6aUIDWO1eZxI=;
        b=fvhenxlF7ktpU7fYKj86Bsc+/XVdvNhuWhSFF4tYU888GTdvqZs6rOzd6Zd0qsr06w
         GhNCjTK04Ud7lIOgFuX6838kUHmCSmzTZpZmVvKdRhGaLNs5dkYqgnzB5VKOtq8bbiCs
         SrsKnp6HZjXAPMWEhXnEmuJqoiCkdg5TXt8G5kY6ckDvc2bvZ5h6XCKJzc0G/3aINFw0
         +vX7V/ppePuhsIHmcS/bIEsJ59RAiVNNWnNrrxJ4OCQ+G6MMu2gEE94qoPj1xOCq5A6A
         F/11UWdKzyItKeWpntZFEBPKcB+yUihKKqXbtUwJZNU9AwewWTEM6IbT3/SXtg3kZtlR
         Haqw==
X-Gm-Message-State: AOJu0YwM6bWm4L5L62319/EljO8heaMvpG4u/YRAULcDNqco+KEgayzd
	WH317tobXs0uvVmTd6PmbAHmLSgsDC1p7fMGfXcjW04bxtVKUUaKXXhbHJfzLr1aP/PmAt38hr0
	DzEec52nUGDFwlpCV6i+I0GagInCn/LVORydGL1JaRQ==
X-Gm-Gg: ATEYQzwwkIJ0BSum85JKc87zDBbU6J9ZllhXA04A0zTbVbPca1dicJz/qW5qFD6wM+m
	Lus/syjMkGP0oXdR5gCs54tJYx3FMUTX1rJBvsQas2NH04xeDrSBO/uk0MN3sJJo2aR9rBmyCS8
	C26m5narapCOMCd7Rc/xZxyU5wO/6j2LohIBTxPhoAyOubbbuFOYI31SeET8WfuJTf0B5viCzHO
	CmOL9Xj3c99w1Gq8BdufTuRBgqjVtDZCz+3BareEpmkyuIquG1VZFEupK/QqkeEj4ZBF1KAzlmL
	2kunlarnBL9IjQdqgn4=
X-Received: by 2002:a05:6512:3d9f:b0:5a1:1d29:e749 with SMTP id
 2adb3069b0e04-5a2ab7eba2bmr7270864e87.12.1774955054900; Tue, 31 Mar 2026
 04:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327105208.1310739-1-johan@kernel.org> <20260327105208.1310739-2-johan@kernel.org>
 <CAPDyKFp1DbRufpro86fXi9xXnJGbWW=NrD3Q0NFQ+aHxhxogLg@mail.gmail.com> <acuiz2y0pIdEwlB4@hovoldconsulting.com>
In-Reply-To: <acuiz2y0pIdEwlB4@hovoldconsulting.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:03:39 +0200
X-Gm-Features: AQROBzDA3rOKmAK4zrEQAayE6915y47sO72Sc-zBqp7MVFgwop6L7ntgv2j6BvY
Message-ID: <CAPDyKFpbcn3SJrZP1SE5VPw4nxk7ct=B80=nD9k2gBdEo6EBCw@mail.gmail.com>
Subject: Re: [PATCH 1/4] mmc: vub300: fix NULL-deref on disconnect
To: Johan Hovold <johan@kernel.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 12:32, Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Mar 31, 2026 at 12:13:41PM +0200, Ulf Hansson wrote:
> > On Fri, 27 Mar 2026 at 11:52, Johan Hovold <johan@kernel.org> wrote:
> > >
> > > Make sure to deregister the controller before dropping the reference to
> > > the driver data on disconnect to avoid NULL-pointer dereferences or
> > > use-after-free.
> > >
> > > Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
> > > Cc: stable@vger.kernel.org      # 3.0
> > > Cc: Tony Olech <tony.olech@elandigitalsystems.com>
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  drivers/mmc/host/vub300.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
> > > index ff49d0770506..f173c7cf4e1a 100644
> > > --- a/drivers/mmc/host/vub300.c
> > > +++ b/drivers/mmc/host/vub300.c
> > > @@ -2365,8 +2365,8 @@ static void vub300_disconnect(struct usb_interface *interface)
> > >                         usb_set_intfdata(interface, NULL);
> > >                         /* prevent more I/O from starting */
> > >                         vub300->interface = NULL;
> > > -                       kref_put(&vub300->kref, vub300_delete);
> > >                         mmc_remove_host(mmc);
> > > +                       kref_put(&vub300->kref, vub300_delete);
> >
> > While this seems like a step in the right direction, I don't see why
> > calling usb_set_intfdata(interface, NULL)
>
> The interface data is only used in the USB bus callbacks and is not
> needed after disconnect().
>
> > and assigning
> > vub300->interface = NULL is safe.
> >
> > For example, some of the workqueues might be running a work that uses
> > the vub300->interface, isn't that a problem too?
>
> The driver uses this pointer to indicate that the device has been
> disconnected. That doesn't mean that the implementation is correct (e.g.
> the check in vub300_pollwork_thread() should use some locking) but that
> would be pre-existing issues.

Right, that was my thinking as well.

Out of curiosity, are you planning on fixing these issues too or is
that left for later?

Kind regards
Uffe
