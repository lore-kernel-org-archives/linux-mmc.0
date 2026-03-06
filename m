Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33039281E
	for <linux-mmc@vger.kernel.org>; Fri,  6 Mar 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772801785; cv=pass; b=DBoSnXkhEopwgemd48RvF7pTrhkoZ5yw+pk7ZyopLzCHZjSXmqLPl3ZcC5xQdU2uwH/0XEybCxSrR68YUGoS28f2Kesbwp9hfEKjcdsK7FeI1gBaJsZLiuuFLpp3qy61pXEJwazEKzzaXngZlsYxwmVIigW19+5Pa6zin6nqObY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772801785; c=relaxed/simple;
	bh=wJffGy7LYKR+jQmMe1VSnAs6VxFS/EDydi1YlF5GWZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEE8pkhsePSAcdQCDkdr8kGG684O4FH6vgm/+JODdIA8Dmzj6ocWOT57TGd69cwhNoqpCS2lhM6AFobw5g91WM9oZfY3qNCdss8Wva326Vp9BqB6xxEgJIGlRcGJdMLevQ97rfCgbss+PrA53WgvAxLewAlav51xfRcv2TRUFP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ogXpuob8; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ogXpuob8"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a12cc20e71so1845061e87.0
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2026 04:56:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772801782; cv=none;
        d=google.com; s=arc-20240605;
        b=UFgD0DUw167io9ripVE9VbgUAWgTVWvPxlXwBYQzDQaSihGkGCfOJOeQ7RtBsaCNez
         /8tGGDX9vV2Vr4UWW+1NPU/FtUgwJmiB7hFiYspIOx9ymab96DHJ2bqLQ9x5ygjRUQ51
         1l7WC73IEHoNUFBbNA85zPt0doLEHFr1SuG5w4YLwtXINgHHizF8IgZB2yuwnDsVA7qb
         5NmOvZVGdBFTSpCMFXw1L8zRN8sFbB7ojiLm6jKUmOYzvzAGjizb+12VHD1X6Ftg4ofj
         Qtifmyf80fzlqQrJh11Aa5wXWWgDWVnZpE/E9SZwnZiAXrQEtz+pjhmvQ386o+ZJIxvn
         y/Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G1h3CA12TR3DUwT2sEpGipCt2aGRjxneEfQ3TJDN9mA=;
        fh=9b0hlgImlszeM0G+cCtV9eohTxMJs5ujqEFvYdyx908=;
        b=JrXRXxN9gAYiu6V9k4vcdYZGDUQAcmenR6wCR6b+bnFmwqLO1f+jfIu8ZGG4MoLNxO
         XU6TXIb4lY68WZ1dFgoYJf6JyRpIVtUP/jd9jPQ5f4Y8iS/Jj3kRwT5hdtgb3OuXLrL4
         fWOalPDAgq8MdLwDU/VsEUkc5fkgt5FqxmzgucetPDTjSl9PkQFgM8EWQcVopCPTS5mG
         AJa0phhJZ7rqGlWXvaWsnO4NALESTeYLRJq/8lUGuv7pj4vO3BBWfq8oWrk1RMiVyrz0
         yTvf+6tdxgaLI5GhSIae5WDLlJ0sHQZxQSj2f8gSx6Vba0wYeric8FxFBiF28BAaXADP
         eE7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772801782; x=1773406582; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G1h3CA12TR3DUwT2sEpGipCt2aGRjxneEfQ3TJDN9mA=;
        b=ogXpuob8Idaca+LX/SbzjmftcU/lYUJ8ZI9oZBLY9GwwtjBzdxSBB3kCOMONwIuPoB
         YsSmTx4syeXgTNQTU0VAiLfiLXzfHFcOMiayOfUvex4R2c5ZCjyheMkDrKaYYduilwHH
         h+T1nWxilohlQFfY1aeRLPHR1LvAGBQwrr2NmRO3GGHcWAK3D1WBDIGmPL7+LOpPRmEs
         hw0Eq2cDJylOYrSf3mLUpd1CKTCAwflaFzaBQEm0g5yMgq3yzGlWKSqayzyrNNvbjRvy
         K00ybSHzxdrEB7GIrskGHuYnqdBGtk2q/0Q2P6Z8xim1akUzhFcOyvHJmtoSLRJtJTmV
         RTDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772801782; x=1773406582;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1h3CA12TR3DUwT2sEpGipCt2aGRjxneEfQ3TJDN9mA=;
        b=Y02c+hEIxRqvh+LhqJWFbCJeLjZtRyN8LakBotqupt8Hr+HoWMMW17rVErNdBnb0eD
         23gjMDNw4k8gGO9a3gtaFNXPUO8KvqmQBRTZ15laXtZ/v42guCWKLa/jU/edxAmCnJ5X
         ZRVUlhRbIw2bEWLcaipTFsdrjBxa05GIlojsiiE2egZMUvSefkNC20wb/GHUFr/G424+
         V6mF6BIFgFDXYOPs0XuJx5oGm5/fRVDenRgqzxaQ2dtdL+KtLxAksTDkT0D5N8jj7/QP
         YSabDUUgO4gfuuCb5EMC88t4zs7hwIDBTTUteX+3q7uZ0DBWZcCdwWxGb6K7ynhjqzWL
         QWzA==
X-Forwarded-Encrypted: i=1; AJvYcCWuUBmMBsZZHtIa9Toi27PLqCBGnDTeerXuERetsIp2J/hD7oONGmSIIGVrGx1CAVh/9XhAe4xJLfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAuAZ5G15nkFHHxuaPQfRGq8eaaOk3/501O5v9N3LfwRnxVmkx
	TCcJppyfJjzPFh60uZKPXoiDv0i867dI2fxPXysQMVfLtCfGCbg3kOEnXQDhLsRAaBM++pRldrE
	A7jCEXsPsTCgUi9TnZxbUY4zW1QDZI4DFNPTbWOAsUQ==
X-Gm-Gg: ATEYQzwo/nD6YghX+k/NXW608o76rENd0lGlGCM5j6RBbDvNn/e3m3bBhhAR9mURl0z
	0lZbg62WQ2Jx+UkxiqE/5Ybfe24B+P5yfcj/kjZjZ1gM24pUeRnNhnnTOYxeUfaFddv88vpj+kq
	/RZCzYmGePyZvYU0QTphwGh7E0HMeol/t/NkHOF+UIuc5xr7b9D/uOg1loROB9jk9rTBBmueNGp
	oTGiyIb6JTR3Uenfcdb/WsifZYgMkZOz+Q7O7qpBPGOzI0gDLoE+qH+8xeQkuHsYRT0XM9EVWad
	RNJiwSB4bqkxN96sr24=
X-Received: by 2002:a05:6512:3042:b0:5a1:1d8c:42a6 with SMTP id
 2adb3069b0e04-5a13caae68emr693718e87.4.1772801782038; Fri, 06 Mar 2026
 04:56:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306112742.64235-1-ulf.hansson@linaro.org> <3eb61c4b-2902-4a62-8246-4bed683fe326@kernel.org>
In-Reply-To: <3eb61c4b-2902-4a62-8246-4bed683fe326@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 6 Mar 2026 13:55:45 +0100
X-Gm-Features: AaiRm53jQNANP_kwu30hFxjm3QLAerKyKf8WmQi4bAp-DnbOlj-A2lK700SBqDI
Message-ID: <CAPDyKFosu5=gAb0QzhkACO6RhXkOFNiKKOSdwrDsezT-bx4U2w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: samsung,exynos-dw-mshc: Make both
 clocks required
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ping Gao <ping.gao@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Mar 2026 at 12:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 06/03/2026 12:27, Ulf Hansson wrote:
> > The current binding allows one or two clocks to be specified, which is
>
> It allows only 2 clocks, unless you meant that referenced dw-mshc schema
> allows one clock. I don't see it there, so I am a bit confused.
>
> > wrong, as both clocks are needed. This is also confirmed by looking at the
> > exiting upstream DTS files. Let's update the binding to fix this.
> >
> > Cc: Ping Gao <ping.gao@samsung.com>
> > Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> > index 27c4060f2f91..3e560dde714e 100644
> > --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> > @@ -42,6 +42,7 @@ properties:
> >      maxItems: 1
> >
> >    clocks:
> > +    minItems: 2
>
> That's redundant, 2 clocks are already implied.

Doesn't maxItems mean the maximum number of clocks? And since clocks
are required, it means that it's perfectly fine to only have one?

My points is, we seems to be requiring *exactly* two clocks, no?

>
> >      maxItems: 2
> Best regards,
> Krzysztof

Kind regards
Uffe
