Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D8235893
	for <linux-mmc@vger.kernel.org>; Mon,  6 Apr 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483312; cv=pass; b=Omre1XGVKghfrRE5ZywJ+Cvs4ljx2f1bGz4iX6I/yP4SXaptKAl56gg7xUWdOGciGL+tzBXTL9+JmXD/v2QRKAcforYVH4QVjc5GQAU1Hjvr1kqsmZ9Xe5hYHB+GoQnAGh9Ndd+NvTCh0dFLeabS3j+7xZWci5LBiNZWu/HRYW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483312; c=relaxed/simple;
	bh=Sqctb5UTnmYyEZeCGHx90H/aOmJZv60DnVHDncuO0X8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FMnQUzFXhcouGoyG8pi2YBrDi3r4pb7fIbw+e8PUT97AGixpEEoO/mzT8MJk+yMFkkTycbdc7GAJguYMJSwyr5ubvq3h0ouzU7UPOmRiDQsR+6Aq//diCcXRvOdsAMVEOs3HLFZDRy6R2ThfjUjAbTVdWWIFNUpOckWOewFd7qM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bODBIolZ; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bODBIolZ"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5a2967e5de4so5314496e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 06 Apr 2026 06:48:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775483310; cv=none;
        d=google.com; s=arc-20240605;
        b=Ikda/lDoLbCmZ27livB6gEwdlyb/XEbUKMVX87+g7P/K7Xw6me7QAjO1ymRoMcd4/G
         j32A1mJi9DW5987xvJu3wLvPTTrBe7GzCn+b5Jo0MR0y37NM68W5aivqI+TVx19EPCUb
         7hqW0OMfDv6PCxnXwxIlSEECfP0kCywr9KFBWoXWpBsSTCIbCfCVQg1NHuUAvIsSzmoj
         3ZBHV8C1p+uNz7J/jbF5QfoL/PUyiTJvG4DvHuWJuKoLOe3LCK3YgDY/+xFmu+cnG5OP
         4E9FcOD4ie95mGo1mXS57G+0ZdF+tTSgEW6rZDfslp4GI9r+qYvbaC8Ik5mXDaXFqnGv
         TAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sqctb5UTnmYyEZeCGHx90H/aOmJZv60DnVHDncuO0X8=;
        fh=zii4bpwgZ04TPaIGOLGXHZatMauYc11EgaHbyVIUUok=;
        b=jm9dgT2EVBTILSyQ15yl0cmmlGgNRD06GuC30OnFk39WoUd/7hkF5vsuktJkb0bLCA
         XjOiKCsBmJcYOdhRiWaVDdIDF7MM3UZfnAAaVZzzC6gOifWpfGAI1Fb86mUZLbwggoJq
         1/Q705y60HSRYJ73LEv8nmkma5dZDw426XzXBH7gmiLQ20UOQkm/hyl69+v+q2UYobqP
         ZqUcmFg6Q8nYioC7X6klLpuvNWZ/LzTGmUH3bnfHvZYSyWGSKSH0iM2bptcouZty+ra4
         HI4iKiuuPJpyqIaeJVAbjlmfDPtoJJphr3c35Q2aHLtaPdfnCLBPx8ehIp7gqwL5p+au
         B62Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775483310; x=1776088110; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sqctb5UTnmYyEZeCGHx90H/aOmJZv60DnVHDncuO0X8=;
        b=bODBIolZaZh1Ro0hLQI1kIeHLGHLYBANwvEjsuu003WsGOZQOmkO/9GgpIscrIfqt1
         rlZ3c0IGYpz7SUzejylc3EiumPk8Mk+P1pJTRBGGq1r9srr137cI0bgN4Y0aOwPpX2aL
         8H8PklDFQAD5XaUw9S7O/VYE7NYCyt258K/xmW4zvZ01RsKs/cqhW1a8nO1ThFwX+wFf
         Vm1ESo5NXIQaq0CmBWHFwcUibH15zIhLGBjx3gC1fIUAfnM3DXbEEX/oI2Sa1aKIqTzz
         iF6mMg+HtPNsBh3rnYKUl7HC/V+x29PgJONumHSnjIl0S+9M62zEsLyhxchnBToB4B7M
         yQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775483310; x=1776088110;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sqctb5UTnmYyEZeCGHx90H/aOmJZv60DnVHDncuO0X8=;
        b=YItQw3U8z2jpVGWkcTJxAbVb+aqRq5c8uv5/Tw51UGLFRj3kW11dnjxpq/xO6H5elw
         nfJ1kjtX+ucmGAv5VW03LQUE+DqKc809/vRheY71pvSzlesYAM7+aK2VKJL+VaUg/6y8
         JiNE8f/YlQTzk5FK75pGKRQS/RLW7qEowLJH1w5cRvPdWJbGzSPTw58hEcqo0NIjePPL
         KpwEGLVTrwqrFMTXFjCTDqMHShtHGqZYal9hQzdsUvx+8vbiuTWTxeNCIC87Key1PxxF
         zEYm6Q/aO0wOcsFrPkudHddV05KkLshsdtWGwPrnT+0PkVYF+wuBYCYyuINxGLqMcBIS
         RW2w==
X-Forwarded-Encrypted: i=1; AJvYcCXNuddyfBWpuFgx0UJZvrq7F6+ImXmKCpOKFq53MgSGlC+dNvKHAUalchD6pF0zTvjJitoYMfulHNg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzSgCehaAZ3SvoSw4ayszVSvD60orMqkkf8AeBKnDc4S6nboIH
	prZK313bkWujupN1b15cf+2qYZknFLk11d7ydmCKYOmqUd25ilTMfifirGq+uq+XrqYTYvk5sbK
	E1KfsPM78oa9wppgbbE/VhI+cVQWj5NOKk4dMw0X5hA==
X-Gm-Gg: AeBDieu2FSZj0dckf6d5aRF1WxlOzwqwuHfYQyAY2qn6UDXtgCstEVujjGpZYM5JSNE
	9FoZeW2ePS6KEEL9w7XJMwUEX4+9tReGB21WBPaOKyGkSs2W+JC0ytqFcVCN2qRxFLokWupkzYb
	hOXma2dTjitst4w82rV2LWPyVwo7wVkpYRTI9PrckH+1qN0xCtphtGAgHtGBFEAFDyyhOJyqf2S
	I6iOBdJAFtXhGhNS6+dBWv7ZEs38qlC1Ce4DSRgOI72qxREC1YANhLDpoWcyL/t03pEjZN+lloK
	aURzPYyL
X-Received: by 2002:a05:6512:1387:b0:5a2:bebd:45b5 with SMTP id
 2adb3069b0e04-5a337556025mr3843205e87.4.1775483309545; Mon, 06 Apr 2026
 06:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403105949.1007447-1-neeraj.soni@oss.qualcomm.com>
 <x2mmttyg5t5qjo2tyrwqbynqylqqlulu7fhoyxl7vd54geubqx@qna6vzzr765y> <dd2c0522-91bf-5375-f5b6-7c9ff5304fe7@oss.qualcomm.com>
In-Reply-To: <dd2c0522-91bf-5375-f5b6-7c9ff5304fe7@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 6 Apr 2026 15:47:52 +0200
X-Gm-Features: AQROBzC6Z4geQHlG5qxG5dgsYbEDZ2VqEZWbRlCdpWNgrW30RabdxBUoa27FfzI
Message-ID: <CAPDyKFpXRPx2Z8Ro3f3BU3ApEn3rHtXhkO09-qjGjHwSEH5dmg@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: sdhci-msm: Fix the wrapped key handling
To: Neeraj Soni <neeraj.soni@oss.qualcomm.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, adrian.hunter@intel.com, 
	ebiggers@kernel.org, abel.vesa@linaro.org, linux-mmc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Apr 2026 at 09:29, Neeraj Soni <neeraj.soni@oss.qualcomm.com> wrote:
>
>
>
> On 4/4/2026 1:30 AM, Dmitry Baryshkov wrote:
> > On Fri, Apr 03, 2026 at 04:29:49PM +0530, Neeraj Soni wrote:
> >> This change was originally intended to land with the patch series:
> >> "mmc: host: sdhci-msm: Add support for wrapped keys". The fix was present
> >> till v4 but was accidentally dropped in v5 while rebasing.
> >
> > Don't describe what is being changed or what was intended. Please
> > describe, why you are performing the change. I.e. what is broken.
> >
> Ack.
>
> > Also, likely you missed the Fixes tag.
> >
> The SHA-1 ID for "mmc: host: sdhci-msm: Add support for wrapped keys"
> is not yet available in tree so i did not add the "Fixes:" tag:
> https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-changes

The commit should be available on the next branch in my mmc tree
git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git next

commit fd78e2b582a0 ("mmc: sdhci-msm: Add support for wrapped keys")

[...]

Kind regards
Uffe
