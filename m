Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86B77647
	for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706099626; cv=none; b=kPE2XZLhe+BnDR4/N6p3f9ukziYb5uiUytD3eYV/jacCeNBJi/+idy/c1misM+jYtyDhrpnOBbe57e931D06xlwRdWLF7Me8o3+keNpprKZUkkp/fTmk7r1Lr0VM8oyt00ALTq5jKReK1utZurhMqc95vRX/tnj0YWH9s0NCQYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706099626; c=relaxed/simple;
	bh=cpiNwEE9Ah0hc4FhtcV39/dK+x1ukcBmQrZAT5YgkPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KU7uTRW7TVtSkJXcxnlLGoGSbBdUc7lS9qw0RyEfspYBCB8Jj9HFNgMdRnS/b4S4fJHZE6HtC+DzPtXr7EOAF59njWA8gYs0bZ34cHagozcEKfMIysROEOBX/kmWQyzwRgeEUoQxAz2XkOtIJOGPdYty+lIDYRw0Fp4w0t4xSl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JPqDJ8Hz; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JPqDJ8Hz"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ffd5620247so35944107b3.0
        for <linux-mmc@vger.kernel.org>; Wed, 24 Jan 2024 04:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706099622; x=1706704422; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpiNwEE9Ah0hc4FhtcV39/dK+x1ukcBmQrZAT5YgkPY=;
        b=JPqDJ8Hz9cyFI46ot9hxvaldzvP+s0zx5lPm0bVIu86wAWgtl/nerjM7HEAH23HckJ
         CqT3Og6zZ4jQDs/76ECEBk9R5fwTOs17XYDwonrpjy3CmtL4n3yDrfcIuYMvY4CKcKEq
         v6I67T6AnztQOFWYvcsbJ8j8xLXR/jFeG/RbNtx+9s13Vn27ltOAOlzs2av9Glq/F4L7
         Wg4l/6TqlKJyc94frK11RhJGLsMXQjyvVXIXIvW+W/y3U9rBH5PGPXma9FVwOFxNcACH
         oa+r46NAo0eQihg8mrOIAfY4ccpHdKeBD6/nC6GQjNlJ+Lu9PBykQnLhvNoEljx79A9X
         7v3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706099622; x=1706704422;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpiNwEE9Ah0hc4FhtcV39/dK+x1ukcBmQrZAT5YgkPY=;
        b=p8usmVrXtIDAou0JSgktzK84jYwUOWBCJ23i4ltjgqHzuxAA0W9jnT4/+7coyiHCda
         qbaUmN4etrS+IA19KUTrL5FBeEM7y3tHMdJDmSytWI/hYnicPw4BZhR6h4dgxWp1FiAR
         FPyF7cbpYdas80u5kZPphmkK6Q7wxjniL6sJ7D09TlAs93xuRSPW4xx+cvA8Y2kHO/jG
         TT2KmXbMIN3p32TrqrnG7iWKVlwix8aKhlHDckTFO3mNgTmyAuPzk3yU9Abw8Qu891hI
         8zSGm+Cr0tjC6L9CojjEs0/KoMJwdJusmqAMXcUmGg66H/uq1/zqoE90F93cAiD2rmsI
         YO6w==
X-Gm-Message-State: AOJu0YzHpBHeuWI572SkD6XXtxLhR3hQCSMRFD2U7S2+y4XrCtuV9B+6
	GE17U7PuR8jerwvKw5hnayDofwmBM3CZzO4exNHDoytKDYXV0KLnwV7YiPJgo3n0D8phfRWzdN1
	mgOEifeFE3XoYnPKAFiyA8NvxNzlI7Y3HdHsn0Q==
X-Google-Smtp-Source: AGHT+IGXhJVktNCrSQyrVAN71joYl0WypGRlCmXcHS57rQZYf6hotNeQTOyL6Gftjs03r/GvLl8hSFKy/sc2u6x244U=
X-Received: by 2002:a81:52d8:0:b0:5ff:620a:5773 with SMTP id
 g207-20020a8152d8000000b005ff620a5773mr633377ywb.26.1706099622005; Wed, 24
 Jan 2024 04:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240112054449.GA6829@lst.de> <9eb0f18e-f3ce-497c-931d-339efee2190d@kernel.dk>
 <CAPDyKFpmEB9FGAmGAQNdEH+DtRtcCNnFszfv_ewihzUU9du+Xg@mail.gmail.com>
 <20240122073423.GA25859@lst.de> <14ea6933-763f-4ba7-9109-1eea580e1c29@app.fastmail.com>
 <20240122133932.GB20434@lst.de> <d2289b38-f463-43e6-a60c-486fd479d275@app.fastmail.com>
 <20240123091132.GA32056@lst.de> <6f38c2db-3aae-42fe-ab97-dd027b90b690@app.fastmail.com>
In-Reply-To: <6f38c2db-3aae-42fe-ab97-dd027b90b690@app.fastmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 24 Jan 2024 13:33:29 +0100
Message-ID: <CACRpkdbw8mGBUOh9W_E=KZQsOpc3TefL3QWApB+t5Z6w6wNRdA@mail.gmail.com>
Subject: Re: mmc vs highmem, was: Re: [PATCH 2/2] blk-mq: ensure a
 q_usage_counter reference is held when splitting bios
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>, 
	Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org, 
	"linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 12:59=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrot=
e:

> Let's use your initial suggestion then and use a Kconfig
> dependency.

I'm looking into this.

> I still don't like how this may impact users that
> currently enable highmem and use one of these drivers,

I'm taking it on a machine-by-machine basis.

For example it
turns out all OMAP2 that use mmci-omap are Nokia n800, n810
and the H4 reference design.

So I am seeing if these can be excluded from the "most omap2plus
systems" list.

Yours,
Linus Walleij
