Return-Path: <SRS0=nsF6=4U=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5FCC3F2D7
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Mar 2020 12:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230C12073B
	for <linux-mmc@archiver.kernel.org>; Tue,  3 Mar 2020 12:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="eD6WUTo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbgCCMsp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Mar 2020 07:48:45 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34875 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728692AbgCCMsp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Mar 2020 07:48:45 -0500
Received: by mail-lf1-f66.google.com with SMTP id z9so2643159lfa.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Mar 2020 04:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w73IegsGQMxPzttAxxqwMsTQbQuXMp1Diyi/iN+hCgo=;
        b=eD6WUTo0c4CLZZuLRpq8ZXQwIokHKpIu7lWM8Hq78ariHO5pJwTsIjAqK5eSONU9CO
         pNst3IBfa37I3IRpfC3A9XBLhi0bDkB7xl6Pbj40WJpMZPv+Vu3Ld0ry/AhaSoszK71P
         4jV1huqaNEscI4nnXj+fRwBqm0nh5uab6FrhTVjhATZbSQ89JC223R6hqF+6u0DI/wLa
         qHkdbnSFaDOHaEYvqTrInb/eVw/nFPaLIuN1yGT3Ww1ZHedulDLw4/nj0lp/d6kUelG0
         NtHSxxUepSaucK6PXS6dl5vCNh8RXhmKQM9PWclZmncY3NJ4TaeLIaKbqXp0lgtg08zJ
         BCow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w73IegsGQMxPzttAxxqwMsTQbQuXMp1Diyi/iN+hCgo=;
        b=p7hdGF07QfzxXfX+gYRg5B42WE8G/9da4BID6ia2KbbUPbYki9YuJFZxBpFggmw1yA
         Kl5WcbDrJ18TtW64sMbi1n9/ZVu/+blGJgF9gIUmLb1l8cmxDndktaJSEOdLWNsUqBM0
         8jaPqLIWMhxhHpDAJUrZuWncypXjMTZ2G54dVQ1yjBDNS9PFHezlvXlUiY8oZh7aMieX
         IQhXeiITCChp6dhmLE8sNJm3wNrzjk7EztpNj0Z4DRf84EkOoyiIBA3PILcJOLydA/TL
         QgUEXGs/az2+N7cRoL0uc/9WE4Zjb7WNyVX2UEIumtNewOD8aoLPashNW/ju5x58wWy7
         ix5Q==
X-Gm-Message-State: ANhLgQ1upaCq8QfUWj6FrRSJseEZ9ypIc/UA2wbkZk0vwg/GDOEOWQSU
        NRdFHuqsIpzMXeuNEA4kAeH1zg==
X-Google-Smtp-Source: ADFU+vvCQvvFvxgeBk/FTp2hpq/O22jbIxfrfh2HTWtMkV4WCowsyp0lIkQj/9kxskL9iWz1l3IkIg==
X-Received: by 2002:a05:6512:1116:: with SMTP id l22mr2706727lfg.70.1583239723564;
        Tue, 03 Mar 2020 04:48:43 -0800 (PST)
Received: from localhost (h-200-138.A463.priv.bahnhof.se. [176.10.200.138])
        by smtp.gmail.com with ESMTPSA id h23sm844344lji.90.2020.03.03.04.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 04:48:42 -0800 (PST)
Date:   Tue, 3 Mar 2020 13:48:42 +0100
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] mmc: renesas_sdhi: Use BITS_PER_LONG helper
Message-ID: <20200303124842.GB571445@oden.dyn.berto.se>
References: <20200302093534.9055-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200302093534.9055-1-geert+renesas@glider.be>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Geert,

Thanks for your work.

On 2020-03-02 10:35:34 +0100, Geert Uytterhoeven wrote:
> Use the existing BITS_PER_LONG helper definition instead of calculating
> this value.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> ---
>  drivers/mmc/host/renesas_sdhi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
> index 7a1a741547f25de5..2a4c83a5f32ef8e2 100644
> --- a/drivers/mmc/host/renesas_sdhi.h
> +++ b/drivers/mmc/host/renesas_sdhi.h
> @@ -60,7 +60,7 @@ struct renesas_sdhi {
>  	bool doing_tune;
>  
>  	/* Tuning values: 1 for success, 0 for failure */
> -	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
> +	DECLARE_BITMAP(taps, BITS_PER_LONG);
>  	unsigned int tap_num;
>  	unsigned long tap_set;
>  };
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
