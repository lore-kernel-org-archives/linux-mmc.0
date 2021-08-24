Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF4BC4320A
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D2C61248
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Aug 2021 14:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237999AbhHXO6E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Aug 2021 10:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbhHXO6E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Aug 2021 10:58:04 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB4DC061757
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:19 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id p15so349198ljn.3
        for <linux-mmc@vger.kernel.org>; Tue, 24 Aug 2021 07:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rG93YVkIW3nqzotuTfLNvUeiSiCqHX1++Ll+NQk788g=;
        b=OWpEOfcC2ZdblqNGIk+5ozXFMkkK2JRZa9xrCDCemKi8RpZEzlwFqVdQSBg9Q2XPde
         wA2OKa+hdTLQXF6cql7XcS4d4e63bYA4D1tttax3LFxF0QWMvhefBDWXi+yIdAf8TNBp
         SWhVosTpFm4OhLHgkafwtiuqiaH3VqorTVCKkidowYOU8GhA80pZPyJeszOaErUWxUCm
         D9Bfe5LAy8swyDG9mCh6BqbEy6wSDEmD9cUh5PAArpUV955+It6XqVt3CY02YQslfsC/
         iHLaNlujbEYCQcAZLIplOZi/oseLe4yTwjxQL8sz6n2DAUzS7qk28MD6tkiNEBcl/xQL
         iiwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rG93YVkIW3nqzotuTfLNvUeiSiCqHX1++Ll+NQk788g=;
        b=VTCfiqIERI7C6oRHOHVfjiqZsBkYApDx2zMW7QE1zh7DkuX6wpbK+7e2WNHB631b6e
         Kep8pnO0M/JLxdiOprNVmwHYprXOqV2oNE6Nu8S39PqNzpo+Qm4mfRNl2sgGbxfPCRlr
         bz/oDsaDsTvAPsj8G8o77BdSA1Ca8E9Te96xczb7wIR2XLTvKfg9AKcFUjn+TtT9L9Vn
         E+0mSgYOzKYs2u7uNCnyCBUNz7r0ZTHpQS7vMilLYjFo/b7hXHLNMJ+xb0DU/SZN1J9v
         HI7opUl5Lb1ogqGu2hzWFFczIbeiJCl3pCGOs69K4AU8zmBLquPREsonkD3KJDyCiK67
         DUMA==
X-Gm-Message-State: AOAM532YekABOsZcHrlxD7W8koV0uI8vgRvLlDLC8JegcAgRlozP3mB8
        /Pld8+mwM8BVGE+GrhR+ueDJTolVMCeA3yTTJfDJpg==
X-Google-Smtp-Source: ABdhPJx6Isd9vLbbCnGy+55W88MXIod8/ktiZreNMJurIqwpxYoSuJ5VA9J6ZrbE2RLDHVxsUN21K+QlYUAu8om/q9E=
X-Received: by 2002:a2e:a410:: with SMTP id p16mr30421923ljn.364.1629817038379;
 Tue, 24 Aug 2021 07:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210820092803.78523-1-claudiu.beznea@microchip.com>
In-Reply-To: <20210820092803.78523-1-claudiu.beznea@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 24 Aug 2021 16:56:42 +0200
Message-ID: <CAPDyKFrcBS2tf32H9+wsy7=TsHkaqtw0cZcSAgZc3XjnLzJ__w@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] mmc: pwrseq: sd8787: add support wilc1000 devices
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 20 Aug 2021 at 11:30, Claudiu Beznea
<claudiu.beznea@microchip.com> wrote:
>
> Hi,
>
> This series adds support for WILC1000 devices on pwrseq-sd8787 driver.
> WILC1000 devices needs a minimum delay of 5ms b/w reset and power lines.
> Adapt the sd8787 driver for this by adding a new compatible for WILC1000
> devices and specify the delay on .data field of struct of_device_id.
>
> Thank you,
> Claudiu Beznea
>
> Changes in v3:
> - fixed dt binding compilation
>
> Changes in v2:
> - changed cover letter title (it was: mmc: pwrseq: sd8787: add support
>   for selectable)
> - use new compatible in pwrseq-sd8787 driver instead of adding a new
>   binding for specifying the delay; with this, the patch 1/1 from v1 is
>   not necessary
> - adapt patch 3/3 from this version with the new compatible
>
>
> Claudiu Beznea (3):
>   dt-bindings: pwrseq-sd8787: add binding for wilc1000
>   mmc: pwrseq: sd8787: add support for wilc1000
>   mmc: pwrseq: add wilc1000_sdio dependency for pwrseq_sd8787
>
> Eugen Hristev (1):
>   ARM: dts: at91: sama5d27_wlsom1: add wifi device
>
>  .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  4 +-
>  arch/arm/boot/dts/at91-sama5d27_wlsom1.dtsi   | 71 +++++++++++++++++++
>  drivers/mmc/core/Kconfig                      |  2 +-
>  drivers/mmc/core/pwrseq_sd8787.c              | 11 ++-
>  4 files changed, 84 insertions(+), 4 deletions(-)
>

Applied patch1 -> patch3, thanks! I leave patch 4 for soc maintainers.

Kind regards
Uffe
