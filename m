Return-Path: <SRS0=/V3P=7B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_BL,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D70C433E3
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 517B8207D8
	for <linux-mmc@archiver.kernel.org>; Tue, 19 May 2020 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXXIEkHb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgESQdq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 May 2020 12:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729488AbgESQdn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 May 2020 12:33:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E863BC08C5C0;
        Tue, 19 May 2020 09:33:41 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id c12so40979lfc.10;
        Tue, 19 May 2020 09:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=erHld5g8aUsGObcGGn0MGFVIEHLOUjB0Us6LDfsWtwI=;
        b=PXXIEkHbyn+P/kMEEJSfC4wL0O4hX4OmmwcfZbc+VOa1IlbTxAww8MjZF1eb69czSl
         JhNxWfdAvNvf0aLOJ2zIgjjWjoo3/qMuhePXkwjT47u0273RtTb2w6fbghDsX1IyOsh7
         ycbxPguVWsvQKY0q2jHaG22jnYYiiQMY92Rhi39x4/Lpu35VITIeAg19c9SUDG8w/qVo
         OX3zjE3HtGEFaPiApNAXpWAwHWvFp5S5zxBcHjnSAgOQpvSbZOc664cbBcgISbUKtgLG
         FhgDukKAHwsL4iNX8v0Uc6U3aGczmzdO5M2bQ+S/NnIv/eLlwVXMGR8NYl2RmzgB+wk1
         u8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=erHld5g8aUsGObcGGn0MGFVIEHLOUjB0Us6LDfsWtwI=;
        b=mZVYCtG+b8MGjjdEASra3n+ImZWjkBDnrWDrC04vcBrkKpwVrAzsBgrLbKLTXgh3yR
         /2fn0nTzN+q2YQxeqF9vf0MQgbBA0peUj4mfnBgY7B2h6ExnN2tPKoAeKTGRcbaLgyw7
         /EHdPZ3vbE2Oh0aZi1Ifok1uZdAI61FFAAarRYs64E1Z1tMXUOi/TqG5L3LZNIIbZyld
         ceCYu6T93g6eN86KXYKA83yokL8qi4zJdYX2NlvVdODRfQFKshE6CqH6XxIXzXdHnPDp
         xtcjFHup8nGbEc/qjM5zHoe3pANHaDpaOxD+GnsyCqhiSix3mPuPWd3hpbN164eFfKFT
         piZw==
X-Gm-Message-State: AOAM531y+Ayjle6mwW5EvlH6xxYXtEVRvsYkdKpecs7K+YN5emUbOIm/
        jAxzSxZP/Ohh6GqO7ruNWANN11Iw
X-Google-Smtp-Source: ABdhPJynTG9WE/2wz7rU96llUm+O8M3VCxmsoLGn8GGEC/AtLXD3ecQSqJWInxjS2UgGX4APrbMdJA==
X-Received: by 2002:ac2:5ccf:: with SMTP id f15mr15638072lfq.216.1589906019877;
        Tue, 19 May 2020 09:33:39 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id v4sm52411ljj.104.2020.05.19.09.33.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2020 09:33:39 -0700 (PDT)
Subject: Re: [PATCH v1] sdhci: tegra: Remove warnings about missing
 device-tree properties
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200516154314.14769-1-digetx@gmail.com>
 <CAPDyKFo_Xp-zipqE26iMv4CFwUoMCQZy3Zr63Cp=uzePgWX7BA@mail.gmail.com>
 <b634e7a5-9a30-3bd1-126d-be62e4dd73e1@gmail.com>
 <20200519162444.GD2113674@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <b4eb368e-adc2-7b77-3ae9-fefdcfddaf3d@gmail.com>
Date:   Tue, 19 May 2020 19:33:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200519162444.GD2113674@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

19.05.2020 19:24, Thierry Reding пишет:
> On Tue, May 19, 2020 at 05:05:27PM +0300, Dmitry Osipenko wrote:
>> 19.05.2020 10:28, Ulf Hansson пишет:
>>> On Sat, 16 May 2020 at 17:44, Dmitry Osipenko <digetx@gmail.com> wrote:
>>>>
>>>> Several people asked me about the MMC warnings in the KMSG log and
>>>> I had to tell to ignore them because these warning are irrelevant to
>>>> pre-Tegra210 SoCs.
>>>
>>> Why are the warnings irrelevant?
>>
>> That's what the DT binding doc says [1].
>>
>> [1]
>> https://www.kernel.org/doc/Documentation/devicetree/bindings/mmc/nvidia%2Ctegra20-sdhci.txt
>>
>> Although, looking at the driver's code and TRM docs, it seems that all
>> those properties are really irrelevant only to the older Terga20 SoC. So
>> the binding doc is a bit misleading.
>>
>> Nevertheless, the binding explicitly says that the properties are
>> optional, which is correct.
> 
> Optional only means that drivers must not fail if these properties
> aren't found, it doesn't mean that the driver can't warn that they
> are missing.
> 
> Quite possibly the only reason why they were made optional is because
> they weren't part of the bindings since the beginning. Anything added
> to a binding after the first public release has to be optional by
> definition, otherwise DT ABI wouldn't be stable.
> 
> I think these warnings were added on purpose, though I also see that
> there are only values for these in device tree for Tegra186 and Tegra194
> but not Tegra210 where these should also be necessary.
> 
> Adding Sowjanya who wrote this code. Perhaps she can clarify why the
> warnings were added. If these values /should/ be there on a subset of
> Tegra, then I think we should keep them, or add them again, but perhaps
> add a better way of identifying when they are necessary and when it is
> safe to work without them.
> 
> That said, looking at those checks I wonder if they are perhaps just
> wrong. Or at the very least they seem redundant. It looks to me like
> they can just be:
> 
> 	if (tegra_host->pinctrl_state_XYZ == NULL) {
> 		...
> 	}
> 
> That !IS_ERR(...) doesn't seem to do anything. But in that case, it's
> also obvious why we're warning about them on platforms where these
> properties don't exist in DT.
> 
> So I think we either need to add those values where appropriate so that
> the warning doesn't show, or we need to narrow down where they are
> really needed and add a corresponding condition.
> 
> But again, perhaps Sowjanya can help clarify if these really are only
> needed on Tegra210 and later or if these also apply to older chips.

Either way will be cleaner to convert the DT binding to YAML rather than
clutter the driver, IMO.

