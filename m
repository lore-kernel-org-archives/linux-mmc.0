Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962827FD49
	for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856014; cv=pass; b=ryqy78c5qr2P7m/BkmFV+sn3KOMibMwcSC/3HD7xfkJMck2nnIEN2Rvz800DX84V6W+/6xgBTEr4o1x0DudKFjjdL67fS1ueXqCkwzJUBeg7elZ4uWai3q6gMD0Kd638C2OY1Y+EDtSafIno1SdcMeens5rpWXLjS4/2keJwn0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856014; c=relaxed/simple;
	bh=76oCx/ttrzREgYvfMWN9RbVec2xG7i0o/OAeFdl2DbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uggXz3jiv7uax4o0toY/BG6PNOFDXYtudhsItE4dcdTMExMAnfw3MgJvEftPOqJKrr0aBFaSdmYibjXAQRkPxmyY+d6OTj1wXCjLUS0DcNqmIjldxIRLvxr7L9imdNZX14G4fJDTbnSIVOCM4K1m9GtKD7MRp3Qa3r87PwI4KWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t+g6Zznb; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t+g6Zznb"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59e4a04f059so5622006e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Feb 2026 06:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856011; cv=none;
        d=google.com; s=arc-20240605;
        b=R3/WNzrE5uP2LZrkzmsWjaXko/IR4ZqftJTgwSai9JQ8zTB913IY3E5u5iFfnbv80y
         GOVooCGEXnckn9J+hQJW0ndgzt8kU6dQ2M5rUVh3xQzpArXgm0neKJoWuR3vG0zqp2Ae
         /zCVH1QDXhqtaLMdNYo144NvW+WpxaZRvK+jurQMIzEBPpMuTpBmBVGj85gcWu79zpW+
         O89VC+3zflmhsi86TYtyIRCmrrjIm8tSKk+GS+3oKILAgyD4CDSSfFeknOibZtrM6tPI
         i7RNxMWo75RK5NMffFq5BxlMr6BQfA1IERSoDFVEsPmTTBWlOiG0/zbvDEhE21gA8258
         1EBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=597mQmEUNbkIDS8qk+5/zMm26WxivzZ2OThkmt6poH8=;
        fh=50mXZKPl44hP+zbFOZu320cQAiRhPiROzt3bryo3xd0=;
        b=BCkMvQ9OET7Dhgj8o1lSL8GWbH5k37kXuf0XDTKvgYesES88K5oumtq4nY5/gS7+Hh
         l4piMkwIRh73nbTd6Koc+KBsORy17Cf51jAjCcPuvtEWDS9vxWpgtOit9jQsaiA6FEJ1
         ZEilPEBFZyt3CknwfqYqgJBwK6onlvgWO9xdeNSUtMlx3vcdg7eTCsI9P025W6WWR7Fm
         zh+FNihl4BNgH+WNYame1BoZUk3dDDUwJ7zMv/e7jJEDcS8s4nuWWrTc+aVL3XXDTESz
         FrPiIZxODVUidUd12eqbT9QqX622qxxhzImLuarTctDBYm0G8ipR8A7+bkcZkctKcPhI
         OmcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856011; x=1772460811; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=597mQmEUNbkIDS8qk+5/zMm26WxivzZ2OThkmt6poH8=;
        b=t+g6Zznbffu9mWS8rFtNQBxx2nzF5u3GxqFW/f4cWpN4RJAi6WFfRbOeSZi47trmjl
         CSPqBIZq9SN3mBk+rG+VbtmyIvfts1X1C2g8FmVX/bTL8p2b6XXQmbETBzc9GleACd+x
         7lmKwJ9noNAWJx3vJei4Bmkszncf5yqzEQJEpUXkZr4nWxz+IlZ/+dKPHK9u7C/fU9B+
         vdKphR9GVSeW2BdT9Egi6ZjQRHC8r+m8xy4MrQOWAmq4CoIGAhiSPN54HU8GxTeX3sS0
         RBuE0VFiGYMuxoAJeYY0i+qNjkQ2exfjDnTTOQiG0MpV6DHesJRCtLg9yYuEI9i3/VmK
         bKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856011; x=1772460811;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=597mQmEUNbkIDS8qk+5/zMm26WxivzZ2OThkmt6poH8=;
        b=KciO0g/CEXsEZetLeSSSF+eqLtjg24BmIn5xkuLp+XMef7ZEdCP4p18bD89/pd0vAL
         vM8qFbm6XCYELZq61bCH5BTzL2XNyZPHBSHJcWWnyW7uoGv9ST4Ti6nPWhRhHwztgUJU
         56SizO6i1EaDJZAZ8F++3gY3pzc04k61ieZ7GJA6UftvOs5PXr0c2urstbGlOlmo5UbV
         AbN8P8K5WqDfK7w4NVGW18hhEiae/iFMRx2SZU2tqvAkyyZrPh4nCERFrKHEhPpx1WQf
         QrWGwWbuHatWA/OTKxzCNdmQuPflgeOI4V0WlrHc4Ev9FhseqMorwQuCEtpeXPkyk+k2
         1XRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYOKDLF4qBC59KmCodB0LmATWgb5KAHVZD8nb7PgPdxU9Wwoq+XBKGc7xdLfwMlGbSZS4t4XozdyM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOz/0nUmmTuvO308gOOS+PRtWwrigcfhaYHkjz0zFNS8uWE2Pe
	mQe8jJFV9EuTTVeSrbVJl5ASwkO8ALG0p359S6YYbc/odz0hPr4E349qqMKOpqS2LBmZFu3uAPw
	PamSJh4VqLEGShnneB73rkd48G5JxvtYQqLCLlMKbtg==
X-Gm-Gg: AZuq6aKdCqfVR5pGBObZVNPD5FXJCUREozQxjzR65LI6lGH0oikLYSLLgR1uZhjSnNt
	yp3UtOJB+lk8v4IQIDsy8oMZYgc1QowOH2QuCznvalrvp6m+HeFByNxlEnP9OSFzvFfyMJiqDbq
	7fsLFK1klBuaifUeebwSeEzsTc216ogJ6IdO0O2zTLoORKUs/ugCQL41MzD92EACQo3tD/GmfLg
	YBCh8PKvf29Ycmimh3YtXsH0GDMezEm6ZOgtBBGUVNzPi5rvtI4MNkYMuB9Of4Ou4rzapO6VXUf
	i5q1NZWW
X-Received: by 2002:a05:6512:64c1:b0:5a0:ee0b:c263 with SMTP id
 2adb3069b0e04-5a0ee0bc30emr1881073e87.3.1771856011225; Mon, 23 Feb 2026
 06:13:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260207131041.2833840-1-festevam@gmail.com>
In-Reply-To: <20260207131041.2833840-1-festevam@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:12:55 +0100
X-Gm-Features: AaiRm51IoOEGcQThAZL7Wz9Wjj3_Ac4tq7Xg58f_oxy_-Jx4aKch58W-NfM592A
Message-ID: <CAPDyKFqmO0DEnmYO4uZEYjDErk+sjH1D8S-djvc83KCETf+ooA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 7 Feb 2026 at 14:10, Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@nabladev.com>
>
> The RV1103B uses the DesignWare MSHC controller compatible with the
> existing Rockchip RK3288 variant. Add the rockchip,rv1103b-dw-mshc
> compatible string.
>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> Changes since v1:
> - Make commit log more concise.
>
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index acb9fb9a92cd..a75209bd2710 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
> +              - rockchip,rv1103b-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
> --
> 2.34.1
>
