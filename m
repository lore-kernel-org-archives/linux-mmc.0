Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28095C43460
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52ED610E9
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 12:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232073AbhEFMwt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 08:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFMws (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 08:52:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEB8C061574
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 05:51:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id b21so6860679ljf.11
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 05:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=leGIz44I+FDaJitpl6Hc4zICX3i8IZYPExD5nafIx0I=;
        b=DX3KA16LeSsMsghPZH82/XQtNlVzAV9W69bzaPNrsqbVgiv1x4Zll52FF33UWdCqmx
         v61tH7eAe02qtR/+yfjvmAMhlpDhREKXiZAhMUuPkwQJSKa9P5MtAeCkSK1Uc7IwONt1
         odhHvegaJCLPAsU+pJvsoUUxD5HjOHNAqTwmAPunac40efQGQrqLxmVG48bEFXmE94rW
         oHZCKurLE6RHJ+h/+FBacZzZ1CLvgVdyhs+D3f6lLo+ggKwt5TEeF/ImX+Jm/NRK1Fko
         4sNelfCaGh6qDCKy7HdaHxVn9LvJdUFQixA5BPwe9Gm0/jyPJHkg+j8Au7I2ZHcpcWKo
         z/eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=leGIz44I+FDaJitpl6Hc4zICX3i8IZYPExD5nafIx0I=;
        b=N1/LN46tnVHHMZxR5pS4pLTXmnXpdHLpndVlVlUI+Bg6hnPo1ePx2kY4fqFraMN4YG
         7UiTQEyQ571qxzl4X1o/K93xbtPCqnCQMn/AhLErU3tfa7fzIG1emfQaFR7rxBHPoij3
         7IvcPWA/olvYSyB5xDco+HG8LA7FW3Lf3lyZdZsAXWkqYeKQomq6e1uKYtowlbHNIIl1
         lBdTN2VvFWXmuh8RMIQvDJmFOXQeBam52SlNiEcHHNVNJXPu/WIhBHcYQp/YLX4uBU10
         o6ni3+XdvGQiJGZXmqp0p/ziQEKNax8ODmGjN4PrBZ4aeuFCH5Zqal6ys1FmvOvW8gFH
         xQcQ==
X-Gm-Message-State: AOAM530RFE3nWRZpV5mDFFNYwsB2s4rEDmsbLr76mwmVCx2vvr2+dJ5U
        QJJbaUFxCYDIJrhF/gDbyf+POvXlIlVCbZg6j4PLgw==
X-Google-Smtp-Source: ABdhPJwMpyg958RS71r2sEro18tQ0KNQqZLWBMMdyKHnmvXWnfmEhJ4zFsnA6TFQW0FHx+ilUWptjsL9/CwbB0ZZ0Fk=
X-Received: by 2002:a2e:a54c:: with SMTP id e12mr3250389ljn.326.1620305507437;
 Thu, 06 May 2021 05:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-3-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-3-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 14:51:35 +0200
Message-ID: <CACRpkdYf+ak=4S0FFQ2zKRTXd7rWMPcvPnrrdtdpVnEJHuiTYQ@mail.gmail.com>
Subject: Re: [PATCH 02/11] mmc: core: Take into account MMC_CAP_NEED_RSP_BUSY
 for eMMC HPI commands
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, May 4, 2021 at 6:12 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:

> In mmc_send_hpi_cmd() the host->max_busy_timeout is being validated towards
> the timeout for the eMMC HPI command, as to decide whether an R1 or R1B
> response should be used.
>
> Although, it has turned out the some host can't cope with that conversion,
> but needs R1B, which means MMC_CAP_NEED_RSP_BUSY is set for them. Let's
> take this into account, via using the common mmc_prepare_busy_cmd() when
> doing the validation, which also avoids some open coding.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
