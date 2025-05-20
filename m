Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9A01A0731
	for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 12:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747744981; cv=none; b=h0rUQ/jG27Z0z1rOAhHzEpuWk3MVcg9MZjunzn4lV8XC+zgHGhzLzMEW/IgFgdb6nb/Bw602IfAZsxkclSQm0+SHMbco+pFsv39WvuQRa4kFPRbR8NUS5CUVpJg+zhvCRrVoBl59PYh5OXAoeDBIa9Z99gBtaU6uMEBKfozxexw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747744981; c=relaxed/simple;
	bh=kAYBhgA7SbgPwIuhLi3KNN6TuETDW3sCCCLPjUs9KLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWFE8PXOTooihkRxOMVMa8fgZaumnE2Sd6Dug5aNIwZ70sVuytxrsgytDw/VbOLoaIB2IuFRPPLWe/POs/tIcYKcqZ5TzbhNVfHj6mPgOPwd9AWzhvsVZ4hGJsoDAOOtl8PlfnqDZYeFfo0W+O7pfj+slcFqP2AOuaAEi89gJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z68jTGdF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z68jTGdF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7b85f1cbacso3247453276.3
        for <linux-mmc@vger.kernel.org>; Tue, 20 May 2025 05:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747744978; x=1748349778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=88lOLN3//BdORRDyk/6LjlOBy9fkXDogVmGs1sgPhyI=;
        b=z68jTGdFqiP6o81qhSPfWRQRBkTV68YKQY5rKGT9CAo0H+HjAXa4IDbhPYQLD/0m/A
         szy5ZbxzUoFCGFcXm+9cseyJm8i2GVo+Bl0W/SlByNxBlKXNu7uCRh4au012ZLSHVJpq
         hvyXUGGQT7tYWXQLFERvM8QFyzQAjwAA1aSqjeh9kWWYTRUltZE5Z6/VD8MQCWk7jL8C
         uF5/wjjpyZRDo+Aj7xAODjjf44F8fpNVXOOGDNUcxoxaVSfSLt3AtkN4aF5XGfmz6VNa
         GsevA4kQw122PHEaY4UBLaHW76GvyvyJUG7EX+/zCFtXswtE/T5t98OoKMgBWess8xRV
         3lyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747744978; x=1748349778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=88lOLN3//BdORRDyk/6LjlOBy9fkXDogVmGs1sgPhyI=;
        b=FXyRXXnxQ0j9Y7XcfyqAbopfkisiiBe17/nAlrTk0U2lT8sFgQdadtwbQ0kdPdZCck
         ZiiHHhhwHFhvbVSTsOnNzquRg06bbzAmpJjHATklJZDJ52i0Yi6NbAfrQ/wxRc/NYloc
         lb9YrMawimfPfzvGAiT5PuENdGGh3EABR+B5fgT+cewzB4g3hlAGyjaQVGRDqTZQVJW/
         y6l7aEo3CS3QTFfIOKSB5LiY8HO1YSxxn1/zhCgX36yM484SKyxGPm+V0Ev4WPhLmZ5b
         3bj9hmny5QONix0TtnCGTg/ewZZbziswR+l4XabxJ3nxyZn5TzYnRfKzIv9yHUi4pMG3
         WTdg==
X-Forwarded-Encrypted: i=1; AJvYcCXC25gFHkwVWhvvhE5mVGh/mplhg/PRBcjTdiXw6lDH7zd+t0wfunM3QN6ficBzRvqrb0/eqLzzBZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVw05PQ5GrTPg1i/qhZQSc/XrjywrP26WO291sfV6dIPt2sBGi
	iT/DT1LwtgmlaDLZNIpgS6vBWgQAmEbHFnQGG7BiguUx8YeVDqZTv4K+rVqyn9ZD1ZD4K2NvNco
	uL2jHmgLLWlTgcaqfNOko2WO+KWFN8M6k78jOZZIn/Q==
X-Gm-Gg: ASbGncsVXBE4MF407WRIOx9uwnu1+s5oEhEUXs+9Zi650OGeK1pg43ju/sQhXTXTVTG
	VZFZOKbCE7c5s5MH+44zAITtAVAvJXRavIu5Fda/AEh+QsUWyIWBPTAmRVdy0SC8d2mk8qihoUK
	ieWeTqzo5il9eDpJJBXo4C6Z7i6aoNTL0hcA==
X-Google-Smtp-Source: AGHT+IGhT+v8r+0GZsiYhs7CHph95cb2P8MRGP6RGC8fZ7dFYUwqCE9+mfUsNw7SyUvETHMbFtvpOAcTqK/Ng1hl+qE=
X-Received: by 2002:a05:6902:1201:b0:e79:774:866f with SMTP id
 3f1490d57ef6-e7b69e80915mr20083103276.17.1747744978059; Tue, 20 May 2025
 05:42:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250518220707.669515-1-jonas@kwiboo.se> <20250518220707.669515-6-jonas@kwiboo.se>
In-Reply-To: <20250518220707.669515-6-jonas@kwiboo.se>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 20 May 2025 14:42:20 +0200
X-Gm-Features: AX0GCFs3Un2EF18YwTSrDKI84LtGeBLBa79SYyXbjLKaJiwIZzX41KzumIQh4bM
Message-ID: <CAPDyKFqu-ox90dEnK8L0C8CqXJDsvgGwH00__nfQcOYu8hNM9Q@mail.gmail.com>
Subject: Re: [PATCH 5/9] dt-bindings: mmc: sdhci-of-dwcmhsc: Allow use of a power-domain
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jisheng Zhang <jszhang@kernel.org>, Yao Zi <ziyao@disroot.org>, Chukun Pan <amadeus@jmu.edu.cn>, 
	linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 May 2025 at 00:07, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The commit 7e856617a1f3 ("dt-bindings: mmc: Add support for rk3576
> eMMC") limited use of power-domains to Rockchip RK3576.
>
> Remove the power-domains: false to allow use of power-domains with more
> controllers, e.g. with SDHCI on Rockchip RK3528.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index 5fb347167004..f882219a0a26 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -120,10 +120,6 @@ allOf:
>        required:
>          - power-domains
>
> -    else:
> -      properties:
> -        power-domains: false
> -
>  unevaluatedProperties: false
>
>  examples:
> --
> 2.49.0
>
