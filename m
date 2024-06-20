Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF12628;
	Thu, 20 Jun 2024 08:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873981; cv=none; b=YySJlUlpaUZIsJW+/mywzDwqm/qQIpnzOFX+nlk/TRLzCrElGRC8RkwIP8XgxojJrRhlwdlgrEA/ZL1mjyx+b3HwOiZGRCS+Zpdh7bFiEz0+sesTiU/aUEWtt3ChRw1KWGrZpdo7Abu6HqS6ZljD8D1HcUe6D0luYbhW7hFGfBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873981; c=relaxed/simple;
	bh=cQI60IEcrqfa42MZTx0roHKso9JPi6x5eVhTKI2b1xA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TFP0+cI91qQvGYUrZkJXoktx4cT6+2AOVD3liBd1dDXcPC6UpucSCLMc6E4LbUzyUs3SNEZE8Aou9S2htjRD16Rf8undCxyKwnkAdJL29uYluv3zjm36Aj84aXruYH1axWzOR0bcJeFOhUCdIaHG12XwOoQfybTxoNEBb8EKEOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1C4z4Z4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1C4z4Z4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7042a8ad9f5so1114393b3a.0;
        Thu, 20 Jun 2024 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718873979; x=1719478779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQI60IEcrqfa42MZTx0roHKso9JPi6x5eVhTKI2b1xA=;
        b=K1C4z4Z4TNezLsDyzLesLkpl3VJS7wat9a8nkHLVNEPhLPox1cytrEZBhMieuGPa5K
         X5ExYxl/Dm+TjN8bb9kW6mXS337PYGdNMdypN8cEC8OSK07G/7oXjPEqY3O6zdRTulBP
         LZ6wOpIBZyQuHBDHOjTe7Qdt2fVq02m8czGOx+ORDVyZOWNqi2FE74g5AWU8AwNSiHQt
         AIRe+XqAeNLPnKSa4pscabXBlMjpd55waZyXauyCTbAOj5YzkWNw4tJkUK6PkW4EPmRf
         zyD5k4UGz5qQ576v5z5oeeM4HvDdSxJNxVdD8ls7Tb2cUayt2aLAR1W+Zjk4t4sbQK6/
         U2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718873979; x=1719478779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQI60IEcrqfa42MZTx0roHKso9JPi6x5eVhTKI2b1xA=;
        b=V+mjgJ4F8PHmnzjNBEsXSMt0v9+rSH+J+cLC/TzBjtHaaZTG3LyiqA132DyCNp/6HD
         bfiA9fyuWAKy+zWDL29EFs7BYepX8wdrc7MuKZ0qC9OItUvsIridr1CezBio/1ab5hZC
         DhKKpPlEg3Z2VC9vwgE/0OZw7GyTcqBfb2+he3ZMckIWBcTcl65mD0N7s09rt7+NPSdP
         ZJ3kIdj4r1ZqROfBbKLL61Y5PYaavjF9x1a8NF3umxXn5o8806WVH4V0eLt+utGtCqac
         6jITP+kb80OTK9bVgasFfuhHklOoMSOhjIqkKRDnrOklNH8wHcCPN8G9OhtPDFty7Hwc
         c7AA==
X-Forwarded-Encrypted: i=1; AJvYcCUBgopbwRUbbFVy2X2TaFiNkwXov4gZjIpkARERtLm/yrfc3qEu85E8vZ9Z5TgWv6APULNzNiuWOZVPqguMapQuEP241GCmI2VjqlP/8pggJWYbWtCgRImDkDJEs04C//KLHO79Ag==
X-Gm-Message-State: AOJu0YxhLD+/VYomvKNxXRCxBfL0daQk/ZMQ0q5teVXdAhPKs2C9Un/0
	V7VSBrmdRjA/hGpAq+j8/5u33NvyZJFegFFFK5hPTdAESVgm5ECG
X-Google-Smtp-Source: AGHT+IGFekQ54+grHq2z5ysdTY1mtaZNfJKFyd6/ZVzSco0KTZV/ANjO3PSYqkiAJjBZaAR25FxGrQ==
X-Received: by 2002:a05:6a20:96cd:b0:1bc:b69f:1d93 with SMTP id adf61e73a8af0-1bcba179c46mr6637915637.17.1718873979265;
        Thu, 20 Jun 2024 01:59:39 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc91dc67sm11971928b3a.2.2024.06.20.01.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 01:59:38 -0700 (PDT)
Message-ID: <7ad3e6a4-8c77-41f3-8e75-bc063e311241@gmail.com>
Date: Thu, 20 Jun 2024 16:59:34 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Nuvoton MA35D1 SDHCI driver
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Markus Elfring <Markus.Elfring@web.de>, Shan-Chun Hung <schung@nuvoton.com>,
 devicetree@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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
 <d0caecd9-bb53-4559-877d-671ff9f7713a@gmail.com>
 <3b8e7a92-2b23-43cc-95c9-1a312866e465@kernel.org>
Content-Language: en-US
In-Reply-To: <3b8e7a92-2b23-43cc-95c9-1a312866e465@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your advice.

Best Regards,

Shan-Chun


On 2024/6/20 下午 02:58, Krzysztof Kozlowski wrote:
> On 20/06/2024 08:49, Shan-Chun Hung wrote:
>> Dear Markus,
>>
>> Thanks for your review.
>>
>> On 2024/6/20 上午 12:18, Markus Elfring wrote:
>>> …
>>>> Signed-off-by: schung<schung@nuvoton.com>
>>> Can an other personal name eventually be more appropriate here
>>> (according to the Developer's Certificate of Origin)?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n438
>> I will fix it in the next version.
>>> …
>>>> +++ b/drivers/mmc/host/sdhci-of-ma35d1.c
>>>> @@ -0,0 +1,297 @@
>>> …
>>>> +MODULE_AUTHOR("shanchun1218@google.com");
>>> …
>>>
>>> How do you think about to improve such information another bit?
>>>
>>> Regards,
>>> Markus
>> I will add my name to fix it.
> <form letter>
> Feel free to ignore all comments from Markus, regardless whether the
> suggestion is reasonable or not. This person is banned from LKML and
> several maintainers ignore Markus' feedback, because it is just a waste
> of time.
> </form letter>
>
> Best regards,
> Krzysztof
>
