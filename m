Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BAF6C67871
	for <linux-mmc@archiver.kernel.org>; Mon, 24 Oct 2022 20:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiJXUDl (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiJXUDM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 24 Oct 2022 16:03:12 -0400
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A72EF19;
        Mon, 24 Oct 2022 11:24:32 -0700 (PDT)
Received: by mail-qv1-f42.google.com with SMTP id x13so5545898qvn.6;
        Mon, 24 Oct 2022 11:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mq5s7oy0Tla8MTN8FSmLqY4U2A2/0B/wrWqKIioZAzY=;
        b=gC0l5ACd97J3Bb3ZayP0I2BJMxirqhSqm5wN3UtL1Vw3vYVFMfn2gUyL6pMJfW4DYH
         3RC7wOv2C+0jUtdJ/F+Ht3zSxpN3i5/kPEJ+/jQjATIl39BPxDJk/eKNEjPGZefEhWeI
         lcz34IP5K7KcfJylLQr0O76AyYqoPgneKt6b58B+lwym5fxcQ0eYnmmywJwjF58fRGHU
         Gt5w0fQmawFkAU9q0l9Qo06kPOF9WDiEMmr7rXlFWZHGh7vVeB27CxgjXz74UzCaLWnw
         Lk+xv979WNLbHj1zHp5tToWdz1kIz0fTmGjAPQweY/e0wuPb7mMDk36qKbULV6B1X5Tk
         Gi2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq5s7oy0Tla8MTN8FSmLqY4U2A2/0B/wrWqKIioZAzY=;
        b=GNO/Iw23G3pJaCAgaj1NbPJGvhZAkK4ptHToXrRpp20XzjuRQd3u8P+sInqoYHy+Mm
         MqiZ2wM5M0HYf1Tu9dN3NJg3Ff2nHUZduYktbCPHb73FOZR5f5q2t9OoDIvR1dgoawHg
         SPFbIE0ZCB3xDCBe85IChRENm1WQXwa1wR/pUYCrJW5akE3N32LGK6oFm5YnN5AMLkcg
         drJ4NAxidXcd7n0cUhCz6MuWO/lkGZA7FGddvuk065Ddg2mFYbCIcnfffB+WAilbWZ+o
         TM0CkwtEeb/nQTBDfLsKY7j6VQIQuqu0LPpIHS2htVa+lOlO3dLDnt8J0WB1LIk4WRYP
         u+6g==
X-Gm-Message-State: ACrzQf1kdi2NH8GxgIObwSIBSCgJukl714CwjPLegUCyFCtirhnRM2No
        +4+Qun+B+xk1rUZDlGHn/mY=
X-Google-Smtp-Source: AMsMyM5sOf5+LqlBIgt4nCoYtOuBfyHj2ZmO1oA3G5LYnMe8N977VJTuHd1rOteffA19Q5l1MkVjVA==
X-Received: by 2002:a05:6214:29c9:b0:4b3:fcfe:3731 with SMTP id gh9-20020a05621429c900b004b3fcfe3731mr28607115qvb.29.1666635759856;
        Mon, 24 Oct 2022 11:22:39 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f14-20020a05620a280e00b006eec09eed39sm441937qkp.40.2022.10.24.11.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:22:39 -0700 (PDT)
Message-ID: <3a74affc-8e17-5d84-5a65-3948dd3a624b@gmail.com>
Date:   Mon, 24 Oct 2022 11:22:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] mmc: sdhci-brcmstb: Allow building with COMPILE_TEST
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-mmc@vger.kernel.org
References: <20221024181759.2355583-1-briannorris@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20221024181759.2355583-1-briannorris@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/24/22 11:17, Brian Norris wrote:
> This driver is pretty simple, and it can be useful to build it (for
> validation purposes) without BMIPS or ARCH_BRCMSTB.
> 
> It technically depends on CONFIG_OF to do anything useful at runtime,
> but it still works out OK for compile-testing using the !OF stubs.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

Yeah, really no reason not to let you build it, thanks Brian!
-- 
Florian

