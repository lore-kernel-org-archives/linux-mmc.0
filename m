Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A673E3D9F;
	Thu, 23 Apr 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937488; cv=none; b=ILAIgPxmnS9idv6WlXlfmMZ9LIzujV49uhCC5a8820wtYZroFVp0FUy0WK6+o78TAQ2zQA/OAGvP5df2lDWt2/7doO+aVoS0J4BDgXWWimsTjP3mIlgWU+AaezuJrYccEToESvO0H10kntsWrckLhPTcSVjtM5W26jrJN0DdXSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937488; c=relaxed/simple;
	bh=UV9jQ9XvPw0/PwdWna/NVSWez2dG6UsrgOwaXbivd94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tP1qx8byWe2X2qj2+Ar2oFdQvshil2a1XhVVydCx2C9sLlVo+Pgx1bdoJo6kr3RAOrUjCYDWM+MjtRddo9oT6qDgxuABbB7YHAk4t40ZCEPettR+HQjLO8FnzCCmQmOGJ70c5QYoLOKuwXkX9Sc8ULHDRg8WdjiasKj2PYWMZNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b8fqnLTl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b8fqnLTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C79C2BCAF;
	Thu, 23 Apr 2026 09:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776937488;
	bh=UV9jQ9XvPw0/PwdWna/NVSWez2dG6UsrgOwaXbivd94=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=b8fqnLTle6qiUny9GLiB66mYAvo5pBUfGKBD9j/SahanJ30PqBLowxW5CMXWn6bcB
	 /9KKEDA4+3JjPVlO8reAQWz3gbHKJHh6CjB0/r0QC1XDIRFmwXmNjdzG5kNEXNX4i7
	 ZreC1J8OXDRgUYm2lq6drbBN35SKwmpclgU8Lj30YaGYBidek7X8ob6HkWEHe90Im1
	 SerDAq+lK3VQnHz9bka8lfRCLgXkZqiZ13bXwAKg2i7/a4khm2umdT52rkMkCQfZlM
	 PAqGOSCIsL90EjYGlCqI3uxbscyr3PsSgAvwt86DBFzgHFg+U0nL2MiJ6ID7r0lSxm
	 wNVlQgxv8w7kw==
Message-ID: <be916c95-1c31-4a98-8fdf-06538e693911@kernel.org>
Date: Thu, 23 Apr 2026 11:44:41 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 0/9] riscv: spacemit: enable SD card support with UHS
 modes for OrangePi RV2
To: Iker Pedrosa <ikerpedrosam@gmail.com>,
 Troy Mitchell <troy.mitchell@linux.dev>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Yixun Lan <dlan@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org,
 Anand Moon <linux.amoon@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Vincent Legoll <legoll@online.fr>
References: <20260413-orangepi-sd-card-uhs-v8-0-c21c40ec16d0@gmail.com>
 <f58ec12c-3957-4d44-b823-6a1ae1a1dd94@kernel.org>
 <CABdCQ=NhTkGJUh_fKnZoQMzdpyO-UbV5zrSfiNVUC7bkSBifTA@mail.gmail.com>
 <DHSQ6VG82QYX.1EVAYV9JTBCL7@linux.dev>
 <CABdCQ=Oata1oXds6pV-RipwZjcztM0xk_J=Rk8Of2w2RqegbHA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CABdCQ=Oata1oXds6pV-RipwZjcztM0xk_J=Rk8Of2w2RqegbHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 16/04/2026 10:18, Iker Pedrosa wrote:
> El mar, 14 abr 2026 a las 10:16, Troy Mitchell
> (<troy.mitchell@linux.dev>) escribió:
>>
>> On Tue Apr 14, 2026 at 3:12 PM CST, Iker Pedrosa wrote:
>>> El lun, 13 abr 2026 a las 10:07, Krzysztof Kozlowski
>>> (<krzk@kernel.org>) escribió:
>>>>
>>>> On 13/04/2026 10:02, Iker Pedrosa wrote:
>>>>> This series enables complete SD card support for the Spacemit K1-based
>>>>> OrangePi RV2 board, including UHS (Ultra High Speed) modes for
>>>>> high-performance SD card operation.
>>>>>
>>>>> Background
>>>>>
>>>>> The Spacemit K1 SoC includes an SDHCI controller capable of supporting
>>>>> SD cards up to UHS-I speeds (SDR104 at 208MHz). However, mainline
>>>>> currently lacks basic SD controller configuration, SDHCI driver
>>>>> enhancements for voltage switching and tuning, and power management
>>>>> infrastructure.
>>>>>
>>>>> Implementation
>>>>>
>>>>> The series enables SD card support through coordinated layers:
>>>>>
>>>>> - Hardware infrastructure (patches 1-2): Device tree bindings for voltage
>>>>> switching hardware and essential clock infrastructure.
>>>>> - SDHCI driver enhancements (patches 3-7): Regulator framework
>>>>> integration, pinctrl state switching for voltage domains, AIB register
>>>>> programming, and comprehensive SDR tuning support for reliable UHS
>>>>> operation.
>>>>> - SoC and board integration (patches 8-10): Complete K1 SoC controller
>>>>> definitions, PMIC power infrastructure, and OrangePi RV2 board enablement
>>>>> with full UHS support.
>>>>>
>>>>> This transforms the OrangePi RV2 from having no SD card support to full
>>>>> UHS-I capability, enabling high-performance storage up to 208MHz.
>>>>>
>>>>> Tested-by: Michael Opdenacker <michael.opdenacker@rootcommit.com>
>>>>> Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
>>>>> ---
>>>>> Changes in v8:
>>>>> - Resending the series as v8. The v7 submission failed due to an SMTP
>>>>>   error during transit, which resulted in a broken thread on the mailing
>>>>>   list.
>>>>
>>>> Hm? Everything is here:
>>>> https://lore.kernel.org/all/20260413-orangepi-sd-card-uhs-v7-1-16650f49c022@gmail.com/
>>>>
>>>> You can send individual patches to fix up threading, use --in-reply-to.
>>>
>>> My apologies for the noise and the rapid resend.
>>>
>>> The reason for v8 was that the v7 cover letter (0/9) failed to reach
>>> the mailing list due to an SMTP error on my end. This left the v7
>>> thread "headless" in the archives without the changelog or the full
>>> context of the series. I was attempting to fix the threading
>>> immediately so that reviewers would have a complete set of patches to
>>> look at, but I realize now that resending the entire series on the
>>> same day was premature.
>> So that's why Krzysztof said you should send individual patch with --in-reply-to.
> 
> I see, thanks for the clarification. Just to clarify for my future
> workflow: is it acceptable for a series to be 'headless' (starting
> with Patch 1) if the cover letter is lost, or is the cover letter
> (Patch 0) strictly required as the thread root?
> 
> In such cases, would it be better to just send the missing cover
> letter as a reply to Patch 1 afterward to complete the thread without
> resending the whole series?

Replacing missed cover letter is tricky. If you patches have in-reply-to
with ID to a missing posting, but you could do that with a bit mangling
- you would need to send the cover letter with that exactly MessageID.

If patches do not have in-reply-too, then you can send cover letter as
reply to patch #1.

Best regards,
Krzysztof
