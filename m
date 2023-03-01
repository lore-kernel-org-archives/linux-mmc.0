Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06A60C7EE23
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Mar 2023 23:33:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCAXdD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAXdB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Mar 2023 18:33:01 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B363864E
        for <linux-mmc@vger.kernel.org>; Wed,  1 Mar 2023 15:32:58 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id s13so4986628uac.8
        for <linux-mmc@vger.kernel.org>; Wed, 01 Mar 2023 15:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FeuWO1CjmVd+hjiHrdfFptk3qAqxlXVOpLYxHpbPoMk=;
        b=WJnh5hlGci68HiRLyG79x3u4rovbsavBZHZuR8lMJCuQbybDL2liIrmKv/gzFSNTLF
         Mhk4fUTjpJVcxCw/2fiU3/xmdKCzxA+zINwPRhVGsy8dAgNJgQtg5j9TyKg2XU7OTh3j
         JQYLOdGR2ehMLg3r0WrSm1wbVfF9s5efcCpWPI9E2YKTrqCHyBFHzl1SOxaHE2k2vBYB
         C53K+XmXlc594gCMULLcpmwbxz3GlAt+9Nk3bs8ccrpIb2G0hQtLWGbACynAmihOzKYa
         CiG6L9qz1Ocdbo521fd3B6iCeYMW+PY9orV14/wBXt1iyOv7bo4LHCXMNhXcE0nhhb3b
         2BXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeuWO1CjmVd+hjiHrdfFptk3qAqxlXVOpLYxHpbPoMk=;
        b=23rgUqJp6X8b5asr+G5INSmiHSnQkgb1Ie0wrzc5IaXLVnz4MNbzgDzp1438zQMMvd
         5D705MYQVroMVnMhk7i5WI4PKLasLVgojnRqmhw1eCAmFUvYr1u2B9D/Scnv6TrAdlUr
         +/+vJPjv9h6iUbkRgvhzG6f2VN3VqfHkTpfglY8OCLc7efn8x9amNmIVo5KNr5bAJkcm
         f+7fyYCTb7oByMHB2HH5NhVUS+14LVBAaNp0FJc0Us0eLibou6Vfr75lcQLidijeyKxX
         5ZUxs44AHl6kToQlhm0Tok6+0BeNVoylJeBaE20VuoTOd2QODHdJ1XPoqF4s3gWRBs+8
         9ruQ==
X-Gm-Message-State: AO0yUKVtgXwsPym9MEPXHXsrRVyHSa1AVLCxFvKMo2IqG6bc4FYSghfR
        hVjsvkRZgXZ89KDXrsMnUJFrzTx746Fw9xX5LESU/A==
X-Google-Smtp-Source: AK7set9+Szwg/MF+U5fSr1gGmRga2npeRJiCdtd+i0GE46DrxKPQzMKQxRY1Hf2q/WM0J9f0VNUjzxafeTFF7J3FXGA=
X-Received: by 2002:a05:6122:1210:b0:401:73f4:dfe with SMTP id
 v16-20020a056122121000b0040173f40dfemr4563991vkc.3.1677713577603; Wed, 01 Mar
 2023 15:32:57 -0800 (PST)
MIME-Version: 1.0
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 1 Mar 2023 15:32:46 -0800
Message-ID: <CAJ+vNU2SC_Q3RWdeO9-mKDYC_TK8_vzefvGz_++O8StJer_h3Q@mail.gmail.com>
Subject: mmc: core: Disable card detect during shutdown
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tony Lindgren <tony@atomide.com>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Jan Glauber <jan.glauber@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Greetings,

I've encountered a hang on shutdown on octeontx (CN8030 SoC, THUNDERX
architecture) that I bisected to commit 66c915d09b94 ("mmc: core:
Disable card detect during shutdown").

It looks like the OMP5 Pyra ran into this as well related to a
malfunctioning driver [1]

In the case of MMC_CAVIUM_THUNDERX the host controller supports
multiple slots each having their own CMD signal but shared clk/data
via the following dt:

mmc@1,4 {
        compatible = "cavium,thunder-8890-mmc";
        reg = <0xc00 0x00 0x00 0x00 0x00>;
        #address-cells = <0x01>;
        #size-cells = <0x00>;
        clocks = <0x0b>;

        /* eMMC */
        mmc-slot@0 {
                compatible = "mmc-slot";
                reg = <0>;
                vmmc-supply = <&mmc_supply_3v3>;
                max-frequency = <35000000>;
                no-1-8-v;
                bus-width = <8>;
                no-sdio;
                no-sd;
                mmc-ddr-3_3v;
                cap-mmc-highspeed;
        };

        /* microSD */
        mmc-slot@1 {
                compatible = "mmc-slot";
                reg = <1>;
                vmmc-supply = <&mmc_supply_3v3>;
                max-frequency = <35000000>;
                no-1-8-v;
                broken-cd;
                bus-width = <4>;
                cap-sd-highspeed;
        };
};

mmc_add_host is only called once for mmc0 and I can't see any printk
debugging added to __mmc_stop_host (maybe because serial/console has
been disabled by that point?).

It appears that what causes this hang is the 'broken-cd' which enables
the detect change polling on mmc1. I have the ability to flip the CMD
signal routing thus making mmc0 the microSD and mmc1 the eMMC and when
I do that there isn't an issue so I think what happens is in the case
where mmc polling is enabled on mmc1 but not mmc0 (as above) the
polling causes a hang after __mmc_stop_host() is called for mmc0.

Any ideas?

Best Regards,

Tim

[1] https://lore.kernel.org/all/55A0788B-03E8-457E-B093-40FD93F1B9F3@goldelico.com/
