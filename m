Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8310EC05027
	for <linux-mmc@archiver.kernel.org>; Sun, 29 Jan 2023 23:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjA2XDG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 29 Jan 2023 18:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjA2XDF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2023 18:03:05 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764BB1351D
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:03:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id m8so144131edd.10
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2023 15:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClbLR2ycXtZtBmoRza/OwnVXwTT5zlCJ+XLmEo5PtD8=;
        b=g8/RieEufLG4r+Dms99sKaHel4hmJOAS5i/h9jYuYePsOwnm5mxw5Z1Ex6JEPCsIix
         E1eJ9fRV+X/ax7K9giLWnGhy/1hywyomw+xb+oZ+yTaldIaGu2Cww/xnMj34lA4X+3gr
         SovwQylu7mNQu7qNVTgHF+5Yk7DvNJStscveKUbc18scrgOIoB1t2AX2lLtXlECCFwa9
         aszuIbuyIvB0evUJTyTiJ5jKbCnDI6JCSTP9j4yeeXhlW44xK0sOG/I3lLIYSS8g3NjX
         6WzuLyd39XAEDk3yO7TvAvRpT+5xd05ssUR8RXI6E00SJyGwYXNVT/SP59XQB/RBYlt0
         TaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ClbLR2ycXtZtBmoRza/OwnVXwTT5zlCJ+XLmEo5PtD8=;
        b=4YVCGAVhLVEj+yOBSKmreNy4mE+Hm+cyHGdDSc8cadONGz4JvnnmO4vrJGuAhWzsuz
         7D03qyZHiD9CabAlS58yJjLQXGWI1CdVAD8t1IgOS+NFFJR9uh3vooPRjHC0hu2axpXi
         JDiKgvfpyEYH5kr4fi+r+eRSMyABE56hcoNu6gJOiz6rLLTZ9Mq1RkeYfiAdLs/eKDpd
         yStP9bOAhPs4XTymcmXSGC6Czq+vz97eWvJEYABvYA/L4API/vKBI9/pqz3UuRA5FCx5
         Eh/q9Vg6GMMYRj3c6+0uJn+txm7B3kpOkxtv6B5XQuH8udup+sSK5WTiyMBBjFc6FgwV
         zB8w==
X-Gm-Message-State: AO0yUKWq05T+HsBCJtybzEfVBAXEExsBGHhcUQddywgkiLiJTe+8rlkn
        TNIQTxV6OENExjOSLlricOA=
X-Google-Smtp-Source: AK7set9ckDsq2gdZ9eivTBNoUFmQ9mkK7SgOCMcECtXrBTHIME4I0GU83O6qhDmQ0gD7N+U+2urCiA==
X-Received: by 2002:a05:6402:339:b0:4a2:2e8a:14cb with SMTP id q25-20020a056402033900b004a22e8a14cbmr5804897edw.2.1675033382832;
        Sun, 29 Jan 2023 15:03:02 -0800 (PST)
Received: from ?IPV6:2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4? (dynamic-2a01-0c23-c5b5-3100-78bb-34b6-bd6e-6fb4.c23.pool.telefonica.de. [2a01:c23:c5b5:3100:78bb:34b6:bd6e:6fb4])
        by smtp.googlemail.com with ESMTPSA id cm17-20020a0564020c9100b004a21263bbaasm4047767edb.49.2023.01.29.15.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 15:03:02 -0800 (PST)
Message-ID: <dfb90ca4-1f62-e3ed-2ce4-a7b5f661e36d@gmail.com>
Date:   Mon, 30 Jan 2023 00:02:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH 0/2] mmc: meson-gx: support platform interrupt as card detect
 interrupt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On certain platforms like Amlogic Meson gpiod_to_irq() isn't supported
due to the design of gpio / interrupt controller. Therefore provide an
option to specify the cd interrupt e.g. by device tree. The host
controller can store the interrupt in cd_irq for use by
mmc_gpiod_request_cd_irq().

Heiner Kallweit (2):
  mmc: core: support platform interrupt as card detect interrupt
  mmc: meson-gx: support platform interrupt as card detect interrupt

 drivers/mmc/core/slot-gpio.c    | 2 +-
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 include/linux/mmc/host.h        | 1 +
 3 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.39.1

