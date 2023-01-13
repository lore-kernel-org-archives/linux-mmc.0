Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29CCC3DA78
	for <linux-mmc@archiver.kernel.org>; Fri, 13 Jan 2023 18:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjAMShg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 13 Jan 2023 13:37:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjAMShL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Jan 2023 13:37:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDB5FD3E
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 10:36:02 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id fa5so14379912qtb.11
        for <linux-mmc@vger.kernel.org>; Fri, 13 Jan 2023 10:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rNFud20e/3X8l4IrIk41AXrLge0+yDw/l7DVnbmsMbk=;
        b=e3zlcmT/ITzizAd0ZpnXmSCq615qTc1feeeGrfHE7gGsT3pQQ9UL1aZtujVq/swCOF
         NLvW+X4MOWFXhqVbaQEqbP/IhqakO2SEs3BrcgNdTr4JmAWMSsAd/wMDmgQSQIVcRmSz
         sXnTwK6OHdeMxDdjoayUjOojr9pP7bpxcknb5eg2q1ZCyIzIEx+uO+anbzzOF1YNMmoL
         sCJpWZUIlyrVNxiBCdkihLqInMluSnWAGhLWKx96aMTg9aWnmFaeHHr+vNBY+NGwgVbB
         b8qCIJF4bjAHD0Dm470903ha1bLhAhTZqc2CqavYIAxRsOhoPHrzx1oR/AKmK2rKEDD/
         zp2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rNFud20e/3X8l4IrIk41AXrLge0+yDw/l7DVnbmsMbk=;
        b=xR6lhJsS/XIt+QmpNEy4f69OpZM13OkD+rKnfYfgkImtEPc07dwcEXdp1h/k88AdGP
         Mz164ussCxrUuHy/F+sU5fncIjYMwDsJRLWFD0I+m4c8VugHJ56utraHf+BZEG1tkn/2
         qyXgmSZ4D4Bgal2pzV4WylpeSkeDCvONItg6HDy6SifRzjNhKHBP64iEBXj0/ec1QGiF
         XAk8O0Qf2HuiLzaOlEVX3joXR8NKF1Lx6cj/gbkgx7yaPsmJWZaM7Ha/lz385fvem9PC
         VWOyZGysmSdiqTHDkrBMonXkWluDEPPI3ep2EpmGqXuwYxN0CXRl1ll4nIOyZKNatemA
         /2kg==
X-Gm-Message-State: AFqh2krTpVRMrwqgENWozonBLHigIHdw7EucCoECVF8r/Gz+8KyxC6q+
        3u85Z0mfZUndX3aMU6lud+w=
X-Google-Smtp-Source: AMrXdXvkbzq7aNkoESIqD6oW64S94aSY5beB318Dgv8G8AYz30MXQsgrP6jycn2/nGE6J7/ZvE6qSg==
X-Received: by 2002:a05:622a:1e14:b0:3ab:ceb9:10fd with SMTP id br20-20020a05622a1e1400b003abceb910fdmr48288020qtb.25.1673634961490;
        Fri, 13 Jan 2023 10:36:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id fe13-20020a05622a4d4d00b003a580cd979asm11010388qtb.58.2023.01.13.10.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 10:36:01 -0800 (PST)
Message-ID: <21e1121b-1ba0-8765-1684-cacab72c4ebb@gmail.com>
Date:   Fri, 13 Jan 2023 10:35:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/6] mmc: sdhci-brcmstb: Replace SDHCI_QUIRK_MISSING_CAPS
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>, Al Cooper <alcooperx@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jisheng Zhang <jszhang@kernel.org>,
        Marek Vasut <marex@denx.de>, linux-mmc@vger.kernel.org
References: <20230113110011.129835-1-adrian.hunter@intel.com>
 <20230113110011.129835-3-adrian.hunter@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230113110011.129835-3-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/13/23 03:00, Adrian Hunter wrote:
> SDHCI_QUIRK_MISSING_CAPS is not needed because sdhci_read_caps() can be
> called instead.
> 
> In preparation to get rid of SDHCI_QUIRK_MISSING_CAPS, replace
> SDHCI_QUIRK_MISSING_CAPS with sdhci_read_caps().
> 
> __sdhci_read_caps() is also called from sdhci_setup_host() via
> sdhci_read_caps(), however only the first call to __sdhci_read_caps() does
> anything because after that host->read_caps has been set to true.
> 
> Note, __sdhci_read_caps() does more than just set host->caps, such as do a
> reset, so calling __sdhci_read_caps() earlier could have unforeseen
> side-effects. However the code flow has been reviewed with that in mind.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>

Reviwed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

