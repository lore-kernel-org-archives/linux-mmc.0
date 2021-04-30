Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BCAC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 21:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E25FF6147D
	for <linux-mmc@archiver.kernel.org>; Fri, 30 Apr 2021 21:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236191AbhD3VMI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 30 Apr 2021 17:12:08 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:33319 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhD3VMH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Apr 2021 17:12:07 -0400
Received: by mail-ot1-f48.google.com with SMTP id 92-20020a9d02e50000b029028fcc3d2c9eso43141531otl.0;
        Fri, 30 Apr 2021 14:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUDa8mELslYYsnwCk0fnXA024TFYhBlM4dLFukV6z6c=;
        b=Ho7Is8QxHcyY+dh34Nz2YKqMIeEJaBP6lLklb+HM/jZ/CxAxdzgwt6uw42diXbZe47
         +VqiyAnRFLrXVUcxxeVOA5iAY5lYcd8u3V5CjusqfbzO696vzr0jseSylEDNBbhzI/Qi
         WdeyamjW3d7qZRqTO/EjmDBlOEDCMKttzKsNOG2Nsjymf9OsCmmW1zInmjEp0ReWvMWu
         ZGLQjBUaLrQiNi+vYSYR8XszLaxshg+AfQyuDZ357OJnczqqT5u8dUyvGHaY8Uwr26eI
         P0pH6LzD5azviQ0efhlAUQkutBibaZRV+wGk8kNgBR04Fs/CSDchhc+6lm/0HNVIxqGZ
         6Utg==
X-Gm-Message-State: AOAM530OFUDf9Y+9DL/SxC+dEiRoL+z9RdQXLCbP6LK1lmnUe/IgUsfN
        oZqpNNt319mhMBHspttj4A==
X-Google-Smtp-Source: ABdhPJxZqLwNO1zjieg6NjX5EQB0zSGFIIjI8Lb0vVSY7a1bPvqP8LDCfXF2RiE2HNve3ZY7Hid9DQ==
X-Received: by 2002:a9d:6106:: with SMTP id i6mr5108080otj.237.1619817077739;
        Fri, 30 Apr 2021 14:11:17 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y123sm1096826oia.7.2021.04.30.14.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 14:11:17 -0700 (PDT)
Received: (nullmailer pid 3900648 invoked by uid 1000);
        Fri, 30 Apr 2021 21:11:15 -0000
Date:   Fri, 30 Apr 2021 16:11:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     cl@rock-chips.com
Cc:     maz@kernel.org, jay.xu@rock-chips.com, zhangqing@rock-chips.com,
        robh+dt@kernel.org, linux-serial@vger.kernel.org, wens@csie.org,
        linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux@roeck-us.net, shawn.lin@rock-chips.com,
        linux-mmc@vger.kernel.org, jensenhuang@friendlyarm.com,
        michael@amarulasolutions.com, mail@david-bauer.net,
        cnsztl@gmail.com, heiko@sntech.de, huangtao@rock-chips.com,
        ulf.hansson@linaro.org, david.wu@rock-chips.com,
        linux-watchdog@vger.kernel.org, jamie@jamieiles.com,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        uwe@kleine-koenig.org, wim@linux-watchdog.org, jbx6244@gmail.com,
        jagan@amarulasolutions.com
Subject: Re: [PATCH v4 02/10] dt-bindings: serial: snps-dw-apb-uart: add
 description for rk3568
Message-ID: <20210430211115.GA3900619@robh.at.kernel.org>
References: <20210429081151.17558-1-cl@rock-chips.com>
 <20210429081151.17558-3-cl@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210429081151.17558-3-cl@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 29 Apr 2021 16:11:43 +0800, cl@rock-chips.com wrote:
> From: Liang Chen <cl@rock-chips.com>
> 
> add "rockchip,rk3568-uart", "snps,dw-apb-uart" for uart nodes on
> a rk3568 platform to snps-dw-apb-uart.yaml.
> 
> Signed-off-by: Liang Chen <cl@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
