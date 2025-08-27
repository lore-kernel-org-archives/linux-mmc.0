Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2593234A30A
	for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299667; cv=none; b=o5uwmI9hcpJFQneN4QRC1cHq6hf1zrsp3/VAneTZ/E7GrzyKsY92h3luji2/sJ4LDPZ0YUuLzu+rm3THhftGwzKJFdir8RxMQULR5kC/VLNx/8s/AGErQdjki3sQvZ/XSsfaCRePJr22QZK6XyJntXCDeDBX5p5qwuG7Ybwoepg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299667; c=relaxed/simple;
	bh=hxB5lyREhdgbUBcOx3UJyF20LvnlKY+cAGXFsyaLqBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfaYwVmB8oeGUkoWrrWv0n8NBTtL+mVn1/bB3rFlWbUPvAiaFnZdmJaXDBy3cQej3636C5lixV6Ggqq1GNJGnViQUB3WRkrMPvTMyArRMSRUifXsnHrer1UczUHnQm1sUe4ghNjcWOdZxV3Zz64VO86sqxVqnWjYCJJKyHnZZwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b9jrQ/bv; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9jrQ/bv"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45a1b004954so54059295e9.0
        for <linux-mmc@vger.kernel.org>; Wed, 27 Aug 2025 06:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299663; x=1756904463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HR0ZA4NZ0E17Q0Z6+d0qJgv1KmpugOB/InPQaoD7lOo=;
        b=b9jrQ/bvqyUhmac0mgQrgGlpMaYtG4ugRVamMtBvKByrnA1PBn3AZWIBZFelvmDVHP
         8OY2ppJ71PmEcumpolpIunrlPOFHmo6OTUskP13osQtc1bksVjIxbn04OY7Gvf6HOAnI
         BuFaL7t9XbWwKqNdlUVLFLJMQxMkY0meEkHNhhG1ZlZL8y2p69WOqEmvbAWUuAePt7ms
         vzQettJ+WJBj54FjXnXTDzlSiTinUz0suXtx5cMtH/QgS+cEEBasmJd1lBrBDM1G859m
         nP+LXn6ROH8f2B3522nVzbxjK2rBR+2p4u5T0S9Yw4VWk2ar34fhORYuTnST25FOZ4RA
         Ng2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299663; x=1756904463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HR0ZA4NZ0E17Q0Z6+d0qJgv1KmpugOB/InPQaoD7lOo=;
        b=d2Jz3IJW6iiKg/kU5MzxysJxWtP5qlDlUaBR9XsHOSLphijeN1mieKmOx23hkc5R9d
         OCVfRoquSRvnmqdXFq+oYT5lFbDQzoVc+ad7MHRz9zqdomjDC623oxsK9so4ggULMck6
         Mpy/bR1WJtsDifCiAqnew+aXwDzy1mvVmyD8YGn163rYOu63nRkB6qsyFdD/C8ByCUzZ
         7CV3g9Pzz2xwMMm1mNxbokVFXiVEx7PGcMgspHSgJvN7swZ8jYKxa/3oRP3igodl2Y4D
         /T3ILrMzRpCCbDI713FhQ9776ZUiDwhQ87xiCzF/TrKpwi9PR3fhPfV1YOTHaNiMcL+O
         gQOg==
X-Forwarded-Encrypted: i=1; AJvYcCV49UTnOPeEQpH+PT0oK1lmBBMLmq6iv5OK+lrZl+7XL18dKArvsExY0XnTPEm2OqyM3xO+11V91us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbDdXX/FFNVfjYZPOjSejqN5WMmICu0IWvKDQ7dAXqCfYFvmv5
	A2M8zi/H4PoT9JG5vAp89ozXe10yx5X5iwGgGauGgxKiJaTh65Qtr79XW0aa/chwjic=
X-Gm-Gg: ASbGncvhlWaTjzy1CpqZ3u/B4e6x44H5LkGHt7tqyVSzIVQhHB3Ot9Dol0VpCeWxagy
	JaQg8aY86P3ayxphJiZg2YAWsyoD499ANB8jVSeaf0p2Jg97oBXBE0G/4VkLI5gyLh+FUuefH+j
	epjmyUa41d031pyUoZfd715uFVv1zerB9IeZ01RJmbIjPFInXxKlw4uo2x0p4Wm6jvpwnms8cxd
	S9DBKIimPfd2MEazSRfGsPRSqHhV/xHMUhhPNUaVKdhzYcxnUIf4/yq/jzxpkeRut2E+RA6UoJ7
	igY85FpT0EPyD+lQ+dd48tW8QJ3dC3Cmz315XPkdT3Vl4mAmICQlK+huN9CljImQCxjBAXrEnWz
	8y98CH3oV96sEhphkY6E8hGF6uQ6ORbpq9gMMtg==
X-Google-Smtp-Source: AGHT+IF1J878zuA2zsA2LZmjU+Nf3PbWC4scoCL4N2DKNTYWqSPUxijVodiq3E9n32T4M+Wmjv6xGg==
X-Received: by 2002:a05:600c:3b0c:b0:458:a7fa:2120 with SMTP id 5b1f17b1804b1-45b517d2668mr180851495e9.25.1756299662976;
        Wed, 27 Aug 2025 06:01:02 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b6f2eab0csm29733035e9.20.2025.08.27.06.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 06:01:02 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:00:59 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Liao Yuanhong <liaoyuanhong@vivo.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Ricky Wu <ricky_wu@realtek.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mmc: rtsx_usb_sdmmc: Remove redundant ternary
 operators
Message-ID: <aK8Bi0yIMW8-yb_n@stanley.mountain>
References: <20250827093530.416071-1-liaoyuanhong@vivo.com>
 <20250827093530.416071-3-liaoyuanhong@vivo.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827093530.416071-3-liaoyuanhong@vivo.com>

On Wed, Aug 27, 2025 at 05:35:26PM +0800, Liao Yuanhong wrote:
> Remove redundant ternary operators to clean up the code.
> 
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/mmc/host/rtsx_usb_sdmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
> index 84674659a84d..97bc3a2e3cca 100644
> --- a/drivers/mmc/host/rtsx_usb_sdmmc.c
> +++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
> @@ -1169,7 +1169,7 @@ static void sdmmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>  		break;
>  	}
>  
> -	host->initial_mode = (ios->clock <= 1000000) ? true : false;
> +	host->initial_mode = ios->clock <= 1000000;

This is more minimalist, but is it really more readable?  All the
"redundant" bits are deliberate visual clues that this is a condition.
Probably the most readable thing is to just make it an if statement:

	if (ios->clock <= 1000000)
		host->initial_mode = true;
	else
		host->initial_mode = false;

I don't really have strong feelings either way...

regards,
dan carpenter

