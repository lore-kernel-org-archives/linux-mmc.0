Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92BA1537B9;
	Thu, 29 Aug 2024 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724914188; cv=none; b=JoEwFkuBCEMtvbEXZlz73ZPxz11xldOF7LGarY6k6CrGbQalOc9+VUvdaNTTNQNPEQEdap8ZVZqcJr+UbmKzORg5lH9DYw5AhoT99HBhreGpBM/8EyLVTQ9Wx+AH28nlGyMFiDcCEMXXYPScYw3OyDgiYDBXqFntpwSi1HcJV+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724914188; c=relaxed/simple;
	bh=W9kKsOLPC6QKl01omv3IXEgcvhizLJ41IMD/bNmcJoA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CO3AtsWK1fXaZXjmQnk8xBWbjvZWnilXMDtPeMcpJEhFjdYX3C8fhmx6LgrGKpuaj022SAyIw/X3mc7v8AbF2CDsuwWPBalbeVyYlPf3G/zrwsSm2538koCzSXl1g1zCZVGdlDycVQgkJVlpfbzb+gz71K9spdzO/d9MfMYQTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhamnscT; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhamnscT"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-201d5af11a4so2616735ad.3;
        Wed, 28 Aug 2024 23:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724914186; x=1725518986; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=anQa1Up6WY/2m1ECiE0UnKX5MheZ8bJlzaDT38mRpx4=;
        b=LhamnscTWP1hJI7pBYtj4wsFTzzXFv6E5FxbFg8OHHyPqUxWwi7GtVY/WA33JdPaua
         bWO3cV3R5wgzewsMvwgOnlhrdqT90fh/1Yagc339aGvzAGJAkF45g/+99XLd0hmySilr
         bwtNLuozMCySaaKdaRBCKdCm4a41Vlvhe8IKN6HSjuTYXWgk7iERf6kMkemIE5cLCyLX
         THXokf1c392GqzMEwsePEkjmTBNMPP9vZFWWsiubhU26iJsH68EmbXGOLiwYw6mjlWfc
         Z+eXdVbVp5MsXes3lFnjh8Mzjbabbsq2wVh3Jc5jx+c292qxvr10NWae6AvUbJe4HTcq
         A+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724914186; x=1725518986;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=anQa1Up6WY/2m1ECiE0UnKX5MheZ8bJlzaDT38mRpx4=;
        b=a/T+EILW5hEngewGCIdfg/46xUIBUevVgGuPE5N9MzhOob5w1iuG2417rk2e+06c4Y
         hBLMQYEP9+JjGmNVRiyPjK4XftPnxYXiL7pLLClOMwRVdfAX2KpWutEbL0V8xRd6YS0i
         rVI6gXco90pgOTogV228LPXKtS+SWHVMLrzyFhWF1tTb6pf2qnsscNYUsX0YX7coMkH/
         mvcA9OhvLXsE3ObtuxLTuVKQjbKgCfQt2vWV+5vkXq1OhXDozJLJ0ygMpkIadAc+aByD
         sOUEush1WYlw4A4VS+FoC+OCQE4rCc9YSiWGR+10pbtlZC/WtLrX8eROkDDiFpdCaKXP
         V0RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWELFe2Eqk0eJYdfRM8wOC8G8sBIzkkM3KHAj6LhjcGMQ++TEeMBc20P3qF9/e9t5UkCkZg6a5jKRis@vger.kernel.org, AJvYcCWZYr2B1Pa77EzVA7WmDur1OdQvEGhDnUjYZ4BXIapeQnd/Qa+kp6BlGLrHYwyti2VCQq5FWepJHV/NToQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+AKhHEIb9QvnANYMTWfjE6KDHROoXvQokILm25XYhSm9VKt4s
	CChC5r3b587Byn+cfM5rle5M+xNXiW5SuQ499nFve365LPbfPuMqz5p5Kw==
X-Google-Smtp-Source: AGHT+IGKLNen4FSlOUtRdc+yeIkCpXX5YLc8NLoqnTGyq9VkNOUA/wMBklkv+q3s4bTll6oXxxruwA==
X-Received: by 2002:a17:90b:4c04:b0:2d4:bf3:428e with SMTP id 98e67ed59e1d1-2d8564ad21cmr1662490a91.37.1724914185839;
        Wed, 28 Aug 2024 23:49:45 -0700 (PDT)
Received: from dw-tp ([129.41.58.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b3b92fasm656691a91.49.2024.08.28.23.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 23:49:45 -0700 (PDT)
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, quic_asutoshd@quicinc.com, adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH v2 2/2] cqhci-core: Make use cqhci_halted() routine
In-Reply-To: <20240829061823.3718-3-sh8267.baek@samsung.com>
Date: Thu, 29 Aug 2024 12:18:33 +0530
Message-ID: <87r0a7rfi6.fsf@gmail.com>
References: <20240829061823.3718-1-sh8267.baek@samsung.com> <CGME20240829061842epcas1p25b97a685d0946c360338adf716bfaf2b@epcas1p2.samsung.com> <20240829061823.3718-3-sh8267.baek@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Seunghwan Baek <sh8267.baek@samsung.com> writes:

> Code to check whether cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
>
> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>

LGTM. Please feel free to add - 

Reviewed-by: Ritesh Harjani <ritesh.list@gmail.com> 


> ---
>  drivers/mmc/host/cqhci-core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
> index a02da26a1efd..178277d90c31 100644
> --- a/drivers/mmc/host/cqhci-core.c
> +++ b/drivers/mmc/host/cqhci-core.c
> @@ -33,6 +33,11 @@ struct cqhci_slot {
>  #define CQHCI_HOST_OTHER	BIT(4)
>  };
>  
> +static bool cqhci_halted(struct cqhci_host *cq_host)
> +{
> +	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> +}
> +
>  static inline u8 *get_desc(struct cqhci_host *cq_host, u8 tag)
>  {
>  	return cq_host->desc_base + (tag * cq_host->slot_sz);
> @@ -282,7 +287,7 @@ static void __cqhci_enable(struct cqhci_host *cq_host)
>  
>  	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
>  
> -	if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT)
> +	if (cqhci_halted(cq_host))
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  
>  	mmc->cqe_on = true;
> @@ -617,7 +622,7 @@ static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>  		cqhci_writel(cq_host, 0, CQHCI_CTL);
>  		mmc->cqe_on = true;
>  		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> -		if (cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT) {
> +		if (cqhci_halted(cq_host)) {
>  			pr_err("%s: cqhci: CQE failed to exit halt state\n",
>  			       mmc_hostname(mmc));
>  		}
> @@ -953,11 +958,6 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
>  	return ret;
>  }
>  
> -static bool cqhci_halted(struct cqhci_host *cq_host)
> -{
> -	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT;
> -}
> -
>  static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
>  {
>  	struct cqhci_host *cq_host = mmc->cqe_private;
> -- 
> 2.17.1
