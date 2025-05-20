Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2414678F3E;
	Tue, 20 May 2025 04:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747715820; cv=none; b=FprbelXiBPr6gaysS+Gv05eEXFpL5fgzMfBTMbH/ybj38UMobGJx2tkw6b82EwHeyeaFvU24VCHf/Ov+KfzGajXWnVBG/Hm/lfNZXv67yu4VdKYVpszA0UCn6GjmxOdcw3QFaBuc4mH9WmyUVeV7u4SqFdQLmeUsFCxXku6qNk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747715820; c=relaxed/simple;
	bh=NhQGxhQ0yL17B3iT/BXjOM4IQOEzGgZC+klQ1+d1vtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DlI/Y9/isg+V3/DCA6GbwLUe5HO6kZ1ccIFEh5U3/WkVg/moEzmkJS6UjMBq3uVSrJ5ZOdXWfgeahZczKEZ/uQ1Eg5S4dw1j8weSuPMdQgb5TSaI9WLMK3OyxOJ/yyTckvSakDJMKsTHP/eAch6ebKUMcoWJWjhCQh+L71KDDxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpLi3S0G; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpLi3S0G"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c277331eso5477637b3a.1;
        Mon, 19 May 2025 21:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747715815; x=1748320615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SeMG9YLsg9XEA0NyUbXcqanyVq8FyPe8fnf9/EUxX8Y=;
        b=FpLi3S0GgRwxxwpG5LXXZ09RgPoQJAgUGxwnLacjdUC24t9f8JwVteKH0jMquTqH5v
         GWiEMUeWfbc0T9R48uZd1Egv0l/3wu/jb0YnxqLKMQq/ggmOVwd+fhxFqTVsg+VQ2RiN
         8ksZ6p/gvXRenkwZPeUvOmJJ1Ndp7AyXaE9ulSiS5zCxzEzgjWIVCyjOz+NLb7e1xhfC
         h9vh5IW8eB1o/xOpkCj1F5b4F3qMvAHk9aL2AxkflHWuYqnW9KFoT+EFg6FzkHEHodWR
         KM+wsAU3DxWpSvAMiVa2W6KvQxxtLCtopq6AJMJK5uIOJk+0xuWFmAhj/X3NuG/9/1uA
         snig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747715815; x=1748320615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SeMG9YLsg9XEA0NyUbXcqanyVq8FyPe8fnf9/EUxX8Y=;
        b=betgChvQuUZHmG/qfecBa60Skmq8KQ03P+I/r4erfIdolCbfl3UQNeZfhryFphTpjm
         NtH23A+qRgcNijY2aWM1tW1y52JAoqMAZdEGQfHLkEXpT90CcxMYnOjuQwlcZh5EAHJg
         25fUWOJ9gIBCTG6zSMHKrwpu172hpJKyI5zgUWkzPmMQy/DlAIgA6Mv018y3i+bdp9NF
         eahEWXwiyjDClZ74Z55NZSZ8hvpZ8B5lsdo2/AkNxPhSVfeU1VXb2Q3gOY7rXI5Z/eWb
         r1/WoK52DLeaM6tgo/Qfu1A1qXobWBeCt0JEyHJkR0BMa6ibrqU9m7wqmVT7Fem0K9Wa
         IqMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJChYSinpWRHqTNB08cS8rb0vmtA2bCf4vXOv8a8xaSlwCiIMiUpo3XWjBvMa7VM0ew8kgcBxFLhgA@vger.kernel.org, AJvYcCXJraCox+CGmveWXwryUkInUmeB/LjB9PLr/OtN8b59dFkctDBrZO0ZLUdekmSCB9vyoLrY/X0NyEsXEJAm@vger.kernel.org, AJvYcCXySua2aMuBgejtV9u8GRc0W0s8K+WdrDmp/a7i09dzxR7e9pa2F+luZUgyo+PT6EbuRyveElnPFpFO@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+zkzsQtp8N3Do+xMjeXqE4xNCdVu9ZznMfEx8bUBI02Yn8bTe
	RymnvAKP3JYCNCgpZwnDiEUc8WqwHREHzEKFMjgYg/646YJ8N5ne+bIHkofcXg==
X-Gm-Gg: ASbGnct9ndmAAqEjGOdF+EEJc3dNvxRRjNctu3PTHv+r4X/wRIT2vxSKplGdkoyRM5o
	fPy5S1vypmKpne1fOuAODPURKfVxSKlsbkXVBKtTFyOY4tWQ73TwRKhzkMa7nV5a+ngbj0GTGDq
	MBJAIUDm/6NgivSATQIR06h1du1tD9Kg+lQIRIqAA4QUr1NfGSLDgqbA4ZehJO6evxfz4p/I35k
	x2n6vQOwMGvn3rR/COqg2++DLsPKASDDyOfefUDRZxK/0Fs5Zgf4jDfZGMIEX1TbyqQ/jLnWWgc
	ek1oLc7MY8hoUI0U8iA9ndS2axh773dWDVON9yxUqiCZC0aC7V8jHUG13i24o4S5fk40tgPesw=
	=
X-Google-Smtp-Source: AGHT+IHy+xxixyPtO+j4BLklrYKrnGOzYdiHTF+lhvpKzK6Qdz+fUN73wAY5ibkqoMQMBWP5ADq8Zg==
X-Received: by 2002:a05:6a21:3384:b0:215:dc32:e993 with SMTP id adf61e73a8af0-2165f5e3ebbmr24708840637.3.1747715815231;
        Mon, 19 May 2025 21:36:55 -0700 (PDT)
Received: from [192.168.1.6] ([27.57.94.111])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a98a0ca7sm7029193b3a.158.2025.05.19.21.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 21:36:54 -0700 (PDT)
Message-ID: <314cdaf1-b989-4cae-a275-d962186bd46c@gmail.com>
Date: Tue, 20 May 2025 10:06:50 +0530
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mmc: ti-omap: convert text based binding
 to json schema
To: Conor Dooley <conor@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250519-ti-omap-v2-1-2a0dbc08fb9c@gmail.com>
 <20250519-unstamped-tabasco-05d9c7223289@spud>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250519-unstamped-tabasco-05d9c7223289@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19-05-2025 21:29, Conor Dooley wrote:
> On Mon, May 19, 2025 at 01:11:17PM +0000, Charan Pedumuru wrote:
>> Convert TI MMC host controller binding to YAML format.
>> Changes during Conversion:
>> - Add new properties 'dma', 'dma-names' under required.
>> - Define two separate phandles for 'dmas' in the examples.
>> - Include appropriate header file for interrupts and use
>>   it in the examples.
>>
>> Signed-off-by: Charan Pedumuru <charan.pedumuru@gmail.com>
>> ---
>> Changes in v2:
>> - Added include statement for irq interrupt controller and
>>   modified the interrupts under property to use header.
>> - Changed maintainer to Rob Herring.
>> - Defined two seperate phandles for 'dmas' under examples.
>> - Rename the YAML file name to the compatible 'ti,omap2420-mmc'.
>> - Added missing type and maxItems to 'ti,hwmods' under properties.
>> - Link to v1: https://lore.kernel.org/r/20250510-ti-omap-v1-1-588b0ccb1823@gmail.com
>> ---
>>  .../devicetree/bindings/mmc/ti,omap2420-mmc.yaml   | 64 ++++++++++++++++++++++
>>  Documentation/devicetree/bindings/mmc/ti-omap.txt  | 26 ---------
>>  2 files changed, 64 insertions(+), 26 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..195db77e0063b867f318ffc6b5f8811adb531515
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/ti,omap2420-mmc.yaml
>> @@ -0,0 +1,64 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mmc/ti,omap2420-mmc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: TI MMC host controller for OMAP1 and 2420
>> +
>> +description:
>> +  The MMC Host controller for TI OMAP1 and 2420 family provides
>> +  an interface for MMC, SD and SDIO types of memory cards.
>> +
>> +allOf:
>> +  - $ref: mmc-controller.yaml
>> +
>> +maintainers:
>> +  - Rob Herring <robh@kernel.org>
> 
> This patch looks fine, but I don't want to ack this with Rob's name
> there. Tony Lindgren <tony@atomide.com> wrote the original binding
> as far as I saw from a quick check, maybe he's a more suitable pick?

Sure, I will add Tony to the maintainers then.

-- 
Best Regards,
Charan.

