Return-Path: <SRS0=q8Wp=7D=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39F41C433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D522078B
	for <linux-mmc@archiver.kernel.org>; Thu, 21 May 2020 12:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqbpbKXn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgEUMkg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 21 May 2020 08:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbgEUMkg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 21 May 2020 08:40:36 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A46C061A0E;
        Thu, 21 May 2020 05:40:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z6so8023268ljm.13;
        Thu, 21 May 2020 05:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Bz9kW9o/9YtdCQhvvB7QDx10N00o+JmEwpJejIQIQC4=;
        b=sqbpbKXnnY6uMSFqSGEn3a6CxICrJyZqvk65oaAGSlYLP6esz/UkVdoJ2LsTojVQ/z
         F3mY0HIvY/wzm+zDbYRIfXdktMFD9zXqXQXT4JfkeXUxe3W0Cs443CEmdR1MlnqbiLvz
         sCwSMTuRvktY2ATbNsLmp0qgnnL71T6aWbCznAKMUaGT0ZuIp9j0NNQA7eoXEo/wH/Bp
         WSq5daGmq8lRF07dPqfeOG8+ZRrgeVeHa1gmMJ3R0PNOMS2YbBpR/lIg9XaVJD2571uY
         q7yLIPA6cKu6yujpOcFxI231bGWMTIxV2feb1uuBQheKSt43UleIlU2grjUVGqCzfa1I
         RUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Bz9kW9o/9YtdCQhvvB7QDx10N00o+JmEwpJejIQIQC4=;
        b=nE1Ewlq/01ZOcvuf5vAGXTKCVzbEMdeRcparP8hYg1axXQ3Y2/FHRKekIan+/aAlPT
         eP7TUeGMPDyL0Qwz0IfmjdUqgx30Yr0MHIga+A+KnOOO5G/WUHyEX78DFhwL2mQKjTtM
         nMMG7p39UPqjl6R6LNCt681D3LZc16tLX5tnNsJgVSSfeRDNUWmATDPH7KvcjPo9LcuW
         03MQk8gxNu/7Gqq6vjL1acd2sQ2v6dh+BPiYi8dupo8KA8oRQMY5X0nAU3R6NlmB132N
         uFjseGKQmk5BiTyxW7mr/PqVdJ7gi0t6gF6Q/rsmEUpJGptXGAzedk/nKhMUK8/szdFP
         72iA==
X-Gm-Message-State: AOAM531OXszLU2W0YYy0HW1Jw7I/YHlkLZ/OZJ3tgG6jF/5iWyQsSt8F
        snM4kTQD2e/rKDW2NUe9na0z1t2F
X-Google-Smtp-Source: ABdhPJzNyDE6H412DCiAfBDPeBmNqbKsp22MrTsH+gzNfvHqt6hOaJDPP4B9eJy5cVKcOiRlz5Skqg==
X-Received: by 2002:a2e:9743:: with SMTP id f3mr5151896ljj.205.1590064833179;
        Thu, 21 May 2020 05:40:33 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id x8sm1700413ljh.97.2020.05.21.05.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 05:40:32 -0700 (PDT)
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <45c290f9-e276-53be-a7a6-23bf81f50bc3@gmail.com>
Date:   Thu, 21 May 2020 15:40:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

20.05.2020 23:08, Sowjanya Komatineni пишет:
> When auto calibration timeouts, calibration is disabled and fail-safe
> drive strength values are programmed based on the signal voltage.
> 
> Different fail-safe drive strength values based on voltage are
> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
> 
> So, this patch avoids reading these properties from the device tree
> for SoCs not using pad controls and the warning of missing properties
> will not show up on these SoC platforms.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 24 deletions(-)

Hello Sowjanya,

Thank you for the patch.

Tested-by: Dmitry Osipenko <digetx@gmail.com>
