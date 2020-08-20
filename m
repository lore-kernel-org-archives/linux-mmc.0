Return-Path: <SRS0=808J=B6=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948EFC433E3
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 06:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7491E20738
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Aug 2020 06:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="rRR85o34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgHTG41 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgHTG40 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Aug 2020 02:56:26 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3926DC061383
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 23:56:25 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v9so923123ljk.6
        for <linux-mmc@vger.kernel.org>; Wed, 19 Aug 2020 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sW5c87vJpt7NYkvzxgQbaQlu5yA0lKJzBLThzmHot1g=;
        b=rRR85o34aUvwwsOGpa0sIUSTB/03pYnS8DL9MBGX9DGEup9lJSCwgSzcYsU2M/gLkQ
         H3UZmqA7LZ/6dBELfMF8Vr0iizNlEwe5frLPx6woZM50ebc87FVQ8aeDc5T/loTqLlcC
         y0XFbxiVsEeSbccB/Disw7amvu7S5jXk/0aeDlrNikE7pmisn8QwGDxfTiXneI+0bZc1
         tGrjtjKZ/PqiHnniQUnESimQVx10Du8BM1fxNTy9axn9At8ecIAJnw/wQX3mAR48IvzQ
         vuiLLEcBK1YjeBit5S90We/v2yVjfh30RhMEXTTbLHUzZbRjVneg2HHQqSAkkCWPTQLh
         FhSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sW5c87vJpt7NYkvzxgQbaQlu5yA0lKJzBLThzmHot1g=;
        b=skequxeUml9xDyzKF/dguuxFiJ5eKCzEQw3QL3Hv7NQ0AOtojLwta+CXjKnJ1HhyH0
         vMQQiCtQdn3SSNbqPm4vhlOMDxa27IGfS430aLKG55GpUx94RzG+K1IC4Udhc5SYIKnL
         DuLfHLzvpG90kO5G5Ya5sA/pYz+fHBdrRhq620C+H9q2jTeYezQ0O0m0K7hRS7UbpY15
         iPjJKwwoKknvGBhn2WD/dT1/ktTdCCH9YetK1H9JHCsDRSsjTpCoJwlSEPhkHkh2yZGv
         w3NJsys3HXMUkdscNKptuTPSVNVnfd+GPWzJNjF2MZyUXX7gdAise4drOVSz28dn9uFC
         gwSw==
X-Gm-Message-State: AOAM53320qKQ0GYgd+l7G02FJEiUA7x8gI9occvPA8kpRUtn+g5wOmWW
        r9hCOe+1K83348lXF2RgfxGmmA==
X-Google-Smtp-Source: ABdhPJyuJz2UQzfs+luVy8+cq7KvJ+WJvlablTkxOWtZo6Q0UxxVG+0hgBnjLvOFcdmigkiZr0akeQ==
X-Received: by 2002:a2e:9bc6:: with SMTP id w6mr901696ljj.404.1597906583021;
        Wed, 19 Aug 2020 23:56:23 -0700 (PDT)
Received: from localhost (host-78-79-224-122.mobileonline.telia.com. [78.79.224.122])
        by smtp.gmail.com with ESMTPSA id e14sm256430ljj.120.2020.08.19.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 23:56:22 -0700 (PDT)
Date:   Thu, 20 Aug 2020 08:56:20 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Wolfram Sang <wsa@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: Re: [PATCH] mmc: test: remove ambiguity in test description
Message-ID: <20200820065620.GA39265@wyvern>
References: <20200817115838.2981-1-wsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200817115838.2981-1-wsa@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for your work.

On 2020-08-17 13:58:38 +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> When reading the test description, I thought a correction of the
> xfer_size was tested, which is not the case. It is tested that the
> xfer_size is correct. Use 'proper xfer_size' to remove this ambiguity.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

For what it's worth,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
> 
> This may be bike-shedding and I am not offended if you think it is
> minor. However, I ended up looking at the source wondering where is what
> automatically corrected.
> 
>  drivers/mmc/core/mmc_test.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
> index c21b3cb71775..152e7525ed33 100644
> --- a/drivers/mmc/core/mmc_test.c
> +++ b/drivers/mmc/core/mmc_test.c
> @@ -2669,22 +2669,22 @@ static const struct mmc_test_case mmc_test_cases[] = {
>  	},
>  
>  	{
> -		.name = "Correct xfer_size at write (start failure)",
> +		.name = "Proper xfer_size at write (start failure)",
>  		.run = mmc_test_xfersize_write,
>  	},
>  
>  	{
> -		.name = "Correct xfer_size at read (start failure)",
> +		.name = "Proper xfer_size at read (start failure)",
>  		.run = mmc_test_xfersize_read,
>  	},
>  
>  	{
> -		.name = "Correct xfer_size at write (midway failure)",
> +		.name = "Proper xfer_size at write (midway failure)",
>  		.run = mmc_test_multi_xfersize_write,
>  	},
>  
>  	{
> -		.name = "Correct xfer_size at read (midway failure)",
> +		.name = "Proper xfer_size at read (midway failure)",
>  		.run = mmc_test_multi_xfersize_read,
>  	},
>  
> -- 
> 2.20.1
> 

-- 
Regards,
Niklas Söderlund
