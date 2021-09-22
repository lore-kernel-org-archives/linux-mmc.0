Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BD0C433F5
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 17:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B5D61156
	for <linux-mmc@archiver.kernel.org>; Wed, 22 Sep 2021 17:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhIVRtW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 22 Sep 2021 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbhIVRtW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 22 Sep 2021 13:49:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298BBC061574
        for <linux-mmc@vger.kernel.org>; Wed, 22 Sep 2021 10:47:52 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id t189so5632278oie.7
        for <linux-mmc@vger.kernel.org>; Wed, 22 Sep 2021 10:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=v7LJlSltaGEJUA4QcSw4axWM6tAbHHqLFLsNxJ1eSUg=;
        b=aLtiIIZJzyibMfdJVE1sMoR3yGDncXHcVsBsgOuhCXPf5Hwg38h4IJJmG4GrQtvvMd
         HPJ7th9Z9BkSxtWOzgNKmxxOF9dejSvBFycnZ/GNzb1JeCFBx4aZotX/R3fNJ1LQy5gR
         TUbcwMjBsBlGa6v69bb++0THAi6crv7d6jMeHw8cMmyt2d5rXLIpjtWXUSS0C5HYpMI/
         3MW9kcCK6SoVD7tRk83C5e8XUh203bWhLIwuBvf0EGtJfaKUq8AdHUi2xgy7qYqNc/7g
         tqFi6vufQm7yWdw6ZYpNBLOm4EbMDjq9DZFnsjRKSS86ZgIM+1wX8MvEju6Jgp8P8o4i
         hv0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v7LJlSltaGEJUA4QcSw4axWM6tAbHHqLFLsNxJ1eSUg=;
        b=P4Rez9RvVnGQDdzgKbIIeTONFq4hyN3VAHuSz1/tFU6kpxofeLPZ3FI2gy2LY8990l
         GTPaL0ovtIrtMnJ16vw2lkmc50BSlTFEBQkQLoF7yufv+xSeCR4XR0V81KMvEi6maJR+
         N19cy5IOzBjrZg5cxkOQ9xlabRaxEonIn1My5rLtteLcXtYYKi0Pr/l7/FubjYLxVf0Z
         y/oD9foa1tSeuECLZxp7u8hRNcO8PHtNT1DGWTZWo6+hQ6mvkI8AYxpFQFfCzJzVwKyf
         Y5/X2J0AKYQzxF+ATKtz8cA3cHUgZZwO/T4+T99nRbjUJLQLj498KH/2uFh6QH7/2vyS
         mAGg==
X-Gm-Message-State: AOAM530vlGkKVs1Vsd+pxpwIy0pRtt0fncGIXX0fsRVBTQSkHMWA+SRi
        7VV45POXqZ0Fzu1qIl015VccUWFCv0RbFmprRXcDE1/bwaA=
X-Google-Smtp-Source: ABdhPJwAn1bjRGz49R6RprxXYnkd8gQJ3dvFMVP0IlXgI71VzLT7FJnN4jytdhItJx1ompk/Q9b5o7T0YOsbWe0rn2s=
X-Received: by 2002:a05:6808:64f:: with SMTP id z15mr5058831oih.65.1632332871575;
 Wed, 22 Sep 2021 10:47:51 -0700 (PDT)
MIME-Version: 1.0
From:   Kegl Rohit <keglrohit@gmail.com>
Date:   Wed, 22 Sep 2021 19:47:41 +0200
Message-ID: <CAMeyCbhTcwcksdNC-1r5487oX-rmfmcdGiBiVng6E338hWzbEA@mail.gmail.com>
Subject: CM23: Reliable Write Request / Forced Programming Bits
To:     linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

I have a question about the transfer of CM23 (SET_BLOCK_COUNT),
before starting a multiple block write CMD25.
I want to set some of this CMD23 bits:
BIT(31) stands for Reliable Write Request
BIT(24) stands for Forced Programming

I could only see usage of the Reliable Write Request for some rpmb ioctl:
https://github.com/torvalds/linux/blob/master/include/uapi/linux/mmc/ioctl.h#L13
https://github.com/torvalds/linux/blob/master/drivers/mmc/core/block.c#L550
sbc.arg = data.blocks | (idata->ic.write_flag & BIT(31));

But there are also BITS MMC_DATA_REL_WR, MMC_DATA_FORCED_PRG
https://github.com/torvalds/linux/blob/master/include/linux/mmc/core.h#L128
Used here:
https://github.com/torvalds/linux/blob/master/drivers/mmc/core/block.c#L1301
Which confuses me.

I am using the mmc_test code as example to execute a mmc block write.
https://github.com/torvalds/linux/blob/master/drivers/mmc/core/mmc_test.c#L190
So i set the BIT(24):
mrq->sbc->arg = blocks | BIT(24);
But then i realized that the sdhci mmc host uses SDHCI_AUTO_CMD23 and
mmc_test_prepare_sbc simply returns doing nothing.

What would be the correct way to set the BIT(24) with CMD23 in the
mmc_test example with a host which does SDHCI_AUTO_CMD23?
