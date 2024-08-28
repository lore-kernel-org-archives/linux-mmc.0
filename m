Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5F35A79B;
	Wed, 28 Aug 2024 06:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724827295; cv=none; b=H/5zbeY9nquxSD1n9spar5VfZdF073D2suTD7H++3/u7UUWc65FF1K8C6Qrx9QvmWKqgo/Y3AuThDgq7txzKEILEjl+6RsKS7K38khBYdCXg3KmbaOVCIY64hWclmP6GdVUuQ0dAQlJsjwtYr0zAAALZtGac8tCTIh3BQzfFQ6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724827295; c=relaxed/simple;
	bh=oNobC8h5dVqhl9uEOpyU134ulI+DdueZlcJwC6uExXw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=b32jQs6pz3sY/q1hB4dGHMF1kWJ+JenTuu8uA1CmTCX3WE9+Shn1/ZsZ60bNzhrYl9u4+UiBgQ8LVsXO1jqvnARwvWmDV1DG6xL7SxXBo6+oyM4whI2NhXVwuAXs+CkZ77SgerkHyJ0nvcnWUAKhV5TtXS26EH8Lfr4ToxEQmtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OH4zoj/v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OH4zoj/v"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2021c03c13aso2458785ad.1;
        Tue, 27 Aug 2024 23:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724827293; x=1725432093; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vjxy1ZZo2xCcgaLJDeDKhMOnGHqoBddskdGj4omc7ts=;
        b=OH4zoj/vZij71mWVCQ/lpxMMCfARGNJUcOjTs3ay1jj8hGPpN5Hrsdf8hSBW7pUYY8
         lyz7xTOjhdZxutG5bB8h/e2ftvbQMPa55oKl3D33LSfQ9S3iL6vHS1cSNv6RmL01PCrp
         /2PoxpesbASvSVjpON6T3LR2VpfJzN9JVMYp2fE0+Jz/GhF3PZJwZ/5Hjc6Jxya4b3Z4
         ndFIdss6TFkdQOgzFL50UoeGnxqifQKulrFoVvbFTDJsbBuCb8KD8U4LTB3L0cq6GHyN
         zFNAbGrIk/aPp/f1a615sHG7U9Ch/cL9Zh+KKP94t5K5qBRYM0uWniZCc/XNRganpmDu
         jzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724827293; x=1725432093;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vjxy1ZZo2xCcgaLJDeDKhMOnGHqoBddskdGj4omc7ts=;
        b=TzJWu3a9Oa/XdCtXm/FF0QFtCEIrqVdC2cey3rlQoJlIxSrkMFRvy7mjozox6YDy9H
         xueSdmqn6DFEwzOkj6tH938xG2hgRkXynxSFD33MYJkvqjkeQFok3UC8Y9R336xDynl+
         cNJFfJ8Q02fBNXaX9d5UvSpGshhlrMw5BTtcDkp/h5lL5v2xpwuXS/96xEqgZNlBgiWo
         QjsL7GkdpykNqzmMVngNP3T8aRQQqcBp2tQZwyU8/4Ifctd7eZTtuWBj9924/SigUMqu
         S3HRBmh2wy0S7+1SAFU3zhtj1QeyENsjmt2+0OrChHF8WXe/c808zUfVlFeCiWG4A0bQ
         VOIg==
X-Forwarded-Encrypted: i=1; AJvYcCVKRe8zVb9r10Sgl44M8tf8hq1wLa5SeVa0FG3oPHr8Dd2NMi1tiuACxkyynn2F/BzBjWvnT5Y9svon@vger.kernel.org, AJvYcCXoDNiegX41L/ddBHGBxlw28BkW0O6j1ymPBUioUN3GYp2B0EhYucUONs5u+1B6BZ1D77z51Ecdwwj8OZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyDBKPwwC6amNzlDKf44nb4DWOFECWnDXBrFs4GLPXF3xcOiUU
	sV+rKqvdNVKNS/5e11wHxMCIyuZu40LYBIeN/uBAeKd3vDXIQA7A
X-Google-Smtp-Source: AGHT+IFs5b6fXG276iUXoEFxJ0d9IBx+yOx87n53Q1tJLP006ZOOZ/hULu7fACO7sCJj408VFJ9HJw==
X-Received: by 2002:a17:903:1c6:b0:204:e471:8f06 with SMTP id d9443c01a7336-204f9c30059mr17375835ad.17.1724827293035;
        Tue, 27 Aug 2024 23:41:33 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567907sm93431465ad.12.2024.08.27.23.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 23:41:32 -0700 (PDT)
From: Ritesh Harjani <ritesh.list@gmail.com>
To: Seunghwan Baek <sh8267.baek@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, quic_asutoshd@quicinc.com, adrian.hunter@intel.com
Cc: grant.jung@samsung.com, jt77.jang@samsung.com, junwoo80.lee@samsung.com, dh0421.hwang@samsung.com, jangsub.yi@samsung.com, sh043.lee@samsung.com, cw9316.lee@samsung.com, sh8267.baek@samsung.com, wkon.kim@samsung.com
Subject: Re: [PATCH 2/2] mmc : fix for check cqe halt.
In-Reply-To: <20240828060708.20807-1-sh8267.baek@samsung.com>
Date: Wed, 28 Aug 2024 12:02:12 +0530
Message-ID: <87zfoxqhsj.fsf@gmail.com>
References: <CGME20240828060713epcas1p4ff8b4f345747eeb7e581385a62d07879@epcas1p4.samsung.com> <20240828060708.20807-1-sh8267.baek@samsung.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>

Seunghwan Baek <sh8267.baek@samsung.com> writes:

> Code to check whether cqe is in halt state is modified to cqhci_halted,
> which has already been implemented.
>
> Fixes: a4080225f51d ("mmc: cqhci: support for command queue enabled host")

Few obsevations/corrections - 
1. This is not a fix patch. So don't add "Fixes" tag
2. Commit subject needs correction... maybe- "cqhci-core: Make use cqhci_halted() routine"
3. This fix tag should be added to your previous patch which fixes a
bug. I later noticed that the tag mentioned in previous patch is incorrect.
4. The commit subject says [PATCH 2/2], but the mails were not linked properly, I guess.


> Signed-off-by: Seunghwan Baek <sh8267.baek@samsung.com>
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

-ritesh
