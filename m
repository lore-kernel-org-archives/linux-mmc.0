Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D391366DB0
	for <linux-mmc@vger.kernel.org>; Wed,  4 Mar 2026 16:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772641802; cv=pass; b=flNiGgkfATm9c6lS5VNgjdalPSTWteB/dF1Uzz7mwi5uQYEHWEsoEt6PxVVin9MvGHMMSP01l3ppEKOyO7GWS2hpCQxQKmTe23k+1yo6UrZQeRK93KHYkjuUVDRDYhQDlBuixAI6GIBM5rMlBiFm5PRV1S0mhViBo1rO6tprNhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772641802; c=relaxed/simple;
	bh=A5Zg8v+SxGPdKUukR5Ep71P/YNiK8JRT/WDGh3Up14U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxfLKt74nJ5nwdV7vA+2BMs0L4U9DZFks8nSej7KhvcoXVv/fqIP4soiA48bzBVDCO4s9l1ItxNdH7g23Yipa23CafxH8/C6CrBTS850vpsvBSl8eO4rUmnlWCxYdUq1Wsd157VsDwz/p6dNo1YS2BPh2TAdjM9JzraqMKJrGQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=axGUh5VR; arc=pass smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="axGUh5VR"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38a1eb8b560so35335091fa.2
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2026 08:30:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772641799; cv=none;
        d=google.com; s=arc-20240605;
        b=VtbLaoV1W27Ll6wzfLaYeq1w/24aPDKdj2eo8iLVTCrWzPG5ylZkAQ5hS5WwC+AvFQ
         Y6Y9mvhUxSv+wVWMYHvBYPtSNLRgOeB0oueqjdQpVLGgX0Tl08HngltkUN0Hv9axfcTW
         Ii6cVpyNGUVhsecTFkaYQuUUjuaV7dnUmdxA6irDTTTHroEZCrLlJ7zYSVHjfuUWk5So
         B/oMdq74ej/R0hyM+q0ydJ/naTEipgbyrZFz9zm9FVuju9JcnjW2Oklcf+ZEMwxZT+cw
         b4DT3vGZAyFjrix8L1LMDdRoz2P1RiP1mZ9MMqLdIqw0+SXbGQFoDeq5kVJOMyOePHbP
         dmVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VXKDrX13quy/p/N23+q1GGdp9yeqWrBE+MhtA8NmE8Q=;
        fh=dmy6u3WrvBWEcPkBRsBgpFWRLw/uWrPePJRBnVXnh7s=;
        b=DCv0RjjD39/CqXiCjbKLZ7hVy8GmlkJQU6kQYHnPGGaYz17YdcAOVMn9IIIum44Vnc
         863xMD5cCUvRCLbjkR9heCetQROdben2l0+IgLYtCL8ZeLIzcnYAeHPH+wWm9tVItfWc
         j22qnrC2W4b4Wp3o7mpJQtTU0TX1+tm5R4lySIXhQdcG9FI95ulD6n7YkElnoEOlHxXo
         rugyRIJxVIVqMKuOPb3oPloaKvye7QibTXUgvUNXAy6AVAsCMv8cw8P9gGN97Fp5IGh/
         bj6Q0FtG/kWi2ElUzVCSS4wBV76wSaQGPe8+8d4a4JY55SrFhvNF/6vmyw6U/LIvAd66
         I65Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1772641799; x=1773246599; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VXKDrX13quy/p/N23+q1GGdp9yeqWrBE+MhtA8NmE8Q=;
        b=axGUh5VRmTYQD/FpPTGloMeebaI0tIq6K8OED5XBN4czIPcf//hxLkY+oJg8+SQ1jU
         91/hOMvlG0lpZkpO/NqwhQGi4TvaBxxXG3ziybi9lFv8xzMwwgSm6fczKftZ/TPV6H4n
         dG/roxXaul/lo6oCizc0BeeYieIWd3n5lN009uvXcMBG0M1Mfv/QL+s99+lsIZKOWSY3
         mHq7br7P17XgcWHviw083IoUBdkXT2EIs9TpXc03Kl80S6C7YEltWm6UMlEbXQd0UJFK
         BEGw7RIvu1Jer/ih37PmzKSpfHqWBt+pqa50EnXPRTqHEx0YMtlvbxnTkCY7prLq7XZO
         cZLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772641799; x=1773246599;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VXKDrX13quy/p/N23+q1GGdp9yeqWrBE+MhtA8NmE8Q=;
        b=Pxb0i48UT5CilQRLIAGA2xlADyY6JL1NXBHoDVXycWJSUIWsK+Fr093MBgixr6/h7A
         Svlg+oyScS1ifAvV37OVJPhq+v0PTmplZU4eNZupGMmgvws+Q8A7hRiDA2hYfD16+Hig
         Gag9pD1RfhVuN+1AvOfkf2UkxjgOqzRu/jDdoWvkhMD+uMBFCPAY1RKUJSN2uuFr8915
         e96mcCAWUthonEwxbbOTdM9Z0/EX4uDxe2U+Pn4S23PzcqVL7h1gEKSvmLUCxwS50raL
         QgU9p48niwA+FM7HMUZ6ZOO1K93kJ7GzBOGJCaBoUiC8t0PpoG5I6oGN2N1ayveHOnfv
         U5jQ==
X-Gm-Message-State: AOJu0Yzcn1cDGCbELPyZJfHyr/QJS4KUOSXeCW6CCWLp0MlDfiKAjyDa
	sDwCJ8wMn3ebkC/Qj+4FMIcOwGC3QZtIljvEAQT+o8lDCP8j44CsqZIohCL81tGFf2KhdbXV8Wf
	mkXEl7BHnJ76ZiugNeW4ZytIIdVkiVBa91fGDV5YCzA==
X-Gm-Gg: ATEYQzwigGQY7gDIy80L5NhZsxmK7agIm98acIn7zpG8T0kDFnv5aW8Yzv1DUmLLb6g
	HY0wYD/2oR/00HfBGuGKnvPDuc/yIlx8BDG/c8Ps67GeudL/dlTP8e1I70crs9Ihyix0WxjtGJ1
	QOwunO3t7+kGdre4AHTOot7DdpDTDN32XTy0bkzYs6joWz2mAawR8BpIwv5JdT06nYTt5+2LFcH
	yQ4p3+Mdadf+bOXmMvsNVqJjAEkyRZ0KC+xFzAg2OYufSooVzQCOZXJCYewUAg+1ABWvKVtl3ze
	5CfV4njY
X-Received: by 2002:a05:651c:f06:b0:383:1704:2207 with SMTP id
 38308e7fff4ca-38a2c5b6bfamr18826661fa.20.1772641799182; Wed, 04 Mar 2026
 08:29:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026022313-cling-pastime-4551@gregkh>
In-Reply-To: <2026022313-cling-pastime-4551@gregkh>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Mar 2026 17:29:23 +0100
X-Gm-Features: AaiRm51WZYqsFzdO1wbfT71UNzMYFnf6hz57TYB8yL1F-s555EeKI6JYhgdtRFc
Message-ID: <CAPDyKFqDfh7Nwy5513wSAbebUSQLMaFGRV-aNSeW7Ev6bi-5kg@mail.gmail.com>
Subject: Re: [PATCH] mmc: meson-gx: fix potential use-after-free on remove path.
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable <stable@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Feb 2026 at 14:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Just like in commit bd2db32e7c3e ("moxart: fix potential use-after-free
> on remove path"), we should wait until after we are finished writing to
> the mmc host device before removing it, otherwise it could have been
> already freed.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/mmc/host/meson-gx-mmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
> index 694bb443d5f3..9557f6816af3 100644
> --- a/drivers/mmc/host/meson-gx-mmc.c
> +++ b/drivers/mmc/host/meson-gx-mmc.c
> @@ -1297,13 +1297,13 @@ static void meson_mmc_remove(struct platform_device *pdev)
>  {
>         struct meson_host *host = dev_get_drvdata(&pdev->dev);
>
> -       mmc_remove_host(host->mmc);
> -

No, this is actually correct.

My reply for the other patch to the moxart driver explains why.


>         /* disable interrupts */
>         writel(0, host->regs + SD_EMMC_IRQ_EN);
>         free_irq(host->irq, host);
>
>         clk_disable_unprepare(host->mmc_clk);
> +
> +       mmc_remove_host(host->mmc);
>  }
>
>  static const struct meson_mmc_data meson_gx_data = {
> --
> 2.53.0
>

Kind regards
Uffe
