Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FCC8C433FE
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Dec 2020 06:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28FB922D72
	for <linux-mmc@archiver.kernel.org>; Sat,  5 Dec 2020 06:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbgLEGMH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 5 Dec 2020 01:12:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgLEGMH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 5 Dec 2020 01:12:07 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C9C061A4F
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 22:11:26 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id r4so219000pls.11
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 22:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D7AczkzMwnCTqGNk/WinEN4GxDXh0TBrfFJyaIs9yxY=;
        b=W6xJPGENxbezmkuhhtaWZSnVB8iblzBFz/ZlCgViToQq/1fJIkWo7hIZ6s89WkKvom
         fKZ1/KGgHcS6ZuRfbmQebsZHKpdk2DSAJVlITgghsbHI0FWR7kMbuabZvjrU3pAT2Uql
         k4hJtbP6tyfLVhUOe3VPtfnV1ln245JCCOPFNJRGPu3v6uzh2kuyBQeFvABGJfzt9NBw
         9By5QUj73eF6+qeQLjlh+Nc8Ya+chlN4VLJXwdHM+vJqOJuZcpcHMiXUgyUQuk4w00b5
         zTDoZia8oFImOhBVf3eAcExH7pekUIWZ/4NPjIKRyo5rF02BDVOFEBJYBXVIUshvK0j6
         LzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7AczkzMwnCTqGNk/WinEN4GxDXh0TBrfFJyaIs9yxY=;
        b=mwZu4lgbrB94dMTnBPUbnowPQAk+ESmt3fUhLvVHbU1z6+3vjGRQyTsIhvQvQ5LKTU
         M/kTYcTn+gtlnalxmIpOOMH8bP+yiow/LAPugBgK9Hx3anayt8Lb76ozvEjBlV6OHQyx
         VwIogbuLX7PVflolVGLeGHb0vJSpRzdyV6RBdHLKai6WTwFvKj1JztFgrFk9Bfzc42Ju
         UN7N4PnG7S0AJvWc/61CASZ1He4yZ44AAt/hME6sS2lMXJltSq0QZO+cAq901pJrd+fT
         zARTYDhWr18qL5fTrvtau+izp+RL+s0YZiwvFzP6EMLpbhtQy7GC52jt8FeDp5AqYxTZ
         2rLw==
X-Gm-Message-State: AOAM5338xf0e89uyD3rxAaEyrGquu0qxB8bmghlzG/PXHi6KM8KcapMH
        MebQiKBYohMbAe8AcmLyI6qR
X-Google-Smtp-Source: ABdhPJzvEXQ4h/j2yTz8qIDNrIHGaz8TRTASTCZ9h+hLDXfffPdy21Bc34vKlGOcvRYRYnuIk6pB4w==
X-Received: by 2002:a17:90a:7e95:: with SMTP id j21mr7373400pjl.217.1607148686216;
        Fri, 04 Dec 2020 22:11:26 -0800 (PST)
Received: from thinkpad ([2409:4072:648e:8bd1:74b2:a4d8:e3fe:225b])
        by smtp.gmail.com with ESMTPSA id q23sm6915493pfg.18.2020.12.04.22.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:11:25 -0800 (PST)
Date:   Sat, 5 Dec 2020 11:41:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Vinod Koul <vkoul@kernel.org>, Wolfram Sang <wsa@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Add CMU/RMU/DMA/MMC/I2C support for Actions
 Semi S500 SoCs
Message-ID: <20201205061115.GB4068@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Cristi,

On Fri, Nov 20, 2020 at 01:55:54AM +0200, Cristian Ciocaltea wrote:
> Hi,
> 
> This patchset brings a series of improvements for the Actions Semi S500
> SoCs family, by adding support for Clock & Reset Management Units, DMA,
> MMC, I2C & SIRQ controllers.
> 
> Please note the patches consist mostly of DTS and bindings/compatibles
> changes, since all the work they depend on has been already merged,
> i.e. clock fixes/additions, pinctrl driver, sirq driver.
> 
> For the moment, I have only enabled the features I could test on
> RoseapplePi SBC.
> 

I was hoping to apply this series for v5.11 but we ran out of time. So expect
this series to be in v5.12.

Thanks,
Mani

> Thanks,
> Cristi
> 
> Changes in v2:
> - Added new bindings/compatibles for S500 DMA, MMC & I2C controllers
> - Added support for the SIRQ controller
> - Added new entries in MAINTAINERS
> - Updated naming of some patches in v1
> 
> Cristian Ciocaltea (18):
>   arm: dts: owl-s500: Add Clock Management Unit
>   arm: dts: owl-s500: Set CMU clocks for UARTs
>   arm: dts: owl-s500: Add Reset controller
>   dt-bindings: dma: owl: Add compatible string for Actions Semi S500 SoC
>   dmaengine: owl: Add compatible for the Actions Semi S500 DMA
>     controller
>   arm: dts: owl-s500: Add DMA controller
>   arm: dts: owl-s500: Add pinctrl & GPIO support
>   dt-bindings: mmc: owl: Add compatible string for Actions Semi S500 SoC
>   arm: dts: owl-s500: Add MMC support
>   dt-bindings: i2c: owl: Convert Actions Semi Owl binding to a schema
>   MAINTAINERS: Update entry for Actions Semi Owl I2C binding
>   i2c: owl: Add compatible for the Actions Semi S500 I2C controller
>   arm: dts: owl-s500: Add I2C support
>   arm: dts: owl-s500: Add SIRQ controller
>   arm: dts: owl-s500-roseapplepi: Use UART clock from CMU
>   arm: dts: owl-s500-roseapplepi: Add uSD support
>   arm: dts: owl-s500-roseapplepi: Add I2C pinctrl configuration
>   MAINTAINERS: Add linux-actions ML for Actions Semi Arch
> 
>  .../devicetree/bindings/dma/owl-dma.yaml      |   5 +-
>  .../devicetree/bindings/i2c/i2c-owl.txt       |  29 ----
>  .../devicetree/bindings/i2c/i2c-owl.yaml      |  62 ++++++++
>  .../devicetree/bindings/mmc/owl-mmc.yaml      |   4 +-
>  MAINTAINERS                                   |   3 +-
>  arch/arm/boot/dts/owl-s500-roseapplepi.dts    |  97 +++++++++++-
>  arch/arm/boot/dts/owl-s500.dtsi               | 140 ++++++++++++++++++
>  drivers/dma/owl-dma.c                         |   1 +
>  drivers/i2c/busses/i2c-owl.c                  |   1 +
>  9 files changed, 304 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.txt
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-owl.yaml
> 
> -- 
> 2.29.2
> 
