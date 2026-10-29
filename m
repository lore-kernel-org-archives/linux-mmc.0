Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793258816;
	b=tmMczlHNW1U/j3gKwzjtDQnfH/Z1W6RQDf84+bJyQuvb6rys3vxtOcZqVw0QeKut7WlP
	 VIMqTi0VI9JrzSVL/tVzALN/YDEheTVtmRloMjAGtHbUn9wyenes+WqQcDdukM34onOtg
	 k0zemUDUZFxNEIbCzpVYlmyccFnVio2Z+dY5KTLgQIkT+8BK4LfAJUyOnMcYw1GeIxtZ7
	 NZwScwZ8HNQDTZWemc6mjtzF9qTUA00TJ5FHUIzafo1p48LqwrWnv4rNvvIm+Soc1ef7Z
	 M3TjjuMIKuZguxaWstnCZgkzY4gVPF3fa5mr/fm5o//DNQ1hV3tRiS5fc9y5vbUxg+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793258816;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XMGPJDGIthI4qhZgaEnIIK6BEfqVenWCLzclU5O7E0E=;
	b=vORNbIh3WJV0GmpC6K+i39khXCGgAa1iQG/5fxX2PZx7DKPUbcASqcQXKrV/o2YKnli4
	 n7+RyNlxSzCIQus0u/i3cAkNWm3YeJCsClG7SRo5Dj7C5dM31vYs1hXU5LuYp080G7HVf
	 jqkyGfW6YAAnyjdu2H9LTxpu9aQ04RDa7XWJL602UNk6slrgc41/UpD/1j17pI2d6R//4
	 gmJdTsqySyAeiimm/yrHnJeeyEuz//nX7oAJNbg08tdJaItEioDXGlaWiVXHtZVtTSrEu
	 A9JYfaWK3tDD5BDUZcX8FMW24OdGv+yJL/oWY1rZAZIwwKbaFfBQ3abKOwS2V1YrwZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft1z2N7J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E0606A31C;
	Thu, 29 Oct 2026 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ft1z2N7J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0A91F01825;
	Thu, 29 Oct 2026 07:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793258815;
	bh=XMGPJDGIthI4qhZgaEnIIK6BEfqVenWCLzclU5O7E0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ft1z2N7JzZD6tBinNibnLzERNsNnr5VV8cjY04boEL3b8D7AIpr8KoSUei3vKh6fP
	 YjH/ATOM5vxy6nOS0U9VFegFjixzZB7ujsnahbm7z/WJpwZjn5qW+gNdlZ8Z0k9gxG
	 thtMoIffsb5VN+QQmzo6A5Mc8BXYdK0dh8P5s+/Yz5jQo4z4GKUGens+Pv6+Ab7hbR
	 QfynquNhVk95qNikI114beAydT8ScIEp03Pj+otZ1l+ElRTFI1lYud1PzyG03Xfsbq
	 xF7lxWh6ugakKp3j8ic4NwUJE+w+8pGRWa174OKwkjm4iqSricdpjO9eiDYO3pV+ev
	 Sm7DYnkihWZUw==
Message-ID: <fd1d29aa-2d6d-4e15-8222-b76929fa5a53@kernel.org>
Date: Thu, 29 Oct 2026 08:26:47 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Document support for
 Airoha AN7581 SoC
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson
 <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20261027144002.10606-1-ansuelsmth@gmail.com>
 <20261028-academic-blue-earwig-72d3d1@quoll>
 <6ae22763.2bb6edcb.3bc160.a0e2@mx.google.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <6ae22763.2bb6edcb.3bc160.a0e2@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2026 17:48, Christian Marangi wrote:
> On Wed, Oct 28, 2026 at 01:51:16PM +0100, Krzysztof Kozlowski wrote:
>> On Tue, Oct 27, 2026 at 03:40:00PM +0100, Christian Marangi wrote:
>>> Add dedicated compatible for Airoha AN7581 SoC integrated MMC controller.
>>> The MMC controller is based on the MT7988 with the difference that it does
>>> have a single clock controlling it.
>>>
>>> Add the dedicated compatible to describe the 2 register requirement and
>>> permit to define only 2 clock (the main one and a fixed clock for HS)
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>> Changes v2:
>>> - Also add compatible to restrict clock-names for source and hclk
>>>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 3 +++
>>>  1 file changed, 3 insertions(+)
>>>
>>
>> Your driver part suggests it's fully compatible with other variant. Why
>> not expressing it with fallback?
>>
> 
> You mean something like 
> 
>    compatible = "airoha,an7581-mmc", "mediatek,mt7988-mmc";
> 
> ? (my concern is if this would be problematic with the current if
> conditions in the schema)

I see, the first "if:then:" would be tricky to convert to "contains" for
the compatible, without bringing a few more conditional blocks. I guess
it's fine here.

Best regards,
Krzysztof
