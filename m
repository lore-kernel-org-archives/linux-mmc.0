Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6162153C7
	for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 14:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752589820; cv=none; b=r1W3w9r6pENlNcRsii1MqQrytK6gmW9wIN0RtAiOnNb9VPMY3WwEN+fhw0zjhaaEeMDBgiLdeA4KsPN0l7tV/ei0uPTVOq1qZj+rH4aXVdrqzil8oSwBbcF67Owg0n9GSuB5zfLGtTnaHFEUK6UzJ0cgm9u6OEWE6cZqXzrj3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752589820; c=relaxed/simple;
	bh=FdL1/HKNTpO4kdE7n4NKm5VaVSkDlbNs48yc+1QgZas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J92g6UNh6sHCWUlUdpAh+HmGzSFmNrudVtTyTYos/rZyATD8asHpPfP+Y8TrsXx7lpOUkBFzGfHAC5QjU3rewdn2wOlc17ZXFirZKOJ32G8RAG0dMUa9OfAAsn8A3R59u7ESVdYdNwkh3tcGQh/afAfJeDB5LnkykfjLtYbIYNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W2v2bzED; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2v2bzED"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71824fe4661so9526557b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Jul 2025 07:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752589817; x=1753194617; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=W2v2bzED3A9ejC4TfbgBBjzjno/K1PhLK2E7O3e0SPUbLWqTR9Evxz9A+K/rXmm1Gp
         Et22K0hwMJdya3IKeHHsXW3hPwxvGaAhOYHBmyAS8ncFcpUbQerWd0RUW9AbdeTrB6sG
         QOUikyYzPsid/y34PVziDdUyKm1BoNauuudY42lVMegWroSPQOo3Qkr6ygEYUTk7hnPm
         kY02nYoNhhonMX9fIknHS1fRHnqETyvy/jv6p/jTCFbethMcmYb0L5oWZWuzyDkW6sow
         OmLBsjvk6glkP806VpmbDr5DbkxrIKVAvgata5YVlC/7rRECoPR3Rnlb3ulchSSzVxCG
         mZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752589817; x=1753194617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+7Su+tXNXtNlViREf/FpByOQe19DRJ2WhD/byKGrG8=;
        b=foMXP0riLtzDrkOBTR+k4K8J3g33aj19nmygIMaDhqgvpHjNg9JqsUJ7C3ZOWimCBs
         /E4TNbF6pSImxiO2toyItbJAb7CCx0H/4PwzvtuCWjKVJYhc8DqX3OCSlcksK5RlEOUl
         ngAYlYJa4X77ECSAskBacT9/2u004zu2mGa5dE0ImDqfM45WDynV6qP0m1trtNPq/y/j
         SWTKdmq6/e3nSPBQ0Ht4phuLgIfuEt45qRxAdscrmAsYkwe+mstvV6+pO1xuOH6tdMrq
         A0bsrKHssyYAfkUvaqKzinJOHWt4/fiU5ndC4JqUvG3QhBkTWwJ6ezFocu/qPukCuKly
         +k6w==
X-Forwarded-Encrypted: i=1; AJvYcCUbsaRRiP/6OXJgELtMeqtekEyAU9wJuqZP8TxZ93kLiVzZ1XQCT4lHQV+mqRffcptMQp0c/seAsNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauZ/lVfEBBdrgzus/qzKBUuY39i+R3tT8Ssn2zqif/X/3GUs5
	6BT4fgTG1VCbozniAcNXDOt4ClukOC9Tt9JN7q+keHDYzNUYowUlTHitPPEGyDcu+D8p7C2XOGr
	M0QZeOoot+12plkOI2gr3SkKnXOWzNE53DnFfDmhoZw==
X-Gm-Gg: ASbGnctsdVaV8cmPIvm3hA50hdLGvRnVeCxyysMPizHNE1pK9B5aTzm54igdBIgF+wv
	cbwjPxQiuealP9HEcVcnGlOlI2+MbVfiDQ+qwVh5u6FTP+qeGA4GbQz7VVGSxqMd+CGKLHUuMXy
	MvHBGaMhHF1w64HGybOJPnCP8rqaqjLFCjexYt8fVShxe6/+V/5gZA5YZkytCgmJbS9JkIFw8Ls
	LhuHW6Z
X-Google-Smtp-Source: AGHT+IGBzBhoCXe5OGunO7xvl2ZbN7LRPwWWQsLELIyQWERT2XuyowSM7Ti1rVh+eETJFMAPU2ltq9fvUbOvfY7jIrI=
X-Received: by 2002:a05:690c:9:b0:718:2387:4544 with SMTP id
 00721157ae682-71823874737mr49946387b3.12.1752589816638; Tue, 15 Jul 2025
 07:30:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713-sm7635-fp6-initial-v2-0-e8f9a789505b@fairphone.com> <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
In-Reply-To: <20250713-sm7635-fp6-initial-v2-10-e8f9a789505b@fairphone.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 15 Jul 2025 16:29:40 +0200
X-Gm-Features: Ac12FXwmHbA2nWRNuYQwrZTMO008mwPCFYz6i2upkNA2qncGOOVsk9AzGvxKlLM
Message-ID: <CAPDyKFo77_0n0SefZ0N3osbSM=0tXW_rsjd9P4WaqoZAwyaTGg@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] dt-bindings: mmc: sdhci-msm: document the Milos
 SDHCI Controller
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, ~postmarketos/upstreaming@lists.sr.ht, 
	phone-devel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 13 Jul 2025 at 10:07, Luca Weiss <luca.weiss@fairphone.com> wrote:
>
> Document the SDHCI Controller on the Milos SoC.
>
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 2b2cbce2458b70b96b98c042109b10ead26e2291..6f3fee4929ea827fd75e59f31527f96b79b2cca8 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>                - qcom,qcs615-sdhci
>
> --
> 2.50.1
>
