Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41E3205E2C
	for <linux-mmc@vger.kernel.org>; Mon,  2 Dec 2024 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733151464; cv=none; b=WzyjmbDXmFXCvf4TGqa0QXIBXUnaLJoBZlfewluPwPWJ4AcwazTfuFnkqjMoWNQ+Lic3yCC/hXj7MzmmwGS9KbQFzic8MSHQZPUPAFz8gCeLy8bDOduHuwzK4dwgNG6m/qx9Di1bpL/DEkV6jIEBWmb8isMYbW1552vjaP6XLVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733151464; c=relaxed/simple;
	bh=3XvEO1u292ulfng+/044B1LGbwNEmH9fzD4lsm4bXE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IJ3iQ+J8vD1GlQM1d2uhX93XWn19E3WEVfJHe79HXn31q95qthd1fUXQNxhNC67gqeNvRs4R6Ga09YW+CdVJyjI6jfJWdP0yI2dm7GMqpmJX9TEMOlvSXLQisj5M5zjG1S7U1I87naQBd3yawpYvE2gdc6vNMN/Z7ZBvY11r+e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KHqfayEB; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHqfayEB"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e38df4166c7so3504793276.0
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 06:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733151462; x=1733756262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9h3arxfXF0d1bbIs89zAuzQqDvvuKqYX7ssse+aWY7E=;
        b=KHqfayEBrc1qtc+FB69H0UE5AQPaw9Meg/C7bEMKON642FBXumZrP4HdNEXQTtYJrh
         fz9N5ltpw8Zw9x4veJR8E6hiGshzWTHfGSIAeNKE7Lqj++yAFaAGHjYnE6l0REHEBcuA
         U47L3iEIXvKvgdVlPW3QvbJRe9a3OTk72CBhp4Fo5Z7g87ozLgL0sSNV2fgf9wkQGmGn
         P8ZlTBQG69B0DbpoIX6V5nWm+k1UuVvPfQGdZY8r92IcW2YaCF5+N9RA0n+u2m8hNuYD
         AGzzx65Ff2qwhRSf4xl4csy9n2uacgkU17+nJ++J4iMrvqs8P51umXeeB17sS6JpFD92
         DFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733151462; x=1733756262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9h3arxfXF0d1bbIs89zAuzQqDvvuKqYX7ssse+aWY7E=;
        b=gnzJX4dQRZiJa+LakyrSdQMtNHCAICHMo6Q8/ZoNxgGkMucURPSPHMkKsDlIJI1/MQ
         uf8kzB473AsZef8X2XVZCgvFEcXu4JM4OKQEXmNdRSJ+pKM5FnKAm1vnAfcy2UgJxVJz
         BArmljwpkUog5P36WwESGTSaAWq6FgI54Y4COT9Y8t/nTRpmSRSpR+Nvuv6NQ3lveYsz
         WPzoFCFLwPsk7VlgbMYySZcpK7NMXSfBKgXHieExqb1U3fHHEJg8eEJXiLDNg3GSZczE
         i+nN/CnL31wV+QaP7H/xJn0YiS6X47rmNFsdv23MLSaCjWudvoPXtWAbJlNliWjJjrrs
         UPbw==
X-Forwarded-Encrypted: i=1; AJvYcCUKiMs45APxuy0QzPIEajk7Im0GYloxuUso0aLpOSwAbf1iJeDlKiSma7ld3IkHS2KwJt8dRT98q68=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFn/fh4fb/Ao+iHI286i8OnfM2RUAdVKpLTEvGyxdMPt5umKEn
	54T90X870WupTnMw4W8uLeK9PfPrwY05JnnWQ8El9qY5CdVCYenjvgWCMgCavgX4FY+C7odYECZ
	0DUMfhRgv+9p3jL5gNWIpVWXVlrjbbmnGhfMtSw==
X-Gm-Gg: ASbGncuE5FF8X9DdcF+UmcNh3crmcO28R1ygcRqBe4IpqFxIdJ3Ij6UhBMwATXEN9Fw
	4hJhXKTWtORXFGEs1zzw8y949Dv1IfftL
X-Google-Smtp-Source: AGHT+IESrBiaQsHj0VmFbQnvOSv7LA62nuFEPnmhL9yibArZHjlnIQDwVpaHS5ZzW1IF64c5qcBCmuJdoD2935eEO8U=
X-Received: by 2002:a05:6902:1104:b0:e39:6e4d:32f5 with SMTP id
 3f1490d57ef6-e396e5c78d3mr16414282276.40.1733151461556; Mon, 02 Dec 2024
 06:57:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128075137.2958211-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241128075137.2958211-1-joe@pf.is.s.u-tokyo.ac.jp>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 2 Dec 2024 15:57:05 +0100
Message-ID: <CAPDyKFpFHnPXbVggg4fRPMU4XYqtAkNd7GNrPc9mJJ6RHSAzLw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: call device_init_wakeup(&pdev->dev, false)
 on the error path of .probe()
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: chaotian.jing@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Nov 2024 at 08:51, Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
>
> Current implementation leaves pdev->dev as a wakeup source. Add a
> device_init_wakeup(&pdev->dev, false) call in the error path of the
> .probe() function.
>
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
> ---
>  drivers/mmc/host/mtk-sd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index efb0d2d5716b..9c3cef4cf47e 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -3070,6 +3070,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         msdc_gate_clock(host);
>         platform_set_drvdata(pdev, NULL);
>  release_mem:
> +       device_init_wakeup(&pdev->dev, false);

This seems to be needed in the ->remove() function too. Right?

>         if (host->dma.gpd)
>                 dma_free_coherent(&pdev->dev,
>                         2 * sizeof(struct mt_gpdma_desc),
> --
> 2.34.1
>

Kind regards
Uffe
