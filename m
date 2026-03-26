Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B563DA7C9
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528428; cv=pass; b=uBR9VVguDe7Swqgan4GN0ERsxichvqv1HI2SrEFW9vGdbVMEXzWbqwbjqahApuMeWuSt5nh4bifmDWfVdkLope/11Ox2x2rVyRuLrJ0u2lc4A/ufl8Ko0FpnYXky5NbiNmValMnkB82jKs5LjdJdy3T7lOAMj2NgKwqJZWbP80w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528428; c=relaxed/simple;
	bh=LSGyBAMlrdeT9CMKolaA6GRSIsAXGM6kyoJfnzUtsyM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZN4fU9JEvmGmZBf0IF5dESod/90l62k18db7LpZUzCMxe7TVQA0XirrpFJSX9znmNX+DxKfvRKjwMwakjRelKyj/YIcsqAIc8iPN2QeOhM1henYlTVr/qB/zul6PFUYQ6QtP/vIwAd9+R2vFyBfD64Q24crsoQyBOv8k0teISUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V83+EjKA; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V83+EjKA"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-59dcdf60427so1120822e87.3
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:33:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528422; cv=none;
        d=google.com; s=arc-20240605;
        b=NJjZY4FosL9HoaDqu6xKp5fj/DAc05fqvAXm/K5CG6gXRxZIYkrYh0qHweY8I5cUfs
         Kj5DACnof8QgHBWdud5AQ3va7gRnLrb1krt263PIkZMd/ihoOEtEL9oiRV1rb1wDJ5n8
         u+8jZL33YFMSdlJ1CdY8Lweufyxxm1VUepEWnVA3d3HkZXW+XkuxuRg71die/dSTCPDX
         p/l/jfjdyZZyUxGt2IR57zM5PbBmNC+faaOFmtlPMk/OLKsm+s7P1Yp1d/DpU4SOfxB4
         t7t64fFURtOLwuCAM8c7/F2L8x0H2DbcuFj/vATTPTQWYXq/t2LvcOw7oVrAUebDU7yv
         Gipw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        fh=sNeHmN17JwWAHX9kvWmznB0k7pcJF6KDpgDSnJ60/Ro=;
        b=LL++CM7Y1hwqmsFjDW5S0MqpA91dLq/LPmCzyKAqo+UXJzGEf75rfkcoYJ/sOGEnCQ
         Dgv0m6HcTyL9aNkuNIjw/gdKBAxPWrNxWSFSHpmTzoM9AthpLqUFX+HFM/z05O9o02Nx
         AE2zyC6cA5Yl0vF07MVk6zmsxCF1cCDWCmPBVCDUhwOsZjPlcWGoLiz/MxUTfY7wLaXJ
         spdcIcfZgDlBCoTt7t4ksTXBVav0s8ph7AHzF93dd3axOR12FevqZhSSLSj9QoAtShKp
         V02Ud6dFj372NR9Ytuv+5P2Mk6MkyPpIyg2TsuQYfddsP/3WYk9QhhiA+rR6NOUpcq55
         6ezQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528422; x=1775133222; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        b=V83+EjKAyLT7nPjvvuCupte8+OkhAc6BgKcTXS4xc4hPIdm2LlWf5/I5nLLMOKBxVK
         sMJnNjVFLEMn36hpI2O0TkdIkkbElOwORyd2mvntgYKQ2H6wOuYjW6WZynKvorHPZAfz
         LGrkvGOsc51FitNBbkK1drocgkS1o9CqXL9Lh8vdY9+wt6QiOKVDe8lUqCcjwca100nL
         AB4dkgrRFlcFqniLcOFCxa4vy6vpE0AfyaHi1XtFfiKrH2KVCWhte8GSLp1AEdcJogk4
         InHrQSlxwbW6Ec2e69j39XkLTPk2VeRb31lWbNt1yf0qASNtYJtR8rgakOIaL7gY9k1c
         hD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528422; x=1775133222;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NdPYgPAlCNYmYAY44z3R1vgWi5y6H5hfActLsqe8b8=;
        b=W7kEyl0BRHj9oHU0YDTB3oCKqeFYl1VvYkajOV5C+eze4gzpzVJO4BFb0UP6po7vWA
         4thorULj4J1WWL87dMXa7TL40+wf/8vaFa9UimcpVa/QMOwDhsywsLFQ9qvsl1fz3jg/
         MCfoMJtZDDoVE1RxXplrSTY63zgyrEhreK+aKk5Pix7IP7xZXVU3YuQc8g+vbSLnYcRG
         dw9MJUmsj1UWv/qQupWK1FANiM9WY8WXjeue+B8bRjJvuPgft2E7YTLgCVBpOr7/zOB8
         fIf2DwI7nJJUZyvN1I9H6nl7PVUmRhCo79jEib2VbGy+KiapLcTxRXdl9ALLOeH2/5ue
         7iIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPXAnuNZbzFFoifHelYGEULHa0CRUcfNsU2I5XzZX/wc38YFzUqgYbwHDlkgilPVqlLCKQitI7c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwo53D8atttkDC06aJniku1yfb5X7aCDOxJLZcK4mQQhUdD/P
	l9SGjYOuIY239p8i2Hp31E49YsjzIkrNCUyYLJy3haL7fDRrfgb3AhG+GfA+R8ROVLXCGJBGBkb
	2kuRhXOj+TlxUBuHrk7QCEnWS+eYEzeV2Gd/vSkr87Q==
X-Gm-Gg: ATEYQzxv27LtCfRQc3H9ONZFrjLWdx/zfz55wbaLU/HyaVCyMVSY3tpRCQYigmT3IGw
	WJMj2rW5E7Cbg4/POI/t7kWUSWEuTPiS1ajsehPMtNkZIuV1JpBox3wReVv+wdqT2N6OTwM+Sig
	0q0/+4dzTY3dSakeqO4xbg/JPvfUBsUIe0LNyhh46n/mfBPSGQrZPYHXZXwfS9OjZ+hkOhxJ1Rn
	TOkbZUUTFpDCXRCGJ8OP6s4xBBNSLOlKA3Y0N5mXXgDXAfS/36NqIOp1W/osrwCAZwgduXoZwHD
	JvF90og=
X-Received: by 2002:a05:6512:48a:b0:5a2:9cb6:ef4e with SMTP id
 2adb3069b0e04-5a29cb6ef5emr1889782e87.21.1774528421913; Thu, 26 Mar 2026
 05:33:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326-add-emmc-t7-vim4-v5-0-d3f182b48e9d@aliel.fr> <20260326-add-emmc-t7-vim4-v5-2-d3f182b48e9d@aliel.fr>
In-Reply-To: <20260326-add-emmc-t7-vim4-v5-2-d3f182b48e9d@aliel.fr>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:33:04 +0100
X-Gm-Features: AQROBzB17m2aMMak7aWoPUlujOd0n_VyTP6ICjVn8RwU1l2ZGeIzCfBikAgvSj8
Message-ID: <CAPDyKFpacFOs_T-Q5ETAEd+bjqtx3J2mZBioztCSM8Li0KgR1w@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] dt-bindings: mmc: amlogic: Add compatible for T7 mmc
To: Ronald Claveau <linux-kernel-dev@aliel.fr>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, van Spriel <arend@broadcom.com>, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>, Xianwei Zhao <xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 11:01, Ronald Claveau <linux-kernel-dev@aliel.fr> wrote:
>
> Add amlogic,t7-mmc compatible string, falling back to amlogic,meson-axg-mmc
> as the T7 MMC controller is compatible with the AXG implementation.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> Reviewed-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> index 57646575a13f8..976f36de2091c 100644
> --- a/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gx-mmc.yaml
> @@ -19,6 +19,10 @@ allOf:
>  properties:
>    compatible:
>      oneOf:
> +      - items:
> +          - enum:
> +              - amlogic,t7-mmc
> +          - const: amlogic,meson-axg-mmc
>        - const: amlogic,meson-axg-mmc
>        - items:
>            - const: amlogic,meson-gx-mmc
>
> --
> 2.49.0
>
