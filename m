Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746594AEF2;
	Wed, 25 Sep 2024 17:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727285378; cv=none; b=cBulvPFmJVYU/6yojM7z7pL8qQzXvhMNk5fJNYcFXbaw810CvdEWdOY1dYuIY1XYsppW62ZNhFyW9fGp0yPEr3KskzzV4efsLCjQeT8laOdJcnWKp5N1UPgoATW3Pg0XaKygJ5ptH/Pv6k12jESGusWA/Z6XfGja9DyvBCZ3paE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727285378; c=relaxed/simple;
	bh=TPOpswsdijw5gm3RbX6cBpr2bSe4KFnYCCRVAKV7fBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OGgWCde8pjCx/LXSMnmWnkBa8G3z2BvqZBnWBEDULp1t8my2aL6NJpUKN0+Je8RUiAP6PqGwTbtP3svhTfxV+GipWcKjbQ5Pr0iB05ZEJjbLOFhljjcfNAsUucceNEqGrHOuYaCRYTYGLEzX8IuImLBKTf3evcMi+O5QnFMbSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=ZCH7+8Rm; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="ZCH7+8Rm"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206aee40676so472375ad.0;
        Wed, 25 Sep 2024 10:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1727285377; x=1727890177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76c1gfIJ44N/4frQpedFLzuDh4DDf4ytBF5LgFjIvvY=;
        b=ZCH7+8Rm+cr8Q4ZBhABe/IrjKKsJhGXxpwCUuKvgCF8//Ja4aADmPGC3M/VV9H+Uyx
         YFcSbAK+6DKQAtALAAP8OZ9nXc77W8f17RR/G3e6HCJiIJZAdDLCggZa5ouhj0gKJaEo
         u6OOk9ZRrCExcZqbfsasNei82Gd6BzqJHbZObOk6C2CTmxKber05e1PF+qOLXGUsGJig
         3ZTLJELwq/lVXBmO0OM60ePfCGzeEkeW3VBfd1D7XJlJrhKb/ykBXPJYVjhwZRB5iB0l
         F5X1T4wrStj8kqie3OzOQv5BUxa27LUSZ/AVAHmGo9g6TsYikSJreKxBGrMjiyc4ujcq
         qMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727285377; x=1727890177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76c1gfIJ44N/4frQpedFLzuDh4DDf4ytBF5LgFjIvvY=;
        b=qgulJGd0OpsEdjPdjIyRXFHDQKLy5n3Yhchv/mh7ofCUHEsjKHmSEjp3cmRz84mdQX
         Pvgu3AVa9+SNHmqzzLa28q/K4n1oRQvUvrOoD2JPZN2YC7phyN1m8SuMyL9jF7N+OYDD
         WbKSEvmzA4PTad3jGKzrRzTuHhMBdtKersBX3/HXwYKxv2WyRursp1Hf9827YUH2Takb
         XtC9d4ZG/2p4NlYl8z9jkva8zuCuKF8XOgSUOypyPVlV5PLhYWyVBOPg6i2PhpJ8P322
         AE8HmbsrLcMUMTjlkD/P/7wxFizEJmIWaVtJDhrnt585J5m24D64pRXotc5WGZDcpJD3
         Rqdg==
X-Forwarded-Encrypted: i=1; AJvYcCVkL417E1b1+evUQEamco0dXbYj4etnKZNsj7XbsBvtJK3yJnpMElufM1U2MCLtyGSe65mbcSfFLmvi@vger.kernel.org, AJvYcCWmrWcL5rZdVkE1YmPPXeA2CbOgrhOSS2l+wOu72/IJeCSJ85bhni70mPmTIZgRL35BeMxh4aZznxm6@vger.kernel.org, AJvYcCXcp0q0ujHcxUxSTaWcEII/onzrFGItRmpgpouSlBr+hi60cZnl3oEPgS7ncQs0ZbozkirQQR8p7FspnYrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHNqsIFihRNQXWUKz9ArKLs49lkfNg1+iQFcSSoXHmigWNF3t
	I18MdUqDsuPYFjPbBkSqaMQdga4DGkNM+eWMiLpLo/ScUDd71WKA35TACSbfZVgmzphftW5Etrw
	ENQj1IiRQ1MULonWlh5O54a2DqP0=
X-Google-Smtp-Source: AGHT+IGL8Tarnw4aOxyngiyyJMw2bFTvc8HSfobctrnuSaGxAiJN+XPoCfQJeAeS5waKELhDrIf1ZNEdC7ArTM2uMQA=
X-Received: by 2002:a17:902:f707:b0:206:8f25:a3e with SMTP id
 d9443c01a7336-20afc60958amr46716805ad.53.1727285376595; Wed, 25 Sep 2024
 10:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-3-5aa8bdfe01af@linaro.org>
 <mbc2cacow73vmwn3w42aucq6x6xijbpgustkv3v6etgv35xih7@truf2rbgf3vo>
In-Reply-To: <mbc2cacow73vmwn3w42aucq6x6xijbpgustkv3v6etgv35xih7@truf2rbgf3vo>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Wed, 25 Sep 2024 19:29:25 +0200
Message-ID: <CAFBinCDu0P8QEvxrUdXXSVCn-1061fjyhYd2nve9QCCvXmoe5Q@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert amlogic,meson-mx-sdio.txt
 to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Tue, Sep 24, 2024 at 11:18=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
[...]
> > +        enum: [0, 1, 2]
> > +
> > +      bus-width:
> > +        enum: [1, 4]
> > +
> > +    unevaluatedProperties: false
>
> Hm, I wonder why not all slots are defined in your DTS? Why not all of
> them are required? I assume the slots are there always, as part of the
> controller.
>
> Is this because of driver limitation mentioned in the old binding?
The MMC core (still) has a limitation of only supporting one slot per
controller - so a limitation will stay in place.

However, the driver (drivers/mmc/host/meson-mx-sdio.c) uses
of_get_compatible_child(), meaning it will also pick the first child
node with the correct compatible string, even if it has status =3D
"disabled".
I can send a patch to reduce the scope of this limitation: all slots
can be defined but only the first enabled one is used.
What do you think?


Best regards,
Martin
