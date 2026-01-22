Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D18306486
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 18:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769105069; cv=pass; b=GnLjo47ERtkNX7dfN3RClEuf2+Kxq5tU6vGeuWFVHrtJzpPE1dqBtp3QSzUCeRFe2bdWJeEsLQY7QtYfRNp8Q/zGiE1x2FQOIcPBJIQQQQGGZ4JHnTbQbVj16y/Sz41uly4mKasSiNgBuB1SynJZKrrc2HM/hztCvw7Eo14zRBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769105069; c=relaxed/simple;
	bh=JoJqK6ZMjXBJh/XZxPRXUeBhD4yr+ijhekfGT0tzlJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtSzYcyma3sEqRiVQYxJjgM+gr5U293sY/71ob+Auh01UWz/mmofker0JVJhfspl74JWO4vgXCtKx3z+8+93SWxXqftEXtLQVX2kCXtqeiO5EGrhiAyw7mXe7dnItQ+auRmGoatY6jxnSz62gG7NQqUJD645m10DWCWHDslSF7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UcNfPHvw; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UcNfPHvw"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59b679cff1fso1197574e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 10:04:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769105054; cv=none;
        d=google.com; s=arc-20240605;
        b=CIlozLsXNzu+jB/mjA/h32kMA8D8A7hIOLOOHUnYI/mQBgC0Nwtao1pfPkVONOhSaq
         C4/Y4QpgdYs0nnfJdglcOJ67Rcwf8Ielr66u+Ulg9Fcxsuv0NmNszDL0hbZQeFT3jNxp
         EfjIyQxRAeE/uigIhngYDVF1JQVW+/zO2bTnojsaE2ldLu0xceTL/8CZq2Fej5cslgjl
         +SUUc9qUL1fN/d4jyD/VbzPnvm899mRYhs82a/zxwBYVZmzy7xRsK1uAZtUgxRPpNJdi
         BxneuOefX8OTVVP98TLjfI/a/nejaNOFait7dytcPYu+lYbOPfQR/lmNoM9ovwXBNFF6
         2+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1dAdnI02pT5EuloFaObahJw7pcpTRooaOZFcQF4dsRc=;
        fh=tWF4ElJ0SlfKVWGYNikX21TBLpcK06kR1liD/5tqrSg=;
        b=SO6S9IpgjubTw56qEwhE+bDSEt9BmN0mRLbnulbEpNmY40B5jq/KsHpVPL7lHKmHz1
         xRVboLNlmf2RQ2Gao/szQ2KBUDuIkIK05bRYTDVn8qrKFWeYAXkLq3YPArhmUYb7tgwz
         v1oAPNj0ZJRJX8niYl3xACSQ5zM8QJQ2lP3AYlUo5aMAx0qU0Y6hIV4VdAWgVidQMo50
         CP6X02v76fZwoTDiNkwGXBY9VlbmiCID4M6BQc21+9OK61bEfx/zK6hs1uHj2c32YGyu
         PeMdhsRfm7r6vfHrUXERIT3wD4vSthR8avrzRhzjZoUwbB6X+ZOq1vENVivFhHd6z4pL
         Yohg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769105054; x=1769709854; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1dAdnI02pT5EuloFaObahJw7pcpTRooaOZFcQF4dsRc=;
        b=UcNfPHvwthfAkHTUj1Epxq0cIarHw3rNWTwVAe1VGU+BLEXOkkA+kjUlqRiPMDs13G
         r0pXd8j21YV7sZe07ICWpqsl/2sjkQl31CoEaI2ZLVH5+DW/ZpTFiXonSpqOjrwIqdjw
         jhj59cqA4DYhtIZsDELGC5eqQj3dwVKcplinjAhYxMDWNHVekUzTlh6Wemh/XJyf8A2A
         grF9EOtUZvNWfBtCpDhdZXsyijQTBmh0ARm8NNsZs17J6tgmDAqzKD7cA5hc9WK8svSe
         uBGHhLfZohoS71lR8iHlsujYo9FW5+MLEPv02fqjd2V0OxwXKmHWIQYLrxDjAUaNr4do
         lczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769105054; x=1769709854;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1dAdnI02pT5EuloFaObahJw7pcpTRooaOZFcQF4dsRc=;
        b=ex3XZZFCmibn4pduPUv7VZOLtHenioNFrGCQjcHFtle9LKFiAIbhjQS1qfLGXPPpY9
         I1p/F+z8kK8S2vtXotaNyfsst+gz5vovH+348eCC0Tnh7CJorSSMB9ZcQpXTJMPGivAL
         le0JGTWA5DGUdTXyWU6sZ94dRR3JdsLhavT6Ykd3Fa4MjHLllYwY0BpwpQFJY/fXmm14
         zDjkX0ejyzybouKjI/lLxnRGk434Dz66s5sVkQwJ4YPZ8zqDnIewTq3yjKl1Qp8zO3ne
         6QKI3TO+doWfkzaMKEysxSs2CNEV9OYdsLbrDKhfuu72D3W52fBq27Qfj44gzz9evFZo
         V91w==
X-Forwarded-Encrypted: i=1; AJvYcCXNxqI7WHOSI6Wp7MtrEzVZlWlIzC+MuRt0zSEg14N8/N4K9AQbgjeKVaU/+H90wogynYc5WAntGZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFgSzLVMh92WkxFwFxIzWJecuk39F951V7rdwugaM2np04X1an
	fR5tNZGk8VuIQL1K7yV9eoizWcXXCeRx1g/E7np9XjTOEUToRE0hptUfuEtpD6SlHsYtcJwF6IB
	mqnz9C7NAJT3DQScKNjDnn/BxcpZQEKiQHw6mIt+WuaRFVlK5BNsn
X-Gm-Gg: AZuq6aIys4I/smXcvde8wgnr9rDkPZKtgLdSV/A2Q1McnQsdAGroFOPam7+aGVqshBS
	6YGYIrOjf6clm5Mkcgk3CeMcqIV3u6/1SeeHFFBxnEEgj0U/IO0oTedkAsztoV17jbCXjF9mzd2
	CNv/AmWXF1P/kE9WdB6UNUEezDYKMrgYXgkVNK5fbqr0RzddEWzkA+E6ZetG6hbSGDx2YvIOVY6
	T9V28JP+Pq5cJ5WtkW9iisCiUjNwds6EGfnQmEPR1SCYijz62WDL9CcaGiP4DexxTD9m+GlWksv
	jxrk9wU=
X-Received: by 2002:a05:6512:2513:b0:59d:e07e:8f38 with SMTP id
 2adb3069b0e04-59de48f58f7mr64524e87.10.1769105053659; Thu, 22 Jan 2026
 10:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122-07-k3-mmc-v2-0-3c3ffef25e94@kernel.org>
In-Reply-To: <20260122-07-k3-mmc-v2-0-3c3ffef25e94@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 19:03:36 +0100
X-Gm-Features: AZwV_Qi_ZbdqQa48xiUnmVYX5skEPfI-gSYl1dRWblEnVxVJaaRBzgmXmm23av4
Message-ID: <CAPDyKFrXNj-FwGvCet6rw3NA8zshLAi02AGPeUQ8zLy6iQ3uiw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] mmc: spacemit: Add support for K3 SoC
To: Yixun Lan <dlan@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 10:38, Yixun Lan <dlan@kernel.org> wrote:
>
> Enable SDHCI controller support on new SpacemiT K3 SoC, while as before
> only the third controller and the eMMC device has been tested which using
> vendor K3 evb board. This board has not acquired support in mainline
> kernel, so I've omitted the DT part patches for now.
>
> The new SDHCI controller almost reuse the same IP as old K1 generation,
> while fixed the broken 64BIT DMA issue.
>
> Hi Ulf,
>  Any chance to queue this for v6.20? I know it's a little bit late,
> but the patch itself is quite simple and we've tested on evb board.
>
> Signed-off-by: Yixun Lan <dlan@kernel.org>
> ---
> Changes in v2:
> - collect Rob's Ack
> - drop uncessary blank line
> - drop return check from of_device_get_match_data
> - Link to v1: https://lore.kernel.org/r/20260121-07-k3-mmc-v1-0-ff77c07bfdf6@kernel.org
>
> ---
> Yixun Lan (2):
>       dt-bindings: mmc: spacemit,sdhci: add support for K3 SoC
>       mmc: sdhci-of-k1: spacemit: Add support for K3 SoC
>
>  .../devicetree/bindings/mmc/spacemit,sdhci.yaml       |  4 +++-
>  drivers/mmc/host/sdhci-of-k1.c                        | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> ---
> base-commit: 6cefff068d030786d63fa50970d6581c354630b2
> change-id: 20260112-07-k3-mmc-6ca01267e834
>
> Best regards,
> --
> Yixun Lan <dlan@kernel.org>
>

The series applied for next, thanks!

Kind regards
Uffe
