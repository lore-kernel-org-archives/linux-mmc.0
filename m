Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B562E03FB
	for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755686598; cv=none; b=SHAzSzlD57rM1P3rpqvusu/GrmTD35DgDoQOPNMEHnXUHZ31WTsSCIn+haLQH721t+S3nV4BDeWDqYp7v6KrmZoYD5PCTNSs1ofNP1362qsGEeyFBXBpxdJEmRkb+rGucy6YPXZ4NQ7T50ZkkAQRgQ7Koi9IgxrUPToluCLAaW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755686598; c=relaxed/simple;
	bh=Y17Rj5E/GRtenqS3b5BfPh0zb3y9f6UoHKe5XhkCVjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvJMta2eYwMRUKKOTv8N9oaOox5G1oPVCCKDWiP0T3Is/elKGNLQ1OTlvr5sEiVymx8WYy9ccga3aDmOL8Vd3hViglkYD81Cianh9hnBiCha/+sKfmxwfnwzJIClXQIR08ewCX41lH+fOZRxdnXfvZthmct+LOGewBXv1QKN10Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M06LK0K0; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M06LK0K0"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9dc5cd4cbso4370952f8f.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 Aug 2025 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755686594; x=1756291394; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6JbHXLCu1gk8Hmp+tYteMxiM391FXMH8MSo5yWpG5E=;
        b=M06LK0K0h7jIhLabCfRCiJF+l45uvu6MWI5UA3Bds7a+K99SfdG3c4hJPMjM0hQmNu
         ujqqPIZ+cMc2zinAIWx6VIHkPGGiM7FFCEPd3aLQRx6a6/znBhYlu8MrOg/atpnF7xlQ
         nnzo5mP4KA+UNFLcJOW9Cr8oz974ZqeCv6XVV+MoTjSdC4a0PzYJ7VqCe+O4eWQ2xC3n
         oTbn7pb8JbgGt4Wrz5XtPNhzPLSd04/Dy7LeyJq36pbJRmJt6t5G0+3u/V0+zWAZWQKL
         IERl1OTtxVoJxI3DEg6PhmVDCybnwI3M5/Yqtm+lpBIfvD+dbLQsilGFHy44mwgF2SHU
         Bi7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755686594; x=1756291394;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6JbHXLCu1gk8Hmp+tYteMxiM391FXMH8MSo5yWpG5E=;
        b=kh8HCsiRVzq2prU4nT+o2hwuPpjvQorZUBUkJQqmcCVzO1Kud//O0yZlC9qnZf3QXL
         xtQ3Gin1rMGZynOfWxDUhF2RuzjZcR9SpUc47nU6Cb4CWtrdzB+OH33/RSbZ8N0vV+fn
         NRSJjtD56ccmybp5F2CnOfmohXopkltR5qqyODR04bMj4o2mg42tlBzNtYNOfpe/fslb
         r90MWMi9BTz5r9cy2JzXit9Oe29SO6SA29OtxVUtJHVgTZ+uYOqz9uw8w/7U43oJZNlj
         JsMM01rt2HFK8c8e5WoiGkBUjLZ4+7SSSQ0neCsySfqlbyEoHEAGqIGEnMUap/0ZZLPh
         lUzg==
X-Forwarded-Encrypted: i=1; AJvYcCVoHNCmNlq7t0XdLoMPDebpjgbiYXA+IBI7+4H2b0mDGq+JC8fDzl52vdnpYki54h1nNhbGHJgJ1zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzoz3XFSVQlFiYTxOOOXcWOF4iGTc47k1za48BAxtD8+ir6abL9
	7rJ/gzaOVX8Q8jXcJPZ4RjIfBaTBZbqFvATLUHeTGNfiFvdcRsq+umnJd5P5Ij5LpCk=
X-Gm-Gg: ASbGncvrFjWkbFhH5juofx3COcfXiQEox91X1EyXUrn62C+DxoNVErNrpbwYz92VSU1
	CdmXfsByCyCWGlgyJzagI8ICKTkZc7fR3r4/vOH7a3WSnAz4dtrRE5tDdZmccV4RZJYU5B/sqVN
	4gtt50yv7N8sgbNvTWBiDXPEp2AZjG0Gu0lXZg1qilCoMYouZIQJSbBHUKBgFfmVTe/o4ptPmQx
	nJZkUdpDXC/8gFzurBEIAb0p15x4Bm/qj90s6UJmFr/aNqVAHADDepGB5SR77IsE6/KFvI+Mjvo
	z9XAwJzs6AftLfqdn92mY16a2AS3mgrUXyxJaJSI/9o69UPlpuVqhRuXosOrSb0Y733E2ZgpLP9
	miIhrqYZDZaJj74vdV8fyk9UxAxBXxIpj2N7yY4V0WbM=
X-Google-Smtp-Source: AGHT+IFfThC5sQ086sb4zojIb5S4YMtFRvJBKvING/uRhqmvc617M0JjqPhE3vfuS8adHjIcpEJ+Qw==
X-Received: by 2002:a05:6000:4210:b0:3b7:99a8:bd10 with SMTP id ffacd0b85a97d-3c32e606ce1mr1724387f8f.42.1755686593663;
        Wed, 20 Aug 2025 03:43:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c0748797a1sm6893279f8f.5.2025.08.20.03.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 03:43:13 -0700 (PDT)
Date: Wed, 20 Aug 2025 13:43:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: =?iso-8859-1?Q?Beno=EEt?= Monin <benoit.monin@bootlin.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	llvm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH] mmc: sdhci-cadence: Fix -Wuninitialized in
 sdhci_cdns_tune_blkgap()
Message-ID: <aKWmvWTtQ_QZYgEm@stanley.mountain>
References: <20250819-mmc-sdhci-cadence-fix-uninit-hrs37_mode-v1-1-94aa2d0c438a@kernel.org>
 <2560300.XAFRqVoOGU@benoit.monin>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2560300.XAFRqVoOGU@benoit.monin>

On Wed, Aug 20, 2025 at 10:07:35AM +0200, Benoît Monin wrote:
> > --- a/drivers/mmc/host/sdhci-cadence.c
> > +++ b/drivers/mmc/host/sdhci-cadence.c
> > @@ -288,13 +288,12 @@ static int sdhci_cdns_tune_blkgap(struct mmc_host *mmc)
> >  	void __iomem *hrs38_reg = priv->hrs_addr + SDHCI_CDNS_HRS38;
> >  	int ret;
> >  	u32 gap;
> > -	u32 hrs37_mode;
> >  
> >  	/* Currently only needed in HS200 mode */
> >  	if (host->timing != MMC_TIMING_MMC_HS200)
> >  		return 0;
> >  
> > -	writel(hrs37_mode, hrs37_reg);
> > +	writel(SDHCI_CDNS_HRS37_MODE_MMC_HS200, hrs37_reg);
> >  
> >  	for (gap = 0; gap <= SDHCI_CDNS_HRS38_BLKGAP_MAX; gap++) {
> >  		writel(gap, hrs38_reg);
> > 
> Thanks for the catch!
> 
> I don't get how gcc does not raise a warning here, only clang does. I
> did build with gcc-11 and gcc-15 and they don't complain about this
> uninitialized variable.
> 

We disabled uninitialized variable checking on GCC.  It was too crazy
and especially if we want to use -Werror.

Smatch also detects this bug.

regards,
dan carpenter
