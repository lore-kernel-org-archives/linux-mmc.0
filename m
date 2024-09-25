Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FF1D5ABE;
	Wed, 25 Sep 2024 19:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727292687; cv=none; b=cfiuEcXeguqoKQJHti09Tt+ErOeTyuJT8XX2swO7HIan71f4XW5SjcqqoxkcbBk/lvRyVkBeEYO4E4HLyfd8SrLU0rpopeOUBwXLx+5uZsy2cIKZ3JVvBfyy3yYM3qpwYsUe2AQJk9MK/pe96cR95kId6amHZKUEJLD5UN17x/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727292687; c=relaxed/simple;
	bh=Zw8NRhd8Kj3Wp7zD5zXcK8TNN/qjT42LyVLnuxRSETM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVrteezevOecWC1JVKKjnpUrviFgbo+kTbv8wCGiOXx7mH160/+i7ZyhYXk4qRx0he20G4kzW6gmW5yy2mUnnpJ/NSoN9yaSgxoEOEKG4iTuBKUfWIaSAPkEhqC8PBhfOm5Ar97Jju8Y7FvKgaJw+v5HvDRc18qikxdpEQrjik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezqRXrmU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezqRXrmU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D22C4CEC3;
	Wed, 25 Sep 2024 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727292685;
	bh=Zw8NRhd8Kj3Wp7zD5zXcK8TNN/qjT42LyVLnuxRSETM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ezqRXrmU476GNOoLcrgM5RmFHqTyDDa+JjHTgd+rnzSaSaodmLwLUupuu5qN2f+kQ
	 A0a0UU6+j/IlWSswt9juu7QfXKuz5e92fbmjgdFg1YbJMKOiF3FlFxCnglq0cCI2O/
	 f8Y5Ya6z+Wgb6AsdjNMkX3YiLqQkNJBDPD1qfOYYvC+UEiXVv+w8weBsiB7hYQsX6Z
	 7NNMOXVaQWHDu3lVk3sYSvlScK+KuVTrsZjQIPFXmBPS/Qz1pSKYDrs/bn4UhX10zk
	 AWyTVKhe2+MUqe28uCNyeiZc3U+JtlmZ8j3hoJbxz3ZrVb8R/L1XI/DFQq7cwx8Frb
	 blf1qBViyo9QA==
Message-ID: <a3777c1f-b01d-41eb-acd3-61b0814668a2@kernel.org>
Date: Wed, 25 Sep 2024 21:31:19 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] dt-bindings: mmc: convert
 amlogic,meson-mx-sdio.txt to dtschema
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-0-5aa8bdfe01af@linaro.org>
 <20240920-topic-amlogic-arm32-upstream-bindings-fixes-convert-meson-mx-sdio-v2-3-5aa8bdfe01af@linaro.org>
 <mbc2cacow73vmwn3w42aucq6x6xijbpgustkv3v6etgv35xih7@truf2rbgf3vo>
 <CAFBinCDu0P8QEvxrUdXXSVCn-1061fjyhYd2nve9QCCvXmoe5Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <CAFBinCDu0P8QEvxrUdXXSVCn-1061fjyhYd2nve9QCCvXmoe5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/09/2024 19:29, Martin Blumenstingl wrote:
> Hi Krzysztof,
> 
> On Tue, Sep 24, 2024 at 11:18 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> [...]
>>> +        enum: [0, 1, 2]
>>> +
>>> +      bus-width:
>>> +        enum: [1, 4]
>>> +
>>> +    unevaluatedProperties: false
>>
>> Hm, I wonder why not all slots are defined in your DTS? Why not all of
>> them are required? I assume the slots are there always, as part of the
>> controller.
>>
>> Is this because of driver limitation mentioned in the old binding?
> The MMC core (still) has a limitation of only supporting one slot per
> controller - so a limitation will stay in place.
> 
> However, the driver (drivers/mmc/host/meson-mx-sdio.c) uses
> of_get_compatible_child(), meaning it will also pick the first child
> node with the correct compatible string, even if it has status =
> "disabled".
> I can send a patch to reduce the scope of this limitation: all slots
> can be defined but only the first enabled one is used.
> What do you think?

For the conversion it can stay as is. Follow-up patches allowing
multiple slots, adding them in DTC etc. are nice, but not necessary here.

Best regards,
Krzysztof

