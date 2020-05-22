Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02B2C433E0
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC08820723
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 12:42:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/3ce5aI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgEVMmX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 08:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgEVMmW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 08:42:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87494C061A0E;
        Fri, 22 May 2020 05:42:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so12442508ljo.5;
        Fri, 22 May 2020 05:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2w3sQsYVGHqugd18wyS5dwx6ShxXceU/hZMilO9mbjs=;
        b=V/3ce5aINSs51/6D2GrqAHtX9BA0h43h3exLi/aCvbY19zfNjJExnAfZsRZqnvB+Xw
         6MAZwMqYc1MgbpvWfUItOD0S+vfNlkBdcLsi1mQVPmKzs8Sl5oD9jEcKtvjvQESVwxeY
         qRyKv4d4WoxYkBVV7JFTwvZwrypZLqZnpkyF/nZxYqQiNBELLavoVJj/EJvEe07Y4HtF
         GgISGSVWUq/BVWlp5LBdAeAyMmbVPHy47tio+DILn375iykHewNQxlUJJbrn4K94ASSf
         ItOnRs610H8gnC48OD85Xtkfejy7ltUyZuNb6hRdmbZOsOJ0kx9bTKJRPGRbhMfcFtKl
         QQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2w3sQsYVGHqugd18wyS5dwx6ShxXceU/hZMilO9mbjs=;
        b=gC9H2m1e7WNr9r5FbW4trry4dX8p/B4M3UFYBwdUatSURqUQpzhQTCdjE8c2oQsAnM
         3N18uNU4Ufp2DPCPzSEyxMh6igMI+OKEOSCBkhareb+wnDWukrRlPkecaZywXdlI8iZM
         1dPBZm8t7AP5MY8u+AE5uaDLd4KVVikGnmpE1ap3wVUweaYxo+/t+KoEtmQ5D6P7RfKG
         JQTpHlUXBEkvDe2jz7T0KDnxfD6zW/3GJ7pBxtkvv6FPwozzuUWY7jnNIoZ0M/yIWTvD
         YGXUD+sGUnkXIwYTjqFCnfJa3JRKq1J5R0ly6BDIFdR95vA6z3wjUPnctk9gbY89aK1U
         mAXw==
X-Gm-Message-State: AOAM5323n5uQ6xOfpJ9+DV4Qz80ykQvGbf7gmG1YiTqwPbJoM8zOaO6i
        2kiQV2pTqulWwy5BiDSdUVdGQ2ZQ
X-Google-Smtp-Source: ABdhPJyS3GYP+UTv9+B00mqQg545qEX21gx1Hr0oX0MOuvZ3va9HT/+7UbNbs6N+gpm4QI7yWlujsg==
X-Received: by 2002:a2e:750d:: with SMTP id q13mr4987988ljc.297.1590151339696;
        Fri, 22 May 2020 05:42:19 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-76-17-204.pppoe.mtu-net.ru. [91.76.17.204])
        by smtp.googlemail.com with ESMTPSA id g24sm2740867lfh.90.2020.05.22.05.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 05:42:18 -0700 (PDT)
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
 <20200522122644.GE2163848@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <95d01fae-bf1f-28d1-2d11-8f5693646fa3@gmail.com>
Date:   Fri, 22 May 2020 15:42:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522122644.GE2163848@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

22.05.2020 15:26, Thierry Reding пишет:
> On Wed, May 20, 2020 at 01:08:57PM -0700, Sowjanya Komatineni wrote:
>> When auto calibration timeouts, calibration is disabled and fail-safe
>> drive strength values are programmed based on the signal voltage.
>>
>> Different fail-safe drive strength values based on voltage are
>> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
>>
>> So, this patch avoids reading these properties from the device tree
>> for SoCs not using pad controls and the warning of missing properties
>> will not show up on these SoC platforms.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>  drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++------------------
>>  1 file changed, 33 insertions(+), 24 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
>> index 3e2c510..141b49b 100644
>> --- a/drivers/mmc/host/sdhci-tegra.c
>> +++ b/drivers/mmc/host/sdhci-tegra.c
>> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
>>  		autocal->pull_down_1v8 = 0;
>>  
>>  	err = device_property_read_u32(host->mmc->parent,
>> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
>> +			&autocal->pull_up_sdr104);
>> +	if (err)
>> +		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
>> +
>> +	err = device_property_read_u32(host->mmc->parent,
>> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
>> +			&autocal->pull_down_sdr104);
>> +	if (err)
>> +		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
>> +
>> +	err = device_property_read_u32(host->mmc->parent,
>> +			"nvidia,pad-autocal-pull-up-offset-hs400",
>> +			&autocal->pull_up_hs400);
>> +	if (err)
>> +		autocal->pull_up_hs400 = autocal->pull_up_1v8;
>> +
>> +	err = device_property_read_u32(host->mmc->parent,
>> +			"nvidia,pad-autocal-pull-down-offset-hs400",
>> +			&autocal->pull_down_hs400);
>> +	if (err)
>> +		autocal->pull_down_hs400 = autocal->pull_down_1v8;
>> +
>> +	/*
>> +	 * Different fail-safe drive strength values based on the signaling
>> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad controls.
>> +	 * So, avoid reading below device tree properies for SoCs that don't
>> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
>> +	 */
>> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
>> +		return;
> 
> Hm... so what exactly is the difference between NVQUIRK_HAS_PADCALIB? I
> think Tegra30 will also end up calling tegra_sdhci_set_padctrl(), but it
> will then write the default (0) value for these drive strength. Is that
> okay?

It won't write 0, but skip the writing if values are 0. Technically T30+
supports the customized strengths, but I'm not sure whether it was ever
tested and whether it's really needed. I think Sowjanya said before that
the default values are always okay for older SoCs.
