Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FE193077
	for <linux-mmc@vger.kernel.org>; Sun, 12 Oct 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760294296; cv=none; b=ZMrKmbGPPlIt0POyvKZdJ1VTIP7qXpEqlLLvlzxMqFyvUchE+EkRZs/SaAwVVwLETn86eMZL3rI63W1nQn4vQFbUyKMq5vwRV9tvoE0AgDhWgp2KoIOipoqSLhu0VwaWGF+isDHA0ykoeHjtEN706iLV3oGFuY/jFTQmuGs+oUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760294296; c=relaxed/simple;
	bh=uQUkzfZR4PJiFUZmTs3kpHMobAqAZ8tDwNcgCtPeYDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uN2L+YnZJSCsEYlowYTsGk+Zj0LpKgLHZO/os1vDfMPj/uUMG6RNxFnSIPuXalc4+vd4OTaSVQfrJp8Zt98w8/aLI5t5HGZb/3GtiPK4tyhBxfI/X+0o1yHuzUqUi5ZTQLl64ROoCSy+ZDJLQns/K9U9qO3GdhFX/4ec9W3UXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hX4m8CBx; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX4m8CBx"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f343231fcso2157475b3a.3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Oct 2025 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760294294; x=1760899094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdM5hdZmStu6wP/lPTHT68dpyLc/oyOsPR/mfyzBd4E=;
        b=hX4m8CBxcRwbwdrFsawvvRn9lfkltGNw5Y53K1+vTEklk8AcKbwnkt1V14YJviy4Ps
         ULETSycL2VlzKuL8cxa9ZEWljaTRNJJeW4zEzwGonK0EgUAc1FgaTLk/3XFpgYgEWExm
         jWhezLQ+JH0IH/wOR5G2YGBOGYdX77aqBO8heSYxCmV4bQYImRiJDmN3wrLaVewAmmVK
         OgSoa6Yjga8GqRgLnLIdi7f7fM1fDJvECqVVHmkHCxEj3uySBl4ouktArHmjYtaCFKCr
         Qtnt2uSCZpcXBkZvafncCBH3HgyWVKeuc3KKveR19HiWnXrQVtvelOkub5PYZMy6Mwio
         tLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760294294; x=1760899094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdM5hdZmStu6wP/lPTHT68dpyLc/oyOsPR/mfyzBd4E=;
        b=YC2yZGIX82EQJmnNjq/4MoHQCB2QqyZkoqkCx7wydmiJXrI6vxeuUNoDo+0p+LmfAU
         wzknGSp0RMkHQUGz+uecpTyml/koFwge1ChNk49r6f17M6l3gOYuJoFSf0OHl+gU8LWg
         7WZetmWskO5tIJXHyNH1Sb40D3jtaOdrQYpVbzdOtdfGKPcTtoQd9gahXq3UpPFgOWEM
         Gmcom9HPUfg9D7Itn4RBMfr8IS4awjYYmHeFHOGG4Zoojnxv8YHGpW/g2HM0YDz3mz76
         i7NSIlx3+VLorWOTDdCMPN0cpIRtmP7rPnAHs2qQQ4U8k9rgFmxGU0X3TLv8ak4tkp5q
         6A/g==
X-Forwarded-Encrypted: i=1; AJvYcCXzBLHalWBucCHGIMIkInaN4vlBN/52Cr/jBu2M8V3u22BAaoIRGbXmYR/czZi+drDPoGuPUqpwlwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjaI5Q3xaCLVzieIyMp+7qRvd4VibB6ciq5EXmZG/W09MRL+Mj
	JFNX5ZDNtnd6CfHBZbPm5UfecnCgnrvkJH/speImEXGO2S9/b4Fydo2i
X-Gm-Gg: ASbGncu7yf2v3UgAAnjoPE0/ts3+K8IiKpzDLcbdTHeG8e6V7nmE3O8pgz9LPKnOZ5N
	ypXqwWOSGM2+XhrlKVG0js3z580u4FlohVknj8CloKAceIpV2bp19S9XlmjQqnDq0meV5HxOFdh
	fvEal3KHgv/6IVo3Cey7YfLjI/YmoK1DE8SpYTN9Enqe1D/eBpR0JszhU7XH0xMHq6F3Rmn9Lkz
	pb6tukbi6Yb+xWFGpHdmrZQ0L1+xrKZe6nhped4o4nPvudyx7fFrHYiSey0q/3mRrBpUR6YDNWj
	6a/irpQ2zmEHzz0S1xMrcKn1iPc/tWMCkKqZYwITjbsB20WMNnUMVxl3VdikY3/uYQm+f1SI04T
	OlbBSaV3ldkq+y0dmcDL9NggkYImjyjkHLhPynLMh51eyk/Jr
X-Google-Smtp-Source: AGHT+IGD4qq0d7J+6TgXoMmi4zHj5Ov0A4tbqkUnz7sBexTic8piA6fopsWY2ndvOzIISYPoIaFSqw==
X-Received: by 2002:a05:6a00:3d52:b0:781:1a9f:aee7 with SMTP id d2e1a72fcca58-79385709970mr22178082b3a.2.1760294294103;
        Sun, 12 Oct 2025 11:38:14 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:310f:1e2f:de73:6871:5bf8:3f34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm8982904b3a.59.2025.10.12.11.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 11:38:13 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: u.kleine-koenig@baylibre.com
Cc: chenhuacai@kernel.org,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	lkp@intel.com,
	rakuram.e96@gmail.com,
	skhan@linuxfoundation.org,
	ulf.hansson@linaro.org,
	zhoubinbin@loongson.cn
Subject: Re: [PATCH] mmc: pxamci: Fix passing NULL to PTR_ERR() in pxamci_probe() 
Date: Mon, 13 Oct 2025 00:07:52 +0530
Message-ID: <20251012183804.15171-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm
References: <xxtrhbv5qm2crtvc5ejpgu5caadsmms3rfulmosjwq7lumrko3@5mlcpk24hymm>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

> >
> > I do not see the need for this code change. "if (host->dma_chan_tx)" will
> > skip "dma_release_channel(host->dma_chan_tx)" since dma_chan_tx is already
> > NULL. This code change does not add anything.
>
> Yes, stand alone this change doesn't make sense, but if we want to drop
>
>         host->dma_chan_tx = NULL
>
> in the error path above, this change is needed. Maybe then even
>
>         if (host->dma_chan_rx)
>
> and
>
>         if (host->dma_chan_rx)
>
> can be dropped.

Hello Uwe, 

I had one quick follow-up before sending v2.

Regarding the devm_clk_get() error path —
you mentioned that setting host->clk = NULL; is redundant since host is 
devm-managed and the function returns immediately afterward.

> I am not sure that sounds right. Looking at the code for
> __devm_clk_get(), if devres_alloc() fails, it returns -ENOMEM. If any of
> the other steps after a successful devres_alloc() fail, code goes
> through possibly clk_put() if needed and then devres_free(). So the
> resources are already freed at this point before the return to
> pxamci_probe(). The only thing left to do is to set host->clk to NULL
> since it would be set to an error pointer at this point.

Khalid pointed out that when __devm_clk_get() fails after allocating a 
devres entry, the internal cleanup (clk_put() + devres_free()) ensures 
resources are released, but host->clk would still hold an ERR_PTR() 
value at that point.

His suggestion was that setting it to NULL might be a harmless defensive 
step to avoid any accidental later dereference.

For now, I have dropped the redundant NULL assignment from 
host->dma_chan_rx = NULL and directly returning the ERR_PTR instead of 
storing in a return variable. 

Below I have appended proposed changes for v2.

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 26d03352af63..eb46a4861dbe 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -653,8 +653,9 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(host->clk)) {
+		ret = PTR_ERR(host->clk);
 		host->clk = NULL;
-		return PTR_ERR(host->clk);
+		return ret;
 	}
 
 	host->clkrate = clk_get_rate(host->clk);
@@ -705,7 +706,6 @@ static int pxamci_probe(struct platform_device *pdev)
 
 	host->dma_chan_rx = dma_request_chan(dev, "rx");
 	if (IS_ERR(host->dma_chan_rx)) {
-		host->dma_chan_rx = NULL;
 		return dev_err_probe(dev, PTR_ERR(host->dma_chan_rx),
 				     "unable to request rx dma channel\n");
 	}

Would you prefer that I:

1. Remove the host->clk = NULL; assignment for consistency (as you initially 
suggested), or

2. Keep it in v2 for defensive clarity, as Khalid reasoned?

I just wanted to confirm your preference before resending, to keep v2 aligned.

Thanks again for your time and detailed feedback!

Best regards,
Rakuram
