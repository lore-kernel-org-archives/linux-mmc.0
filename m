Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0351C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Apr 2022 17:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiDVR1p (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Apr 2022 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiDVR1p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Apr 2022 13:27:45 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC927B6D18;
        Fri, 22 Apr 2022 10:24:44 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b7so12276042plh.2;
        Fri, 22 Apr 2022 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=lAqkZvINpgNz8/aD0yPnpAot6tZ2geN0RWeM0UzjlI8=;
        b=UL4sGjsKtItvqT6/gH3WoIcqP63X57bdRKAq3k7e9xfGhz/lzR7MTzjo8Zc+SkcM97
         qgSoVtKPJsXPmwZsctAlVx2f2k9vGWllbxGSwy640oF7Pi5++MzpcK7/1zFOiBbI4WHn
         R13LypCLRiGNq7sJ0S1qT+8HRYjmJgO4snQSs1k7jvsFtePhImB61Z4h96LURZZj65Mw
         l0ibe4aRfMycih9LI8toV4dhPmyUJGDhdsOAaXa/JkyQuE5FIH4sUqfivnCNxiQLafrf
         bpHP9QvFMspYARGpp3EHa7QSnojLYiMPk1UtMoMwJSbuk208GuEPiQCjR37e+X2GJ2mP
         V7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lAqkZvINpgNz8/aD0yPnpAot6tZ2geN0RWeM0UzjlI8=;
        b=pWvzrnLPHg+9JA01tVQ1fGGhLsjN/vw6VlqDxUqRFS/smFn5TpBsdhOMvWKVj6HvjX
         r86nuuyuEyiShKy8vZZ5e3RFThOISXoVnf4gYlvyW37bo3qxZQsw4KSjE8nw3jrPREfO
         uSglAjDqIsULw67MZgGt5NPPPjVFvbf2lxEKfVS2izIzzOlVNRTjysOoMTNUT3K6UbL9
         LDKPTUZCQC+ui4pKTNEtHfOHaOOLkyht3F0PF5Rk7LTRQPAfy5Bq+7+ydpM/Mn73w0YI
         T32A/0IDR/cQFlY5l1EpfxEVSA69U39/GIEe8t5Vc+isuk+Acm+MOUH4G8ckR22q2eF/
         X2aQ==
X-Gm-Message-State: AOAM533Tz9H08l4MDofI+Eq6py1aeuS6kwgfLotI0O0OfBzTb6FabTLP
        tmW9giyOo4J1ScpStR2BHcnSPkvFVu8=
X-Google-Smtp-Source: ABdhPJxb9NL+GJqHE1pa/S+qUMK1JNobr/j1j23uv7kEHBkHtIZoiZJMBlWACpzZNwsjvjY7YiexQg==
X-Received: by 2002:a17:902:b10c:b0:154:a3b5:b33a with SMTP id q12-20020a170902b10c00b00154a3b5b33amr5491418plr.3.1650647663605;
        Fri, 22 Apr 2022 10:14:23 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id b13-20020a056a00114d00b004c122b90703sm3188794pfm.27.2022.04.22.10.14.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:14:23 -0700 (PDT)
Message-ID: <767923aa-caf6-dea2-1504-2a15058df5e7@gmail.com>
Date:   Fri, 22 Apr 2022 10:14:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/5] mmc: sdhci-brcmstb: "mmc1: Internal clock never
 stabilised." seen on 72113
Content-Language: en-US
To:     Kamal Dasu <kdasu.kdev@gmail.com>, ulf.hansson@linaro.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, alcooperx@gmail.com
Cc:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220421182803.6495-1-kdasu.kdev@gmail.com>
 <20220421182803.6495-2-kdasu.kdev@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220421182803.6495-2-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 4/21/22 11:27, Kamal Dasu wrote:
> From: Al Cooper <alcooperx@gmail.com>
> 
> The problem is in the .shutdown callback that was added to the
> sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
> shutdown callback will just call the sdhci_pltfm_suspend() function
> to suspend the lower level driver and then stop the sdhci system
> clock. The problem is that in some cases there can be a worker
> thread in the "system_freezable_wq" work queue that is scanning
> for a device every second. In normal system suspend, this queue
> is suspended before the driver suspend is called. In shutdown the
> queue is not suspended and the thread my run after we stop the
> sdhci clock in the shutdown callback which will cause the "clock
> never stabilised" error. The solution will be to have the shutdown
> callback cancel the worker thread before calling suspend (and
> stopping the sdhci clock).
> 
> NOTE: This is only happening on systems with the Legacy RPi SDIO
> core because that's the only controller that doesn't have the
> presence signal and needs to use a worker thread to do a 1 second
> poll loop.
> 
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
