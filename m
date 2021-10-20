Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CDAC433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 20:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B7B5611ED
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Oct 2021 20:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbhJTVAj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhJTVAi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Oct 2021 17:00:38 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB407C06161C;
        Wed, 20 Oct 2021 13:58:23 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w19so515857edd.2;
        Wed, 20 Oct 2021 13:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=p82YL0D5HeYBv9P48l1ubMQJCPT1B3EyFPBHcWoPvPM=;
        b=cNwcJVoCFZ7X0025fVWetlAmRER6U4CpeECs+r3BzxQpK6Lo4oovoSYc2l2t+LRRIC
         aAHlpgn+bsVdrJzV+MdFNSsVb+lDbJmkKBmu2UfpoiL2IlST84vNzDC+yiDSgucnsjVA
         7Rf9Qhv96YOB5E5ac/U+o3PEE0F8ifgcvISjUw67Z+lRdCLQQ06IBGiz89bwUQAVk1go
         nD7nz3GD/R/7rrcIf1CIIBr0kYFU7R35rfC0FH11K6mRnL/qYLKI9cpPkFBFjm8owi98
         +1TVov3yAXTJ9FZj7iaZPq3NWsrZQpys4mHvcqoiUna6UCEqNmI2TfieNJWcNXcaECyc
         jRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p82YL0D5HeYBv9P48l1ubMQJCPT1B3EyFPBHcWoPvPM=;
        b=hdQ+cfU08ridE4P5hI70YvOnLSmqor7kp6oPNT8/5Rn2TtD16U1/RNnO58bd7l8UYz
         fKne0c+avxG/WlBV1gG/Z2XwGhqBQ5lbwk1ViA0eM8vSo9antioWUC/L9do0RUieNrDj
         16nnXOfW2HUzRBKk/PAPkRVqqKAl0TASr6R75scrbVMUZodaLusHYUPfP7wNePhSKycQ
         7fZnHx3/RVTOeWyoDr+wDg5dUESsEF8PawUQG4iM3dxlCAid6L613bY4Fe/yYks4uJdb
         UIoR7FOSXFVgumqQtg6c8ju/D/8eXS0+22VXjuGlek39OQpBUHmD3oBnFQ1kJ3gyNw0V
         TIKw==
X-Gm-Message-State: AOAM532iXPxhrQkKLuH1qzxZO4SMu1FMoVuYyisXHj609aQFYapp2qH9
        dd7oP0m0jw9KD5S8r4Fe0q1h+uyA/dQ=
X-Google-Smtp-Source: ABdhPJwqfJvimEIS2BOKN2FCENYqFv1j80aLjxbRsgh7c8AbCjxmJKnAw+fheMF42FL+GZDS+gMZEQ==
X-Received: by 2002:a50:8ade:: with SMTP id k30mr1741326edk.162.1634763502346;
        Wed, 20 Oct 2021 13:58:22 -0700 (PDT)
Received: from ?IPv6:2001:981:6fec:1:3bbb:3574:7e12:f56f? ([2001:981:6fec:1:3bbb:3574:7e12:f56f])
        by smtp.gmail.com with ESMTPSA id v8sm1735117edj.7.2021.10.20.13.58.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Oct 2021 13:58:22 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] mmc: sdhci-pci: Remove dead code and deduplicate
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Raul E Rangel <rrangel@chromium.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
From:   Ferry Toth <fntoth@gmail.com>
Message-ID: <27fbd7d6-3d44-39f4-9589-06dc6deed572@gmail.com>
Date:   Wed, 20 Oct 2021 22:58:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211014132613.27861-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,
Op 14-10-2021 om 15:26 schreef Andy Shevchenko:
> It appears that one of the supported platform magically worked with
> the custom IRQ handler (any hints how?) while having two PCB designs
> with an opposite CD sense level. Quirking it out reveals the code
> duplication and dead code.
> 
> Patch 1 is code deduplication to save few LOCs.
> Patch 2-5 are dead code removals.

Tested-by: Ferry Toth <ftoth@exalondelft.nl> @ Intel Edison-Arduino board

> In v3:
> - dropped the fix as it has been applied (Ulf)
> - added tag (Adrian)
> - elaborated commit IDs with their short descriptions in patch 3 (Adrian)
> - corrected dependency in patch 5 (Adrian)
> 
> In v2:
> - redone fix to use ->get_cd() instead of quirks (Adrian)
> - due to above transformed previous clean up to the current patch 2
> - added a new patch, i.e. patch 3
> - added commit IDs to patch 4 (Adrian)
> - mentioned dependencies on previous patches in patch 5 and 6 (Adrian)
> 
> Andy Shevchenko (5):
>    mmc: sdhci: Deduplicate sdhci_get_cd_nogpio()
>    mmc: sdhci: Remove unused prototype declaration in the header
>    mmc: sdhci-pci: Remove dead code (struct sdhci_pci_data et al)
>    mmc: sdhci-pci: Remove dead code (cd_gpio, cd_irq et al)
>    mmc: sdhci-pci: Remove dead code (rst_n_gpio et al)
> 
>   drivers/mmc/host/Makefile          |   1 -
>   drivers/mmc/host/sdhci-acpi.c      |  14 +--
>   drivers/mmc/host/sdhci-pci-core.c  | 152 +----------------------------
>   drivers/mmc/host/sdhci-pci-data.c  |   6 --
>   drivers/mmc/host/sdhci-pci.h       |   5 -
>   drivers/mmc/host/sdhci.c           |  19 ++++
>   drivers/mmc/host/sdhci.h           |   2 +-
>   include/linux/mmc/sdhci-pci-data.h |  18 ----
>   8 files changed, 26 insertions(+), 191 deletions(-)
>   delete mode 100644 drivers/mmc/host/sdhci-pci-data.c
>   delete mode 100644 include/linux/mmc/sdhci-pci-data.h
> 

