Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAB41DF963
	for <linux-mmc@vger.kernel.org>; Mon, 22 Sep 2025 14:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550865; cv=none; b=XSJDBx4Qez/qZXBKQx/0tIYK22bgxO5OKgdamdax5GnZWbDukVnMQjB0Nsu1vDQCYZUODExlKJdrw0ltILucRYpDLXOgyVrzXFBYsbANsbR3fTtDpr01BQb73g+aibWq6G8KWBY+9rmB6a2gBQBX1+8bhxEm/GXk+G7e1VQGvyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550865; c=relaxed/simple;
	bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUztMe24m+qcfCgziWRKo2Q8LXR2RRF3po/ShnNs/NboOWvQ9wZAqnbYii/X8Nyu0ODCxt8hScwssS50tBoJIcL0Vp2pO/PePYOv/B5N+EI00hQ6HzswKlV85tT7Va5676OMEy9+xvkFPMmwzY6L3XzO7DWwinwuIXkMMiQion8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xmDGy+ST; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xmDGy+ST"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57afc648b7dso2705276e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 22 Sep 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550862; x=1759155662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=xmDGy+STUmXvdAJZ0LPjBV1yp4IwEktn7OtJPwqszQGAibeAm50CKoYPBSFDur6O5k
         YxgwbAzPbvlH17GdsSgow65hWx7+QQbk/ydzLml3jOScoZyeDOG4JEPy0L2Suu5AFVGJ
         pOW2VEF/PGAVH0iVvunzOleqiTKo2VTEcWdq8k16ndTSmuYjB/YwouiTdPQTb+2OcYjD
         vGgyTpj0TCpKNXPjXtJLKpeo7ln+JUULrnpOUP1vhsKR4UC12JT8l69KH9BQLE2bBMdV
         JMX98k6kQba0kM4u2GF/jEWhUlzOdQdS78ZV73oplEKcupAak60k75nA1BClFMwmJ8LY
         pnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550862; x=1759155662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=RFALFvbP1dzedDoXtcfE8CIz7c+r+H4xwKXX9UsBcRoQJg4px8s2wNBas0+f15Dn1j
         DbfJ4I0G9ShTZco4CUTGkMXwZftocZWhnvjg/DZ+OqRnOApv6HPLWoF+6XsNDUE3qHbM
         EmgmtyjFvvDrIXFdmZMUHHliaekeliauZlth0EhawoIQOmLB16LoK84jCzso78tQr5Fc
         SMRqEr8dgAi5vMOMoHIn7EzIHQlAAqzzXnHH1tJD8YT0cq7YsJ0squPeLLM/14l9M7rT
         yjZ2nvetK0wIyHg41/w43C/N+1amMdnh8eOmwBk2TMTEX/p7ojdXdX1ivJ25HpiU9yhQ
         ociQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv827wJO7Nz/4Y8T4ceLoMi6hxLU6w0lC0V2yW87UiQHTXO+2WwbvssistMy3MnwTCm4RLjCYw+bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJy+gKiFGSgXe1N7jEAT2iZvB9gTG6OJ//zgZhQzWM5B3wP3gU
	rqbB4y1h14J9CNwKECQ2fekIXOYsN8p8nzdn+3LEuEHbuL6mYnPQrr0T44dmiDIv3tsuDH6K5Yj
	9L3zRdIzT55/Qa5fgAFZU8XEVXnyxeAtz9/J8/wUR+Q==
X-Gm-Gg: ASbGncvp779E8APZiWXl0J3i4alt0QZDtWBTSM2RcomlwkntYZclJoq3k0DKBvZSyfg
	2lw9kMXaCxrbTj4tjMovRjtCqteTQtXvtD0TytwxesyQtfhitF3imsj4p7u1+StUPw6V4rCct9m
	wE82Yehjwm6uKxR5pd/V5APrTB8uTHeQZmoSSU1+0RtIduuuCwy7pbXb+Q7FYIO1bWVVZP1Fxaq
	pIB5urV4N5jaaO3TfTxJ6NbaUBUsV0mDLuQ3Q==
X-Google-Smtp-Source: AGHT+IH7ov3L6MY+/rmciyf47ro1aYeL/sC/ClPN8jzfMPrPzjD7iBzVpIdeYJWjKJ4AasrYgahlFBVLjb5jrV6WEng=
X-Received: by 2002:a05:6512:2305:b0:560:9993:f14d with SMTP id
 2adb3069b0e04-579e1b68f17mr5336192e87.3.1758550862286; Mon, 22 Sep 2025
 07:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org> <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:20:50 +0200
X-Gm-Features: AS18NWCnht0SxyHuFtw_GctfcVE1YPQlre0zCChnlr1t9VjjDpuBjNY-9qJgvpY
Message-ID: <CAMRc=Meh5WJ_C1wMjAk9CzFW729QfX_Fbq5diZ99GtsR43k8ag@mail.gmail.com>
Subject: Re: [PATCH 06/10] gpio: rda: Make direction register unreadable
To: dang.huynh@mainlining.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> wrote:
>
> From: Dang Huynh <dang.huynh@mainlining.org>
>
> The register doesn't like to be read and would cause all the input
> to be switched to output.
>
> This causes the SD Card Detect GPIO to misbehaves in the OS and/or
> may cause hardware to malfunction.
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---

I have responded to you already[1]. The commit message is still
sub-par. Don't say "the register doesn't like", say: "Reading the X
register causes Y to happen. In order to remedy it, do Z." You haven't
answered my question: what will happen to existing users of this
driver?

Also: you have not bumped the series version to v2, that makes
tracking the changes hard.

Bartosz

[1] https://lore.kernel.org/all/CAMRc=3DMeHQf_Oa2DRR0T7tum-Tuk3qPh5r5gimxGY=
3EXTyvoKZQ@mail.gmail.com/
