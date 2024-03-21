Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DC1133419
	for <linux-mmc@vger.kernel.org>; Thu, 21 Mar 2024 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711043622; cv=none; b=AjITnRkNwThlpxWai/J3tfe/Lf22UyWIXukHds81wk5A5dxA4IIVo0L8fROrSfYrV2F+attFKrLcpd/y9S/KU++E8xHeRrAU9Dq/5r0BA/lfYLjolHAmaeN3Z7Fzw7aaeUy4hGb8YNm2eVh+wKCd0FnX34qQzlMT+rgUii3rDlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711043622; c=relaxed/simple;
	bh=bF8QrpzwQGgX8su9aJVHy7LJKwzxezOd8U7dVZd/t0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z35Ni8USn6u646C/UZUF0EObkj1VpweT7DWT8HbnFraWLDhVNH7g3zP/Y6LMj2WfAjklQ3CBFie3MhHEJT3/0KWj1hz3wqV/bYKZ+Z5RRvxw2mgM/kOK+klsYoZGs+8hzzuV4j+gXD1YfKTcWz2hCwItFAOc9dJLfJDw9w5Pf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wpdVb1kH; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpdVb1kH"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so15228971fa.1
        for <linux-mmc@vger.kernel.org>; Thu, 21 Mar 2024 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711043618; x=1711648418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WfLcNILKMVKH6IqH6h/LG+TRykq0kNVLgBulVnZ4zQ0=;
        b=wpdVb1kHZRdQaK9RJxt6HhXEO+ZpEpfU+XOyTlbWkxbxfqugkBq1pGSuKtpB0fgsrj
         99ReSUQRx6A+gOQkOVoPffIcWutHF3qNxOnOz8zZKG+OkIKq9PDXQDYK2SsTm0yBV33u
         /2c2NLHexvUPaCLrgXlJvuqy0X14fMwCftqBlb47n33VeqNrAyDf/rhBvJcJRWOAHGZt
         ieHxduI5gZbSbJfkdB3qILK0hhoE6pWKf0hW7bXnVEkqxS2Vl+24NqrIIQ56yBf+Kgi+
         4GcHB1ypV5u36TepNSmf/+ApksmyB64phFtvqD8EsDykQRBd99JOxrLCbrp11QhXYo59
         Uy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711043618; x=1711648418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfLcNILKMVKH6IqH6h/LG+TRykq0kNVLgBulVnZ4zQ0=;
        b=O3wUz3q0WqvY5XK5bj0ty5ql3MBdb7lC5ljLe1twRi2moI2OA9lMLggR0jERR8RHd2
         V4JVUUawK7VkRhGFnrOmNLiCV1jJZuxPg6EbeeR3k0hKhQQlU07a85ayKi4gc9+AUhoo
         Mpd4WYn8sreFuhSb3yirFmNBeIKRvnRWXIZ2cHO6wZDlJskIf5Ki27C4qkjQtkx8LS4t
         a7Dgav3cd6weK8xuHCuMnsrc63gau+qGLxA/oiMIVm2/0Ctf0CJwaYXC6uh7h0M9SJsf
         Dml0P9Zqqfh05M+8gpHY68+qTJtl9O0JT2o+k8BeaOVdq5XNhbz9hZMdqiJPANatwMpY
         HMxg==
X-Forwarded-Encrypted: i=1; AJvYcCXrq8GJQZmbd9YGdcQ1jQqWQf8uZvQOMC74x1pDHyZa3yTzV8/Hk7NH9Dn1GxLE9RNcYVGjJGhF5T0KbPJAWhD5PApRxLUSHFxD
X-Gm-Message-State: AOJu0YxkbaqBnEV7v0Bw/0YpUvGcn/9DXPioV2Las+iwwN1bRLWQpSYQ
	MccUyFPIf5eS+q39dB5TmeLYsWB3WpveM9iumICQxAbUwrNQkM/CbcWkV+5MGpI=
X-Google-Smtp-Source: AGHT+IEgLpwbnVgSnpxQTIOpQab94kvnZWJf7XczPmv9vUiAZoOrKbqCvLR7HxrAOTIShSszLroQ+Q==
X-Received: by 2002:a19:c212:0:b0:515:8568:bb67 with SMTP id l18-20020a19c212000000b005158568bb67mr70197lfc.27.1711043617842;
        Thu, 21 Mar 2024 10:53:37 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id la8-20020a170906ad8800b00a46e92e583bsm151110ejb.149.2024.03.21.10.53.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:53:37 -0700 (PDT)
Message-ID: <00174dc3-65a7-4a2e-b48d-a974336a3f18@linaro.org>
Date: Thu, 21 Mar 2024 18:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] dt-bindings: mmc: fsl-imx-esdhc: add NXP S32G3
 support
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Chester Lin <chester62515@gmail.com>,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, NXP S32 Linux Team <s32@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Marco Felsch <m.felsch@pengutronix.de>,
 Gregor Herburger <gregor.herburger@ew.tq-group.com>,
 Marek Vasut <marex@denx.de>,
 Joao Paulo Goncalves <joao.goncalves@toradex.com>,
 Markus Niebel <Markus.Niebel@ew.tq-group.com>,
 Matthias Schiffer <matthias.schiffer@tq-group.com>,
 Stefan Wahren <stefan.wahren@chargebyte.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Philippe Schenker <philippe.schenker@toradex.com>,
 Yannic Moog <y.moog@phytec.de>, Li Yang <leoyang.li@nxp.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-serial@vger.kernel.org
References: <20240321154108.146223-1-wafgo01@gmail.com>
 <20240321154108.146223-4-wafgo01@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321154108.146223-4-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 16:41, Wadim Mueller wrote:
> Add a compatible string for the SDHC binding of NXP S32G3 platforms. Here
> we use "nxp,s32g2-usdhc" as fallback since the s32g2-usdhc
> driver works also on S32G3 platforms.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> ---
>  Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 82eb7a24c857..b42b4368fa4e 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -35,6 +35,7 @@ properties:
>            - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +          - nxp,s32g3-usdhc
>        - items:
>            - const: fsl,imx50-esdhc
>            - const: fsl,imx53-esdhc
> @@ -90,6 +91,9 @@ properties:
>            - enum:
>                - fsl,imxrt1170-usdhc
>            - const: fsl,imxrt1050-usdhc
> +      - items:
> +          - const: nxp,s32g3-usdhc
> +          - const: nxp,s32g2-usdhc

No, that's just wrong. G3 is not and is compatible with G2? There is no
dualism here. Either it is or it is not. Not both.

Best regards,
Krzysztof

