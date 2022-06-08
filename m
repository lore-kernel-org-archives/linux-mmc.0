Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CD5C43334
	for <linux-mmc@archiver.kernel.org>; Wed,  8 Jun 2022 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbiFHRWa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 8 Jun 2022 13:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiFHRWW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Jun 2022 13:22:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D59A94AF49B
        for <linux-mmc@vger.kernel.org>; Wed,  8 Jun 2022 10:13:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id p10so29194311wrg.12
        for <linux-mmc@vger.kernel.org>; Wed, 08 Jun 2022 10:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v+GRs44ZAaCp+LmoA0Cy0UHC9B5TNPhLzc4XBlKlRTo=;
        b=hD81EXZWqyx/co7W/gf5GnU9GUtXPEgMAioMsT+GWekm+tuav8KGKCdXziFPvH04/6
         9Xu6DxyqjAF6hPIBZwu0EceEN4x3pASI87/zXb8nQd2YshEUp+eeJ7kz6FyJKAUs0iDb
         MWjIW2CKumSxIj53VjH4e35KJ86gPUUQC7JlXXfyDfBz1rto663/xVAR7BmWYi9hw3NY
         Oq1Wcn7Lnuq1e1sx80VkHjscYbJD91L0WcoDOTdzFhrretv3w6o4vrlssMzaCiw54GPp
         DKP7qDgxrAzl+rEthXs9qYFpt03+KCUR3ixggR9S9/qYBoAzc1dQ+c8Jgifa5niLyhzT
         3OHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v+GRs44ZAaCp+LmoA0Cy0UHC9B5TNPhLzc4XBlKlRTo=;
        b=iYqGuD2YhuTePDXDmkjxUOyS+cxm5MoNnOnv4k8U0vaMTE5F0Sydkr0AlT8+fU0OjX
         kngUsA1p3XbtiSeUVR7IMhk4fLt9gSL6OW4bueirNuAd4ygCzQFRZ3Q/VlvEONXeJrSO
         zgf2cIocQtbzHGUDOUjcyatztYMnXoQD4kiDnxvj1Bh3+G2CxeUd7bT5rle/GPSXQV6e
         gW8CnqHRqOdqL8UcuS6X2PFf3rJmtIGRJIYa4iZeFws3IG8OfGOjHdx1Lo2d4pgQmZop
         6c1P+8J7rwcUscQqnqh5mTfTedYb0mlgdY5oM1NcdYbyJz95yWHAoxVgAH9i8LIfi5CD
         gAhA==
X-Gm-Message-State: AOAM5316y1znmWjf+ugI/QEup+BnAKLopXK7s5Qw5n7awfeyNlYvTRgi
        6K48puEqvwAtSPuiwMvzz8E=
X-Google-Smtp-Source: ABdhPJwkgF72nHBSu7q9qGTg8h+atXBju2MmrOTs/inNaJwRb7OsEfkkDX6uot0cngO8WakstveCDw==
X-Received: by 2002:adf:b644:0:b0:210:1fde:a513 with SMTP id i4-20020adfb644000000b002101fdea513mr36197690wre.604.1654708385227;
        Wed, 08 Jun 2022 10:13:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:58e:6120:8c0d:a21d:4424:54a3? ([2a01:e0a:58e:6120:8c0d:a21d:4424:54a3])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b003973435c517sm23631084wmq.0.2022.06.08.10.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 10:13:04 -0700 (PDT)
Message-ID: <51542057-4b25-7897-b2a0-d5027af869ea@gmail.com>
Date:   Wed, 8 Jun 2022 19:13:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Initialize base_clk to NULL in
 sdhci_brcmstb_probe()
Content-Language: en-US
To:     Nathan Chancellor <nathan@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Justin Stitt <jstitt007@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>
References: <20220608152757.82529-1-nathan@kernel.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220608152757.82529-1-nathan@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 6/8/2022 5:27 PM, Nathan Chancellor wrote:
> Clang warns a few times along the lines of:
> 
>    drivers/mmc/host/sdhci-brcmstb.c:302:6: warning: variable 'base_clk' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
>            if (res)
>                ^~~
>    drivers/mmc/host/sdhci-brcmstb.c:376:24: note: uninitialized use occurs here
>            clk_disable_unprepare(base_clk);
>                                  ^~~~~~~~
> 
> base_clk is used in the error path before it is initialized. Initialize
> it to NULL, as clk_disable_unprepare() calls clk_disable() and
> clk_unprepare(), which both handle NULL pointers gracefully.
> 
> Fixes: 2cecaac1b21c ("mmc: sdhci-brcmstb: Add ability to increase max clock rate for 72116b0")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1650
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
