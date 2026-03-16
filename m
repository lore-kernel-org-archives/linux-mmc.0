Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C650B3A2562
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674165; cv=pass; b=atcPE/Uw0smitdfec0004Ft+DSgZPQO2SS1Qg9wIL5GvEVuIATrtv0iYMIE/7E5XhxvZRgvq90EjBfOAhjCGChnvYKtGTk2mNvL9ny6arMeyNFHq8inyJIRNzlruRuL+cpuD1k8yDJLOrkFCKpeHtZj6SDrX7u9FYjrXYGYE9Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674165; c=relaxed/simple;
	bh=SGrKOh6DxyjU+GV0XnOjtJnq9uPykPDANTIFfa61QH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFGhyFm/uAwgtxxvEP99K5D16RYucnieuFNxHPSKd1xuYzxQN8o4OD5KvGM4QQje609dVqIYs+15puN+0SunLG1Igm5Ig0F0Pi07/HiMZl58xSFuNWBqNugOxNo4K+q/IzbU8xHS+jwzHedAFVpYyOl9vsjZRDg04KDIaNXpZLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jtsz07GN; arc=pass smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jtsz07GN"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38a23dd61c1so43777821fa.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:16:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674162; cv=none;
        d=google.com; s=arc-20240605;
        b=iPAihWb/p3Wk0fTwDHyHkPod5Zim2RED8qHQqALTb0l06slZR1LGGH5b+8ZVWQ5Nk2
         cAJEBbBqy6Hu/CkMyjYwKcrslkIA6aCiOU4byPkI6D83jScDW0EfQUCQ+QI4SY+nF2hx
         F/xwgOvTsBffNm1isYUMtz3gjff4KzXo7ZWax05IEtrGUVrSgoIxwYRM00j6r7m5gXm+
         NT9Yh06aPhBbFJNGePML6E+1y2s5IU/BMYJFP1u53y3mVGyX8FuHHPFsh4kHBtcxKJIT
         41WzVDJvTIuk7/umMrOYdI0Uo3YDkmMKMIQQLcmls4O8p16lEu8+H3VYEk2J0tilvnqX
         9ftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aWwOA9SQqzmxmd74/y4xRp+f9Kw/OsZUX40Voc8OPk4=;
        fh=Ev6uPZQOt+6UchYsvymBiOSqg11pFUUDEYAq49lLh4I=;
        b=a/BPmtp7AvLd8d567yOAjeoAZXr9SnltsMWpFb2vco/oldAhInQ9RmjMxXFQNWm6pG
         V7pp1v9AFOgLJ8tqIJRTccg9cqrJ4UycsD2hU+aZCxKvzNiqcGg4qRvcdnc/S/7OVnhu
         +Y0XK8ABBEgFrh9w+k2LaxyTV2WXohBjBlmassOs+OrWT7Wk5UMytvAL8FitWlsUFVLU
         JnypCsIVULCEbErTRLDKJV8BSDNI9xct7HQoFJ4A9UsABvbRJ4H/mbbRAtaX6DLZIsfY
         EfrLkdRhWmKi2hRxER/sKDhzIp9Q+TXTWdV0gJLefL8A7R4oG4k4TgrBLHXGKrqipYo4
         MI3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674162; x=1774278962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWwOA9SQqzmxmd74/y4xRp+f9Kw/OsZUX40Voc8OPk4=;
        b=jtsz07GNFeAEXMC6uCu//Kl6N+FETjCtKU3pYIQGECDs/OEavmObeUfyyeV4xJYGAa
         JP3KQ/hR2fIxtUIi4vLy/zrESlImC2KgV8N2BWbuXtqq+lodc+6T3NnuRqHg/36XtRM8
         2jyu9oHE6oP6NpGRlGITsvzGunnEG6OnlOq+XQ97omXL/cGdtiRTfj4Xkypi8XBHzq4g
         hi+9JLBr+Fek8NouPQwdUQ8u72u5DpSMoK9DWQbPZASR7aZOntoPxVGjLJ92dI9D9ZDU
         2sTvLFOCqHr/zBXOFcAZpEH5e95dpF787Uv5voUdcW0ozL5K2Y8iC6mjSxDMc65Hf/5j
         RUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674162; x=1774278962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aWwOA9SQqzmxmd74/y4xRp+f9Kw/OsZUX40Voc8OPk4=;
        b=LLE7UYsQwi+e7715vQWDdo2lwbR71gRk2Ps9k2MN3Pz1gpUhQIwiQO8uBtDWAsl5Eb
         Kc3952Ij4nVbedWYCGmCAije21BxLDb7THQ3One9z+yOR4v1RvBFUmcXcm1IXJ7u06SH
         VUuWHq4L1E3V1BgSM62e09t5i5zkfhqF7Aq8ZzU6vuJGYO9PRkNl35Wskaek7t51UdSe
         5Og1xOFlt0NP4Rh4QpEiRiPYfyZvEJWdJBvjL8b4nz5Qa2x+XCGFMTME7mfw1gQcpz3u
         jOUw0t5nZESKysch/+mXo5OsD14vxQst3mUkOrCFrJ8rL5prkWbMAZApIXPGckr3U6Uh
         lZLw==
X-Forwarded-Encrypted: i=1; AJvYcCUSLHzdZjw8gI0cFXrlKs2fwEyGpr/sjmuAReSdt9BO3TyJkm2v9Xr4oZStgOWHeLxprscby8dpFxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMe6jHqjoIg0N23SlBVmhOCmnmQLKvFbig+IwkXzeQyo+NU8u3
	3hMLsGwqGtoIybAzTgK9/r7wG6IisvkXmmjCnzJFfK/s35b7JeEQ58Np11j4LkTwx5ToJa2s8aM
	TFlwv/YPEYsBJTmmWEmCSuCjhNrEQk4bHwJ3yM7fPOw==
X-Gm-Gg: ATEYQzwn6F5R66vpx4Bt2SziqkB0km3TzUcXDz+5G0smM7eiHQUWAXC3KWw9VwLwSIY
	fRwpI/MjHyUw9d4U1MF5G34+u6wSkxmvyHIx6Nq486AwafMseqqJvlig6/ihVixeXazIc+120QI
	gg6S29cYwPbSdMnJi4i9XrYu5RURWFlZCsUaC7/re1ReXG3p4eAnMbIXk4qCyY/LsGSEh9nPP/5
	JYN2ZZbWQLQq5iHYewxSynK4rRckKROH1Wv76/lmqStiZZ0c+GPikXIa6MwPZMcBdKuTuC4hRyc
	FVRzOm3e
X-Received: by 2002:a05:651c:b1f:b0:386:7e61:5de1 with SMTP id
 38308e7fff4ca-38a8930e573mr42245921fa.0.1773674161832; Mon, 16 Mar 2026
 08:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311-ipq5210_boot_to_shell-v1-0-fe857d68d698@oss.qualcomm.com>
 <20260311-ipq5210_boot_to_shell-v1-6-fe857d68d698@oss.qualcomm.com>
In-Reply-To: <20260311-ipq5210_boot_to_shell-v1-6-fe857d68d698@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:24 +0100
X-Gm-Features: AaiRm5153tShsk2TIyyE8TGCBjpaUzTwpROv6h6ltabxhtejv3_1C_1EaRy8Em0
Message-ID: <CAPDyKFq-pyTffu_D_eZAZQo3e=vkO3uhQ_hAjS-s2DY4TmXoXw@mail.gmail.com>
Subject: Re: [PATCH 6/9] dt-bindings: mmc: sdhci-msm: add IPQ5210 compatible
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Linus Walleij <linusw@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Mar 2026 at 10:46, Kathiravan Thirumoorthy
<kathiravan.thirumoorthy@oss.qualcomm.com> wrote:
>
> The IPQ5210 supports eMMC with an SDHCI controller. Add the appropriate
> compatible to the documentation.
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 938be8228d668c87f0be95c63d4d951ebbadd4e4..fd1d5b04e7556903daffe86e455fde11be0dbd9f 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -38,6 +38,7 @@ properties:
>        - items:
>            - enum:
>                - qcom,ipq5018-sdhci
> +              - qcom,ipq5210-sdhci
>                - qcom,ipq5332-sdhci
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>
> --
> 2.34.1
>

Applied for next, thanks!

Kind regards
Uffe
