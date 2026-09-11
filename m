Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E9A3B774B
	for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789118927; cv=none; b=KyqWEpix0AkkkcW+TJHyxqthTu1bL1NKhvdpbwiaihsed8N3P/vP26gbIg4rbsgx9VzM0lYzXVMoMm0RJMoAWV/ddXDH9AdVYkH8ifBW/Y9ER2zNyzKtYlvTR/GH8ZK8SskAQvE5o2icVVgIOTfgJz+k7bdaOSvsAfyyrul1fOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789118927; c=relaxed/simple;
	bh=6SidIVM2VhXxSqtPqbCE9i/tqnPHI8JtRxVo4q8INdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IdEXA/HDzpLFRUXw/RjEJqxeJnIL6pB02kT/ehzC5xGq1J8+hqaJkTAhp4mPKf2NQImtT3Vw4GPAxrFltIG9cpynn9DGZg3x/xYIEdyDx3LKLaNmwCGY+bgbQUcKjnHinUf+bDgsyqRa2ITGhd5L3XseF8KF0W2syxeIV/Z8iJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NWQUDG23; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NWQUDG23"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b94fce6e8so5551535e9.2
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789118923; x=1789723723; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AQwqbXwJzJUEnBnzBsi0ka1PwipDEMcTOXIfYajspX8=;
        b=NWQUDG23O6WOp9oPryh7MMYkMP92Kiq0A+Z3D3Y/dpQgJ1F2VoPI1FSDmGaRHRcX2a
         jazybtr0BmRS9q1Xylm0TsW0niyc8LGX5zePgj1JXcaqeL9Lb2AxexfZKRZmNN2w6/Ob
         AQvrbqLW3QMsugmHeWCWzzXCWYk2SLCNyIU7mmRCyiS25428uFwJ2Nt4IkIcMi7ECq0o
         crs4IXRjITJz6wPkwogf6dqD2JIlPY6E+rLun3B4mPnr0pQA52dzvoK1MvRz05qz5qTi
         4HFeLdPSfNyTyqQ9rokoS8qlHSOCB5D5CklHZC3RhdCIFnKzUdlzdvISaf01tPpIbdnO
         voIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789118923; x=1789723723;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AQwqbXwJzJUEnBnzBsi0ka1PwipDEMcTOXIfYajspX8=;
        b=dcC+heKT+No/S+jv12drGySjG/i/REeG6lNda4iN9X93mEfglLgcINOMivcbkBstvy
         A7rUeQ0ngDoN1ZcTTQ9OqHRZ0ckDL1bmSyboIqoRjxpRQLLlPfBXK6L5sRQiN4ugf+lD
         bz1iVy+FjIw8+SGA19anbKUhujTWNyg5CJUuXz4T4lXA4nluRihZShLG1j1WxlwuXzX9
         uLNFwYVNZWTQaMCk0i6wOcRTBxUAPcTuYL8z5RyK6bEAmSpLwDKp0AAfadCigMWyUjqx
         2iQs2hi5O7q4LGrY2nMQ4/3uUQ1NwaHyqE9eQMk9MUZ1JbXeUM4Pg6efXTl7ydjpIqrf
         s9aw==
X-Forwarded-Encrypted: i=1; AKwUvByANXP1BDhvnNBS0L4+HRCkvt4PU4AxF8jI/t48DpGlwhyEUAGhcrll+rnPhkJt0ikY8aRvurjTP/Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lviyuJF9f37scsa0NeerbT4DYi//mamU9+XiaAERE307aYzWxR
	3YTix4RUxOSMP2drihO6Sno9KrXhIWMQhnzRn5OOyPy5cUq0MnHf+nf5rOh2d3MO2Uk=
X-Gm-Gg: AYBFou2PsQKfoQUYMMvh/YuAd0nHjxj7xVKDsi4ZaEE23IHeqbvipZTxttTTY/RaQEX
	H8BVxX6OdKoSzcVScedTAccRcephmeZUtaamXFx2h3iWmr/qHMsPIeH0qKbE9P9HsUxUhQyev/e
	dWvuqu+CBsgwPJSPCrGygrPRXIxPfm3myjvCaQ3OdBaYXr2zAafwXiHG6/vuUnyI1v0A3d7OpzC
	Kq4alI/+40Vr9EZsihFGP4SlBajRgB53rXTsm/EtD2XYgklskPhmYHsIzfkfup1SR9V2AI5oyBI
	YBrgf98xNqK2xYaCBpyBd7JHNHfEtWhPlLzoOLxmA8GcQ6Y1X4YZol/MaiXn9DqbC36CsVn0tmF
	UZtucTdWO/qed0IRplt2aZCYWFBjEP9AGrQ9nmV9XP6XpDMrvfI8GyPcLysAnNsg3AasakpMFCy
	ucfqBYFMtmq9WyVDs7wxsZehiOhuQrFZhHqoEQGJZahHcteS6iRC14yRzxwEPSo7uAyBaSJEmrd
	cpbG7zAnCVJcn6LHxtx9I4Hm53W
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id 5b1f17b1804b1-49e619c0558mr44117805e9.20.1789118922855;
        Fri, 11 Sep 2026 02:28:42 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60ababd5sm83052575e9.4.2026.09.11.02.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 02:28:42 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Andre Przywara <andre.przywara@arm.com>, Enzo Adriano via B4 Relay
 <devnull+enzo.adriano.code.gmail.com@kernel.org>
Cc: enzo.adriano.code@gmail.com, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen-Yu
 Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, Ulf
 Hansson <ulfh@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 3/4] arm64: dts: allwinner: add Allwinner A733 SoC
In-Reply-To: <20260911001805.0a2e033d@ryzen.lan>
References: <20260613-a733-dts-v1-public-ready-v1-0-7787c94681db@gmail.com>
 <20260613-a733-dts-v1-public-ready-v1-3-7787c94681db@gmail.com>
 <20260911001805.0a2e033d@ryzen.lan>
Date: Fri, 11 Sep 2026 11:28:36 +0200
Message-ID: <1jo6e46ssb.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ven. 11 sept. 2026 at 00:18, Andre Przywara <andre.przywara@arm.com> wrote:

> And what about I2C? We would need that for the AXP PMIC. Having that in
> the initial DT is required to keep the DTBs compatible with older/stable
> kernels later on.
>
> And it seems like the whole r_ side is missing, even those we should
> have bindings for those. At least r_pio and r_ccu would be needed, plus
> r_i2c.

I have sent the i2c binding but it did get picked up.

https://lore.kernel.org/all/20260707-allwinner-a733-i2c-compatible-v1-1-566340542bdd@baylibre.com/

It is a marvell ip and I used b4 to send the change. I did not notice
until now that the sunxi list was not Cced. I'll re-sent it

>
> Cheers,
> Andre
>
>> +	};
>> +};
>> 
>

-- 
Jerome
