Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786AD1DB15F
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747770374; cv=none; b=huJGQuIa9S4d10lz4XgW0yRz4HYM47VR0ycikuVvLs2RA7lLZ0JbblwShPSan6JC6/0ayYaLFZqo+F0+KJO3u6xTTwGooWIWNgyII+opgOkDhzLhRfdAky08PlWdioa/uld0fR99Qxk2NIAMfFd0/WpBE733wSdX39C3ymWtlrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747770374; c=relaxed/simple;
	bh=dJ752p4GXJdXH+eL1jq+5Attl75vSjLmSkmpZ0siUe4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qA5/IEV/4sPmOOIg9hw9bY9M0FRqb/FAYg69c3RIkUNAObRpvrWyYmHjlMdxQwGSCgRrEIzvZ7PbFAA3tKjkvxylvLRcI2nNBI5aJp8eb2rzd5zGEn30u1PNtgMmd+SBAf634HFLtfCBSQ7Ujf4IDFODu6jq7HMutU8FS5LPneE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=JK2yK5Ed; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="JK2yK5Ed"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2320d2a7852so27548585ad.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1747770372; x=1748375172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yiqgvhPL3huWrAAY6k1RZtnEkStLp95GFptcfgV3FCI=;
        b=JK2yK5EdrN/gBWjyVlOvjT+nzFxnuLwp7B2s7AkAMuxUSrBIqwMRjkMomVsrZhmDcD
         ARS0QZdPmIaBXsTQalHUH2rELwAltIeJt2Esgndhr5ry9XqbfSTVHOX50kDuByTvbTWo
         FbKgDa3AScHrYJFsjUCTJChS2j8QfBSELVf84MTPDMQ8Bf82CohvK4ZALgrgBOvWDACt
         ILp/OC9zMtjokLXf+WOHFIuyGJM+T4JyfpE2NQzmx8dj0gDj3Qz0XrvQOcy0fMMiLZsC
         Ruoegd4TWsi0beDwK/8aafd+3eu2Y9RcAhrjBgw5NLFMXLNqymRwKiCwbqcjK0MWDd8I
         COfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747770372; x=1748375172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yiqgvhPL3huWrAAY6k1RZtnEkStLp95GFptcfgV3FCI=;
        b=gH4El57+P2rA4qe4TOh/4PMA9c0i5wi7tdKwnaIRtME4f1vL4eMjealKhZaRotzYSi
         uhidHEnFgJndkqzCD0LWG3ndCHA58B87UDMCITTB6o2HiBX2NsauDnyaQwxWtGDPIO10
         lMrrJLK/6VNM4smwZDNS57bT99oNwCuylAZsYcQDetfKLOmNObTdZEG5g0gvILZkiWKc
         sa4fHIw/s2B/5nYJd7Slg9NPxPX91c23DTr/lwwM7IDICm0odzpKrd1EdheTsWHvBiqD
         tOtL2+v54899im86wDkvUNIRyFLz6wdEb5PRgxtICPxjygqt34D32nbdbVoAusYeFKyc
         37lw==
X-Forwarded-Encrypted: i=1; AJvYcCU13zjhdZsw11dDuIevsuEOA0Sd2tJgUTJLgShcqj5pxqVyWz2swjdRCKy/a0mcRbSF2FcdaYSCRLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5DEMGPZkvv726D3zW0FuN3Lkz0AeJJzOtOaUL9YEBZkRiD46K
	lXArAasCpFAGZXYVG9gEUXgLGu96VekaQYrKbUSa4ucW62M9k9qMLUzQCHf0tT8NNGPEEbUWYWG
	Opt7WjhvLyZK6jWiUSfbb5H2NKeb7QS0=
X-Gm-Gg: ASbGncuX471SxOPd61pQZe2x6WAGr9PXracXfzzHXzpCyFaip3rXe9Thv0ETA+kz/L0
	Ya4d42RD8wFi+OtTn0zMUr6chyCWxN2CfdKFXOqXTYXmSWxW1bhgLgzV0bX4/feOkwo2oJl+oL1
	5k+fWKUVC7IAXAgsZE7UucXnN0PYIOw3eegIsCl7jT/SoaodYajLnbLAxveuJwZ5KUfA==
X-Google-Smtp-Source: AGHT+IGpOU8AuTpmfyiPWHS9f9AyIuq2oP/9T8gLrzp4+R9pQw/aaINR4j9OtNfdZ5TQfBliNbuTK4NWqSXI1yA/+0M=
X-Received: by 2002:a17:903:22ca:b0:22f:c530:102 with SMTP id
 d9443c01a7336-231de376f89mr246040095ad.31.1747770372610; Tue, 20 May 2025
 12:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1747739323.git.zhoubinbin@loongson.cn> <abf952393b2089dea103c1976a7af878b1c9852a.1747739323.git.zhoubinbin@loongson.cn>
In-Reply-To: <abf952393b2089dea103c1976a7af878b1c9852a.1747739323.git.zhoubinbin@loongson.cn>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 20 May 2025 21:46:01 +0200
X-Gm-Features: AX0GCFuCAFO7TJI-d6sab6lfsbBBjAJjzWttXJVDpbUIJxRQPTdIJJC4cQ5RkPw
Message-ID: <CAFBinCAZMqSzhudhZdnES=4E8yKUUZz6cEO7fgguvE9F02XHtg@mail.gmail.com>
Subject: Re: [PATCH 36/36] mmc: meson-mx-sdio: Use devm_mmc_alloc_host() helper
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Huacai Chen <chenhuacai@kernel.org>, 
	linux-mmc@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, May 20, 2025 at 1:47=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn=
> wrote:
[...]
> -       mmc =3D mmc_alloc_host(sizeof(*host), &slot_pdev->dev);
> +       mmc =3D devm_mmc_alloc_host(&slot_pdev->dev, sizeof(*host));
Last time I tried this I had some problems. I don't fully recall the
issues (I can test in the next few days).
In the meantime: could you please double-check the driver code to see
if you spot any issues (the special bit here is that the struct device
is created by of_platform_device_create())?


Best regards,
Martin
