Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52E218021
	for <linux-mmc@vger.kernel.org>; Fri,  2 Feb 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706862220; cv=none; b=dL+v4l9r4jytjT/7OwoiEHAyoR5q1ofLTRxVD49Cwgv7+zEVlKB3ukzpLxP5w0p/7GCpCAmePd4ZVM0GBxu8WAa5Yj84IXJEnC0qAB9lZt3BcdnCB9cFKT4LYhuWxCSW6KZ3doronlqhUvU0kbMJnCgGWG6jXKJtZggh0inE5OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706862220; c=relaxed/simple;
	bh=xewRIeaQFg1AbeZ7+QaAVaL2ZFfZQKRa5jlYYB9mxV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U20TJhjI6vMREyxOfD9vQ9DNxV5WA/LFKGs+ycwJUpigQmCuxAFKWdm+rdPrzRyQy0WGLLQkwJ1ZnukafKtbyrUZk1/oyEmuD/172LDUE52NrSLe+ne8XVjKaPdtKhcL+M7xOjPHXnzF5dqrHLJJzx6KupDU8FlFtPE3H4XKf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G2QRVsnV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G2QRVsnV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d70b0e521eso13104355ad.1
        for <linux-mmc@vger.kernel.org>; Fri, 02 Feb 2024 00:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706862218; x=1707467018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VuecZqHkgLflMmLgZf4ZSLRxGy52wVJ+1D0626OLoD0=;
        b=G2QRVsnVGVb2dM/9hhy82DcLoVb/UP/xVncbWz3xcl/5rANq5hqpIamApznLAqOoNB
         0xhVH5i0Um1LvOWAcdkePBM1CNPOsnL0Ao5ITxs8pB8jL6Uis/81EnIc1YPJwRC0RLKL
         Rmm8zK8YsJXsgFfKrHNvmr0h2hNWv06oZsPPGkQkMSWcktCqpWjpwzVvSFgt/AZFy0Ge
         StCJHBmkmrtP6BrX5XJfLfbP4Iep+0iKsoUTjt4sU/GwRAF++2wDOg9EX2HXc167AgLb
         0l81A14gN3pYv1qzGEpy+ZnmWrW8STF4G1wdu4x537iG9YwEXal0Ky3lJGT3+ru01nbj
         BgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706862218; x=1707467018;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VuecZqHkgLflMmLgZf4ZSLRxGy52wVJ+1D0626OLoD0=;
        b=bcUgPOI12s7HRux3HJKjKnFDuj/egnnQZmV+uAd8crWf3O/vSLwtbHE4uo/t/OqO2L
         cZai2alDJcFBwwTAoAtxta7fpAX09dMZJ19NqA+HE5C05TdAT8/tJMeWd1t6B89cH+T5
         zYmB40VTYoN6SgVstanDTYzpsMKOZdb2pt81LV7t48BhH0khhoJGzUBLiK+Gd7dE/UmQ
         bm5vtmBlmPxKS0TwBjCRqX4uaWoc9CuzKB/A1dikOK6kw0Psm31Xv841squ79tFyHZjs
         tiYUuaaMC+AeyW31rlHsa7fdxF51jyAVKrcAK+Hb4+vbkLVYtTNlJMXA4vUySSbMSino
         pz2g==
X-Gm-Message-State: AOJu0YztDjvB4vk8ilyBnSs5nwK36R/e3V/h+9SOHAh0tSVVeJrZxs07
	EYNPIF78g4pYR6bChY6LjwD4y0WQCL1+fspHcIN3vHpodpC3he4BZB16p9pKE5Y=
X-Google-Smtp-Source: AGHT+IFvpjf5ic9pPp0I0oH89bz+61xCGdTv0feKA3rHpe9dJkxNwswGNwcn4VMZtl+YQQwVbYjWug==
X-Received: by 2002:a17:902:650c:b0:1d7:5943:21b8 with SMTP id b12-20020a170902650c00b001d7594321b8mr1475938plk.16.1706862218012;
        Fri, 02 Feb 2024 00:23:38 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUkLr1nGCiRksBEdX3ay8JGVXW8xWK/+YOYV//B3uvgEgnB9jQQXWD41a8LOPZr0RYjFAqHwyFxC4kPYZg7o3gDo0p8gadhD2DkQdCCXiZnoOkcum6n320K0fhDj9GuFQi5PjcHE3qPxieAiGkOLxc6ibC0ibO0CcA87u5fA58L58KIP/8X1dc5ZScT78UVR5x6Bj/LV31GANDZBT18BsW8Hr80w2PVdDIzfLZJKMMSJlIEZzaB0qQvB5zsK8l2Zpc1+WT60VLTnSKVsf9vcwNMONFjYbBmtIhGZVuKk/eoFcXUybNqn392f5FufoAaqqNffpAeNJARWGuOcgBtNXKko3Hl6/l0+wWlcIypRmV1KLz+F+v4ltLJzfk661hKnqD8JD5F5j7ldAwRu/vwIJX3GSwYTpDu7UjLfPW3MkYn+OY53BJibMvYwuoH2w/HUkqbXkYtTJsAwV2i5+tTRXk1LNon6t+lY4iLFue/hRR7piSkGDPIBsC34PM50mv0D170ILsOgVd15Zq/rH9EJ4e7dpWdYyJ4vG9W1AtMO1X/k+sdqZHcw/prWU4C8M2D7kmfqWKEvAh8lmfOzIJ5e62orufAu4jbRiAsfA7gBVFgCIEA2b69Z3q9fpp79npTXjor1EgzP5o2BBZSvie0QobY1/nhgfm5e8+3t7kb3JA5wSEL0+cjKkDDNZfsNYRkaFQ5jmrDmedZ
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id jg3-20020a17090326c300b001d94871ba92sm1038374plb.239.2024.02.02.00.23.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 00:23:37 -0800 (PST)
Message-ID: <c519661e-c37d-45e2-99dc-22fb86a8e97b@linaro.org>
Date: Fri, 2 Feb 2024 09:23:27 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: mmc: fsl-imx-esdhc: add iommus
 property
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, imx@lists.linux.dev
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240201-8qm_smmu-v2-1-3d12a80201a3@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240201-8qm_smmu-v2-1-3d12a80201a3@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 21:22, Frank Li wrote:
> iMX95 and iMX8QM have smmu. Add property "iommus".
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

