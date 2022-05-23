Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0807EC433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 23 May 2022 23:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiEWXJf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 May 2022 19:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiEWXJe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2022 19:09:34 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496C0AE273;
        Mon, 23 May 2022 16:09:33 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so612167pjf.5;
        Mon, 23 May 2022 16:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ybEmxk4NXzWhLZHzOrZoaS9EHEMhwQJPYJOF/YKJYGE=;
        b=LAAP08YZH6odwXEqbFhaY6E9FelYfcMLMu+4vWhJnP7ftrHbKwYOzV1bO6p1f4fxV1
         vQ2OMmN5ypTGI8mu6TK0zFq1Roq0d59GpAGjzpim1M28OfDwiC1URcBTkCMb7wTLhM3E
         L/vxNha0yklWdWDZtOE/sMfr2C0BxmSBkcAsIA/+mqSJWNZrJMcPiHSVgfHNm/kehQwL
         MWs2u9iwTQs2pnKTafpPpOdRevdizhBaSmIhm0VQ0ytfS59ynru0fsmw5LBmvCZZuMXQ
         CIySjv5eA+6t9CE4KDyKo16ZKAQQUfUC68zZGAskG+gljFtfL/Mn76JtEV+BPA7+yo8R
         2+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ybEmxk4NXzWhLZHzOrZoaS9EHEMhwQJPYJOF/YKJYGE=;
        b=KhhZ1eICwDN1dYsIO5u4wzGPdyxye91Ia8QHHD0BU+mUzISd+nwaKGVXvJ7SHafstR
         H6lR/rtp/9ttx2FtMpezmKRATdGD3w8VFSg/o/tgkiXwQT0tKkHOGeLimkXSe1Lvp0X/
         TjlFHEAaLyNZ/88VS7weakOl90fCizjkSTM3HIggMTsqAoXjbTQ8Vd6uQBfn5BXA7dt5
         7qKV2O31VxbFBd30CZGjVmwWsKNpUaHA8hEbf2+PpCIvUek5mbNkXadZ6jFq5mjQeM8N
         jA3+fe+P9DAPfoqOT3zwbDdDDmEY3OngZCl7n3Npftz0DD40P84mZCgvz4QF1DEiN4Fe
         +OhA==
X-Gm-Message-State: AOAM5334w1HpnNVnSeYWg2Rm4jKHAsyq5POEg2xQXN3aX7dFx0WnrZ9u
        LCh4nxhXqb305G1NmBY6vCz3e0aIChU=
X-Google-Smtp-Source: ABdhPJzgEeVkleQ2wCoSD8IC/No2YAJRJY/SvxFYl5Nj/lsQ8x9CenMA4u6MJR1ezw34uxNm+2ATJA==
X-Received: by 2002:a17:902:d2c8:b0:161:bc97:2805 with SMTP id n8-20020a170902d2c800b00161bc972805mr25524691plc.4.1653347372699;
        Mon, 23 May 2022 16:09:32 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id a13-20020a1709027e4d00b0015e8d4eb2d1sm5675922pln.283.2022.05.23.16.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 May 2022 16:09:32 -0700 (PDT)
Message-ID: <5146c8c3-6904-ff27-c2ff-31721f5c6eda@gmail.com>
Date:   Mon, 23 May 2022 16:09:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 2/2] mmc: sdhci-brcmstb: Add ability to increase max
 clock rate for 72116b0
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220520183108.47358-1-kdasu.kdev@gmail.com>
 <20220520183108.47358-3-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220520183108.47358-3-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/20/22 11:31, Kamal Dasu wrote:
> The 72116B0 has improved SDIO controllers that allow the max clock
> rate to be increased from a max of 100MHz to a max of 150MHz. The
> driver will need to get the clock and increase it's default rate
> and override the caps register, that still indicates a max of 100MHz.
> The new clock will be named "sdio_freq" in the DT node's "clock-names"
> list. The driver will use a DT property, "clock-frequency", to
> enable this functionality and will get the actual rate in MHz
> from the property to allow various speeds to be requested.
> 
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
