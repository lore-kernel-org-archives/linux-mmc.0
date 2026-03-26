Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1B8399352
	for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 12:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774528481; cv=pass; b=hFTVmdeWEkt+fCVB2zMY9SBOQoyfVeXeJ0Lv72C/6qv0I9OR9IVnS6wUXZnt6VsjH81tXQoh/UgoaqCw+R40DxwTmeNSw5UmVNDkbAHk/+W32Ko3NhkficgK/QR1QdUxZlGtJa1vptnC7onCXXhoxMOYZ4TTAAusHgYMfQVloP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774528481; c=relaxed/simple;
	bh=L+4+cBfFgjRVu3c6cuK68SoH4vuUvAH87VW8dhUcjhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmCVfldHjDI7Pf0UgTGThaCcbLS9gIaH+KwKPyaPRt5MmmLrlnW+700aUtcHEVfqpfW+zvMUI2qLRfjL8otKPhWpCMt2ZDbUIwQDXqxihvSEFk1lEQ/d0znB57j8tJ2lXjJG0VNQxlq6aAut516hw9pJ2Hm5iS7kz2DtJaLqqPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CYD/O+9j; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CYD/O+9j"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59dea72099eso1090543e87.0
        for <linux-mmc@vger.kernel.org>; Thu, 26 Mar 2026 05:34:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774528478; cv=none;
        d=google.com; s=arc-20240605;
        b=O35J1B+UvwLVshOVQxZmHV4cjFxPoEnOHmv6ar8xcCS234dElx8Czh+sUEPnDbJrf2
         Vs8DsEzErNpRtI5lYRsFMcviD68OfbgYc6JALkBIAlf0vYqXmyhWxTtW1ZjYyDVWhgK7
         F2OtJX56tY3seSojFJikgvTBymwbuKV5yFiukrzXtuVhrzC8eXspR+QwVdLU1v+EF4EQ
         iyaPmlT2FFLL4nqpayND9pWt2L/3I8zHpaWPe2FJclUR3b2pODivQFzkkCbns+WBX7JT
         sTihO1sGj981zeMqyPNgN/+Eyg64iYR7a6EwutiRiKwXVDXS1MTa8QbMEAFlDk8gB1Iy
         6C1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=whbb87R02VpuWnrdM86dwQGbuC6f1dMRJ8XJxXPbpSk=;
        fh=+7i1L6B6HSf5D5swOpbbocfhWIv7bpzSD+VPkqZh1Ws=;
        b=VbNGVh8THXAyRumpRpTTpQBBfewFZtBv3aE/EE0BbfJjRpjaPTQyH18jxB8fAljOfc
         ycFPRJZ9tLJwJ9bD5WuBWeHOByBAmJIkoLTyD/US9IeCqQczVcQszJOTHGR5uww+HjlK
         +5n7P/6w4baHIRGhNK/NB6989D7RlUcIR4WNvXmJG9SfF3QAdz/s4dP0Qg0gRWceQHn9
         LaFCVuNuuBdnQeMPPdWj85uvsNOxmhb65jO32KQC2JWXxHPElIZmnfaK6OCFkNOSGNrc
         DHt6OAHxJicGJ2BMPZYVh4Oj1dz9EnS2z4zqnszjB2Yk7LF8IPEMHJFUOZ3wDh32gFZH
         phMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774528478; x=1775133278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=whbb87R02VpuWnrdM86dwQGbuC6f1dMRJ8XJxXPbpSk=;
        b=CYD/O+9j3q3h0pAFEM9o3a5mk51M6+0GVZEEeJ52Usbq42iXsEY/sLSKyrrvOPuoJe
         8T5vzjEy8CeioOqyOVxCTrnHcxbVvfB9a69XVmv3fh+Eo06wWAOge9YjVq3Cu0craXjU
         Nk9RNoJQU1DpRBwA/CJRfX+Px6gRz/MFHWM+RQ/d/yL5dpTC9UsARnsRPYNEBWPJ7Abg
         XDda7/uHEuxBbnqq7SSxc193N2kA5tDCijFWQowpEWyGCmTW7IpVNlJOqv5wfq240rOX
         KbRWyAMO6dqSHWheji+RSKuSJg2or/EuW/nj0OKqbhYIC3CCdRHwIIqZJjhq/Xtab8JB
         evOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774528478; x=1775133278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=whbb87R02VpuWnrdM86dwQGbuC6f1dMRJ8XJxXPbpSk=;
        b=BZHdnYscAWkjh9nW5x+a+BDw1js+8tjo5a/p6J8owLxLrcU0JNvOOiO0XPxPELwODJ
         9cla39klcWjS1p8EwF/ika0BBQGwRLbYQ36qMOAqnX3qBvLTBP25fG0rIGMEWaq/UDVR
         1Qsm3li9hQu+p8WLzjqdMZetsiSAtFlROHt7VMV91Ih1kXaJprAaESwN+ZZYpS/36sh/
         aPig8Ms8nVuYodA4YglxMmFvKE/TSiyXvlnaAg80shKv8jM/Oe7x58YvDaXss6Xmn7DI
         Z0euQxb9wh1S27PQ8S3fMHYpMfoRopv932u7P05s+LkDr62Rt1hbFqFwym5M/PVgDdhJ
         oqjQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrFJ7IhCXURkbgLxpO7lGZjD3D09x0bXgD6BmtWTVL7B3JiS8JaX2Gfr4q+3+H7mg1i5pmQQOOQXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlY+LEvzCu11sslL/8+bWCptumsUNqzp+RbQgctReuYfvNK5Wz
	N7QIJFxfGRM+/ROtVtzmE3oUvE8MirlgPFTja4t+qc00sQ2wvAiZD5LYKtB0f88QgfMAxkGHnKe
	JbXm+m8cL3xW2Hhl9mn4xBCxtyuuWNyF1EgH1qracIw==
X-Gm-Gg: ATEYQzyuuhOtTNqI0SQGXHY+rO+Qsk7HX/We8eUsXRl4PiwaE0JZUrliQdNEZiw6Ko9
	QxZfHNG9xrxmo9NAVQ2mhx6E7kIkjk3ZJQ7hpeauYXnvoTmb6/VzCv2jDsXwOnLUvPAvshcgptz
	zLARfdX6E8ZCQrA5R19GObwpkncVY/sQEjYEXV6+oV/p4DohNGfGQn1p+M/FyQHK7YqPoNNsyP4
	Cce5naspD+P2Rpbx5oCPWcf5uZW47htkUCmGatV/wpZMyX15Qj0wdIOKgOL6a3vVNwsUz4ZzMO4
	laxI/Hw=
X-Received: by 2002:a05:6512:224c:b0:5a2:a568:65dc with SMTP id
 2adb3069b0e04-5a2a5686674mr633975e87.29.1774528478029; Thu, 26 Mar 2026
 05:34:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325-ipq9650_sdhc-v1-1-53cf7ba11087@oss.qualcomm.com>
In-Reply-To: <20260325-ipq9650_sdhc-v1-1-53cf7ba11087@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 26 Mar 2026 13:34:02 +0100
X-Gm-Features: AQROBzARZ36FCtAuNnlkbnt6Q97KUANYiNkFWS4I0NgJYn-2Ep_TtXNHwsftZn8
Message-ID: <CAPDyKFpRqE43N8S5ndpv4EG+hpvLCPrnC_i41TATTGnTYTjpOA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: add IPQ9650 compatible
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Mar 2026 at 12:40, Kathiravan Thirumoorthy
<kathiravan.thirumoorthy@oss.qualcomm.com> wrote:
>
> The IPQ9650 supports eMMC with an SDHCI controller. Add the appropriate
> compatible to the documentation.
>
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index fd1d5b04e755..695a95e8f35d 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -43,6 +43,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,ipq9650-sdhci
>                - qcom,kaanapali-sdhci
>                - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>
> ---
> base-commit: 85964cdcad0fac9a0eb7b87a0f9d88cc074b854c
> change-id: 20260325-ipq9650_sdhc-9b75ee9ed5ca
>
> Best regards,
> --
> Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
>
