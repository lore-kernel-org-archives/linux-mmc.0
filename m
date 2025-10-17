Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96A369966
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707872; cv=none; b=F1qEJcc+l8zzAjvtnMNZFubkoENkNTo13y12w2jK+bEb9ecTj8pgCginDXz7vbFvkGcS6VfzBfOdoffGrGVQfzso0E9U+BCWYvnEFEjmp/x/MHAlYoJ03FKB2HsVPxi6LjWbMyWkmN1Jp+DC7PHz43TLpJea3aYUPicbwJR9x20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707872; c=relaxed/simple;
	bh=i+O3goYjT4QQXxLHScTtYR8tB+lqI6cv3xXIRKCisAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K2PsGsLssAb4LWen7ct1b/S86OJLij/ArPoUXL1G/7dz9C3cZi/YtX8qERgy1ZKD6pMEEZkWlLKKv7G+nHxZeWUbM/zETDcktlY2AsInohZFpJH9s0K49GQOX0UlMKzkcUI63xUMfHBmwDFswcIljPP2z66BOnBCvlN8Qdn5dXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TJJTlH+A; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TJJTlH+A"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-63bbf5f77daso2033361d50.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707870; x=1761312670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DUCXQ0EvV9ktxmOlNW52FjkhtUMF4mrPMo81WKGkY7k=;
        b=TJJTlH+AdWbVPr4lWHccUlLtKQCL3SxG2ftDDibxk6+eXLd1N7cnCuLl8Kx+f2K0dB
         dT+gLRQLmsQVVSy/FZKcbqz695iwUYEt3a6HhE1dBhPEIieivCgMMxvlwdtKh+f+62Op
         lImGEchQ3yjfl11cG1oTk45WIZI4DtLkWuOWhw8M1snVo6RweJ327YgzPRXlgVOJNMLr
         SzqZkJtNr+vPctEku2JQ4Xof0cM7f7xL+ujd5OQHPdQ5+tNwH8HelbtNwwksXRcPguQm
         Iq57lKxZyB9tWpilqu29YwFnKl4uBD31YkyM3jo3g5F96p+szu7MettjmWh2GzzVBla8
         h9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707870; x=1761312670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DUCXQ0EvV9ktxmOlNW52FjkhtUMF4mrPMo81WKGkY7k=;
        b=HRKirGdJ1/MX54PZAhjBdtsA4mnEDwhWy0R9g5u4Ss15Evi0RlnOc4RLUamrvkjBj1
         XEoQsrR96v6uTHR2kY318E4qrQaWtwJsjwZGCT4xKhO7VsAJb8Oqg65jRrtCZGchlJB/
         8wq4zlTX+KOa15o4+VKeAM7aq9UFi8slXsDOxMfjADbyRMZl7jeDkyNSJbT0XGsSnJIa
         uqKxsmYKKV+lBUiZrSjvLNATrbOU9CXIrb2genwxkdtvSw/iV010RjFdPCmzuceC0cID
         3WxV/l5n1slLWCJv339xtIzvQKsXNB+w3LBQO02rzFEOp2ID//0s8BVQC8Ixk2d1hv1W
         2aCg==
X-Forwarded-Encrypted: i=1; AJvYcCVdZb412uCyD3ZnTzy9ceKpNXxQrTD5h2pRMvyNyuqjg7rXKKTM6CuiRed/39hlYBk4he/WfKGLXgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqSjGiQcyyzExS40rM99QEpsK1unKSz4eJ8/kChczK7kRUUWxo
	ovF+FsovluGQ8+YRtICEf+GI5qTHu8JuwL3kQXCFGL/Hfg78zg5lsoidOFhs9bajD6fh3qRDEGV
	PVHm3VXbAED7J50tCnzK0wU06Pn1Sl5zNlys9uFBn0g==
X-Gm-Gg: ASbGncsaS9KpERJyDtUpyjAJJfeD/SM0OgrcZ+MXvSPgxnQEoHxLG0hNoc6z/qoLHQJ
	A5zXd5RHxke5MsqonFrn7+nhVWGpRdRiRO6D+Fy4NtzA4Kh1ZR2MqhY2ycpM0gYu8dQok6WYKvw
	EqxFUIH2e917eTDtdyHyiSNr+HVQUIIsIrkw6jUPwMX/dlmptFSjj17LN5KayiYpLiQK0lBEPQJ
	vQaYUrDW/+2SPxJWexDTNi7mbaduYwIFOpSLAGdSCQcItRfXHDb/AOzJzjJuYC9B3/vvJhc
X-Google-Smtp-Source: AGHT+IE99aLeU1qJuGUKKD3EwC+82B0WlUi+IrZYAAKOJ3BjaAC6xXwG/vSFF6c7L0L5r1xHD6BMxG1tEIJhEP9Q9Zs=
X-Received: by 2002:a05:690e:4009:b0:63e:17d8:d985 with SMTP id
 956f58d0204a3-63e17d8db6emr2723484d50.53.1760707869805; Fri, 17 Oct 2025
 06:31:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007140434.606051-1-kamal.dasu@broadcom.com>
In-Reply-To: <20251007140434.606051-1-kamal.dasu@broadcom.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:34 +0200
X-Gm-Features: AS18NWCxOo1IPoxvNmAyvX3kK0QzpALZz5b5Ua2IC_5KvIDu-uhmuTnAMYhlcsU
Message-ID: <CAPDyKFrsjnSYBTpPJ1qWXVHTZSw8EuQh6b_CcNAKuKHHMwy2MQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] sdhci-brcmstb SD host controller SoC specific enhancements
To: Kamal Dasu <kamal.dasu@broadcom.com>
Cc: andersson@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, florian.fainelli@broadcom.com, adrian.hunter@intel.com, 
	bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 16:04, Kamal Dasu <kamal.dasu@broadcom.com> wrote:
>
> sdhci-brcmstb HS200 configuration for BCM72116 and PM register save restore
> changes applicable to various SoCs.
>
> v2 changes:
>  - Separate commit for SDIO_CFG register defines that moved
>  - Implemented cosmetic changes proposed for initial change for :
>      "mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200"
>  - Moved BCM74371 support in a separate commit
>  - Implemented review comments and reorganized code for :
>      "mmc: sdhci-brcmstb: save and restore registers during PM"
>  - Added Reviewed-by and Acked-by tags wherever applicable
>
> Kamal Dasu (5):
>   dt-bindings: mmc: Add support for BCM72116 and BCM74371 SD host
>     controller
>   mmc: sdhci-brcmstb: move SDIO_CFG_CQ_CAPABILITY define
>   mmc: sdhci-brcmstb: clear CFG_OP_DLY when using HS200
>   mmc: sdhci-brcmstb: Add BCM74371 support
>   mmc: sdhci-brcmstb: save and restore registers during PM
>
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml      |   2 +
>  drivers/mmc/host/sdhci-brcmstb.c              | 154 +++++++++++++++++-
>  2 files changed, 147 insertions(+), 9 deletions(-)
>

The series applied for next, thanks!

Kind regards
Uffe
