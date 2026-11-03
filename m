Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793666519;
	b=oW0xUocOwC6AsfI7jBDczE6pN7/gH6Hhz4Zguj2SV2rs/LeucVqT80NjtjZYI7ONc8t9
	 bPsqBZSNdOZFWVD6tHOgkskHo8DKS9cINL1Tw0w3hVxUNW9xjLnjbwfpycyeecTnsIXgc
	 nCEYK99rudTHBfmgshdCG+qnctxLrhvAZUjx41DuU18aqwsTfCp3+qHjKPiNSmEeO2N+G
	 zeXwAPw4eSJWoZj0poizTllq8ejc85sJAb+5w/iDpUhzCKgwU7M6UGKmWJUU4TtWFfmfF
	 e+kyTXEWnku35caVe32wLUpocG7fj13a/QsqJ7Z/ZTsmURv5jHWEXAr41f6opDY9lAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793666519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Vh/cvDInRTV2ogz1411cOMX/5XEmrB74tytYBj9+zVQ=;
	b=kMzGadxR7P06lBAyhgWn6vYq7KgpaysoJcwfRhz7JyOCSmPlFPYOlysgqtdJTP7f/2zK
	 e/xyUcvXNurNFIZ/CFuFNs/uaZHC/DKVd7RhyB+iuxkYcUXKRwW+EBPtcnwgqf4NPR5X/
	 Q4si56rYFfFzhCy0ee9QIFFWZbYFUZ2PbhfvMoFFk3G8gtxFzQMZjdNkRndD1+qekHpXO
	 qdqKa3CeF9fBJlGrw/KZIs7Ijo8XuY3yT2DU/6lcwS1j87F9FzGXUlRjhwC07X1CRtrxP
	 n1Q+gNvFpCn6SkhLYKcTLNWtkcs5O8wi8UKgfEW2kRb1+ewwh0IIVLgWYQiAWuYct7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlYgoHZJ;
	arc=none smtp.remote-ip=209.85.210.43
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F93606A32C
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 00:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86F93606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mlYgoHZJ
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-85a6c747dc9so118541a34.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Nov 2026 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793666518; x=1794271318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vh/cvDInRTV2ogz1411cOMX/5XEmrB74tytYBj9+zVQ=;
        b=mlYgoHZJPyDH8aKsCrRTOTDjkn/aAYIuANPWW4NFdj3cAAxSk1WOS8ot81rJ+DOEvL
         RY1FsZgPT6NL6xxURQIGTx2LwhVUyjz5SojX+TtvhCn/b9O3GvLRgdJgiVvRK9LFWo/z
         8gyOsn4BbOYm+3d8n/OkA5TWliFDTlrbhqO0Rd2DtVYhWXIf2a11C62f+Hw3KOhz33cS
         xhxcTfJBn5yDU632B0voD2ZGCYlrjnUUTlxlXZoKLnbj2YcI5qufZkT27bWPEMcdZSWe
         2i6vUxVatS8BvYy7nGyr7SG41YlVpGsXx9uUl67h/1jZhwzx81pKp++1pCmRTMf/7EkL
         NwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793666518; x=1794271318;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vh/cvDInRTV2ogz1411cOMX/5XEmrB74tytYBj9+zVQ=;
        b=bitqGr4W6u4YWO4wCH+MAPQmv7UcpaHSEgHUJvVtKY67LkklC53wSB5EWBdlEewH2M
         PA7bBmQxt9Mop8T8jWITfpokabyaHskKtZdswQ4qPD1tQNBny1C0n+Xq7s0SApTdLchX
         drcn1V7RIYQPWkxjCotH518G0TruixtxPDmTdLR/ACPn6x9eSHqikPQ6rgDqg+7rxEwQ
         X5hMf1dfGoAduRtXHYgjxOI5uNsMMD2rIs2HgeZBcHPP5vIhwKOiEAUaCaCsN2I9b0F3
         vKGmKW4qMFxiamKVqaqw+ca2nbu4WpiRfgKUJ8JFRm1aAPEoPq5wQBEm9fkT7W7bpePC
         4MXA==
X-Forwarded-Encrypted: i=1; AKwUvBzDV1kJwScM1ktVW5bmHVVQJ1S1SoAwKl9MakYkBW0MyDLUSV54ES45jGIKXDy5rpi2AASsPTdCJ/s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJO7Xvt4nNLnsMQRpUObsmRCs7tornEbvUChhrBnisN2qtbHVdC
	yreteLy0pyOiwWhFz4vBJonUouI9CWOGvJF5tcVQtzBYsF912DBVsGWc
X-Gm-Gg: AYBFou13yOzxokqJQbTuuZ4EvSCKq26TBmPTclWKcZwzmJKze43WzcTcR8LL0O5H+Pz
	MBNorUl2Rl5tzLP50szO60bvw3vSU9LGx3J+f3tr8WmhfvzH2PicLYdpbDl5BIEZ+6v8uGW2WT7
	heJk1T+MGsCjkmG67DflG36h3FVT3rkI48zGKiJhF/hNYg8P2O0891fQi6xDS8b2pXBPEiiA326
	xFn4C+99QDE1PpVhPGMSAmjv3+ryPTGgf13iN0J0mgxuAx5mARGvI8qC8EZkMFEIptyFX4jUN64
	tsu+F1U6ub9WjkBUeXqqzr7Vz4I3qxE30TzV6HBj9z6jnXBT2q+P0YNWmT6w3a8Hn5KGO+hapU9
	YkxAJEXJUryk7STr/hwyZ7aebzRIAsMRlAbSpaTNFIlJSt0Wq5GfNXkPdNlpHThSTPXiCcEkMQh
	+gfEqAtYNvQxHOjDeA4YFxy0y8ak90G40tD3wVXJ+mgabDy+phWlxKGQjbfKvoHF6+zoz2bk/cp
	SKHxBosJUnnfYJ9/uTHXhl6sidZcF94RJBQefVKyrELj7tNs0B6vLjTmr/zhYqrtqBebY2SPxmT
	KQJtJ9iGg7htqL3xRMaTR4dHvxj3NXksukzuxaltj96poXhE8hSvDPwv/tIxtsrl7SwcdtJZ5wf
	f17AW
X-Received: by 2002:a05:6808:6f82:b0:564:57c3:2b28 with SMTP id 5614622812f47-56457c32c1emr1301058b6e.8.1793666518415;
        Mon, 02 Nov 2026 16:41:58 -0800 (PST)
Received: from AMD.home.internal (dhcp-9-244-8-156.gobrightspeed.net. [9.244.8.156])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56523cdd0ffsm388473b6e.8.2026.11.02.16.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 16:41:57 -0800 (PST)
From: Enzo Adriano <enzo.adriano.code@gmail.com>
To: krzk@kernel.org
Cc: Ulf Hansson <ulfh@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andre Przywara <andre.przywara@arm.com>,
	Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: [PATCH] dt-bindings: mmc: describe the Allwinner A733 eMMC controller
Date: Mon,  2 Nov 2026 19:41:55 -0500
Message-ID: <20261103-a733-mmc3-withdraw-reply@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102-steady-grateful-chimera-e2363a@quoll>
References: <20261031020640-263f7b05-a7s-mmc-binding@gmail.com> <20261102-steady-grateful-chimera-e2363a@quoll>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

On Mon, Nov 02, 2026 at 08:27:19AM +0100, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2026 at 10:26:47PM -0400, Enzo Adriano wrote:
>> AI assistance: Codex:gpt-6-astra.
>
> Drop, we do not advertise slop companies anymore.
>
>>
>> Assisted-by: LLM
> Drop

Will do, here and in my other patches.

>> This binding is a separate prerequisite for the disabled MMC3 node in
>
> How this can be a separate prerequisite? Binding without user is not a
> prerequisite.

You're right, it isn't. It should not have been posted apart from its
user.

>> the A733 DT v2. It does not add a sunxi-mmc driver match or claim an
>> operational eMMC path.
>
> Hm? Why?

Because I can't test one. None of my three Cubie A7S boards detects an
eMMC, and their vendor device trees leave this controller disabled.

[...]

>> prerequisite-patch-id: 6fc03bfbd343042dd3b660938fcc09c5e7d48314
>
> So this cannot really be tested.

Agreed. Those IDs came from my local tree and are no use to anyone else.

I'm withdrawing this patch. André, you asked for the other MMC
controllers because the IP is the same, but the manual documents a
different descriptor layout for SMHC3 (A733 User Manual v1.00, tables
11-3 to 11-6), and I have no hardware to test it on. The next DT
revision will describe MMC0-2 and leave SMHC3 out until someone can test
driver support. If either of you would rather have it described now,
tell me and I'll put it back, in the same series as its user.

Sorry for the noise.

Best regards,
Enzo
