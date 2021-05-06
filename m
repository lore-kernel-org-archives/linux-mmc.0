Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97421C433B4
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 13:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5004D610A1
	for <linux-mmc@archiver.kernel.org>; Thu,  6 May 2021 13:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbhEFNBi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 6 May 2021 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhEFNBh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 6 May 2021 09:01:37 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3124AC061761
        for <linux-mmc@vger.kernel.org>; Thu,  6 May 2021 06:00:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c11so7632536lfi.9
        for <linux-mmc@vger.kernel.org>; Thu, 06 May 2021 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=imjkp9zgX91dHPVMnXtZjX6RL8An3N4T5kLaqqZ6UKOJo9faTrNHFaPZELcNYuaypq
         uQ0/erVuIlCfOsrMExtH/3x/rE9AIDaoYdRD7IrMtbmzzNF+jCZ91F3hF4DXulvJ6zP/
         MuHOWqMS5MWRUIAAm/gj0Ow6coQgPBzRVIiF0tbBbonfjtA0fkRH7Ofu2gJc4sFh4VdW
         sMUdEY07akP+Z82iHfIBKrK5uAdOQyVWleVZtjHg9DWsguCqgfIU/qgMkTmCwb6F0X6c
         dykfROgNLyZEnLXx3Ol6DzFYXh8Gi3IuCvomWSHe7l1JjMTLqe1pyPpxL6b2H45b1H1J
         TQag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=co6Tu6p7gwdreS8j+kzhyH/BpJmEW7gcEZ8FRox2VLM=;
        b=IwslW61QZ84cvb0/Qpwq53SEtBBM0w0Re6o0WYWnlrHyFUdtxn/V8YS6dSoPptR7eT
         2aeDsWJEG5DFg+g19AJeMIsCD8aPzUUQ4OxIt3lhgxT50ykeXuDcOwoE3RmDTWYqOWHa
         EAzoXxVX5GDHTfU5jVwMmoiIJci3LHi+JuH9iGBkIaNsl2eOWbeVipCwX5MEPOE/LZoQ
         CA65lkKhd7NyDw3eEahkTrrcgXNKT1xiD++c6tUp6/6UT2HcpnL25umqVBYLGrdVAyrR
         muIADSwbSBkmMlAlnEQDVNjAu7xvJ7BadcxYkJOiF5NFmNG8rp+XCQmgxX3A4nD6HFDy
         A0Gg==
X-Gm-Message-State: AOAM532N9jqnoFyrPIeGEP21gAhIOreV3BjnpYWneQ8fAR3DeoEXsJ8A
        wZRgXRgHViBOChrfyEyPZKLtFkflSuINxGrPZq7arQ==
X-Google-Smtp-Source: ABdhPJwechm8k/LJgQ4yWdTtDYG9Go8iYVJJpJ+sWs2TdhwxF8w4kKFdR4XnUVrgxVAIpiJ8CaDV03AcGU3DFLg9ZH0=
X-Received: by 2002:a19:a418:: with SMTP id q24mr2688212lfc.649.1620306037628;
 Thu, 06 May 2021 06:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210504161222.101536-1-ulf.hansson@linaro.org> <20210504161222.101536-7-ulf.hansson@linaro.org>
In-Reply-To: <20210504161222.101536-7-ulf.hansson@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 6 May 2021 15:00:26 +0200
Message-ID: <CACRpkdZUWP5hOCLpVvOSfR3YNXF6HC4GaO5ptYify2_EPa=wOQ@mail.gmail.com>
Subject: Re: [PATCH 06/11] mmc: core: Prepare mmc_send_cxd_data() to be
 re-used for additional cmds
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

>   * NOTE: void *buf, caller for the buf is required to use DMA-capable
>   * buffer or on-stack buffer (with some overhead in callee).
>   */
> -static int
> -mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
> -               u32 opcode, void *buf, unsigned len)
> +int mmc_send_adtc_data(struct mmc_card *card, struct mmc_host *host, u32 opcode,
> +                      u32 args, void *buf, unsigned len)

Just a note here (the change is good)

When applying please add some kerneldoc above mmc_send_adtc_data()
and expand the ADTC acronym and add some info explaining what it
is maybe a small protocol ref or so, so readers of the code get an
intuitive feeling for what this function does and what ADTC is.

Yours,
Linus Walleijq
