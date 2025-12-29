Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FDE280A5C
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001692; cv=none; b=NRxJt5yJmMk0m+HgECRxfZMrv8PaqtroBDHssgg8YtTVbWqaRIPXF6gFiiwc0SvP04QTD2p4lO08nX7ui4ptEz0d8uJ/E47UOb1MQnLlhwoUcASZ8EGjJDUd3iqIykGQKlXMmE9r/bqc4OEfkNlDAbVqXQAZjvrt0jWgb6GlbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001692; c=relaxed/simple;
	bh=X7tl44V3WL7cO7gk/CByTptZ+spzMkyKgxlBDoZ4nbg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TexXWkBjUVzlfQtPOR+hw2xuJX49uOed5v2uA/bChRNegwwkT7CL8FmvkVYEbttgmbjhuDJyMqGZYr2dyBkq2VM9XqIsubNEi//O6OkUBEia8z4/H4rutdYGtOkEht5WQKbydrcAVFISROg5x2b84AyluwT6Zbr1vnKaomuWaUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Diquq6ck; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n4mB3cxf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Diquq6ck";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n4mB3cxf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767001689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RnoxkXU/GI8KdYqeGZPuNP5j74RbxRLg0HQulbL1vDI=;
	b=Diquq6ckUWczmy96UrGzUjSiXDv7oGioq3tHzXEW7sLrP7pIv/wMaa9rrDM2r5351jYqx6
	dnbqv1itvwinXbZWfVwYI8uUUkGhF6AF96OpWvEP6/JXPnftIro2KEDWhSd8NqakUUuZl+
	+J6+jCY4ofTnjE0h7TNYARB/JhskQso=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Pa4VPdSeOymaNzmGj8_e0w-1; Mon, 29 Dec 2025 04:48:07 -0500
X-MC-Unique: Pa4VPdSeOymaNzmGj8_e0w-1
X-Mimecast-MFC-AGG-ID: Pa4VPdSeOymaNzmGj8_e0w_1767001686
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775d110fabso76203485e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 01:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767001686; x=1767606486; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RnoxkXU/GI8KdYqeGZPuNP5j74RbxRLg0HQulbL1vDI=;
        b=n4mB3cxf2+vlcC75x2qFuSjnE2LvtTq0LaM3DJrFPzDWPqGU2s7ZslhrVYdKasotbd
         STZPfD8gS9oNodueIkDQwYY5vU0OxrsZNkblT9C+0hOdTI0bmaPCVp6nft6fWHLtss62
         CC/Qb/Fi7/K8V7f5Van7OT8r5Vi3ORR8pTFaCTz1h6Oa1I9ckYJvMs1i1V4ikUd8B2NJ
         fMDvN+oBB5c3O7jrDwznHWMQdIPFeGJxxl6F6JKWA2Yf+VV262Gp+qK+q+Yxxc9HngEu
         2amA3rTnVAa5R1iBeRiQaD05G/alIlqc8RHz/u+K+06do4sDrvi98QsaXNh0LPURIJ64
         5wVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767001686; x=1767606486;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RnoxkXU/GI8KdYqeGZPuNP5j74RbxRLg0HQulbL1vDI=;
        b=bm3Z6rcBF7vilNgdbHf2Kn/Vw6J3Pw8qs3g/Fmem0pDWU8grDPlHr89FkdBLY/zTPr
         Nh9v6xRCzzzH0zGQgq5mglQ/dClKpfUWdsFbiJ7iL42zULLXN22e4fhsFdp1mZiohMJX
         XPnB/gwyLz3+olheeLJr0KtXbcC+ppLCFPIpkdVeIbRvVNywkXxD5SHTD5XXVs5LBigU
         KCjfvotDxCe9KuoYD8zENeAEtcHF7/k+Tv/MVaZ2FVHiUWOJAkAGZxhVdRF3hxHP74zU
         ljQWpwDm/zfX1hxs7o8NGo+OoCX/shX0QMh9qvRWr4pV4YOZaQ1rJr2nr19W6LiFPOc/
         9TAg==
X-Forwarded-Encrypted: i=1; AJvYcCXvblo2Xqm+wixXhLDwj+KJy+reVqLKBi0K70qOY6W+Cdnzz/SWREB8W2FofzxdAy6fPhlEXg3HIHY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk+YxGPJNBcYZ9MvPzkEIBg9y+TZeNagJgn36Jgp0NneS6HWcE
	x2jMyUyViZ5ngU04r4+TckOtapnitrFoxiDArJRIffxp1t2bxpTcadoZdFS3CvPK+qG3kBarNA+
	L+sx8Ve46u6wne4VqtALvSh30u4UYif7VccjU9fImhDRVz93wqire9g1cYJTUIQ==
X-Gm-Gg: AY/fxX7ybruKKoeVDwryCB8CrQoMlHnVoyq0T6I5g8gR6kkP2EvMLb97YbPHFbs6wt5
	i2DG5sfnhn+znmBE4q+2MicboWjFb4qtPhVbMWqO5QiWNyMwM9kgSESeoBp8vnHHHbx8qsZSa8W
	Lcm4uFUwEvI0p8cpxUuWg8jaeP9rrqkKH/XHgxK1b+XDSZycQPpTsUxEvtU3yLG3s13rHUxpw8t
	r8ZH2NcraR2JBk69Z30Ah/W5FiiqWIFgISippz0iyfuLlC1WIJ/n34ap9Aoc+Z8gfoVvSIkbRly
	2YMMT/HSey+UU7ms5FoQ9L6IJdoazTjjEyM3ur4ZbvrBudurqsQjujHPBu8OuMYPD4K3PKz3WBp
	Kv6CJJo7sJLjnkc6yqtImpyMZ8BRU4GIy8iMm1SbcJam6d/nMfegP4jStDq81ad98SK5s
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47d195911b8mr306757915e9.30.1767001685815;
        Mon, 29 Dec 2025 01:48:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzfoPDCziY2Ru4fP0I+7aTnAKnoHe3exw4U31W/SkLy53MoLHcz6raQVV4UNwNgdpcefpRiQ==
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47d195911b8mr306757565e9.30.1767001685444;
        Mon, 29 Dec 2025 01:48:05 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d19362345sm528501075e9.6.2025.12.29.01.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:48:04 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: mmc: spacemit,sdhci: add reset support
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-1-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
 <20251223-07-k1-sdhci-reset-v2-1-5b8248cfc522@gentoo.org>
Date: Mon, 29 Dec 2025 10:48:03 +0100
Message-ID: <87bjjhhb58.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@gentoo.org> writes:

> The SpacemiT SDHCI controller has two reset lines, one connect to AXI bus
> which shared by all controllers, while another one connect to individual
> controller separately.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

