Return-Path: <SRS0=lwnd=CM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D11DFC433E2
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C5520C56
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151715;
	bh=80rixeqGoQEhzSDPdDtUk/bb0DY8XRaKZ52bzlpzygc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PJbZRog9F5VFsbK16BOlsg9Q6HYoiRsrfOyvCQNJpCL/ji8Qyjoaheg17dxGpt5DA
	 QzyZX5sZIVNSFXa+H+wFOuJUuV5/GmGNzEBzBmFbzdce6qJPCZujizxMevLMsyqpRU
	 FOcfj9ht0OsvzuaGuj9IdjjSFBLRaLmOYKSozZaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgICQse (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:48:34 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:36356 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgICQsd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Sep 2020 12:48:33 -0400
Received: by mail-il1-f194.google.com with SMTP id p13so3341396ils.3;
        Thu, 03 Sep 2020 09:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNiY/DRiWacF6OHUlQxLTfybQn0rSJdq/hYWpwjpp+E=;
        b=XWcz/KXQbVFvHtlfdYeMLDFPSiyWxx5oP4HU4Lz6oKHyjTVXbQuhtxhbjMsh6FvfCw
         dkVEf7SIMka81veHqoHk5G9DvUtucjnOlfUNVbrzHXVnX3EV4djt+H6DopxIct3x4gXE
         Os228gY064JA+L8ikgwvGKCsxxR2di+nVHG7POK7ttdc0uh6mSNC1G9ox4I36g1XteXQ
         St6uPUUWzctpySJRiZRy15a/a6/KmyqXmBmXX7g3mNrOo8yOw+TEwR9zOFVrbY0pGv+z
         VXFnvHeNV/LQQFvhwlEIMtOKlNV8c3bKJJbZJ3QrII8ptv6+nlXxO+oMt4PzaY0QI6cy
         yllA==
X-Gm-Message-State: AOAM531lf7TcEs+OEJMvpN6FA9jNAgp5golKMyMG016NdUhZHhqf3hTg
        SFLKMyrtLyDXo3mbgb2JYQ==
X-Google-Smtp-Source: ABdhPJzfeYI0FvdZ6FUCCDA/wrEom4N9g3CW9CGIw27/5bR3r6kw60a9A1utzg6FizD3GqotnilFSg==
X-Received: by 2002:a92:c605:: with SMTP id p5mr3988425ilm.194.1599151712621;
        Thu, 03 Sep 2020 09:48:32 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m87sm1763596ilb.58.2020.09.03.09.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:48:32 -0700 (PDT)
Received: (nullmailer pid 2932708 invoked by uid 1000);
        Thu, 03 Sep 2020 16:48:31 -0000
Date:   Thu, 3 Sep 2020 10:48:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: google,cros-ec: Use
 unevaluatedProperties
Message-ID: <20200903164831.GA2932271@bogus>
References: <20200831161147.13515-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831161147.13515-1-krzk@kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Aug 31, 2020 at 06:11:46PM +0200, Krzysztof Kozlowski wrote:
> Additional properties or nodes actually might appear (e.g. wakeup) so
> use unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos5250-snow.dt.yaml: embedded-controller@1e:
>     'keyboard-controller', 'wakeup-source' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. See https://lore.kernel.org/r/CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com/
