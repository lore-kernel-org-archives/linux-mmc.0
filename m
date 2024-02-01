Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CA15B96D
	for <linux-mmc@vger.kernel.org>; Thu,  1 Feb 2024 11:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706786827; cv=none; b=JGkngt8JrGiVw5mcyHlBRCNr2jOUk0poZJlKoyoSl/DeOBechQPGHfkICIbYwFqEfx+m7455OnLntwGrQdATIel6cEGSRScfGNDHm/pzOW5dZs/ahH73vx0JgWCWoBH/moDZ+fqBMkZtX45F4bLI1yObzsRzr9a0bJyv+P0EnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706786827; c=relaxed/simple;
	bh=7t3cN4A5Nlnf8vbZj/GgzpI6OT/EQej8eCPkMolSN48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrJtpYiWt6W20xjaJKmsvd5UwExqkIABl+ZsL10AnWK2jx0864rarO86yIW9tSGneFAjns8XKDYYgABkB8z73fAgOrkCeXbKfeQQFaDlmnTdkYcpFNAmfDn59zvYjLNQxTi69Juxc8avyPKkomaaI80yA89UPrlSIyMuUvz/lyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CQkKB6Iy; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CQkKB6Iy"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59a1a03d09aso310416eaf.3
        for <linux-mmc@vger.kernel.org>; Thu, 01 Feb 2024 03:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706786825; x=1707391625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6xvSwpoCaGMK0fP8eY36xc5e6rfWbJpXKZf4oFjUro4=;
        b=CQkKB6Iy8WPZ1nc4Wy8M4ODGe592/Ur30qxkn2q5AzbcYqLL4xhe0NQJ8N/ALrM7a5
         WJdlpOmBRRqJ8+ATJWgzfQ/OYI6nqCidoDNSvbgqVd0HVAOAb+t5ZaZS++C4yzAwx45k
         q7CtX8LMWuH7ktZq8CE+ndw8gcU3MB3AswD+zPEhidqpvLtxKgYdXOv0GvL/rnIYI8NC
         aT241XwR4WLiACswBf5aeHY8YKZ2iMJZN5NaLVHijTUd7Quyi1i83a1BfM+2iBSbB7vt
         c4HAHYVax0QfeGenIu9ZJwrlNoDxjtm9ElGMr2R6P8sJuv91NOMZLaJssJDyWSgNOGoC
         1T1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706786825; x=1707391625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6xvSwpoCaGMK0fP8eY36xc5e6rfWbJpXKZf4oFjUro4=;
        b=PJjz6gzX01Q/MdhKunV1k8pwQhqCfwUEjdtrj9SHMVkaDyDsse7OI2fgnmmSRj3n63
         CwVMY9uAJ2JL/v1hQaSZDz9JTFcliWXPj/K44U4c8PRd4USbsV6SyYUZ5UrRGmo6hqyd
         omv4pUVmM6oMn3QdfL0ywCX9lpzH/1nM8omcyGhmc9jHVZf7n+dHcRTxSCKCC1Rx26Df
         aTiPobAeC8KZ145Osr3XhyQXxyq7PEbKbQXp26WH9sJPTT+hSb5rRqZn4HTg47KNjmuH
         WhP5nUiTHLzzJF4KDti9VbAn/Ze5VgtFpfcuEmgUcjW3ZfG6UZlbrvGHfmwtwFCXSuds
         sPMQ==
X-Gm-Message-State: AOJu0YyhJDahBBT6kbVsB9PJLKaxctY/d6FjUt/EzQ2suvoXClkerjRD
	aqm12gj4yF8wk8E4Ui8paH/CLgFAE3p3WJicG+dLBcRgzlpdqe8Zsi/I7NYk72vKF2mwz3PxWOf
	InhsK4Zw5WC7mVZyGENvNimBzv+3moL4tuVUvzQ==
X-Google-Smtp-Source: AGHT+IGzv5bqyac0Sl+E4Ott6FDfnvYUxR7kEJdGMC/RTOZsnHXv+0sPxgCUUESgqBg+PtcOcG5cX5u/cPC2w3/wXn0=
X-Received: by 2002:a4a:a283:0:b0:59a:3c1b:70a1 with SMTP id
 h3-20020a4aa283000000b0059a3c1b70a1mr4693871ool.1.1706786824672; Thu, 01 Feb
 2024 03:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org> <2024013108-hamster-audacious-9e3a@gregkh>
In-Reply-To: <2024013108-hamster-audacious-9e3a@gregkh>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Thu, 1 Feb 2024 12:26:53 +0100
Message-ID: <CAHUa44HFiShTKrY33iUsi0fq++4YrFva503wh1pJT4GZ7z7ocA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Tomas Winkler <tomas.winkler@intel.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:13=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 31, 2024 at 06:43:45PM +0100, Jens Wiklander wrote:
> > +struct class rpmb_class =3D {
>
> This structure should be marked as 'const', right?

You're right, of course.

>
> > +     .name =3D "rpmb",
> > +     .dev_release =3D rpmb_dev_release,
> > +};
> > +EXPORT_SYMBOL(rpmb_class);
>
> EXPORT_SYMBOL_GPL() to match all the other exports in this file please.

Sure, I'll fix it.

Thanks,
Jens

>
> thanks,
>
> greg k-h
