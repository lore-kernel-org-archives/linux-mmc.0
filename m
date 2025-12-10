Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9673176FD
	for <linux-mmc@vger.kernel.org>; Wed, 10 Dec 2025 10:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765363562; cv=none; b=bETLC2qr20VgyBsCktO5ArsmH+DH+E9hVqVkdrzgiES8GY53zECRzSlRbAyKJ8WekYm+/KdXMUfWnT2MMCiOPSYTR/DPSBtD4wGqVRkfPa1LO/V6EPvLxXBQFQDddisWmZ/JqGXnQpM3ISbGXAXSwhD+94tj8EqVlaZfWSBhRXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765363562; c=relaxed/simple;
	bh=/xeqJhOhsjl3wudfR3pdeE4WcsndsOTNoq9IWAICiDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTpQs5E/He7cTVU4x/KyFo7su/mcdqPxXyTQzkbc72sCzrqrivmJ/Wawro5SXTwVeOp3M2zZ7L//KUmHbEKakXAY3VfgKzQslPSIPnTBcDgpnfAQikPsN3i9eHEL8v7VJkhSd33H12fQJQy2snBuzYbKv/2284t7lA9q4kclBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hg5h5nsm; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hg5h5nsm"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-787df0d729dso64262027b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 10 Dec 2025 02:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765363553; x=1765968353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ghkZh52oFs78ALP4IMks/eXKzti16uBL4Cv6AozNfyo=;
        b=Hg5h5nsmqrHPojcLCsHjNU8wGjG+cgKCdIuZ6CFKTpOEYNxAdNs1ahvUjXuTWHx+xt
         koziSBIfqDTlH5S2xXTkuC+98o/9oEthcCidV5izsuqf6n3dBLSYaAgfl7olU5hKWTtg
         OozrUfOatEMfcIvh3ci5GmTDs0dkf7ytnMeX3i4M4zBTkWx2teauPV524/GCYyQHZvgq
         EMYBKadBeJFPhbRouRtaIakWBVpaY8CIRBuh8sfkc7ndyoZpAcEJzP6q0s9teUMg++xY
         DPCibtB6djIeqtojwNz4A4vR+nZlnkXxXbFxByD2MTki1JUsDC26azzRViF9IR13zngA
         FYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765363553; x=1765968353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghkZh52oFs78ALP4IMks/eXKzti16uBL4Cv6AozNfyo=;
        b=EosAfMiyIr5okoT1DsVGx1XjacNxkjP2nnNq38XNcadDPdkiBVGIIa+kHNKtk09cNT
         Xf2WsyVt9KRt01UfdyotPqksFIlAmVsApKCFTyi9YNxRgHWDMiQDQQpayXwiTLrRPc70
         wtPzXFTeTgBCZKphAZbfDa+nTFMX+6vikLqionkJR6EmeHOWFi7Q/B4AShxhnFjzB4wH
         fO0e5hh5BtrR+hIkf+mKl4KW9vTdLdfXOa5sjaH+y+JZ9Nsga+6ozMPCcLuAkkpu0VvJ
         bqqPX510McFJCRVtP//l+w3kRXdluavqVv2xMnLP0KGR0j82TnS6uYRIch58G98h8RZm
         rMWw==
X-Forwarded-Encrypted: i=1; AJvYcCX+FajORZrbKUBeOiAXPw4A/j7ZTWvgI/VvbjO4m7lgzYqZ9NsqKpCdEvevdY58Xxdlw24Nf86e5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzChOOPaipxcde7Vw37fknBGanCb2YsW7XCEmiB3bsx0ROvaO/G
	OF76Gr2c9oyKzMhTaCMuZP5/o2FKAYrZ4CczbJL+Zmo/4S0UZQZJr4k08d2O+LiDFvADekWVjTP
	NeU3eYXdypjz4rG7rLe9/B4r9sJhlASGTGFp7wYTkHg==
X-Gm-Gg: AY/fxX6+D5CMm0vGxHps2leT3EP4PhJsUnd2aak9uIp/dEWtAoJzsfWKHQtamclI0HW
	BU1nBw6o0vTbIMbZFoS8H4E8S5BCHUankSWoSylmEav93R6mqZaUu6tjzx3SsiSOmTbyEabhDAK
	zzIK2z3akbKZ50qoqiy8QXd7o+1lLz51cPBqneHZOjAfwHgwOmu+aTdt4YijkYcYp+S37rjmvW9
	nGq4R4Zc8YRNk2oUiU9eVSd8zxT/Yr856aMf5YfNFiPUJCqAuDAf7KUnfMJOsf6mLvxmmgbWJ4u
	1+pM+Q==
X-Google-Smtp-Source: AGHT+IFcwlWg6ofRCirA4ttNAc8ZiHjzU2SotcGyAFpDz6gJRs9KsUbt5dSEIOnMcNzExUkQ6U93GDU8YA6AUUBSJvc=
X-Received: by 2002:a05:690c:3806:b0:78a:27a9:d471 with SMTP id
 00721157ae682-78ca63e46e3mr14877077b3.69.1765363552616; Wed, 10 Dec 2025
 02:45:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20251210022622epcas5p3faca823fc4bf50267e4b660d4776cb1d@epcas5p3.samsung.com>
 <20251210023008.1198860-1-ping.gao@samsung.com>
In-Reply-To: <20251210023008.1198860-1-ping.gao@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 10 Dec 2025 11:45:16 +0100
X-Gm-Features: AQt7F2pNbirOoRHqerZdNIYQeDQImMRpvuU373uKpqUen6AxDtJAcVVdmDaF1Bc
Message-ID: <CAPDyKFprYewRzLb3rvWWEVocdbHvZ7o-MWL3K9W5=+X2OE9B1Q@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Use pre_request & post_request_end helper
To: "ping.gao" <ping.gao@samsung.com>
Cc: jh80.chung@samsung.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Dec 2025 at 03:26, ping.gao <ping.gao@samsung.com> wrote:
>
> Use vendor drv function to let other vendor can add some vendor function
> before and after request
>
> Signed-off-by: ping.gao <ping.gao@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 7 ++++++-
>  drivers/mmc/host/dw_mmc.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)

In general we don't add code to the kernel that isn't being used, for
several reasons.

If you want this to be applied, you also need to provide a user of
these callbacks. In this way, the code will be used, but it also
allows us to understand if the callbacks are the correct way to
implement what you need.

Kind regards
Uffe

>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index c5db92bbb094..04fb92579509 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1416,6 +1416,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  {
>         struct dw_mci_slot *slot = mmc_priv(mmc);
>         struct dw_mci *host = slot->host;
> +       const struct dw_mci_drv_data *drv_data = host->drv_data;
>
>         WARN_ON(slot->mrq);
>
> @@ -1430,7 +1431,8 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>                 mmc_request_done(mmc, mrq);
>                 return;
>         }
> -
> +       if (drv_data && drv_data->pre_request)
> +               drv_data->pre_request(host);
>         spin_lock_bh(&host->lock);
>
>         dw_mci_queue_request(host, slot, mrq);
> @@ -1897,6 +1899,7 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>  {
>         struct dw_mci_slot *slot;
>         struct mmc_host *prev_mmc = host->slot->mmc;
> +       const struct dw_mci_drv_data *drv_data = host->drv_data;
>
>         WARN_ON(host->cmd || host->data);
>
> @@ -1921,6 +1924,8 @@ static void dw_mci_request_end(struct dw_mci *host, struct mmc_request *mrq)
>
>         spin_unlock(&host->lock);
>         mmc_request_done(prev_mmc, mrq);
> +       if (drv_data && drv_data->post_request_end)
> +               drv_data->post_request_end(host);
>         spin_lock(&host->lock);
>  }
>
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 648b4a5641bf..6c258e0865e7 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -618,5 +618,7 @@ struct dw_mci_drv_data {
>                                           unsigned int timeout_ns);
>         u32             (*get_drto_clks)(struct dw_mci *host);
>         void            (*hw_reset)(struct dw_mci *host);
> +       void            (*pre_request)(struct dw_mci *host);
> +       void            (*post_request_end)(struct dw_mci *host);
>  };
>  #endif /* _DW_MMC_H_ */
> --
> 2.50.1
>
