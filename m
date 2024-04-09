Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6E386651
	for <linux-mmc@vger.kernel.org>; Tue,  9 Apr 2024 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664084; cv=none; b=mtt4eVDuEfOElBfB3ime0cLatKG/TnO9NZDlThkNGUbsSutE2N3Yd6T+fqaXPjlohIgSAeUcGtrJgs5bMDb+abD4KfMNpf76YmYTo5rcIlRsjPkMHWIFBEAV6SyOk66oTCj+GfcYBy/YttoSjS4vg2WiXJUXnWji6InhRt1x10w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664084; c=relaxed/simple;
	bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AdeJrkhCY7dksWu06CX98vXugQaEAchFD2el18COx0ueABxW99RLIpWmPnhu4q2tPWZFczvJ7AeKCcJ1H6AWoVsyRYMsAWKDA0zdcKc9jTaRU9vY8XKwWosLU5OQ4sYGPDUUENGmt8/PuDT1wqGP8vuhHpm+I+y7FIixpxPAbCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V0FxeHBd; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V0FxeHBd"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c5ed27114bso450107b6e.0
        for <linux-mmc@vger.kernel.org>; Tue, 09 Apr 2024 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712664081; x=1713268881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
        b=V0FxeHBdkZQ+o6HC94cZygYR+Xjvwxql88Cyzl6Vpn73+DCWvqcVgSf5O6h0P1kOjm
         79Q5TdQE9wekXswdzU3lNr7cdEuc/G0l8vUmV8W8YVSicbcXijltOdiSQ7M2h+q0Tf2h
         GqHkAqft47gwnupuAbHy7a9S1kpAzGwanRiZIX+USa1U2pVVDtYVi39BoRN0sRtqTjGM
         409fxdb6wit+nAVMq3j55CbfEe07u3w//6DcWDsQKySBInWBLTZiZnf0fiE+TS4oFuq3
         ETHYz+IFw5UaK9G3Ne8sfQR+1UDcQhewD8UQieF1aH7o7NE7Nx/cEGLxlUlZ3ZZEZPXj
         gwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712664081; x=1713268881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/bJkIcYPyNFLkwEnXNF99Y8h0DtpWIDGG30A3oUtr9o=;
        b=ZA2aANHl4YYWVBfg4Tr2+E7lHJaUb6ZQfiZ/01ESHYVDGGOdWh8FO7flNsMJv0DrfE
         Fpo/bwbEKYXHBcyuDM2glQjybjsCpSVF7hI9dxIx8lx4qTgHwpqZfYKfgDczZ9DTT2yE
         M9dH6Hi3ZuQy2U02y1mfPv/1Ob73E4KRwnxFvGXKHP/h8Nln3vqtj/PTlmP/wNa190HF
         OhxuoNqZy94yx2lJG4HcpBZ3lbIDZx2L3p/d9ns5nHIJfNECSxrZssEwFh1BHavtQdg6
         pr21A6lr90zs06wW6zOjBTEMmmZaAL+vvi6HNANrWogXmJKGDBint7DaUTYxY22TiAE8
         +UKg==
X-Forwarded-Encrypted: i=1; AJvYcCVgqzAlnQc7yETNPmyecXDerzo9XdLRJ9+2Fohrj6fVVUi1oxHEH0skRwMC7BNy2jKtsE1OSGcP2GH4Z/bOMhE5wQIWDxwKjfhJ
X-Gm-Message-State: AOJu0YwoeQHfEvPoa5AyfnwI0mBsHuWdqmX5338xIBQJa4TAiac5gnrj
	vzqVMCgprT8IMeJuZR7p3z+16+j2yM7Jhp31uepGY4sSpUnZLrSVqlhS4paAyGo02heRhlknpKy
	SMxluG/H4vBG3OxPn9TlEw3YXPHP6DoS5Yg2FEw==
X-Google-Smtp-Source: AGHT+IHvCXB+IR0sKbXE066F42lsqz3+YeUibucf/KdS8fPmJNMZ+gR8gytCo2qCKC+gCADN5Y/2vZAoWEhybIwI6FI=
X-Received: by 2002:a05:6808:21a3:b0:3c5:e755:834f with SMTP id
 be35-20020a05680821a300b003c5e755834fmr1114418oib.0.1712664081629; Tue, 09
 Apr 2024 05:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405115318.904143-1-jens.wiklander@linaro.org>
 <20240405115318.904143-3-jens.wiklander@linaro.org> <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
In-Reply-To: <CACRpkdYLCuRKZRqRUkav7UoT+0FSaMmciH9bps3VGgxLCw6+_g@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 9 Apr 2024 14:01:10 +0200
Message-ID: <CAHUa44GozpaRSC4oNiGCG1Myv+GE8bvk6aHS0q1ecQwW-YMMUA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] mmc: block: register RPMB partition with the RPMB subsystem
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomas Winkler <tomas.winkler@intel.com>, 
	Alexander Usyskin <alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Mon, Apr 8, 2024 at 11:07=E2=80=AFAM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> Hi Jens,
>
> On Fri, Apr 5, 2024 at 1:53=E2=80=AFPM Jens Wiklander <jens.wiklander@lin=
aro.org> wrote:
>
> > +/**
> > + * struct rpmb_frame - rpmb frame as defined by specs
>
> As Tomas said maybe we can write the name of the spec or the number or
> something so users can find it?
>
> I would also write explicitly "the stuff bytes and big-endian properties =
are
> modeled to fit to the spec".

That makes sense, I'll add it.

Thanks,
Jens

>
> Yours,
> Linus Walleij
