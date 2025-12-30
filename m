Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C95A293B5F
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108847; cv=none; b=nC61okPxlKisdRS/qPVAiDns+hOtMLhXX7E06GM2NAATj2jlP5abzCY7la6KRG0q4L2GmiXaso/ltshgVkLHc/H/kdF6tamacfojYYczvG4QCuH2qVUl4kQmONi3XL72Gou6fBjFRpamelCCtuT7MAJ9nwTOZCHuae/3jmNBm48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108847; c=relaxed/simple;
	bh=cJNaMYuuC2I7/+95x8jcQiPUFjMk3F+7PHyjW8Lo1tg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4G0KhTpjrIul3e/B5L1lDQMpGcjn55QZbLLRjl/wZGc5NcmI9CtlZ1yQmsuipqupQykL84eBhMbgl/ykHt9aHj6O+VFzOBd3rxWfczCelIZWXd3DT9xo4/BSLclVEbERvVXxLyP5oAApCVgmspZwzHIEufKNdKwfJEzg9kg54s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wGui7GhQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wGui7GhQ"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3825ae23d95so29428501fa.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108843; x=1767713643; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IIQJu7CyiY9gIZvx6eWahf0Uexh2lGW7onsdB+Wi7IY=;
        b=wGui7GhQoHJYpY2Otxo7tiH4We8oeeHpoP6VQ7TRJ9ZSzcXbqBqnJJkQcVV8/9g/2X
         ZkGO/j/H29qUP5+hpfwFsuEA21LfmoktR79tgfwAIQc7rrml4FmkaQ2Q7xcEVj09FZ2r
         UEXqXefVZhuXGDh7K/DNZnWHszFHxQRABknXdl+dsHlqJhEgAtWYIWPwwBgp6XZFrrss
         BiL29uqiCNwccLKXiwpYALYjr10GYIiOY5lAUuFidugLIL7gsaF/BtxwZ6trl24aHi8a
         iNIYA1w1qdezVc16PB491R10N7wKB5mJZAV5o4kA88XqK25DTHkIJ7l+8DtQTmoh/hr8
         f/WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108843; x=1767713643;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IIQJu7CyiY9gIZvx6eWahf0Uexh2lGW7onsdB+Wi7IY=;
        b=sQp8Y9h5fZAwgRaZIhGS9foaJeyUFDcpUFf0arFkmMvXrpuP4eSgfkLSR9Nj884rtl
         kNL9EYOe3TWkH4/d1gEft3vvUayH28x6KmO00xbh80SyYW3T6LxA03/V4BCeDESr9XJy
         ZnoFjOAn2fDFMpOa4bGK+cgiZXpiOuzT6OA++MmIYKtRsyS+rNhS+6DHT8DAC8unVBp6
         /drV3f7qyTgSJn2BcbmUICY3Lcs0rVg5tXpuIYxQUwMTootnkjkZDrFTuSGDBANhHe2Z
         55d/ejjujzgwIAoD39Pd4IAt+X8uq5UjV/Uc1uG89+FmxwmDCaGH8JH/ifbE4qQh+oNk
         oINQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4Dk21EHja4CfRSR5jNh84jOtyNBMH5u7veWs2eyhKx7w27GMHmFGQaXPlfEzVIH+hs7uefL7QR+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbN7lD9Wr08IE63bkhM/nsxnU8+/8fWDHyrCk1Xhp/ECHmQgE9
	BIcNzezYKPHSVbCrY3/YspMPKa3t3QtvHnxxomr/JjrHFqi22TwykdbhB9oMGnV08SRrg6GoYTj
	/Pjk59ejzj0wuLAHhuEk+e/6D94HwuBFiJi7wwJZL7g==
X-Gm-Gg: AY/fxX7y+AWl2SZuO3cYptavTPXf6muf83uzGVMF9+2W2JzmlQE492B6/GteXyp2gBR
	Zw1Mpkvyc6AEwa5cU+gH+/KAeUuYmaN7ERpYnsvAHiu34LuYZn7YM+5Mrc/Dg6FgD+T1orSkJ9a
	cTs5odyVmB5n5oJbHR8vNENZxyB/87esjm12wMA0NtDgcvCLp2l4yyjSrg5+MV6b/tmdILkCDVZ
	UpfRw4ejz5Odu+I8JzTfWiKDIhPtruATUGVRyjl4vvOLgGFr6v/fHzagzd3DCVkhygbaO7PAL9O
	s9m7yH8=
X-Google-Smtp-Source: AGHT+IEEzSWxU0Fr9jtKf4rnUE+MZIqWiBIfHx6EwjCFpsAYl5LLEX7BferoDb537v/2XTB1q5TRJQn0YC6nmgiVvgg=
X-Received: by 2002:a2e:ab89:0:b0:37a:3033:16f6 with SMTP id
 38308e7fff4ca-3812164513emr98831031fa.35.1767108842896; Tue, 30 Dec 2025
 07:34:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:27 +0100
X-Gm-Features: AQt7F2oqCrEKFHiJvi35sI497oUVGoB1FksL7aATuRnp8180lObyxwQDc3LztRs
Message-ID: <CAPDyKFo905ptdO-rSkiJ-ax2u=P_+EAJA30b14n=B4j9adaaKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mmc: sdhci-of-k1: add reset support
To: Yixun Lan <dlan@gentoo.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Dec 2025 at 03:25, Yixun Lan <dlan@gentoo.org> wrote:
>
> This series try to add reset support explicitly to SpacemiT SDHCI controller.
> Previous it works well for eMMC due to it's already initialized at brom or
> bootloader phase.
>   The controller has two reset lines, one connect to AXI bus which shared by
> all controllers, while another one connect to individual controller separately.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---
> Changes in v2:
> - To not break DT ABI, make the reset line request optional
> - Use devm_reset_control_get_optional() api
> - Link to v1: https://lore.kernel.org/r/20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org
>
> ---
> Yixun Lan (3):
>       dt-bindings: mmc: spacemit,sdhci: add reset support
>       mmc: sdhci-of-k1: add reset support
>       riscv: dts: spacemit: sdhci: add reset support
>
>  .../devicetree/bindings/mmc/spacemit,sdhci.yaml      | 10 ++++++++++
>  arch/riscv/boot/dts/spacemit/k1.dtsi                 |  3 +++
>  drivers/mmc/host/sdhci-of-k1.c                       | 20 ++++++++++++++++++++
>  3 files changed, 33 insertions(+)
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251221-07-k1-sdhci-reset-1990d1170437
>
> Best regards,
> --
> Yixun Lan
>

Patch 1->2 applied for next, thanks!

Kind regards
Uffe
