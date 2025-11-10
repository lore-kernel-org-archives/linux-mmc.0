Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360B153BD9
	for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762789001; cv=none; b=DWvm3c0uzxJ8m9vbQkMd7UYcU1QFBVZX1gs7oOf8zwXMmzrOzaKX6wY/lRCH7lHoqQjKNY+PQ3/WLAUk+U4bM5pbAn5AXDswkW6DR1jEoyWjUFJwPoJpiu3UNl2Yso4qJal7c3r17mH39GkyuBakF6WqJpuzJ0p/k9quGJ3wTbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762789001; c=relaxed/simple;
	bh=uNaQu/Q9ekThqQDmD6zJz09GyNvN/wxUvc2BUIZOTaQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qxa/jfEskUwFWXcNXK2z9aZn8W9FheVB0sYexveXA6AcFqQ4fqODPjogTit5z/5GsqqeChPQCVJmELOHhyYKnmOYYmiFr+SQUyZh28ckAAwZxN6R2hxNFhkz4ojp89MNmkv4bd9GgRBA95kRxTXblOAGfLNivCvUUlU8ViFsx3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=dDzrr5WB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="dDzrr5WB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47754e9cc7fso21047425e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 10 Nov 2025 07:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762788998; x=1763393798; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5Bd/tXItEBXiIJloafWDp26fh+vqPiEInUwjV8UvKA=;
        b=dDzrr5WBufjrCoJ90m04t2gdudcMhJxYfk/ZbjMGcMDt00JdTS+9NlR+obpva0uuy1
         yfw4GWYQt3mLOdx76sfQQTHH7G+HjCdw/q6dvEhO4+QnY7sJtpohMjNWld/dn8l9DCbu
         l3j9Xdd373yjn9xjNPFLla4FcBXSpzt94XBqIVPlpNRhliw0Lel+m+3m8w0Q+X4YSHts
         Bbn9ZNxeuqTu9599cFEnvpujFLwgtT+NF4DdpufvPF6xWfj06ydpF0rZwCNie+2QZZY2
         FQB+tj9ku/T6enwxJvmwa4r0PUCe+9k7is9vv5jbDE5V5OgO7nWjCbLH72PExrAyoWkq
         VM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762788998; x=1763393798;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Bd/tXItEBXiIJloafWDp26fh+vqPiEInUwjV8UvKA=;
        b=Pof7fM4RobJYoxn9AsXm4kx/2+6YmUE4MgzC/Hi1m5AylB5CaKzPiLGvqooZutw3yj
         +rIHfD+Vf1Ssxt0wxmIouFoy7G2nvgjsmU+/IHX5amCJSABbrTBpMECgquU/RIByiTtl
         4pNHMmyxPJejLHCngneNcpI5Msj7YvwOr16qZYoIbt7U1yf0MM+pgd/u3uGjexr64DBd
         pA/N7rJc2YIGWMyzvQ2QZ/jz+VMxmFup2RSBhabEI4y9Dx253lumDrHlKqqpRVQ9GXwK
         V1Q43WrGxUxWQdsl1+Ewr++ZxnOHMtwCAyc6n6Qh+qvWRJXXymAeXK8434HbFxS6+P38
         3YLw==
X-Gm-Message-State: AOJu0Yx0VtZTHLipzPKlNIN6TRUHApcZa+yNSvdg/YqXkF3j1dqebmqU
	UabC43QH8WDyuR0Dt+xheY3LdtZmzg1iAqPNAUCoy5yxIw2IAWwffnucMiNph1c6mC8=
X-Gm-Gg: ASbGncsYBSm8TIbVhm+L/FJKo0pIM/nSO95PgTB4xqdZu3nN+Ks4RhuCnLMbSTnuin5
	6E8X5BA9clEJ29Ut3u4jLGHND/IycXlSG6dlZx1GdydBng9yXaMD1AxlKupRRkJq3EBbg9PqPxd
	PVWWyxpEEtd934CPalfpzdUZuL0+/5H74S+/h7LYUdOK4puEKNMvVxKJSIVRF8ph4pRKlVUK8B2
	2Q/DzPoUe5iaPa2KJal4nj3HQ0uC6/URoUMU0Y8K0FCmMU10LOOz58IZeGberWieMCPrMrpUNrk
	IC+mmfk1ts1mZbQGmaClwCRI0jPjJ7RxJnQkiIAfDEIm5oR28bdKKAHIa35k7lciJRhXmxhwRHa
	s5rdoL2KqJaslx2I07NcKyD6WoRPbAnuHmF2nWzbfsDjH+c50X3BZ2BcWQdwLJmn3Ce5KMNkqoe
	G23VdyBvhG6aqiAFgx9Io=
X-Google-Smtp-Source: AGHT+IE9qv7R/OTtTxm4cyE+W6NnDq81Hw117g+4APUr7JY/9kd4Ue3rk8z43sXSS7BU9Q+6UaWtaw==
X-Received: by 2002:a05:600c:4453:b0:475:da13:257c with SMTP id 5b1f17b1804b1-4777327cf62mr77057595e9.27.1762788998113;
        Mon, 10 Nov 2025 07:36:38 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47763db453csm122413775e9.1.2025.11.10.07.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 07:36:37 -0800 (PST)
Message-ID: <8c654a1f-2513-4afb-b33b-fabbafbbe845@tuxon.dev>
Date: Mon, 10 Nov 2025 17:36:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] mmc: renesas_sdhi: Handle resets
To: wsa+renesas@sang-engineering.com, ulf.hansson@linaro.org,
 p.zabel@pengutronix.de
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <20251008042526.3312597-1-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 10/8/25 07:25, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Hi,
> 
> Series adds suspend/resume hooks for the Renesas SDHI driver. These
> are necessary on RZ/G3{E, S}, that supports a power saving mode where
> power to most of the SoC components (including SDHI) is turned off.
> Resume from this suspend mode is done with the help of bootloader
> and it may choose to disable the SDHI clocks, resets after it is
> done with the SDHIs.
> 
> Reset signal was deasserted/asserted on probe/remove as well to
> avoid relying on previous bootloaders. This is also useful for
> unbind/bind operations.
> 
> Along with it, driver was converted to use
> SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() helpers.
> 
> Thank you,
> Claudiu
> 
> Claudiu Beznea (3):
>   mmc: renesas_sdhi: Deassert the reset signal on probe
>   mmc: renesas_sdhi: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS()
>     and pm_ptr()
>   mmc: renesas_sdhi: Add suspend/resume hooks
Gentle ping on this series.

Thank you,
Claudiu
