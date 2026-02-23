Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCEF1BC46
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856010; cv=pass; b=uP11QYpaCBRrgubA/zzEfSAmpSWS28HOCnS1Gf9Dpv4mg2cOU3C6JxYdrO4Wb7DbZmDOvSpdXLgblukMGJSEnglz8s6BG3EV9qWvj8n/j/8x5V2bFNt81hiIFs+ORCFUE0CojIvYM8sL43Y9XXrcALhzj9f3g7QQDiIjHprzOnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856010; c=relaxed/simple;
	bh=DEy3igJL1rnXb1XQTLdcuyQYF3Tqk3XhzqptPi+Dy1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HFOWwaWJPWhGzkCCoanA2Qm62ZZyi0X4xoaPxip+oDVuLPcfOWFD+STiD/avFQOhQOR555KATNr1m6oukyQvC9uLeA1fh3pOGzzrQhzGBOtfiB0WerdqfgchiqaQi2I4jsl0pv7TcJ9dRf/mQw7o2ChFimb2Y19Pj/yiN9s14Ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s3+GAuxb; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3+GAuxb"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e6491f1a2so4943289e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856007; cv=none;
        d=google.com; s=arc-20240605;
        b=FgxFvpeIMdPa3NwFhH4zOq2OnKpxPlAZnP8soLZGKmmILTWHxqMPEN0Oea7JgUxunH
         +gx99T4sxMDmOJP038lA+Bf2DJ5BSu2tdroBM7S54U3wSCzdZYupli3nAbYhhU5k9TCV
         YBNVokFyMeSuw0ndTTJveXpZmxg4OYthGpqgRBLOQYYJtEOfY0iaQ7Mjt5RWq5pHZlN0
         CWPrXH0Vt0eKv6j0hdlER/FYFiyK7KTZT0jBzK/zntHIm4jREWkX/QsqPfcZnjFBq+tO
         TIfYjVCVB/v31uXSjgUvYPgLgzYgeh7vebtfuUUhf1V+ovD2RzeUsdL2p7P5Q7Q6rkF2
         mYaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7UcNIiszEKvIE+Kf7TAf++7dJZgkiPPqma20oF8iNSw=;
        fh=WKlbvzaEBhCHfiMZPjosvwnNAqtpzMAacakVGU/sVM4=;
        b=WAvZMbjq59mLBIe//9ipPy0KqrgxgpiXI7IfigE9Wqm8RYIFxcuTYQaGwdhaXfCOW5
         Uoav9F203VP1+AtwKJ4AYtKGyEK4IhoL70kodZ/oCGeUYFV9V8n8LtP71/aqrw56ukee
         bkeLGCFE91tpztE1NsDGyJZ5JEUjlQ2elpB6qA2ASp9nEmxesKgQK+aaK34few8J8/n9
         o1nGiBlfPhgL+LlQnGUXNPJ1bNjv+RyMwrCgUBYPl0+XDOyDmTXocwezmjhdL5kSm1Za
         jODcRFoh6qXXELClSd6iqIYH5mlb2FAC7OkP1j1+8S9WEcy9SPe5aGHEsX8XQkuFpJw3
         q0mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856007; x=1772460807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7UcNIiszEKvIE+Kf7TAf++7dJZgkiPPqma20oF8iNSw=;
        b=s3+GAuxbKrXYFcFtPDerz2EAOBfCPm+22uloOdyuAScdQJMDZVVPW+PLkpbjMPrnkV
         UTTRUzQh/jRRK4syYmSJUCiUL/sfKm5RoPvKGL8JxpBdATZ7uNVv2f+wTFRJZ/V3IKkA
         1rqwe0X0EloAucZ8iDUqcbBDAJldBpeQ1Y3Ckp7heEbHtmZe0Kvwfp5ZynXjKgFZpvXb
         vFx4ojCMqbn0YLSSHVWWwSr7YoM6RyTs1x4duUxwfnlBo6sSdVIP+SrIOCHrULlbU0E2
         x1UNluqQo6TVxYzXCGW9/o+nXno889PdiXXnoCZBJ/+0lFQxNRipr6rJgnQ5/ilzyrk+
         d+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856007; x=1772460807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7UcNIiszEKvIE+Kf7TAf++7dJZgkiPPqma20oF8iNSw=;
        b=t89a9zMxYPZL710UCsrrqtd22bxU15LfUCLPJeV9uHwJs8MfFwPjc++X2Bm+7vwLf4
         23Xh/Bsin+peDh5hBbbqk8kbMsnxXY3YvaCAQagDRGUjnDjA3SmHt8MY9cdHORG+NDGZ
         sgpKPfBNVVFv9j7q7yklZ9in7+p11kEsNMrzyhJYnI/xvw4f5Ne6ITqbAZIU9BH057QL
         TDFSYUUPpuoK8IxDOzVP2dICrf8BPY/2MzovLHV2KSrt1m4oK1+c+HR+kTnwwP97X+XW
         6wDtePdesOWYAHC6qDOqQVjihgfIx8R+aKDvCpbQoIM23kQ/3DU3BpdBzH6TnunZ6JfI
         XaxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6rSHihRLQnl4NZUj3s2057K/eWN0P0fyccvfPeT0NVyf8tku0wtROyhBP3O9K/LTMdL/RvZowcZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBiETf62wjkrAL0X8LSW2nciykCFsLqw3KP4mo2365iz2ipUMW
	c0ihWBzyDbaTPvsl5fvMFH8C4ISZcdzg6i/01OInO0oScm0s/EFs+FNTIfMn15ErBRwVqbfNQYn
	ASti68BHhzuO2qrZp26tlvAA8/9C4YKU8gIWQP5A/qQ==
X-Gm-Gg: AZuq6aIvo5vI3nUUKkZQbcYaK1CDwX1KW9yJN96Uj1K1l0IHkZCb6Z+4zU8w3cW9/zY
	Z4QjbtHCOIRFW6YDmDPJkHxA9oSj1QYrNEdeZxpGHEtV+3ezsku8nyHGFIRu++f4K+9e5lU8M3p
	AkTmkHg0MbcQil9OAVc6Awp2Df4XkS2V3URs1BqDF3JqtIugIkzKvLK14j5j8hDBsC0a1wdLNUe
	K6U/y6nM/oOZzuYW4vR4z43/wE9r0YIsibVKS7b4rA5jknmlBKvKQfbRmcB84A5a7FamCaTmGX4
	gmUNxTa7
X-Received: by 2002:a05:6512:108c:b0:59f:822b:b739 with SMTP id
 2adb3069b0e04-59f8abde44cmr5314261e87.4.1771856006894; Mon, 23 Feb 2026
 06:13:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-0-ef83b09325be@axiado.com>
In-Reply-To: <20260206-axiado-ax3000-add-emmc-host-driver-support-v3-0-ef83b09325be@axiado.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:12:50 +0100
X-Gm-Features: AaiRm52Jn7GtelEGkOZ9XPfUniIrpYcIWOFdBS3zcfWiZwJDEnJ15M24z8fGJdw
Message-ID: <CAPDyKFr-N=P1vKSHGtOr1surWApBUz630v2xsBD+5KkPWaPZbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Add Axiado AX3000 eMMC Host Controller Support
To: Tzu-Hao Wei <twei@axiado.com>
Cc: SriNavmani A <srinavmani@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
	Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@amd.com>, 
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Feb 2026 at 09:23, Tzu-Hao Wei <twei@axiado.com> wrote:
>
> Axiado AX3000 SoC eMMC controller is based on Arasan eMMC controller.
>
> This series includes:
> 1. Add bindings for AX3000 SoC eMMC controller
> 2. Add arasan sdhci support for eMMC in Axiado AX3000
>
> For platform device tree change, we will send a different series of
> patches.
>
> It has been verified on AX3000 platform.
>
> ---
> Changes in v3:
> - Enable SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN quirk
> - Remove dependencies in b4
> - Link to v2: https://lore.kernel.org/r/20260109-axiado-ax3000-add-emmc-host-driver-support-v2-0-934f1a61f7c0@axiado.com
>
> Changes in v2:
> - Keep host controller changes in this patchset
> - Use pdata instead of mix compatible string
> - Fix coding style
> - Link to v1: https://lore.kernel.org/r/20251222-axiado-ax3000-add-emmc-host-driver-support-v1-0-5457d0ebcdb4@axiado.com
>
> Signed-off-by: Tzu-Hao Wei <twei@axiado.com>
>
> ---
> SriNavmani A (2):
>       dt-bindings: mmc: arasan,sdhci: Add Axiado AX3000 SoC
>       mmc: sdhci-of-arasan: add support on Axiado AX3000 SoC
>
>  Documentation/devicetree/bindings/mmc/arasan,sdhci.yaml |  3 +++
>  drivers/mmc/host/sdhci-of-arasan.c                      | 15 +++++++++++++++
>  2 files changed, 18 insertions(+)
> ---
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377
> change-id: 20251222-axiado-ax3000-add-emmc-host-driver-support-2cc84a8f889a
>
> Best regards,
> --
> Tzu-Hao Wei <twei@axiado.com>
>

Applied for next, thanks!

Kind regards
Uffe
