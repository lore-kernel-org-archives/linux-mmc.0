Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA1AC433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 14:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8998D20823
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 14:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JNM5HwwQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgESOFd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 10:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESOFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 10:05:32 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78BC08C5C0;
        Tue, 19 May 2020 07:05:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so3988578lfe.11;
        Tue, 19 May 2020 07:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3ngWGohqyk1bY0kV0++kwnpeD3y2ZE5Nt8l5LSZ6FRQ=;
        b=JNM5HwwQ0gQ6nuCM6Kwij9v2fd9iRgUdc+MT4Op08k7J6Ulu1qQVyXeFLvk7ehAi8K
         +EnpUcbc4KK4ErikoxL4837JsZFfJMcoh84iWKWNRzVzXjZ3XIG6NVQUa2XVeWrq25d2
         V+UdACbBZga9RlPT36llf67I9pQrLn+zXRj6i2YjZOWNjdlLzI2cV4vuVtzqUlp3NvXH
         Xrnj8h6hFoKRUMc+ejo1L08QIDjmdyERbsLAqcmyc67t1TPEFbBmc1JE3Al9M9lw9Izt
         3QnnpQRuriGz91mMQ8rFOxR8bHQDEtW4+Xes5BCx5wARSFHjdNioYpTlgqJiJcPj5rl8
         VRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3ngWGohqyk1bY0kV0++kwnpeD3y2ZE5Nt8l5LSZ6FRQ=;
        b=lUGHUGAWx44nLseswMnQXMVm+h1ToXFRKJ7YL3gp2bTOkXFFpGrQ3cNx6ReSUJ5IGu
         Ut7/21Rnfbv7kAoS26kfpsmQQqzEphvJda4BOqY4Z8Ax8gzfC9xM6pfLxMPO6bEnn25O
         jOnLir1rXwPLWWNVuAZvd1Qvvuf4Cb9cEmB+mgwtDS8QO2PFJefqqQ9PAKWyZ+ZTRY1w
         FGTfS5eNhl8Bhic18ijsABOg6lFaG9Q4BMKGu5xp2oC233cs9PUVjXgi/DQ1SzT8PbUJ
         0s2Q0bZylQZp6HDvDLROVXLCd80S33pQJWUxoyvUOq93PmaebAd58UnztztVBAytnYLL
         Ou3Q==
X-Gm-Message-State: AOAM530uvaFHxBxrAGSQsCX4/DrK7951SFU6uSGeL8x9vkBatDq2wRN0
        wLh4XtwUD1uTfmNzixHjeBd2A8kZ
X-Google-Smtp-Source: ABdhPJwWBveEsnFnC70i5Th3zmI8qQ90kscFZox1OYGMh21oaSbVDP3KHvAzjOQRvnunWXdFREr1Dg==
X-Received: by 2002:ac2:5f69:: with SMTP id c9mr8778817lfc.2.1589897130069;
        Tue, 19 May 2020 07:05:30 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v28sm3041273lfd.35.2020.05.19.07.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 07:05:28 -0700 (PDT)
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200516154314.14769-1-digetx@gmail.com>
 <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
Date:   Tue, 19 May 2020 17:05:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

19.05.2020 10:28, Ulf Hansson пишет:
> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> Several people asked me about the MMC warnings in the KMSG log and
>> I had to tell to ignore them because these warning are irrelevant to
>> pre-Tegra210 SoCs.
> 
> Why are the warnings irrelevant?

That's what the DT binding doc says [1].

[1]
https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia%2Ctegra20-sdhci.txt

Although, looking at the driver's code and TRM docs, it seems that all
those properties are really irrelevant only to the older Terga20 SoC. So
the binding doc is a bit misleading.

Nevertheless, the binding explicitly says that the properties are
optional, which is correct.

>> It should be up to a board's device-tree writer to
>> properly describe all the necessary properties. Secondly, eventually all
>> device-tree bindings will be converted to YAML, which allows to validate
>> board DT files, giving a warning about missing properties. Hence let's
>> remove the noisy warnings to stop the confusion.
> 
> Yep, makes sense. However, perhaps we should do this conversion then,
> rather than first drop the warnings?

I don't mind to postpone this patch. But again, IIUC, all these
properties are optional, and thus, there is no critical need to verify
them in DT right now, it could be done later on.
