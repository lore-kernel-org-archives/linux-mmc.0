Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795821516;
	b=PPv4dotaedYXhQYkEpdjmr0dvt9PTOQF9ZAHEdk5YY0NGd2vxB35S/FnM8UVjTUE7LmX
	 +p17dGMzoRKLhe+rCoZMVtwKMunVWziuc1Hz1QYsrUwu3lDOEXWYhFzBQT/I8v5lTUD3f
	 XGrQ5JrTO7YV3IBsSbzc8VBKscPbsKyjRRXsEvYtjE0WjDYbBTZpoe4Nzne+aZocOkeI1
	 BapBWBdr7cJsjG7xq9wgne3M5HS+OXbysnyjXczfQ+HLgWUMP/HTekGGUoRq5gcPuXpRr
	 Tunm0XTCgLtwl8Ui6H4Qkeau7c3z4tLdDCCV7aPBREU2ZgZn0lOfnWuRPjHs8yMnQYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795821516;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
	b=CaUmD+W1n3WP0VG2Jzp2l9kJ8EdtPSLM+NE9iCY3H4VkKH42FPXdsXK/JJrbu4x+fzUR
	 UtGKRrXYvOTujtb0d56t0iJPA4BbaEpikcqI+NdUbo+aWHpQy2zvsiPWVhMvbKnJU5QJt
	 pb4MED5LKpSfqnb1RIUYBKNEcCkG7mA6FZKyK1Hbwk3ik2fpkz8h25Y407NB+xFhBNRXj
	 feq5A8Su/JW2clITwekZpfkdJOw0XJgxK8oDoluXlvlJlmeQ9d67RnnNSMrtx4rFY5KM8
	 9H+1pAu7TUKh+kYspi1RqT5g/+aDXgifNiJR2jlmUa+HPpJPtEig5rXC3WwUEUQfuPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gE2gqa1H;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127B606A31C
	for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 23:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9127B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=gE2gqa1H
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-498f5fa4f70so7106912f8f.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Nov 2026 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1795821514; x=1796426314; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
        b=gE2gqa1HASDlw4HLZWgBBQWSdvUizr9GH8J6QVL8nNPedx6uB61BV+HUrF6Wuyw/BB
         PcA6z+0Uj48zloEWvjEtcqzJ6IyjLWGQdrBFlb9TfOIALwBJmsi9FopHkiOS+kS0Zkuq
         lXR9jkjMff8XjBdzfe9l+t1Ajy7tytED3MNkSNa5U+qORRIxgJl/MZxYtBhsyHaL+hu2
         rfA67xg5fPpRqOtfSCJbWRjoq1vy3/2eACqpJWjP/ndPBC0iOXPGzPDFNi+qvLOYCeIM
         TnX4kg0P9GQQjDzUxH9rCeI2O8r7iWh5FFSvfJ2RcZf1Az9ApjNXvlcgLK5AyXr+P9B/
         WR+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795821514; x=1796426314;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L68NfkLh2sSnkPajUSfsYj9MfFaavbba0O0y/vWyU0c=;
        b=YyT4gUlxRBGdauTuxf5zK1+3mx2FNhuAbTd+mh1St3xaiWB0S5AykFwo+NPa1WKnoY
         Z8a/X4s/qxHOHwHNgZG7fl1qtfBKuC7k8iumyrMQf4YzdkjGX64dA+Lrafl7rAlXe/4a
         fel3XtsSZxJDEBIv41BSVzYBAepJh+j1JAU3KCAa6711xjO3AEA18PbL4Brxn9kgI4ir
         x3UvRGl6bHdEiuclklq9ZG4tq9qc74mzshzg+uggx0TC/rdhIF5Pnc9Q9LML3L0+N2nQ
         Rlnf+XL1zhsp5C77PlfyfC/LR1VatFH55+Rw3CjvEHYo0PHGBhnePk/KImPlfif/LjcR
         FBEA==
X-Forwarded-Encrypted: i=1; AL+hErGtRlVx5aSjYPYDe32rABzfbChO7XNmOf3v8QdzxnbuESvhabZn4vOY4Pk3orJ7/5tEOsXakNQejsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FQm2MPi8OwJj4LPwJXeVX11BSbIZ6rIDFCKwtu9L3NRjorrAh
	oBcdpThnrO3+TGu8uKdFK0hJWKsYjYBBvxARDWbJ++7M93M7uC8UM6a9ScOldErK41s=
X-Gm-Gg: AZFdTZcRZrvmBmjGa/LQkZmsEopFoqNCYOEuhjIEVasU2EYM69rF+/zA9kIZMZXzRSU
	bYIgAq2EkOd+u6m3NZj127nH07BzAc8onTa3JG7K0i9/zBnPHB0PP3BwecpaOZ5J/a2qrH9Y77y
	27ijjr6NAlP5a7qOnP5WS7yxolbm5VXkr0hoa5cTH8i0R30FMY/vF1xloYah546jEJ6+EmyhN3o
	321VPK5bo/UlQWIJeO8T8RaALvw9FcKRj4mUUfLioIt1ojG7DE+9TgifnnXs/ZjTwOFVCOMQTBK
	j8iagiGwDauL5wjSa/caxAYNhWIjpj9i7L8fULe63xd3nkd0/9tzELv8QCPo2aj3lIrTRG40qM8
	LUdmkqZytH8Ixq5+OqcWq1mWQpQTOCp9GQBSxcVeb4hxPWm0XbGoSBgRhdgyBpxFW6WWsie85Io
	umzGEGaN4xdXH3RkniJTt8srWbafsVL2T4DOqrWQb5HfS/O2h1bwxufs5Spr0hK/x5HZ3odu7zy
	1QKc+nRlV4nQKmniRKRtIcbcxJ1+puW6XzwjEa3apiJGM7MGkxgt3e2PxFshULc/ZpTquIb4pJ/
	RtGNZfSLJRoOehJCJjDOTG1HW3o=
X-Received: by 2002:a05:6000:2b8e:b0:491:45bc:d69a with SMTP id ffacd0b85a97d-4abb3f158c5mr33838415f8f.44.1795821513578;
        Fri, 27 Nov 2026 15:18:33 -0800 (PST)
Received: from [127.0.1.1] ([151.42.79.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b2052c8sm49822762f8f.41.2026.11.27.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 15:18:33 -0800 (PST)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 04/13] mmc: meson-gx: Fail request when descriptor
 chain DMA mapping fails
From: Valerio Setti <vsetti@baylibre.com>
To: Lee Jones <lee@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Heiner Kallweit <hkallweit1@gmail.com>, linux-mmc@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261123191703.179283-5-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
 <20261123191703.179283-5-lee@kernel.org>
Date: Sat, 28 Nov 2026 00:18:21 +0100
Message-Id: <179582150150.1958718.8445295799895434689.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=784; i=vsetti@baylibre.com;
 h=from:subject:message-id; bh=8BHON/4l5h6q1xjm/WKKH4SM6biaPJLVHJzVeZlzOuU=;
 b=owGbwMvMwCV2z3ty7kUrRgbG02pJDNlc/Ef1ln9ojoqOfGmv63j0Za3rE67Ytoe1i3aea+zbk
 Xl4U/HOjlIWBjEuBlkxRRaW6fd+F5SqPTROOFkAM4eVCWQIAxenAEykKpHhv/skRnH3ZWsKxTbM
 FxcprJMXFZi7cAO3n97ixSuES+q0PzAyPN0r92Wbun/44eYT/FZf7qt8Piy7m+G/VFx8vqJM/Qc
 PNgA=
X-Developer-Key: i=vsetti@baylibre.com; a=openpgp;
 fpr=0497DEFB707526E13360C970DE4B936DD13A0100

On Mon, 23 Nov 2026 19:15:48 +0000, Lee Jones <lee@kernel.org> wrote:
> meson_mmc_pre_req() flags eligible transfers with
> SD_EMMC_DESC_CHAIN_MODE before mapping the scatterlist with
> dma_map_sg().  If dma_map_sg() fails and returns 0, meson_mmc_pre_req()
> logs an error but leaves SD_EMMC_DESC_CHAIN_MODE set with
> data->sg_count equal to 0.  When meson_mmc_request() subsequently
> dispatches the transfer to meson_mmc_desc_chain_transfer(), the
> for_each_sg() loop executes zero iterations and
> desc[data->sg_count - 1].cmd_cfg writes to desc[-1], corrupting memory
> immediately preceding the coherent descriptor buffer before starting the
> DMA engine.
> 
> [...]

Reviewed-by: Valerio Setti <vsetti@baylibre.com>

-- 
Valerio Setti <vsetti@baylibre.com>
