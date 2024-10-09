Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5709190074
	for <linux-mmc@vger.kernel.org>; Wed,  9 Oct 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470299; cv=none; b=X/0OWCloJ9utyNfNv+6OOKjbpU4LTUBE+NbpawGQTOQLed3LxeBJsWaw91PGhJ5K+JOaz0PTOuRy31iLUWBd3leY6CtVYPTacPggMoAWnfyFg6uG4sKky4XygnhZHa4bwL1B8A+Ta07GiEUkeaTbnFJvXGHcI2pG0eC1ELBKZD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470299; c=relaxed/simple;
	bh=/pirvcswA+FHOwpqdaOFXRCzEZ6TIlpHexynPVzZ09E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKWCg+jRW9T1mRqVWywNcSkerBD7mfycVxysMxbcMlV1m/nyMeSnlA5SlCWvYv7+1JJGWBWaK+122ykqf13p1wJ4QK5oA70euWtujruzJUcWA71XBv5ZJpBUNOjclMM4z4+/53HANMc0olpTmPRkZtfLqi020eQJAKLV7dXkPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qmoEEGBJ; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qmoEEGBJ"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e25cf3c7278so5908578276.3
        for <linux-mmc@vger.kernel.org>; Wed, 09 Oct 2024 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728470296; x=1729075096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ID1WufQHJnNG6qgq2q02dpWhdZV7K4BwizWlrE4oEN0=;
        b=qmoEEGBJkSJudMhCOcbWY6+0lZdlZc6iWyuMpGeN/8/AoD4VTBSuaiYUzFEm1Gsa1K
         8+CIo5z5tB3l83u/f3/Z5M5FunX5/0BCIRjsFQIah8RXKaW5SiqI545uYuS7YQTur8X+
         RTL4lxlk+s34a00BRZx2Cghs65NcSU4/YEl3JvzTYSUzBFHZlDcMCx8gzGx1YEGMnFBX
         wSF+NhNuiE+CscVOBBBUMxB9yBvFcJnk/tcPZHaPN6HhFI6gvBSiPdwDVC6uCPqjqeI1
         PXtnfBedi9Q9s5465+cEuISCzjVzLDGIdUxxto5bIYlUCakINVBx0Vwx0W0FDO1KfJez
         a00Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728470296; x=1729075096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ID1WufQHJnNG6qgq2q02dpWhdZV7K4BwizWlrE4oEN0=;
        b=FwLWFpjuKsn6+z5Qnvw6N5ZwJekAnWcGwzaXAMpBgGHEoCVNN24HHcCGHRvH0GFc23
         +zZVnWSdWC7bXBRc675I3ymM3iAuKCMw/JnCwFhLSHXlPzurB/wNtevrIuDnL2ENqanj
         cCf9JMw0TMF7Z9ccTzHJRnwNPP8qGp+zhtYrevq1uADZ+cnxFPq7MSpF8VexU8rWV/h6
         7uyFVzbIkOwbnXe/xO4cAzdCeeJmywBmTz/J88SRilc0VidQxJmWT3Rq+4Yj66XqVHFz
         hdy6r3k8uABb+gUhA8mxrlop3FBWOh7JU+pA86ih9Szxr5k0ZHxB19Na0Oyw9A6r/Xkw
         aCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjxjxp7t0wVWRelAOuHwzJ1mvVYF8Y7DpCrHTWtn6hFpMJTliCJEaa30ynJECxUq2rA79Q2jMic/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXtwKR5kCaLosaiKUpob8KRci7h3bufjFP/c6rwQg2zMZKrSoE
	gHO36PqDDgHTOl7eWoY78uOHNbAIReibGV0OXPGumGo1u6AzeqC86HBb7ht39Z8SAEc5aqU983F
	K90Ll/ADgitHBmA7WnxR/Xr3QMCsCGqSL40T7sQ==
X-Google-Smtp-Source: AGHT+IFoviElVg6zgPKSNNlWRMr8af1m9Z0WlJoeomF8hhSrWTf+U4itcPkeioazo85YkG9vWzGOAE0Jq1Lc8Dev+Pk=
X-Received: by 2002:a05:6902:e0c:b0:e28:f2b3:1a3d with SMTP id
 3f1490d57ef6-e28fe33b8c7mr1913514276.6.1728470295854; Wed, 09 Oct 2024
 03:38:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-x1e80100-qcp-sdhc-v1-0-dfef4c92ae31@linaro.org> <20241008-x1e80100-qcp-sdhc-v1-1-dfef4c92ae31@linaro.org>
In-Reply-To: <20241008-x1e80100-qcp-sdhc-v1-1-dfef4c92ae31@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 9 Oct 2024 12:37:40 +0200
Message-ID: <CAPDyKFobpQjYBys6J_WUM5ws53ffZfn1G_b0AHN6xee=q0KJHQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: mmc: sdhci-msm: Document the X1E80100
 SDHCI Controller
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Johan Hovold <johan@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Oct 2024 at 16:06, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> Document the SDHCI Controller on the X1E80100 Platform.
>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 11979b026d211050270d018c03fa73c107e7c10f..8c7e016306f14be20e4a3cff289317ed603633f3 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -62,6 +62,7 @@ properties:
>                - qcom,sm8450-sdhci
>                - qcom,sm8550-sdhci
>                - qcom,sm8650-sdhci
> +              - qcom,x1e80100-sdhci
>            - const: qcom,sdhci-msm-v5 # for sdcc version 5.0
>
>    reg:
>
> --
> 2.34.1
>
