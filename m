Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBD7C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 11:20:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616C4610D0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Oct 2021 11:20:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbhJNLWj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Oct 2021 07:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbhJNLWj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Oct 2021 07:22:39 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B46C06174E
        for <linux-mmc@vger.kernel.org>; Thu, 14 Oct 2021 04:20:34 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id e7so10465652ual.11
        for <linux-mmc@vger.kernel.org>; Thu, 14 Oct 2021 04:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2SsWb5zBEuql+rj/JRtzxIkZvDD53R135NjgjLfojg8=;
        b=Ctjn9wnv9T8ASZGza6N3LXLNgVS/LhluzbFLQAHjhQ0ccBpox6ozvJtsBKd5G6djpI
         O7/1/dk2A6H4jjcTdkM3e436CKAasWlmHWWJYx/6gAnSeBsImiUBWRe2kwognXnQrrbo
         8hvUdiV9JKSrBIdBsDr4qNuEfikHdQPBAMRt3umo7+8U+xGYFirTOsR5aEB629EEFNpG
         YC/RDKCmBIElzZr2399KN5R2ThVpbuprxMHXketUqz0KRR7/9Ma2+i6AsMTTVtZSU/ZU
         jk+ajKeGe4MoxBBzAoYYjclMG76/gETNN2qIMy2nAD6grzBhfc394fYik7BFq4+NRKzZ
         UzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2SsWb5zBEuql+rj/JRtzxIkZvDD53R135NjgjLfojg8=;
        b=vO/HQ+jEeuCi+oTqgd2lc3rimRovLpiUrKY97r7dagwxQK/Vzs/QyBcsPYylPSglsQ
         LTDdAjY8hm/lgrrzPFB27hlz3d5TCWF1ely30sG6ZOUPZIf6FMJD9e4hvicmo2F4qdIi
         VIUs7EvbNX1gT7RajHMnAde5DN7DahouQLlRtSoYUu1OupyFetWlWUtcMivfZyrlRkI8
         5Ng9jXppQ0IFLbPr2ymK9SHekj2Jh5cma6/UqU5Mu+e+biSGAD7Q+BCOzwaZTY8NKERP
         kDKYUxFR76M56onkvlnnzMRHigt3e6nSwJcunGwUOLEtJud4ljCOOUSdAkRsSu5IqiXt
         cv7g==
X-Gm-Message-State: AOAM531MYlIh4KKG5+Dkc/u+h+++NTrRhCmQnB5cbMjExCTq0CaIaa30
        reVXaMO8JPaH9EmJe+PjSED2f0Q+afQoRg7qz6o=
X-Google-Smtp-Source: ABdhPJw+zV4fiH+59fD+s47//hMcHWbJ985q5ybRYr1j7y/FssJTjj5wUvzDM0420cN2s/u9i1SsdWdl2YqXZMCnUto=
X-Received: by 2002:a67:d114:: with SMTP id u20mr6107367vsi.3.1634210433285;
 Thu, 14 Oct 2021 04:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <1634206268-5416-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1634206268-5416-1-git-send-email-haibo.chen@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 14 Oct 2021 08:20:22 -0300
Message-ID: <CAOMZO5ALWG9ovHGJ4Nw0x72E0+ONxQjYzGNPTkUKgX7La8W1-A@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: clear the buffer_read_ready to
 reset standard tuning circuit
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Haibo,

On Thu, Oct 14, 2021 at 7:36 AM <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> To reset standard tuning circuit completely, after clear ESDHC_MIX_CTRL_EXE_TUNE,
> also need to clear bit buffer_read_ready, this operation will finally clear the
> USDHC IP internal logic flag execute_tuning_with_clr_buf, make sure the following
> normal data transfer will not be impacted by standard tuning logic used before.
>
> Find this issue when do quick SD card insert/remove stress test. During standard
> tuning prodedure, if remove SD card, USDHC standard tuning logic can't clear the
> internal flag execute_tuning_with_clr_buf. Next time when insert SD card, all
> data related commands can't get any data related interrupts, include data transfer
> complete interrupt, data timeout interrupt, data CRC interrupt, data end bit interrupt.
> Always trigger software timeout issue. Even reset the USDHC through bits in register
> SYS_CTRL (0x2C, bit28 reset tuning, bit26 reset data, bit 25 reset command, bit 24
> reset all) can't recover this. From the user's point of view, USDHC stuck, SD can't
> be recognized any more.

Please add a Fixes tag, thanks.
