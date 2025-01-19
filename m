Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5C1DF964
	for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737305992; cv=none; b=u4xsB0oex+5/KkwMVGOmgTkbEjv8ZCB4g0c/kt7+5i0T8j9vV4NU2oce7pWMEiCQkC9XDFbq6Xp+U2MhFlFfbTcOJ63IMAnewLJKrm2zyNd7DFi+799UrmpPLcO+fThzxo9t0gvvW8ga1i7jQOEFcjegNdEYKij3TdUlC2mWOmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737305992; c=relaxed/simple;
	bh=moQ4Sx1R9uDF15Ros1s1+SmGuBjFhQZ7Ns8wG2ntmxU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6OsygO/uhEr69ys90O7JktVV/4hKlUzzlv6p1zooqZN+9KDSK2PgDiIsYREq2uoe9L6h1nXZrZDnqkK6qwn31KPBQTaO59jxoS+S10cFsNJHNB6e2ZTwHaB+QyMRZmJYDY/8JSSKoFHGWFcgaaWVx+St/uO5HkzMkiAOJ7FWGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NKaV1550; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NKaV1550"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so36499485e9.3
        for <linux-mmc@vger.kernel.org>; Sun, 19 Jan 2025 08:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737305989; x=1737910789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gU2K4r4ZzM/BRR+Tyo710S/yU02b9d5jbFwsNMfd6eQ=;
        b=NKaV1550pNQjUbFDK6asjoj7qqXbwZ3MOAucx0FuXEkIQHLix1SuyidZnP9cjtrque
         URgsqlqYkf/SXwhMB6xyf9d5eHop8jgyWcoy3+Fhk7Xur2023UBq1nfQOrKRkbVOdYN3
         3Hd5tkWS8rFwkdlF8ndBkURsYNlFqRtjWJfgHd0nCFLnjhT3gTLZ4Z4UWrKaZP7qJa/z
         98r6SruD/3BuHT76vhsgUzGEZR0k9zysLqM6TRWOC/w2CkcEAexcS1DLVZdFZaM0Jfhx
         KIzMIv7FK4tE/DcDd8VzuAc1Rhs+MJTFAOMZWFAnUmg5jo3nSXjh4UEKRdZLqDac09ly
         nNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737305989; x=1737910789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU2K4r4ZzM/BRR+Tyo710S/yU02b9d5jbFwsNMfd6eQ=;
        b=rnIASlczb2BX0UdeAKNKxSrQm6ISv86FMqXkcRrJ33kN7U3GQV2LiGL9YjtMi85h0P
         KgSMwM6sZFiWSTQOqK77HO1StF62NAJUGJ9+H7IFTLHsQyZeYRcgtF8ijn4885ZF2zgz
         jQ2xvzhIX2QsIQGefjFb/fmzc6htdm41zXph1S9dH28+lmLKPz62hkKqkfAAmS0oItX3
         xeCxBmimJhbZRHz+HxLSaq5if5eN0Pw2T3Z0vYnj94ITS50nWbjhFTjxlCzjZG74HgYm
         ZURBupRqPvgvq764MBb+id9XFd6kMwAVz3ikUwXEYPDwCytLNs0RsAjW2d0GR1+QYL3j
         vLxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXc+FM9bAwdkhZLFZzszvulhzvAwoMj8ZWQZ2s+JDFIv+0peW87LrqeszMxGZqdRX7tADU32I80Qt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOMR/NkzA908/BL9JFnudmmPqL1I/I+VPaByj5J6RHV1viD4b
	sPAJYt3Si4KNi5NBQLyZAdrdrGuIXeprERk3aNc2dszXHepm7BUyUvFOcDvmKj0=
X-Gm-Gg: ASbGncu8a2zloCJHcFb07i2nKB5an5Vk6dSEvNV7G8BpxUqaKNNiqAcbwWhTwUu0peK
	ckwbeqcplOtd7dcf71ec18k2DAr1HjunA3FtDGA/SVz8Qvuoaq8QTG5PjAM1sc35XiOOFuyd34f
	9TiPVLZwF6wee1hormOLXI6R3L3r7iZcf6nVtYdBRs6GjQW1khmOHNwTNbBNMbd3g9DJhgjYG7b
	8C5ajKhQtU/ZsJ2YojtnJ3vLnIRlEye82p1l4/CcMNXYgBrRxfLZeILS7I7UTlg7noV
X-Google-Smtp-Source: AGHT+IGecv9i+IP+93WZa2OpzfUcrFBdgsvIOe06ZTegWk6SGd3ckOy9AuooWsDdbYCE9mFC7/pmGQ==
X-Received: by 2002:a05:600c:4510:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-4389144f671mr88149435e9.27.1737305989481;
        Sun, 19 Jan 2025 08:59:49 -0800 (PST)
Received: from linaro.org ([86.123.96.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3221b5asm7939547f8f.21.2025.01.19.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 08:59:48 -0800 (PST)
Date: Sun, 19 Jan 2025 18:59:47 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Eric Biggers <ebiggers@google.com>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-scsi@vger.kernel.org, andre.draszik@linaro.org,
	peter.griffin@linaro.org, willmcvicker@google.com,
	kernel-team@android.com, stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 2/4] mmc: sdhci-msm: fix dev reference leaked through
 of_qcom_ice_get
Message-ID: <Z40vg9CZQ60HRBoa@linaro.org>
References: <20250117-qcom-ice-fix-dev-leak-v2-0-1ffa5b6884cb@linaro.org>
 <20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117-qcom-ice-fix-dev-leak-v2-2-1ffa5b6884cb@linaro.org>

On 25-01-17 14:18:51, Tudor Ambarus wrote:
> The driver leaks the device reference taken with
> of_find_device_by_node(). Fix the leak by using devm_of_qcom_ice_get().
> 
> Fixes: c7eed31e235c ("mmc: sdhci-msm: Switch to the new ICE API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/mmc/host/sdhci-msm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4610f067faca..559ea5af27f2 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1824,7 +1824,7 @@ static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
>  	if (!(cqhci_readl(cq_host, CQHCI_CAP) & CQHCI_CAP_CS))
>  		return 0;
>  
> -	ice = of_qcom_ice_get(dev);
> +	ice = devm_of_qcom_ice_get(dev);
>  	if (ice == ERR_PTR(-EOPNOTSUPP)) {
>  		dev_warn(dev, "Disabling inline encryption support\n");
>  		ice = NULL;
> 
> -- 
> 2.48.0.rc2.279.g1de40edade-goog
> 
