Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4B0C433E1
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 09:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75D3A20738
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/HXMGta"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgH0JhU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgH0JhT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 05:37:19 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068A6C061264;
        Thu, 27 Aug 2020 02:37:19 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r13so2238211ljm.0;
        Thu, 27 Aug 2020 02:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GY1rN8KvUeBPuS99BWAMkTAboyulS1ztwK+477Pzgnk=;
        b=W/HXMGtaMBCNIjXSsI42yyo8JZP002u/pWs62pQsrVU4WAeQzaTbeQM3yg87iI2fAG
         +l0z2nICgrSeYyLt8xY5o/1dXBsSGAzMgHYMhTy5dCbAV9cTaRAoed5T1UqCAAxpGTmP
         9Tw0WuVOkG1ohfIsWpL+YHpAsaT7V1aOgAhbH4lQbQlFpM8+o2BAd7o6oCio5MeZ0Z4d
         /Tvrb3YqaGvBKYJ5/4ccGcOsRSwE39TnEFjM6HqhuTVGVATuS/MaZGS4rHz379uCElT1
         do02BFvqMgBeuizs6Sn9yFrV9zrIOsAsFj6LSrfaD4Ajtfp2tBCiCokRURMxtME2VT4h
         SD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GY1rN8KvUeBPuS99BWAMkTAboyulS1ztwK+477Pzgnk=;
        b=OfUprUXGvoXAUSqUYixV5yN703djCcp7BQCwjlPaTwkjUGY4/sAIZWZ3VZcqcGv5r4
         7YLNxDgV3tcKhm1m+1KFUnq8odq1GnYKiOmX7T55kHQ1eKt43lUVrJJUabLhwx/N3DhO
         Xjn3qJQ5PRsF/xdgXOa2w5kMrNKVwzVWoB5P8nsbRtaZRa1SqEQK/s2OScKVl+/zmrVP
         DKk9AOK0ksdNG+ypg69Lmk6/XM/FFV/IlhvL9T8uGzikyiqoyB7Wo43IxJIkCGfltxYQ
         1/oDt/Ukic0s+mSPvNAXXovpuVRFBbs+ydMMHtj1x3ru/ta9ZPqMmRI1u/r5m0GuXRvm
         U5Dg==
X-Gm-Message-State: AOAM531k3lbeYPfeijo3SgIl7SSGClWD+EGMrACUIs1rBhXAijuiB51u
        ibjB8T+eIf+x1wZwhoOtXsm57e0szIM=
X-Google-Smtp-Source: ABdhPJwRRCiqTzPrEy6fkoV6x3zZn4FlnHFbMTF/Bhy4jGZWGgspCK/7OYxer08qFGa/Zzc7B8CS1g==
X-Received: by 2002:a2e:320b:: with SMTP id y11mr9251653ljy.92.1598521037145;
        Thu, 27 Aug 2020 02:37:17 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id e25sm350263ljp.47.2020.08.27.02.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 02:37:16 -0700 (PDT)
Subject: Re: Broadcom WiFi SDIO performance regression after commit "mmc:
 sdhci: Remove finish_tasklet"
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
 <9332715c-6ee5-fce3-8b93-305823d5a551@intel.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <eec0c7d2-87f3-1213-dec1-bb34c5bde35a@gmail.com>
Date:   Thu, 27 Aug 2020 12:36:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9332715c-6ee5-fce3-8b93-305823d5a551@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

27.08.2020 09:45, Adrian Hunter пишет:
> On 27/08/20 9:07 am, Dmitry Osipenko wrote:
>> Hello!
>>
>> I was debugging WiFi performance problems on Acer A500 tablet device
>> that has BCM4329 WiFi chip which is connected to NVIDIA Terga20 SoC via
>> SDIO and found that the following commit causes a solid 5-10 Mbit/s of
>> WiFi throughput regression after 5.2 kernel:
> 
> What is that in percentage terms?

That is about 20%.

>> commit c07a48c2651965e84d35cf193dfc0e5f7892d612
>> Author: Adrian Hunter <adrian.hunter@intel.com>
>> Date:   Fri Apr 5 15:40:20 2019 +0300
>>
>>     mmc: sdhci: Remove finish_tasklet
>>
>>     Remove finish_tasklet. Requests that require DMA-unmapping or
>> sdhci_reset
>>     are completed either in the IRQ thread or a workqueue if the
>> completion is
>>     not initiated by the IRQ.
>>
>> Reverting the offending commit on top of recent linux-next resolves the
>> problem.
>>
>> Ulf / Adrian, do you have any ideas what could be done in regards to
>> restoring the SDIO performance? Should we just revert the offending commit?
>>
> 
> Unfortunately I think we are past the point of returning to the tasklet.
> 
> sdhci can complete requests in the irq handler but only if ->pre_req() and
> ->post_req() are used, which is not supported by SDIO at present.  pre_req
> and post_req were introduced to reduce latency for the block driver, so it
> seems reasonable perhaps to look at using them in SDIO as well.
> 

I'll try to take a look at pre/post_req(), but I'm not very familiar
with the MMC code, so it may take quite some time. Will be great if you
could help with making a patch that I could test!
