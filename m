Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40296C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFA520679
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqJrQj+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgEVPvc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 11:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730243AbgEVPvc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 11:51:32 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31C9C061A0E
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2020 08:51:31 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u188so10290206wmu.1
        for <linux-mmc@vger.kernel.org>; Fri, 22 May 2020 08:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ptDc7nrJWtn7P6aAIJf1VCfoCYrKGriWx/Hm0wdZ+LM=;
        b=VqJrQj+y3r+GF52uDWGZ80/WxUXN3HtjWXTbrVrw1LV6l0mVuh9+b1DVkj5HRTme/3
         ywWqzNAn/61nfXyxRbSilDjUBCF/slbo3kiWXRf5K/cGRqboNRajUxe6YwBM/1l8eVHD
         N4II5Wd5wrZ1tcYm9cVJp/n5GjCFRBNJnzccrywHLMWb0RS9HTP2erx/EQWERdOeqzhs
         gZEzlwfJDXbqWY+OWHIcSOrGGZni64Zsy7wlm1Ng3yPm424e/niB9boe6hFS2viCa5dC
         mHgY5g4h/o3BBqDa5zLEb7h7fUJ6Th7uxvxOaZnPJ9MKUlKBF/lerq6rhE3O1kQoLeFI
         7d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ptDc7nrJWtn7P6aAIJf1VCfoCYrKGriWx/Hm0wdZ+LM=;
        b=V7nXf9U8FJHJVWkz5ZWGvy7Iwpn4jnoYppexyrTpo7Uqu0hhkNp13Jieqt2n1shjSW
         IzHVzlzN6cBBVR6sUOF6/4KNdkoZolUc+S97R5NJGo/917cB68rOa0YvoZRWBS5N6dS5
         AWMcx7zUCpXvpVpX7WKfsHOa82JSwzfXB9e8bxS8A1cCS6JWbatsr5XL5vo/OioSbrPL
         CuXKGr+hbFJJ19mBAPExciIig+9eW/8myfTvE2bPAEnOKBChUTcGxQCdvKkKmsZoMpx7
         GuTkuWUj0QE6uOTX1rWEVpYdPdHiC3h6N9LwC2Sex4Hz99HSaQdo8raAOaDmDfDQkvwe
         Wmog==
X-Gm-Message-State: AOAM5338pW8f6YXDVdGgfWIrWumDOma8k0SiGFfpWb+v1xJwFkclssOF
        LjDtG5utoyNpU8cVo/gKeSv19yrvRhA=
X-Google-Smtp-Source: ABdhPJxTvzt4SoETXGXffaBnDmXVN2/LVMNa91F+AquMom0DzpqKyu7U0iJtcO52xJiRGu6oV56WmA==
X-Received: by 2002:a1c:dd44:: with SMTP id u65mr1680925wmg.180.1590162690239;
        Fri, 22 May 2020 08:51:30 -0700 (PDT)
Received: from [192.168.86.31] ([213.191.183.145])
        by smtp.gmail.com with ESMTPSA id m7sm9998436wmc.40.2020.05.22.08.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 08:51:29 -0700 (PDT)
To:     kernelnewbies@kernelnewbies.org
Cc:     linux-mmc@vger.kernel.org
From:   Iskren Chernev <iskren.chernev@gmail.com>
Subject: sdhci_msm issues with cold-plugged SD cards
Message-ID: <491cfef4-4a97-b6e8-0f41-d44e1c73eea4@gmail.com>
Date:   Fri, 22 May 2020 18:51:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


Hello,

I'm trying to add SD Card support to a smartphone (Samsung Galaxy S5). After
configuring the sdhci-msm driver through DT, it all seems to work fine except
the case when the phone boots with the SD card inserted. If the card is
re-inserted, or the driver is polling, or the probe code is forcefully executed
a second time the card is properly detected.

I logged the SD interrupts, commands and responses, and it looks like the
hardware is returning Command Index Error and/or Command End Bit Error via the
Error Interrupt Status Register, which gets converted to -EILSEQ error. On
a second attempt (due to re-insertion, polling or re-execution) these errors
are missing, and the card behaves correctly.

On the downstream kernel, these errors resulting in EILSEQ do not appear, so it
might be related to setup. Also I see that sdhci-msm driver has hardcoded
a SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk, which might imply that polling
should be used (instead Card Detection GPIO), in which case this issue won't
manifest itself. But polling wastes power, and the Card Detect pin works well,
at least for this device, so I feel it can be made better.

Any suggestions on how to track this down are appreciated!

Regards,
Iskren Chernev

