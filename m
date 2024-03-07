Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709F91E897
	for <linux-mmc@vger.kernel.org>; Thu,  7 Mar 2024 15:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709823705; cv=none; b=ZZga9MQMtjpBqTMwqg3BlBrcK56XVjmRhv8FFje2IH7a8jC3plVMl3eEX29od1t9YbfL7531B+10DIUMDLu0fbyKHmQ8XK11ElwJGvdBr2ODFKCG7TG9wDtoUhftttE21oaVgQj2Oaup03S6O2qruCh9Fk3h63DBmXeH+0RLSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709823705; c=relaxed/simple;
	bh=ipDoqaGJry8XFBbFQETVEMjCjvVX2Nh/sKemer023uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja9lZOMtiQb4JhvTnGsAQhL7f0D5D6rL6ZG8MOtFcE9iCWYKQGg5zPT4xXKnep05vUh2q/SXynSz9a9TsRI58gJEF2eA7eitpiJhKM8C1KJHcMeq4Yv7ft94v5EiAmwuDHB2kpTeH2ZF5LLm13M0h8XHpSNGr4QaAwJYYp2Ju84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oVfDVpD2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oVfDVpD2"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412ed3f1e3fso8268565e9.0
        for <linux-mmc@vger.kernel.org>; Thu, 07 Mar 2024 07:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709823701; x=1710428501; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BOmqNU1lRIv+DURE4y+VSSKM4JviZ9Mjbtz+cTDb3pQ=;
        b=oVfDVpD2rEQcNN+t1VExQRRMXde6sCLxfdQiGKZcaNkRFCwS+mUYEOiuHxEf89vQwN
         0rnqYvoDVqIDtQ9rIeVSw164hEIkTEgvpy6TMNIuJGKvbMZnHx+4XFcizLvCkomh7/LQ
         KKzcZiNzu8V1VbiEwt+s4iSLKBftUzIGw5JSHxBdRAybgAPwDrxnJTN7cfytX5aXEnmc
         IjX2tm0rAUz2dBp3MGg75khgVoo7iN7lAiq/4FS8mx06XBPW3hehhCxuzZv0+JOaWtwG
         SjXQOuXMnZL6PQuzpTaIrJjUdZwcCISmRxrkgY62RrGCEt1BzagDq3DAFC2RI+jBBHZL
         peoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709823701; x=1710428501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOmqNU1lRIv+DURE4y+VSSKM4JviZ9Mjbtz+cTDb3pQ=;
        b=LfXp+r1m11kdfOvlsdqD0/jhONNbMy4y1UZk3ziZuo+/elM/0FLYOL+xzFcRW7bnlb
         yRhMXoozwo46ew/bPRXYueWfGDnMyE8hVGH2SGh9m3YJARf5TvSn8dca+StDjyTKXlFr
         w0T8q0aBf1gk6QeFaKWO4yQfq7Hn0i+d13Cytg2GLs2hPu5Sfuy+y4fRn5hiW+PBDgY3
         W/tgOTOeHlWf21PXxn/wG9CIzEvCPNGb9mxhLAREKt/8ivVcGyLUSZmgtk6xIfTVcRlS
         Xpbw8+5BJQaTRuNRp9Gs7tgqWNRvOvMoIFF65kE4eOwHp2lBSBGLO7I5+HRaph89rdkU
         P3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9T8+FpaQ4KzWCTb+gZ5vGYkSBk7g+YGhU2EjsaKZWI7kyUWa5mahpWZXrzZA6J+yltySWTMNC2rJD9AwTh3AkUIHx4whR4YV5
X-Gm-Message-State: AOJu0YwQ+w0VtQYIO2rMYKB7H2ZUYhlqiHXPZIXWLTPyX67cmyX2U6bn
	cx6p4JZCDu05uC+eA9RXFriyjsd3L4OyzKDN+37cjm2MNFP8Q6XepsTQ43/no/U=
X-Google-Smtp-Source: AGHT+IFXXvFEdnuCc608hqNnc23woWbYxgaTjHYOVLDkcJ3Xj6RdzH1iq7gCWqRkt07ORdYnLKUfuw==
X-Received: by 2002:a05:6000:11ce:b0:33d:a011:ae42 with SMTP id i14-20020a05600011ce00b0033da011ae42mr13601493wrx.38.1709823700652;
        Thu, 07 Mar 2024 07:01:40 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cl5-20020a5d5f05000000b0033ce727e728sm8175322wrb.94.2024.03.07.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:01:40 -0800 (PST)
Date: Thu, 7 Mar 2024 18:01:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Yang Xiwen <forbidden405@outlook.com>, kernel@collabora.com,
	kernel-janitors@vger.kernel.org, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: remove unneeded assignment
Message-ID: <e34b5334-48c3-4ebd-9a1a-7ea26899d304@moroto.mountain>
References: <20240307122129.2359553-1-usama.anjum@collabora.com>
 <SEZPR06MB69597EEFAB2F77049E9B257296202@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <8cf4333a-b500-4fb7-8176-734fdc892da4@collabora.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8cf4333a-b500-4fb7-8176-734fdc892da4@collabora.com>

On Thu, Mar 07, 2024 at 07:51:37PM +0500, Muhammad Usama Anjum wrote:
> On 3/7/24 5:22 PM, Yang Xiwen wrote:
> > On 3/7/2024 8:21 PM, Muhammad Usama Anjum wrote:
> >> The err is being set to 0 and replaced every time after this
> >> assignment. Remove this assignment as it is extraneous.
> >>
> >> Fixes: 25d043841db1 ("mmc: dw_mmc: add support for hi3798mv200")
> >> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> >> ---
> >>   drivers/mmc/host/dw_mmc-hi3798mv200.c | 1 -
> >>   1 file changed, 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> >> b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> >> index 989ae8dda7228..96af693e3e37c 100644
> >> --- a/drivers/mmc/host/dw_mmc-hi3798mv200.c
> >> +++ b/drivers/mmc/host/dw_mmc-hi3798mv200.c
> >> @@ -133,7 +133,6 @@ static int
> >> dw_mci_hi3798mv200_execute_tuning_mix_mode(struct dw_mci_slot *slot,
> >>               goto tuning_out;
> >>             prev_err = err;
> >> -        err = 0;
> > 
> > 
> > Same for dw_mmc-hi3798cv200.c, maybe fix it as well?
> Sent separately as different Fixes tag is required for that:
> https://lore.kernel.org/all/20240307145013.2721326-1-usama.anjum@collabora.com
> 

The subjects are identical though.

regards,
dan carpenter

