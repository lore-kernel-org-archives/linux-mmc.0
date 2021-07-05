Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781D8C07E9D
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 07:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F9456135D
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Jul 2021 07:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhGEHg6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Jul 2021 03:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbhGEHg5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Jul 2021 03:36:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BACF9C0613DB
        for <linux-mmc@vger.kernel.org>; Mon,  5 Jul 2021 00:34:19 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p8so20846084wrr.1
        for <linux-mmc@vger.kernel.org>; Mon, 05 Jul 2021 00:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EBNJ83/aCZlajq80Bp2dxWGUc5q1W6Xlxd/F1gzRdXk=;
        b=Xlzk00gGZIIPjUG03hvDIbMzZnKqULFck66hAW67IX3sPMhaZg5kWn1gPXUw8ALjbZ
         U8I+2DyZjPp3FyhNSi1CUXyBRqe2vosLqYjdojnZQc7KM4T87rNdMryBqJ/sZa6Wur0g
         1bV2+twE7o/l1icuxUainWzuIUQRbzteavaQTI/NjgGuq3DOw/YJdrAPbzri1vkjAB15
         vNmLQnh/i0vwyi6kc2BjGMRnFsZd20J/NFFwepZ+NIbx19kLehzc83nr7FGmJFzhcxwj
         MrSlpDUf0WqCumoDb5lBnAIaGD6ISorisnHvcwJHyx8Ne5qr2TrNCFXNVfSfC9qbXN43
         No5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EBNJ83/aCZlajq80Bp2dxWGUc5q1W6Xlxd/F1gzRdXk=;
        b=dQWpX0xxt06mEHrlYoSQGfSXwgjQJlJDSzFY3AY5xVIxp6GO1EYj2fJQ2GbOy3e6Yd
         u6eKU/PzwjxCr8fFBTLq5Y0eCcR5HhV6yitbTc2wiZmOzoKQO3zOlELgGJ8P62B+Khx8
         l24XCrlsIzCZDKDXwqcvZL2NmXXAMwgDcCPqULQ262CBOIipJrPz0qE58B64Syf0rQ/8
         o9YCr80pQFVMXeCNMjAId9Bt8Li81hddjuyzZgZ7zu4+ZIsoYHEUZSExKQ+3AW5pevSC
         4LTJyWvM7BOzmCV29Fok35Hu8quvNnCtpjw/M6cR9GfJUkX/Cag+r/j8OeoZDJcbH8IU
         mZfg==
X-Gm-Message-State: AOAM532lhcg/VlZqEBpx5GQ6hnqV1tPPVEQIjPsGectjyol6be7nORNl
        9Zs7FZAPZb4q6K+acuhPNhjg7Q==
X-Google-Smtp-Source: ABdhPJyehcg9ReIxi1AOVhCby1G/JJZ5u9bOeyubGcqCl5ofyE6O4PKjYJShptLMWn8w2a6VlgL+iQ==
X-Received: by 2002:a5d:4a0d:: with SMTP id m13mr14086437wrq.368.1625470458082;
        Mon, 05 Jul 2021 00:34:18 -0700 (PDT)
Received: from dell ([109.180.115.218])
        by smtp.gmail.com with ESMTPSA id h8sm12128561wrt.85.2021.07.05.00.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 00:34:17 -0700 (PDT)
Date:   Mon, 5 Jul 2021 08:34:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     cl@rock-chips.com, thierry.reding@gmail.com, robh+dt@kernel.org,
        heiko@sntech.de, jagan@amarulasolutions.com, wens@csie.org,
        uwe@kleine-koenig.org, mail@david-bauer.net, jbx6244@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        jensenhuang@friendlyarm.com, michael@amarulasolutions.com,
        cnsztl@gmail.com, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-i2c@vger.kernel.org, jay.xu@rock-chips.com,
        shawn.lin@rock-chips.com, david.wu@rock-chips.com,
        zhangqing@rock-chips.com, huangtao@rock-chips.com,
        wim@linux-watchdog.org, linux@roeck-us.net, jamie@jamieiles.com,
        linux-watchdog@vger.kernel.org, maz@kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [RESEND PATCH v5 1/4] dt-bindings: pwm: rockchip: add
 description for rk3568
Message-ID: <YOK1+pMy+N64eR75@dell>
References: <20210622020517.13100-1-cl@rock-chips.com>
 <20210623021303.28015-1-cl@rock-chips.com>
 <20210705064914.o2neaiwqndjfdyqd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210705064914.o2neaiwqndjfdyqd@pengutronix.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 05 Jul 2021, Uwe Kleine-König wrote:

> On Wed, Jun 23, 2021 at 10:13:03AM +0800, cl@rock-chips.com wrote:
> > From: Liang Chen <cl@rock-chips.com>
> > 
> > add "rockchip,rk3568-pwm", "rockchip,rk3328-pwm" for pwm nodes on
> > a rk3568 platform to pwm-rockchip.yaml.
> 
> Looks good to me
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> Who is supposed to apply this patch? Does this need blessing by Rob?

There is no standard.  Rob will usually have some kind of arrangement
with the associated maintainer(s).  If this is a big functional
change, I would suggest letting Rob and his army of bots give it the
once over before it is applied in any case.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
