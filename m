Return-Path: <SRS0=f1/V=DU=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A366C433DF
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 15:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA8525220
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Oct 2020 15:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f5lLOyG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgJMP4C (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbgJMP4C (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Oct 2020 11:56:02 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3B3C0613D0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 08:56:02 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id c2so204504qkf.10
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2020 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=0y5digyfqEWINZYlGh3PIjke80LOTkJWf3I7iMkFpEY=;
        b=f5lLOyG59KVuNw/1m4SvDhx9OFYPCutbM7pKcMx1yOzhEdcN1iVu7O2s09EA6s853W
         eo5Y471agKAAUAf6EEvJ8afMHTlE1b4zoqziOHh/tB0ExP8J6q6YUnx54Je4OFtY/yYe
         OaVn2RLQCYUT6frsfBKODnEypKJaVxDdj8fp3T6D3LyLGTfgGnxK5Vyg/MT684hPQ1Bq
         MeI0FeJqN1E58+N8hdGytZLxLahcnJ0GUFbxgsz+KReWVCEQL5x1kBAaMWjRXAJAlwbk
         3TIABX2hpGl6h3DaoLlzQDZ9Wzz/Fwd0H49kAxVNiUn3KIvz3mAZ4mTyVFbky2FNeuKg
         MQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0y5digyfqEWINZYlGh3PIjke80LOTkJWf3I7iMkFpEY=;
        b=r3yYUGiyLda8rsajot3Pg2ZLPfSBp9ANXwTP7HJqTVi3XrV8J8KRrgylDuyNo3jBXH
         OW6c5G+UkRnuTkgysV8kOYmImWDnSQFn7f8Tjirpjq0qKplehiVJw1iY5bCSClPIJLa5
         ur67bzKGf6GnBVqQU2mK4nG4+dq82IZETFEOzL0K0SSXhBntbiO5IIyYtO6u5XCk20e1
         6joB8Qw4aU0bUtp4mp/9xTZ6Edz+VBpqP3xhsvRkpErT55PgrNJIof3W2YK3FLMYZ1uW
         /l7RC4cQmBPmdn6Q9Axrr6Bu/GEPheOWA/8Jjz1MXPCpxwJYinOL47esv+0RovW1F+cR
         Oauw==
X-Gm-Message-State: AOAM531yuEsZZLdy5nRwA0p7cMBtsLOuQKg9Aix+HcWNS1LOUuXGiHTy
        gx1NGVJB8aLR5kPJhWpo/Bf6NwA3+6D1mS4z5ntxm+HOel1VjxIsSt8=
X-Google-Smtp-Source: ABdhPJxoneOEFRdgQls38ZRrImdLCLM/RolMIP7NVJs8jUVWsBizPCqsqf2ZdcO6020V3ek3LxohJEdLJnd/rS5XekY=
X-Received: by 2002:a37:4fc5:: with SMTP id d188mr670760qkb.234.1602604560649;
 Tue, 13 Oct 2020 08:56:00 -0700 (PDT)
MIME-Version: 1.0
From:   Green Wan <green.wan@sifive.com>
Date:   Tue, 13 Oct 2020 23:55:48 +0800
Message-ID: <CAJivOr7kNsa5GYQ99wjFdEHUNHoK-Cq2nzGweyG29YBdtjOJcg@mail.gmail.com>
Subject: Have SPI CRC error(-84) since tx buf is modified during SPI transfer
To:     linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        andreas.koop@zf.com, ShihPo Hung <shihpo.hung@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I found if enabled multicore and used a Sandisk Extreme U3 A2 card as
root file system(ext4). Then, running 'stress-ng-aiol' (async I/O
test) would randomly cause SPI crc error in
./drivers/mmc/host/mmc_spi.c and ./drivers/spi/spi-sifive.c.

"mmcblk0: error -84 transferring data end_request: I/O error, dev
mmcblk0, sector"

After looking into the issue, I found the issue is the same as the
commit, "3a855b7ac7d5021674aa3e1cc9d3bfd6b604e9c0".(enable stable
write) The tx_buf is modified during the SPI transfer and causes the
SD card to fail to check CRC.

There are 2 ways I've tested:
a) Passing 'mmc_core.use_spi_crc=0' to the kernel
    This way can workaround the issue by disabling CRC check. It can
pass 'stress-ng-aiol' consistently.

b) Copy tx_buf before generating the crc and SPI transfer
    /* memcpy sg to another buffer in mmc_spi_data_do()*/
    memcpy(page_address(host->backup_pg) + sg->offset, sg_virt(sg), sg->length);

    This way also can fix the issue and pass the test. But it has low
performance.

Currently, neither of them is a reasonable fix to me. The previous
commit, 'enabling stable write', seems to fix some cases. Maybe it
means we should have other places being blocked before transfer is
done? I would appreciate any thoughts about where to go next.

Thanks,
-
Green
