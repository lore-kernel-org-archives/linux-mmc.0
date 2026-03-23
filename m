Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68A3BC691
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279198; cv=pass; b=A8R5LHLwR98mmQ3yIRzL519dZQAYZbrpouBxhupiA2jEsqnm8lkji+VQ4BcEtG1c3GAoOteSRV0bNqXyBQAZmKjUNBvbOtrEz05WmYS9YUWKxtc1R1IQZmx23OWsbk26+sir14RANpBAUFHiBYhuSL/bhPqgLKA9dMyUBY04I5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279198; c=relaxed/simple;
	bh=3bLBwlvoKV9D8FRW2lSY998rKGPTuAzsW91tz//soKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GFhVQHPaDKT3skJAQKZOaNNsjHdFUuAFeHKOJ14yPEfBsICWyx0/tHR4jFh9YRyQJWwM17oOZkf7bPRN7PLF2kLsn2YHhsFbiKOZc9CkyWPxl5L8wlxL1pwHAwVahdFFH2u9dhzrvBjvE++oW9wQpXOGCrmNlv5vP5rPM6ElXXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pnLGxyyG; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pnLGxyyG"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38aef9cc451so21060931fa.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279195; cv=none;
        d=google.com; s=arc-20240605;
        b=H4OD6kMajjYU3PJsaH5Pqmvx95Z78hJFw87rzVH7xyfnGXIqEUQPp/RAwzGBlzxot0
         L/xP72Z0UPaLFnQRX791Ta0RRMaxhFgVtoKVpo68FrhBiiTSbha/R86JuWyOmoT1Oe8C
         aTUH4l+mXvcdgQJqFVAAhuDhDkFwjUXjLBoyxX2sKn/3pl6FhfaKnOdeVuJGZ8nW/xH3
         czwvdK1Xb6VQgAmzpu1YO05xpdHvZr4p7AaLbXPOhM1bi2rGGbr8lhstQ8Ng/BkuQFFA
         Ywr30B/jar9k5SY3IXGxIaxTS8oQt80Oq8F6YJ2LC6K9vjpjYDwz+qsGzUkqmJnqvWes
         oGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=e9m6IagqbiMUTJX23Qe4eCI6DILlg9PmVieqm1cjUqY=;
        fh=Q8G8rSLrI6ABc0fm+YCBWAA9mcPkYXmxmDYzCsZ9KO8=;
        b=P/8hXOhDuQ7euZEWPDEDFIbUh8HXxxb06QgWA3R49ZsrBGKABBlMhgjEG5SORcO3aI
         r3DQWEPcxZGFXeYh1DcP7RDkICogLQky9LjSBJgcZo2LsGYVWDBM/Ux3Mtiby8wYq0TO
         JevMYAVZ5sPi71TyRfBBHbEu227jz5ssqB8pMX+EH4MRTBqP0OPT0d+WrbDrYfz0v0EA
         At4Lk+VGGoBxZdRFp4repNXev7bN1fv64nJZA0AQyGKEQgSkvqRzMiXKCgF0O1zXFAnv
         vu/ykunFIZhbaOl2GfNqJY+AUDofPuK/7W5JJb9HyZtTkC2nmkwkqXmj7kXC1OLw97Ok
         0JKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279195; x=1774883995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=e9m6IagqbiMUTJX23Qe4eCI6DILlg9PmVieqm1cjUqY=;
        b=pnLGxyyG9Io3AllDIScxlNB1SCwtiwFzwclnAaJrSmvd5bBU2QNxpQJ3noaoXVAVbL
         ajzCEBnNOHOV7/K/n4yEEzr1CahODRrJ4ADQvL57Aaf01dbdj+LrHUawtTSNfP9t742v
         TVjBfUWdlLeqWR6ywwV5q8OZiX4H5sExzEM+5JhqFz+7ifLsGuW2ZpM1i5S7SS3AQhzf
         4WM183V6gW3sk/xhm/Eq/aueCtnPPfgEQoSYAKl2D8a0wntHIHad0voDc07ltyjNyl/M
         X2PsaPhwi69rtrri00gO521fv5SbWXJZIdW4vq8xpfAjBV3DzKNwusVcBeSvqMunoR/u
         3Uxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279195; x=1774883995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9m6IagqbiMUTJX23Qe4eCI6DILlg9PmVieqm1cjUqY=;
        b=E69qQkO2X6RALlZ7Sm0PGboAuZIlgr2fuoNMKV8Qjzd/DhbRXvLOLGH7zeeTqRlXFY
         mf6x6F5suY3WW2AYethnxDOI19jOLohzTm0+Fp0P2T/mAsAr6UbpXg+3uHxfVrXH0A7N
         ioK64KsV76BPk3IFoEiv5Zv9n1PrQ0lUfnZTJXX3lRAXgDSXMAml9WUDHQ0Ud9/JkjgH
         tXl+WiENCPtHjUrUzStUi+Fb1/E9U4fwM5sEksqTsnmU3XJBWVVpWY13ZCkVJZSxx1jd
         x5CMUwycr74Es5oFB+bFHPEKzPeooqQYzwmm4gDjQun7be4m1JKgwdqgtZcnz2eX/Dr0
         jdow==
X-Forwarded-Encrypted: i=1; AJvYcCVaNq6Q2MmiyHyLZuVozBExdUedXb/N61zV1op1vfETEwZf5av5EXTnZQbQ95k7Bhv6XKIYwr3dMk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEvqpd7BRLSLqGVr9t+i1ix7lz+intGhVSD7ia+13zZ0/OZUn/
	riN2kAlqj3jo4eTFH1oL5UqFFGTRMoQcTqN069rkJNf1NeLVBjxnrPzvPbTI2Ywa5Ey+lKNRD+p
	Hq8Aa1x2B+gyqnvTsTFgsezS4PM8bT7RiR5wMBiQEFHVN/s95ZJVs/ls=
X-Gm-Gg: ATEYQzy4NqJke2g99pu+1CfyWHF5hlReYXEscznjVmk+SyaBevCEhYX9PmjAEhbjTHd
	RD8N1qOAf9kp/Eyo5kudDzR95lfdiGHKU4fdHzM3UqnHMEw54s7+aaxwIUS8cw59SOcBMhIgElM
	75eaJwMoNWpimjL5O8QQ2+blprWsWQz8DhxB6OQyYnJvZ68WEVBuUufbYbZE2HRhZWYYaD4xOg5
	QvcgZ190LkEui4R25ezkCEEeTe1LW3X/FZlwckgjLAnp0nxq8IzlCoP39lJvAEJC5PYu6gCPBqW
	LpAwgX8A
X-Received: by 2002:a05:6512:1288:b0:5a1:4017:18d1 with SMTP id
 2adb3069b0e04-5a285b54ea6mr4675867e87.37.1774279195001; Mon, 23 Mar 2026
 08:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313130835.708066-1-festevam@gmail.com>
In-Reply-To: <20260313130835.708066-1-festevam@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:19:18 +0100
X-Gm-Features: AQROBzCNP8s-Y9NKf75E5i7SXfCEWFK3Iny8BNioMSMMiWmWo13eeXGEDAPT9OU
Message-ID: <CAPDyKFpGo6aHh3qjT-cTT3SbLF8F1Y6voKEmj3aT-KqK3yHYQA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: rockchip-dw-mshc: Fix the RV1103B compatible
To: Fabio Estevam <festevam@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de, 
	shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Fabio Estevam <festevam@nabladev.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 13 Mar 2026 at 14:08, Fabio Estevam <festevam@gmail.com> wrote:
>
> From: Fabio Estevam <festevam@nabladev.com>
>
> RV1103B uses the same DesignWare MSHC controller IP version as RK3576.
>
> They have no "ciu-drive" nor "ciu-sample" clocks and use the phase
> tuning inside the controller.
>
> Fix it accordingly.
>
> Fixes: 517b1e3c9455 ("dt-bindings: mmc: rockchip-dw-mshc: Add RV1103B compatible")
> Suggested-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Fabio Estevam <festevam@nabladev.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> index a75209bd2710..4965bb518c54 100644
> --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
> @@ -43,11 +43,14 @@ properties:
>                - rockchip,rk3562-dw-mshc
>                - rockchip,rk3568-dw-mshc
>                - rockchip,rk3588-dw-mshc
> -              - rockchip,rv1103b-dw-mshc
>                - rockchip,rv1108-dw-mshc
>                - rockchip,rv1126-dw-mshc
>            - const: rockchip,rk3288-dw-mshc
>        # for Rockchip RK3576 with phase tuning inside the controller
> +      - items:
> +          - enum:
> +              - rockchip,rv1103b-dw-mshc
> +          - const: rockchip,rk3576-dw-mshc
>        - const: rockchip,rk3576-dw-mshc
>
>    reg:
> --
> 2.43.0
>
