Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E601FC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 18 May 2021 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F5561261
	for <linux-mmc@archiver.kernel.org>; Tue, 18 May 2021 14:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344223AbhERORw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 May 2021 10:17:52 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36798 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbhERORv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 May 2021 10:17:51 -0400
Received: by mail-oi1-f173.google.com with SMTP id f184so9913182oig.3;
        Tue, 18 May 2021 07:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ApdT2ZVeO/Dre6C+tPn+oiUE2pUa+eU6zxwzAzRnwbQ=;
        b=WBxUBI0FQ6wTcFNmlk9nhRwNjAjVe2GbNjdKAqWDLsYgmIew3asHQzHeQTIgLhs5cu
         gxSvfom5Yo059NJh8mR2ruLK5N0rAp2R+01tXK/4N7kyN21LltFMrZSR4pcJm4xNHg/b
         MZ9/jzYKWh8ec2naPXHe8vUJbNmjUX5Iy9Mq1FOj1h8/OsicmX+D2EQ/ybhqyBH1avJ6
         2eYvZZjxvuHzSqrek/R/hJBofxRLOAQT0+Plt2bYGx1pcYyV49kv08x2UZiWrUCpkYkX
         BNsM+cdnLMDVe/0iVNzuTI5Ep4/u8xDBwiVGR16kV9XZ7ZoGGWvKPsuy5lMbQMxCqN6v
         CNQg==
X-Gm-Message-State: AOAM530sGRCJO9kGhgdbbyTVerZxy6cSJpv5NXxaKGen7wEgDD5AFXKK
        E7tx7e+7oKh24U3KWTUDmQ==
X-Google-Smtp-Source: ABdhPJwKeA/B7qE5e/6vshliOBR9uw9IAmWJN/K6lQBwRVuSqMtApoETBfkjLsWH9TEiXwE6k88veg==
X-Received: by 2002:a05:6808:997:: with SMTP id a23mr3602047oic.129.1621347392729;
        Tue, 18 May 2021 07:16:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g11sm3434822oif.27.2021.05.18.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:16:31 -0700 (PDT)
Received: (nullmailer pid 612177 invoked by uid 1000);
        Tue, 18 May 2021 14:16:30 -0000
Date:   Tue, 18 May 2021 09:16:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org
Subject: Re: [PATCH 6/9] dt-bindings: mmc: rockchip-dw-mshc: Add Rockchip
 RK1808
Message-ID: <20210518141630.GA612127@robh.at.kernel.org>
References: <20210516230551.12469-1-afaerber@suse.de>
 <20210516230551.12469-7-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210516230551.12469-7-afaerber@suse.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 17 May 2021 01:05:48 +0200, Andreas Färber wrote:
> Add a compatible string for Rockchip RK1808 SoC.
> 
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
