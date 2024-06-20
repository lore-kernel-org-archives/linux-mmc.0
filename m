Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898B23B2BB;
	Thu, 20 Jun 2024 06:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718866175; cv=none; b=advcTW8Ea03d/ZSqu1brf+ligCOwKbGzC+Ub/HvCuQ2GQzKkDqfRk2zAW7NhfkzJ0/lyjDpGoZj6Z0qsYHsF3BLCg7fWmAQn4jFS2/G6y27JZ1O86+hY8PiJawNE9rBbPWMUspEqrn9uPj4A12eZmuk8BmQNkRcyuG9LPCRFcJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718866175; c=relaxed/simple;
	bh=btiadovay9LU0hRwoxV7sZqApNRsA+OKlx0Uc0f87bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZszeAJsaopT3H891P0qMv1wIMmQ0/RugKeeGKt73ce21HruPaCAkTs1lwfb5tRjaBzYNmG129j+k5WmHPtaEH+2GXt+8fYegUy63IydpZpU/MnhHWKtrNcYwcf9IWqQgQawpCLQjsaPiPz4hjoy5Gcbi7uB7WQeNUjAN/OKjtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kWPwpwuG; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWPwpwuG"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1f70c457823so4028415ad.3;
        Wed, 19 Jun 2024 23:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718866174; x=1719470974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=btiadovay9LU0hRwoxV7sZqApNRsA+OKlx0Uc0f87bA=;
        b=kWPwpwuGdaMNBTi3x7fAbi6WVEF9l8/Lurc/5w5NaxuBT3uVbNubnPQYlmjiXIm9xN
         TClJZQkijaiI63DFRkv0AMbvLRdtFa7R+J7ElMkvzAqCdgr/Tm9oYMEEF5/IzEPsVk0a
         K8DOHEvyIYr+wW16AHSOTPOv5z3v5vKdKC7towT54B3+Ad2ebxmx+V9hDBi3xhdmIZez
         G9fcZfey/HHyBjFB6IFyhN0RjpcDjsovyzsL2TPfa99AmlFT/vdBbfnlc+8RYm0yvLI9
         QROsCL294r9Q66Mw287fAYS3nWKIRZyfiMXvPHixYGmNvqm+huMqE3rSM7S+vGB31upJ
         iSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718866174; x=1719470974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=btiadovay9LU0hRwoxV7sZqApNRsA+OKlx0Uc0f87bA=;
        b=geE/V00l9q/H+3HzWQ7JfgnxCCSLSaiqAYjPxoWHViasKK6vsKpkAlbxTtcO1EYurL
         n95JHY1it9jkmd2Vk240YQzT84eYxVZu+xqYLXYYd4ktHPxmqZS1eca0PqOgrIf4ckxA
         W+9uiOaiBSC2WlsaJC6W26DAJU3RFjlLP23TYQBoCCj730aFrmul8h5bC4Ow/CG0dhzM
         d4xypbT/unbFReYImS/n/1hAKFy0aq6DZ0aM/cb8R8BCW1uZOWEDfXv6r1/ABjcpGWuk
         dKqxeKIDb/AedMFieQra0SAwjrRLw1Fli4yWhrQlGh9sjP07bzZ6joiGqeVzC+EEINiD
         9+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVBBEN0fC8ZBc4K+kfcWLUQZQJB8wn2XOlQOBV4Y+HMghxozunxHfShIXVVuwnLLP1dP3B5j6rC8/ICR7IXR46ScvksghD0YJ9ch3+MM27lYLkzH7lKm8AXi1IT8C9MTWUOC8xrg==
X-Gm-Message-State: AOJu0YxXCXacDcqQ8uFSsnJQEwk0+vtdkPYqtXh7zD5X8t8uitYwXTQh
	+NQCN9uFnpxcHUOcROCkXi7+Z4K+eZ/DkzAuSZarPgFUdaSUbTku
X-Google-Smtp-Source: AGHT+IEogyK87l0A2wQlLmlpr4tE9zfQzwvzpbH/CACDMPoAcQ7iGu12TCkIrGSTGMDeU6de9PemGQ==
X-Received: by 2002:a17:902:d486:b0:1f6:f984:f759 with SMTP id d9443c01a7336-1f9aa40fa43mr47736245ad.15.1718866173557;
        Wed, 19 Jun 2024 23:49:33 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9b5b7a994sm24696245ad.177.2024.06.19.23.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 23:49:33 -0700 (PDT)
Message-ID: <d0caecd9-bb53-4559-877d-671ff9f7713a@gmail.com>
Date: Thu, 20 Jun 2024 14:49:28 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
To: Markus Elfring <Markus.Elfring@web.de>,
 Shan-Chun Hung <schung@nuvoton.com>, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
 Jacky Huang <ychuang3@nuvoton.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Sergey Khimich <serghox@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
References: <20240619054641.277062-3-shanchun1218@gmail.com>
 <af302db1-1d97-4974-9c97-de4a10100d20@web.de>
Content-Language: en-US
From: Shan-Chun Hung <shanchun1218@gmail.com>
In-Reply-To: <af302db1-1d97-4974-9c97-de4a10100d20@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Markus,

Thanks for your review.

On 2024/6/20 上午 12:18, Markus Elfring wrote:
> …
>> Signed-off-by: schung <schung@nuvoton.com>
> Can an other personal name eventually be more appropriate here
> (according to the Developer's Certificate of Origin)?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n438
I will fix it in the next version.
>
> …
>> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
>> @@ -0,0 +1,297 @@
> …
>> +MODULE_AUTHOR("shanchun1218@google.com");
> …
>
> How do you think about to improve such information another bit?
>
> Regards,
> Markus
I will add my name to fix it.

Best Regards,

Shan-Chun
