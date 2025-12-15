Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD1A32827F
	for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765813465; cv=none; b=oL3fRHrhpxUqK9usdQsvvVQJRc52TFTU6CBpd7UMFMpe/6tSJ1kd0PoLGsCMfgvFuWVFQ92FZEMFdvcomBS7kFWj9af0r58RFHssLLHiv6qGOBsTV4IBUwW37bTMTufcZkcqytrqTkL4kvdVU20k9UySWZdNa3Tj3R8I/bTmI9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765813465; c=relaxed/simple;
	bh=8iKNv5PQEpmKjIAUgM1w+AdyIYWdjSQeOABuH8TkxsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hBSw2oCR/6wvoAq+J2aPfKJrodqU1A50eun9pE2oacZFZ/yqdoD3TAgZBVU0ZuKgxGMu5vKovf6w0eHMHWmQTWgLWGXi2Lrsc1oWSn3gy7kbM1UvqL+dLEoef2QNOvWa1neAqBYL3ixEe/OhfybAaXWkfapQ/tUYX6QFOWozE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LY/hFd7x; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LY/hFd7x"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-640c9c85255so3039283d50.3
        for <linux-mmc@vger.kernel.org>; Mon, 15 Dec 2025 07:44:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765813462; x=1766418262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K3EiCf37zmh6OYCxevsK3wYl1l2l0yO8i3lRu2zzoOo=;
        b=LY/hFd7xvQLOwN+S0mEgPP3Db+sBku8dlL9JWgstaRGJEuwgvH8X8tAfDmpGBiXSrV
         KyIkPYfBYCYG6jqgHL7Yx1Nn0KNrD1G8T/ZLbed8x1EeOGKy5UKjNOLPT+G5HmWkJMVQ
         dJxT6myPtwfQ/v/uCtS7ICinkT+hTXb2sBX0KEH13UqFiNWOby68Vi/CqfSFa99pclyv
         zReD1c/vR+idOTpMySj3jutUbZQpoXn5x1jdlxJqqR/wbONHUPAcUmvSmdVReg9uhoSo
         HUkg4k6HPwqRO5jdzYqfQNMKroOEPnM5Ou1lbfyHxgk9cJkAt1u0ZfDOcTc+uqIQWfVh
         rdWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765813462; x=1766418262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3EiCf37zmh6OYCxevsK3wYl1l2l0yO8i3lRu2zzoOo=;
        b=UiuLdyGGsdKns0AU8IOn1Y9VoqZ5YsHoexA10KbDFc/jwr2WlRcZ7VABB5T/HKV2Qv
         i5en0tMEi9oj9KIhe1hGAXvckZVWNbP8mO7KHwrVv20eeKP+oGY23nskdmq+4kAxCCgJ
         3EPqlc7qnX+E5JLhtxZWubNJkNXtnM40ylg3cnrZMYGTMhV74jGefGQCETBYs+cPC89Z
         1n1I4fteUTXyAm/GenlAzaABmGDE2TRq9Upfegv8lxRnA7bv8G14T057ulfBplyhcI2x
         X2tRdSKGODILRDYDpjqEAWwbAprzKe1ANTwMoJ9mJkXnBw5B03YF0fyUIBbMffeXz8KY
         FAKQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgMbUA7P/+LAhvmZKEKBabrNGkG+Wo0SdyJY2+/wv4fcK/T78+pYjXKOAcUTxTT5ZVRga+jRP4QkE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEJamg+g1A19fRZZeZrTRmu6czzhgj9QDvPNptI8yUSo7TQEkB
	UrxJMDYmD5jp9smxhYA/LxZIIrhE1fUqInhuon73ZoeRsLM6P9jqIIIoVM2mTDlbHyTC0ub2R6S
	4zd+ObR6EkVCFzla5BzHpXRgq3hs23nR96JghGi8Oig==
X-Gm-Gg: AY/fxX7vfmMTqnTS/zbUqp+3PA/WK/2KbzIma1bG/XGH1kEWWocs4g4E1ualGPBT7kR
	mX55tiyySjP4pW3nEZNPQQdLwkt7b9KwoM0niQp+BXrqrLr968euVeIYTwzCUJPGBJR2esy466B
	tggbfm6/SSUH7xYRzUrm7aiuscAopqKIkk+a/CbYpBsR+kUrUzHD4M0jYaGQ+WB3sxGVJ9/C6Gy
	usCZTotyiu2T4vCLDE0XnTbV2C7zrZ0b6SDFhrCqY8xuD1esS9T1H8mWxfjHJ/ss9cjDDrQ
X-Google-Smtp-Source: AGHT+IGoFL7q8HvVv9KIvA1/iDdDg15+gVc1fqtWPGh45LUtRp806bxzNvgl8df7HOVfQLqABF6bjGbmgvq2nhhi7vM=
X-Received: by 2002:a05:690e:dc9:b0:645:541a:4f11 with SMTP id
 956f58d0204a3-6455564f24fmr8169644d50.49.1765813462393; Mon, 15 Dec 2025
 07:44:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
In-Reply-To: <20251203-mt8189-add-mmc-support-v1-0-f5ce43212fe9@collabora.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 15 Dec 2025 16:43:42 +0100
X-Gm-Features: AQt7F2qLO5M-hmnWGiTMCwqz4Oz4UGYnEMVnkbdBTh1zCvxxkv8BxBAberyOD40
Message-ID: <CAPDyKFoXoO-rpEK4Y-FZyWhpOumiwir96-XfLOOR2U1h73ADhg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add SD/MMC Card driver support for Mediatek MT8189 SoC
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, kernel@collabora.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Dec 2025 at 12:45, Louis-Alexis Eyraud
<louisalexis.eyraud@collabora.com> wrote:
>
> This patch series adds in the Mediatek SD/MMC Card host driver (mtk-sd)
> the support of Mediatek MT8189 SoC and its variants (MT8371 and
> MT8391).
>
> It has been tested with a kernel based on next-20251203 tag on the
> Mediatek Genio 720-EVK board, based on MT8391 SoC, using both onboard
> eMMC storage and a micro-SD card.
>
> Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
> ---
> Louis-Alexis Eyraud (3):
>       dt-bindings: mmc: mtk-sd: Add support for MT8189 SoC
>       mmc: mtk-sd: add support for SPM resource release control
>       mmc: mtk-sd: add support for MT8189 SoC
>
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml |  3 +++
>  drivers/mmc/host/mtk-sd.c                         | 32 ++++++++++++++++++++---
>  2 files changed, 32 insertions(+), 3 deletions(-)
> ---
> base-commit: e47d97576181b31291cf58e77d737d21def0e160
> change-id: 20251128-mt8189-add-mmc-support-ff6df8f89e41
>
> Best regards,
> --
> Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
>

The series applied for next, thanks!

Kind regards
Uffe
