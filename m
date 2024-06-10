Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC57780C16
	for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 12:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023965; cv=none; b=rKRtzT150b/yaKvw5omSpbAWDP4F2T0xn/cdHiX3Mzas28W/hDhfXbB5gHfusW/XqRKdtKtrTFMdUHzRttfZbLTTCvYSqqCvSbGgqCfwDy5ZmsuOJiqch2oHc4iPWuiULV8/QHWZR/doA1BxZyGYaCQa7+AR6UUSL4YN3N9nqb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023965; c=relaxed/simple;
	bh=Pb4ILEn1rx7BaUK688G74zQ8ueGofBspL2NxeMpyZXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SVhOKU81E31x7ubRID4W+YJji6eaLFBm2jQ+ZJFfLZXY5k0/L0PoF0O4rpnq8byDKsGQp1pY6unkqwWArSaDTiIQ2TAQ3I0dDvnYmHQzqZVss4dq396kqJPgXN95qvNnL41zVW9uCOrdILXK7TxCi/7xBBB8g2UXYq08uU9DgX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KQeiIwpl; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KQeiIwpl"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5b9778bb7c8so2217168eaf.3
        for <linux-mmc@vger.kernel.org>; Mon, 10 Jun 2024 05:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718023963; x=1718628763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNyMG3UNAL6Sc8i1K2Tl8gyCNYCtq54XofHbrxpAG/M=;
        b=KQeiIwplc6apgOu25MCr8dRl7RR+RWss2dc7rZVLhom5KTEHpcoRyMTw/1eOQRTN+O
         y7O9BlRJwePfyGQXhAMjQway3wfVCaUeUPnRE15Y/ue3nqcJFeXDceogfcS7EhJTfhKu
         m363niMfsEUW41I1tm9r8lP3bDpeZxNKSx2RNjbyQy2Rgjs9Dp1VVr2UiOw3Z/ik7sYY
         3/DWI6s6pd2zwLHxpMcUjw2UeTMbDOFUz4/7/cK8UrG2OIYhphGNCfwSqBGdmq+gju06
         25/vz74sPN+92ihK5okPPJETNac6hL8NZZ1nw6OXJgWhXzbY8VxEjyXkTQwi+GH+lTNv
         8GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718023963; x=1718628763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MNyMG3UNAL6Sc8i1K2Tl8gyCNYCtq54XofHbrxpAG/M=;
        b=HKlGldWyaE7+LL0ooa0XZ4H2s/HcM9BqqjsuLG1qBcgakZhivbZSIFQp1m6JhUvofA
         wiba/G9psV6smPZaY/oM2TSg5WBdYomRhiyE1QoR0GiB0kM7t+5aaUPTNb6miayULog4
         nbSwl/l25XPCdaxMtSMpOKL8QnaDpKZv/wirW+Wu5GE98rhmnlViiZRwv/Dnr7ivJYYv
         9E6ebQYc3pJniMXpjPd6cwV/XXFmqoc1svEAl36/3FSY2fwULe9wg+BTQipF/07r1YSo
         HNyRPoxoZp8ZltdGKEUaV8gznToqaz60PfRPoVcH+315N5wcVpH1INSttA0KjvrofJuj
         /Eeg==
X-Forwarded-Encrypted: i=1; AJvYcCWV0CrjGlLmP7G4y4FbJaE1LevpPkQocpfVU2MQxtKTuLvDjrD6tgUDTF8HDRqdGQA7QJfj8m57Z8Na0WFK7kQSEeu1BzLlefOR
X-Gm-Message-State: AOJu0YxMRRYLVI7Lqg7plfIfmd82pgDp6ZSQvduWpbhIaiEqbLgo57Ih
	EadvHKjhls6ON5CbiPWE/UTod1Z38J6HoAha1k3fj2EPtV5Euk8iLXddL4CBBejobMiI0CVbNTa
	8bBteGh6gV1mYOfRjLEMG+lrIApFNHDPLisu+gQ==
X-Google-Smtp-Source: AGHT+IFFE/hFRs/En+Bg22yshxU9afylbEt0nscWxB/+DIRAwe3OFfdP/zEyzYCZF/ZLgGKI6XzonkiYq5JT3bsnmVQ=
X-Received: by 2002:a05:6820:1c90:b0:5ba:e2cb:c853 with SMTP id
 006d021491bc7-5bae2cbd02cmr4030715eaf.5.1718023962852; Mon, 10 Jun 2024
 05:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527121340.3931987-1-jens.wiklander@linaro.org>
 <20240527121340.3931987-5-jens.wiklander@linaro.org> <Zl2Ibey9Qck-VLWE@manut.de>
In-Reply-To: <Zl2Ibey9Qck-VLWE@manut.de>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Jun 2024 14:52:31 +0200
Message-ID: <CAHUa44GAiUf9+PxqhXOwGfOuc250YDyJ7uzGe2B1bGmBw2iegg@mail.gmail.com>
Subject: Re: [PATCH v7 4/4] optee: probe RPMB device using RPMB subsystem
To: Manuel Traut <manut@mecka.net>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
	Sumit Garg <sumit.garg@linaro.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Bart Van Assche <bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Manuel,

On Mon, Jun 3, 2024 at 11:10=E2=80=AFAM Manuel Traut <manut@mecka.net> wrot=
e:
>
> On 14:13 Mon 27 May     , Jens Wiklander wrote:
> > --- a/drivers/tee/optee/ffa_abi.c
> > +++ b/drivers/tee/optee/ffa_abi.c
> > @@ -7,6 +7,7 @@
> >
> >  #include <linux/arm_ffa.h>
> >  #include <linux/errno.h>
> > +#include <linux/rpmb.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/sched.h>
> >  #include <linux/slab.h>
> > @@ -903,6 +904,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_=
dev)
> >       optee->ffa.bottom_half_value =3D U32_MAX;
> >       optee->rpc_param_count =3D rpc_param_count;
> >
> > +     if (IS_REACHABLE(CONFIG_RPMB) &&
> > +         (sec_caps & OPTEE_FFA_SEC_CAP_RPMB_PROBE))
> > +             optee->in_kernel_rpmb_routing =3D true;
>
> The SEC_CAP_RPMB_PROBE flag seems to be missing in optee_os at the moment=
.
> If I remove this check here, the series works for me.

You're right, I missed pushing those flags to optee_os. I've pushed them no=
w.

Cheers,
Jens
