Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BA2222AC;
	Thu,  5 Mar 2026 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772707605; cv=none; b=l2ccoTaP7LhMg9wpf6uL3JwGUm2ryD12PLJms7QgYFHFOA7eGEgrZUuxhejxYub0cbhY+YlcPU7bj3wLfQkeKttlvJMKlFfwSKiOtGZJWU2Li0HYEVeYbvOvuctOmP0x3jVkf/jhGc/lesgsLSCAQVmoAGzDpgbJ+7LJ7VQbbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772707605; c=relaxed/simple;
	bh=1lEbzZR//+Yc7K5TUFwZ97IJ+ukRCAnqOXR6JFDQSz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhGnNJNvPZ4Ff2mD5TY6xUL1hJSMxseoDUVkD/ag+YBHh+7R3qR2E+yrdTdnlc67UPzKEv7zVa3kmImJJF84MMwwN5phJnG8vsz3HugvVFWbdaWnmU3KsgiKA2bP5jojjd9Uchm5kXloNKkOzVgJhDHQIeW9Bz/N2nFTFZOdSKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJr3xQBD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJr3xQBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF16C116C6;
	Thu,  5 Mar 2026 10:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772707604;
	bh=1lEbzZR//+Yc7K5TUFwZ97IJ+ukRCAnqOXR6JFDQSz8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJr3xQBDAxaMYTCCGl2Xbz20BXRD6QC+6s6ohVgHv/LcHsWM2PiFV8WKvYkXErAgh
	 /6Z0VzJVi3XLYRbUIXMIvT3/pn9p3eguvUQi24ogjaTEuNh0d9Jo5y3FzNhCFI9DhE
	 CLdg3fF8TnnlJup63/KKl2eCrCMVugrV9Dn/uTKZcYToPTZNTdSHDPStx3z0bL/mD9
	 3/bLws5REUCiXxgb1Q+KJDNye62w7b0KdvtNAnNWWGLq0JFuSLMXKN7D3gcGwnEaJV
	 vq60lyySCrhNmrAswIJrNg8y/Hnbv4KD8q+gsODmMFa7PgEOeQPtqHsvZ8VEIh0V7s
	 rMCs0AOPuJPkQ==
Message-ID: <8d991c0f-3244-4c0a-af4a-8d7aeb8ca35b@kernel.org>
Date: Thu, 5 Mar 2026 11:46:40 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: pwrseq_simple: fix probe failure when
 CONFIG_RESET_GPIO is enabled
To: Bartosz Golaszewski <brgl@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Sergey Suloev <sergey.suloev@gmail.com>, ulf.hansson@linaro.org,
 catalin.popescu@leica-geosystems.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linus Walleij <linusw@kernel.org>
References: <20260220194725.1341281-1-sergey.suloev@gmail.com>
 <CAMRc=McNXzDE48zX=eH_bfg+KBN=2-yeW6bjL1L=hCmHu6xv8w@mail.gmail.com>
 <923d35430a633af4064d671f1cac1d47780cd14f.camel@pengutronix.de>
 <CAMRc=MdAp9fgp2zoU0AXow2avejqB=ZjiKanVgFVxokcmFAvuQ@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAMRc=MdAp9fgp2zoU0AXow2avejqB=ZjiKanVgFVxokcmFAvuQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2026 11:04, Bartosz Golaszewski wrote:
> 
>>> Philipp, Krzysztof: what do you think?
>>
>> I think this is a missing feature in reset-gpio.
>> This driver could fall back to to devm_gpiod_get_array() also if
>> devm_reset_control_get_optional_shared() returns -ENOENT instead of
>> erroring out (maybe -ENOTSUPP would be a better return code for [1]?).
>>
> 
> I did not write the initial version but Krzysztof: is there any reason we only
> support a single, two-cell GPIO? Would it be problematic to support any kind of
> reset GPIO setup?

It was only due to limitation of my initial solution - see even a TODO
note in reset/core.c. I think the problem I had is that GPIO specifier
without flags (so cells=1) would mess with GPIO_LOOKUP(). And if we have
cells=3, where do the flags are? If you assume flags are last argument,
that's an implied ABI encoded in the reset core.

Well, heh, implied ABI that 2nd argument are flags is already there, so
the code is partially hacky, I agree.

So honestly I believe that GPIO core should handle all this mapping of
original reset-gpios property into platform data to reset-gpio driver.
That's the answer for your question "would it be problematic".


For reference, original patch:
https://lore.kernel.org/all/20240129115216.96479-5-krzysztof.kozlowski@linaro.org/

Best regards,
Krzysztof
