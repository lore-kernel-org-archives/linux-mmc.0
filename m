Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358493D1CB3
	for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 11:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956417; cv=pass; b=IjRaQBPwNQlIeBV4CQiJCSPaqfnUR8/8cgGoGxJt7wQPdU28GdK8gWBt8sf8uNMVT4ZgrBo/AX+vKsi/WAZaF+0IEVgsV4yvEMeCLjJbLnxWxthV2QO0h4eGC4Y1iDqeGzc7wbSemxF0tp24ldzd+Xbt0v+IaAkCVLwCmt3cEAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956417; c=relaxed/simple;
	bh=PFCBmuwuKEKtQ0bPc/Rwi452Am7mRq4n8aDYWPjSjzo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oviIUJE1brrH6pJkmGrqLRnS7vob8SamG9DFMRmJNYFQmvHHfojm+bevulSsoaoDFdfyBZyOqmq8LEZtkBRE/Hav8rzJQTOB8SmEh0XnA8zJNbcmrjiU5AjQko9P86iUP2kagjkP/ywMTaEgpWhv1cv/8KIOaaADNIx/ieRQw8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=icmuuahh; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="icmuuahh"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a2ad56dbb2so3607783e87.3
        for <linux-mmc@vger.kernel.org>; Tue, 31 Mar 2026 04:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774956414; cv=none;
        d=google.com; s=arc-20240605;
        b=AplIB+ZWr82mPBln5W8WlC1N9ao2gWAeZ9NCRbAdAUnsvtCtl0MBkqQ1qeT7S6rvIZ
         eP98DbKJgm8XrwMLNk2jl9Jklm0Xr8aqOo6Fe3gewWOMZj1d5PGCLMh9UQ+dZViilT6q
         i+cChsGrezzUNj2gUUUzqPa9tPO2HmysFH2J5xf1f5Mvp2Ym4v1CyZB2zc5KtWUT43bc
         /Yr7a5IQDc52Ik/zbFY8AlJRg/4sj1kK/LzjHF5lTfLKEBH8dxC3OZS9EfZldpiXUcyx
         11SpRrLf+faOiCjfeLWSln2ubZmlQSQk/JV6RMdLPwgMYhFKZxtqi+nNh0Gz39Zl6HeF
         9/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iP+XvAcB0McyuH4v01BHzzfnUMiwboyQfOJw5woEYVA=;
        fh=DRBs8uPhZAo4yO0s21pj3gq1Cfcavc68A8Q5ffnIRkw=;
        b=h9YQOAwk9Nmra8UWBwer3kn8Ui0NqliEzHjbuidBa/1S1L6EeioqsBMd3niuG4NEa4
         cPHveiVbpNxKve9pjwqiKCejbbuVGNJRrrt+m1xghzyRRgD0na6F7oxBOspXB3+G10nA
         oKH5KpG8LAaIedQHXyWRt1tVo9QsxEk1AdCtewu5eE31CMKMRwFIFm9SMPZNoed04C5i
         OAJ5/ZmC9HFjWQjmcsI7DAso/dYDm6KOOTHxGlrZqZjp97IKj0MB4segDe1XM3DMEIpu
         8+4tslEvAy/2sONfxpR+yI5cnDcSiouDwYe7XN0QHYFUxV9YoTF1O0r7GsA7oQKi+TBu
         tzlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774956414; x=1775561214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iP+XvAcB0McyuH4v01BHzzfnUMiwboyQfOJw5woEYVA=;
        b=icmuuahh5X89FeUvS2Jy0gDfrLgQagi88vflKfJmW0n18nTSBqxM072rqDbNAa12wR
         1QxzMk84i54x/boxh2Z/8q1nNltCVDTZAqP3DL8d6WjtG70fbXIAHvtlBLV5q/REOTD7
         bVpxMmJcDyENct7xoj6H6xlwoNqwkf092LH0MO7fQkckDl9tzRhXv3/TkGOKIIVrpP5g
         UNKfeDVTRsoa/JrtTSfA8ymba/VMznbQIbMnow0Qn3bpqM/p28HvqCQ4xT8oNwf58yhK
         oCS05fQdB1DPSSFh+pnO3aD45ssX5hCcgFfnBDxZciGbHFAmKkrjRKRaHTbAOKuBJX/8
         u+9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774956414; x=1775561214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iP+XvAcB0McyuH4v01BHzzfnUMiwboyQfOJw5woEYVA=;
        b=EJCRB1xPvmM7kVwHd28hP00QLooN1XipX+eXkFZOXMG5RynN7zWqQnfW2o8iWj4wYD
         rJFSZ5Zh0zwQ2rOe9ISE3uZGXxq1m/sfG6R9L6FkBkrERL/o5pRzn4Udb4zHnCT4YSvL
         AGxuep6HKXSTZwCATr7Fw49FgTC1OxUpNwk5LNfaXU9M3XIc0T5WAygwVtbDQBsDRTTc
         aq8FwdAhGtgFhGMFdb2GHEviu+g7Vt0QGhprED1NgTXy4RG4YfxozYXET0CST8YCwKp2
         JECiuQo9oVIPtaWRRPeNDQr3XkEtKCWgnax/JTBsYlZlBy81aQgHv9z1H+bQvvEyCBnK
         Rrjw==
X-Forwarded-Encrypted: i=1; AJvYcCV+3QWOHdZf19XiC6gFbBc9fIF4trqRJwHDRvAhVolYZkMXetIsE5EQyKM1YDAir1bGbzuu7qbGhgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCBO/XluFTfybUueIlYUgqtQrbzEzGk4hVkxGPmzBXa17wiF8p
	ffr9H/4q+QO2srsqd2uiPccdnzf4GGQf+BiTxUoQJ6CD2Vbuh894HJ0kWcdczQYKJ5e8m+Mdky7
	s8erQ0JTGLLv6doPz7AIykryHx2WP5WzgHM0fQWVXIA==
X-Gm-Gg: ATEYQzwRJtoUQp2PPVw/gjwtHCzuiSVXDJ3KXDEH46sTyR214dCsX/Sig8FkRxKiP9h
	lqBk0toWoQQObLc7nUzPRTkVC6d0Yj6hGC6TgDClzZ4r9U96GYpfivvCRHZ2Hl9KdlYLPnvtM8R
	adJp6+fnqgTNdXk4u295lthPtGYLfw+bXmzgtv27yRYeUy4d6sWHX2IwjpWv5PK4xrdoNDaB7QX
	5ldhYxrJqzXAc6MMxbdc7sFWIU/zGpcEibUQ3O3EqB1LKWbu5vmn2LcV6beNCsZURsnEiJXtU3b
	TWjKuKyL
X-Received: by 2002:a05:6512:691:b0:5a2:beb2:d440 with SMTP id
 2adb3069b0e04-5a2beb2d489mr790442e87.22.1774956414346; Tue, 31 Mar 2026
 04:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
 <20260330-orangepi-sd-card-uhs-v5-1-bd853604322d@gmail.com>
 <20260331-eager-kind-civet-62f60a@quoll> <CAPDyKFrafqhNbetL5kOzAFO526yUrJWa6mS_FPX-cw9bj2Mg4Q@mail.gmail.com>
 <1c1b12f2-b305-4341-8269-788fb9e11cdc@kernel.org>
In-Reply-To: <1c1b12f2-b305-4341-8269-788fb9e11cdc@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 31 Mar 2026 13:26:18 +0200
X-Gm-Features: AQROBzCzMHq52lgKp4Q316ICmztzPT5EZmpknBt6jAeduwaEYdNsbbTouxZZ4hE
Message-ID: <CAPDyKFpXq7_UX52zH7MvvYJVdRML=zeWw0p3izG7_EHRA8Te2w@mail.gmail.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: mmc: spacemit,sdhci: add pinctrl
 support for voltage switching
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 31 Mar 2026 at 13:11, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 31/03/2026 12:58, Ulf Hansson wrote:
> >>> +        - default
> >>> +        - state_uhs
> >>
> >> Instead: uhs
> >
> > While I agree that "uhs" would be better, we have tried to stick with
> > "state_uhs" for legacy and consistency reasons with other mmc
> > controllers.
> >
> > No strong opinion though, what do you think?
> >
>
> I missed that it is already present in other places. Is the name coming
> from any other referenced schema like mmc-controller? Does the existing
> common driver code expect state_uhs?

No common schema or binding states that it must be "state_uhs".

It's all described on a per-controller basis, but I was thinking we
should perhaps make it common at some point.

>
> If yes, then go with state_uhs, if not then let's switch to new name.
> Old conventions in the bindings can be changed, we already do many
> things differently than 10 years ago (e.g. no underscores in node and
> property names).

Okay, let's go with solely "uhs" then.

At some point we should make this part of the common mmc-controller
bindings too.

>
> But followup question - the binding is called sdhci, so maybe sdhci
> common schema should be referenced?

Yes, that seems reasonable.

Kind regards
Uffe
