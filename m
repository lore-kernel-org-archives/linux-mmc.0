Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793573536;
	b=yVY//eItUma4uTctuExTSLFofUOZMCZGJ0yRQWU2fnMwWljRZNqtKvl36aV3umA64iSs
	 01o0Dk/d9F51eG9n61uzmv2VkA6HYPUerz2oq3phdYkVDueTicCJ/WkkSozWQY0FLqxp1
	 yMjO1SEW6+BtP2+we77fQni9y0QW8DYFPsFJtZf4PI0oE0W6u9Pwl8fZkPEM1Ndq58jaB
	 KvBD8/8H50YGFdZ6zKBJ6kpXvMBFNc3Om4ogHNFXCqIiE9VXhUq0s5nvPtTvoRgNKAC3v
	 Ag+P89l7TqpnYofXiy6BdNymctVZPsxGSl1zM3RE/8/fbNHP/zrHuIn2wv8Uyvseh2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793573536;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eu5PeOoH37NAfd6nk+CLB2nF31owU+T7GEbEN3ieYFk=;
	b=5hqorHz32k5vsOI2BFj3ludbxKKUvh4qFZM/UDCjf8AfbzyGVwuheY6MEwPtyvSkTNaB
	 o9UyutQZYNcJayesplZ4+5lhvcbiowZq5NBaHnwzVAYKdOJ+kiaig1QE4mOAwKf3H38I6
	 DuSgtzdPw2rqgZ0aNndhQ3/g83LTzd9oVXgy0b2m+BJVbEXwQ+bCZaWul3f2OSgP0gsaL
	 NnBH2kDQufYxzOsCfStHwwkEkDhTCLcTsMDGqysZNgrJ/GkvL/i+U5fAo2yV98M5da8dF
	 Uj0efYYAwXa2NXX5AhMKTHC6yirBXtXUsX7shy+Fd5gTwV1EbVzPGQYWjjt7s7ExFFA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=bGeXE1lu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F00606A327
	for <linux-mmc@vger.kernel.org>; Sun,  1 Nov 2026 22:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09F00606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=bGeXE1lu
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67a6b2a2259so1611835d50.1
        for <linux-mmc@vger.kernel.org>; Sun, 01 Nov 2026 14:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793573535; cv=none;
        d=google.com; s=arc-20260327;
        b=TGrbd3Oz/etnC9FToGMx7wL9lOq8A4QyEOHCMBlUAxWm9sHmJY8ViFIn6u3MXjKd+4
         dFuoPoAMiv/c2kCfAxO/1y/mnldoKXPeWg5RigtIoCKBxQj11p7oKUv0xzo7IXDBCKUD
         fgX3i17qROInTJw9+mi0N/nKiMoEu0EkV1xA6p94DgDEdKO9cD/ODNYkQje37WlBTlWk
         5nEKPozj8RpAs8iJSRkcQ1x+npoURBtolATlJtXcODoZcsnuddV7xdsha6YXBnrzR6MD
         AsSjjiYO9y5AFfdhAvBVRiyqOyXeM/J9bPRfcm18NF0vX+DZ2DUTXTvZ4zEWYWyhc1IC
         EUwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eu5PeOoH37NAfd6nk+CLB2nF31owU+T7GEbEN3ieYFk=;
        fh=jegrraaUUJKxa2skzF13Y+HILVcu9MbkQUf5ptkkeKc=;
        b=n+ZNGOFgyegchS4wGtCnDFpf0/cCYym/C0uHMXLbHWMXCw6K1CCRMAH04jXQ24lIQB
         ihLAhXJ55qBeUDWC66g4t4SDjdQMfkTos4r4o2XWeoW5kdIJiqf6uCLt3/fk2Urs06j3
         OOt4HjfLGoZtDxsr3+FRfNs9WMquSgErjPXTKEIDipQWcEhkVC0uzGZkEJtAdQebL4bh
         aKRPOBnxLu0JIScybrGX8/SgFr7HBED/olygMNC/2QwRDhyIw0JqID3U1fLwX+mxZu5p
         z9m+SZd1G+L1NyyJDPqOBf3fzo46xPk8JPNiSHSOQ51xi0BZ2UjrK89XDeLmfKAljF4r
         vSjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793573535; x=1794178335; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eu5PeOoH37NAfd6nk+CLB2nF31owU+T7GEbEN3ieYFk=;
        b=bGeXE1luiCMw3bBTfuupe0ogYgEZmQtxfeFDub8NbPQ7t8tAUp+zRTbt2l1fcRm3yM
         RymSZLhps++0mmDisypaK5p7TbhwcOmQIZXxMuMqFFqK5l0ILxH6ekoFjNOCVIyigd7C
         zRCdfMEK+xwcztJE/K/QieA0ZraLeNQy40BBCv867SwcGxHp23rXuzm6ze/Vm4aZPyq/
         rVP5S4L5x+UefHxWgSfWRA9az620uOZKtHoWdzKFatJwZB1ubvExY/LylSy0t3ayqDsF
         LQvGtI5vQ0fz/82RXsN5PULk2l3FjB6n9nEsEvtqCFentKRUIzZiDeEQH18s/BUEEvOz
         2rSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793573535; x=1794178335;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eu5PeOoH37NAfd6nk+CLB2nF31owU+T7GEbEN3ieYFk=;
        b=DIcCd8pGpMDhSiUd19acltBlLIsHqfx6jVehUTGf2RFbsZys4uJvEr1ZHEp0TKTkWq
         Y1Gvdys172a7qJlZH3JO1+KFHRB89T7iHrqBDQNvh9IDD+o4Amdw2eKgmekntq5qa1NQ
         PYxhRbRjYF/Du6eh7rC7un1VWolBQYPG1Pc05yb3CTQ4Q7DckCTRXQuycEFSJu85ODws
         A1RuHZQ5UUwffvmdnIC6xhwddFL4BFaCvu8FavAGGpU89TjHeiayiHX3mZR7ZOWw1wCD
         cvxpqAfk4UQeNQTROHDdIx0vdtxGW6GslMh4Nrgih2l8FSH4MJC46ldhwbWtIJp//9Wp
         XV7Q==
X-Gm-Message-State: APuU4Z9F4CtZlV8Y9LsPVCzron+p1PmF09DHHj0fGaSCDSoV6mMdwpSn
	+GYX0zwDmuPjMtIsHvP1s4GBbq/a1mS8ffyK5QHij1fBRavV9EG6QCBcar1BmyT9jqRZwznE8FT
	iW2Y9cKzWhzWsqCsB1xGKCzDl6o4rz/c=
X-Gm-Gg: AYBFou1bg7prh4pmcj6oF8+LGhFU0Pg8nrVQ4sv3ZM4UAkYrjW/MBpkSdikVwyqx3sl
	Ww+F1OyZh2X59jLwzgNeXqH63t2Ct+n9po8OJEIIj6aYYBXznLACYgfJcred7uSSzCYw7uoXjPo
	R05e0XXA2IBCS3OMh830LkxN1poZC896QqTv5fKeJIeI6d5xs/KF7mo1PQpL1VPRUP9ynrtdvS8
	9bjQaAdZDn5Edei3bCDRXgks7rpa5DHa0EFvMaRwaLZidGXY/6ztmM67qD1EO0sUBoYTagmK3hj
	yutzCZA+G2r//hV0bePHuQ5Kx8qqci6WMuip4ZIqPUpQBXcZK3wcPY3EMOuy0Zkk7+EWkZoZWhi
	0cW8FA7VSTFnpjUxTg/nSz3M1ZRuuoEmMKirX0Dpq+xHE/M+bb1DQznciKYAiFnMHDUhqYg==
X-Received: by 2002:a05:690e:b8d:b0:679:98dc:b39c with SMTP id
 956f58d0204a3-67ba501901amr5094827d50.125.1793573534917; Sun, 01 Nov 2026
 14:52:14 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031200925.3364-1-yuanzhenpeng210@gmail.com>
 <CAFBinCBo0C=KABcg5ueDTRSJhF9vmWnPwYHbaMGTOYppOsabwA@mail.gmail.com>
 <CAEDN0nDjYLE5hy7gVLQ3hv1WESVJQWgc7T_8aLqzRui036A-_A@mail.gmail.com> <CAEDN0nBEK5PvkV-eC11XHYG04Occgs6o9_9K67OZn+xtkh68yQ@mail.gmail.com>
In-Reply-To: <CAEDN0nBEK5PvkV-eC11XHYG04Occgs6o9_9K67OZn+xtkh68yQ@mail.gmail.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 1 Nov 2026 23:52:04 +0100
X-Gm-Features: AclHuK-R3xNv9qpm1VWMmHjI05K4ugJP9l_pkjDrq2qiEZoGQf-7YzD1L0LqP9c
Message-ID: <CAFBinCCxfp65Fe0D1UnupghgiOkTB0-m=+L0kNSOUm7DzRFKcQ@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: meson-mx-sdhc: add DMA bounce buffer support
To: HELPMEEADICE <yuanzhenpeng210@gmail.com>
Cc: linux-mmc@vger.kernel.org, ulfh@kernel.org, neil.armstrong@linaro.org, 
	khilman@baylibre.com, jbrunet@baylibre.com, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 1, 2026 at 9:55=E2=80=AFAM HELPMEEADICE <yuanzhenpeng210@gmail.=
com> wrote:
>
> Hi Martin,
>
> Thank you again for your feedback!
>
> I've completed the comparison between the original driver,
> MMC_CAP2_MERGE_CAPABLE, and the 128 KiB bounce buffer implementation
> on my Xunlei OneCloud (Amlogic S805).
>
> The results show that MMC_CAP2_MERGE_CAPABLE alone does not improve
> performance on this platform.
>
> Runtime instrumentation confirmed that:
>
> - dma_get_merge_boundary() returns 0.
> - host->can_dma_map_merge remains 0.
I see, so that will prevent it from doing anything.

> - The block queue's max_segments remains 1.
> - The merge-only variant behaves essentially the same as the original dri=
ver.
>
> Here are the sequential read results (MiB/s, mean of 5 runs):
>
>                  Baseline   Merge-only   Bounce
>     4 KiB          11.81       12.20      13.01
>    64 KiB          12.88       12.80      57.52
>   128 KiB          12.97       12.80      67.68
>     1 MiB          13.11       13.05      69.43
>
> The bounce buffer improves sequential read throughput by up to 5.3x
> and sequential write throughput by up to 2.1x.
Let's wait for Ulf's feedback in the next few days if it's something
that should go into MMC core (either by default or opt-in) or if we
should keep it driver specific.


Best regards,
Martin
