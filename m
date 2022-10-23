Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E99EC04A95
	for <linux-mmc@archiver.kernel.org>; Sun, 23 Oct 2022 02:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiJWCMp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 22 Oct 2022 22:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiJWCMl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2022 22:12:41 -0400
X-Greylist: delayed 222 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 22 Oct 2022 19:12:39 PDT
Received: from 014.lax.mailroute.net (014.lax.mailroute.net [199.89.1.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FB97F273
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 19:12:39 -0700 (PDT)
Received: from 003.lax.mailroute.net (relayout.lax.mailroute.net [199.89.1.119])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by 014.lax.mailroute.net (Postfix) with ESMTPS id 4Mw1pf07Dmz3Gxsr
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 02:08:58 +0000 (UTC)
Received: from localhost (003.lax.mailroute.net [127.0.0.1])
        by 003.lax.mailroute.net (Postfix) with ESMTP id 4Mw1pd268Hz1spkm
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 02:08:57 +0000 (UTC)
X-Virus-Scanned: by MailRoute
Received: from 003.lax.mailroute.net ([199.89.1.6])
        by localhost (003.lax [127.0.0.1]) (mroute_mailscanner, port 10026)
        with LMTP id qMsbIZZgxjjB for <linux-mmc@vger.kernel.org>;
        Sun, 23 Oct 2022 02:08:56 +0000 (UTC)
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by 003.lax.mailroute.net (Postfix) with ESMTPS id 4Mw1pc1PTZz1spkf
        for <linux-mmc@vger.kernel.org>; Sun, 23 Oct 2022 02:08:56 +0000 (UTC)
Received: by mail-pg1-f199.google.com with SMTP id x16-20020a63b210000000b0045f5c1e18d0so2958248pge.0
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2022 19:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=googled;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4buRFRGWnnlKIHql0Q3qqpGLkPRxc7dJGxBLjsZx+7k=;
        b=gHDPNqOQBs68kFLX07Qc8yCj+HUCAxaB2KUMqDN7ASOV8uQ9lPx4i8APW46VkpBG6y
         jrMT3BGjO3M7bIbA7Igyry5dJaTXwM3w2e+054BMLvtnc2r47Hb1JrV5LIvnilCchuch
         Ld8U/3+GXwNZjDXn9lq7aB7uSXMrRdXw9zLrfXl3+6w1wsIrql82s2wD6TjqXuAtLck4
         dgEF1OtrWhs1aLBo2PJsaIp1/oiBRQoKF1eEM1G9Oqx3nsHsBkZ09Ps0Xms435XnSMo4
         bIrmfgJYwSUefDKoByjxBJRC2XeCs7vyVjujK0BbtzTqgVLX8Eynzh7gcQ98nRg0xTDC
         jCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4buRFRGWnnlKIHql0Q3qqpGLkPRxc7dJGxBLjsZx+7k=;
        b=KaCEpmWcivkXJqkcYXjvnt0aFtYAw04rmRwiS6BprcvUZQiLstC9p1+tigaDtGim7K
         N+0KyVNGgfL6yYPnekxE7tk88N2PUT9IwiC0k/G9ulG96O0+qPg2dpn9lhtYwgkPP3Lr
         UIYCMnzSlKHIFHxrFLXZ3aZMjyLE9ViHMsF/WFFMCEyuG5WYJahmqQJt85og8K7mzBPZ
         JIitywMxYPiySTMpJ2Ocl3l/1OF+5jUKKhGvSXQ9j0MRkSxE/qZLVop6GPstdITPVDY8
         QA+h77A59+vRHGWtPdXj6CV10KfGN4Yx9QCinoTFds8LmGifvxwJuDNXVZj+r6gEwfCl
         XT3Q==
X-Gm-Message-State: ACrzQf1gTG7B5uYT3H5Pnj4W7+jYnNHsAr8Nv5b1qbIG8C0A/aTKJLW9
        WwBTsT8lPSrY5XYQSzZ3jljLjqfFCdBBa9fQ6Jy9B7kyxyqHOK0PzA2rhyWICCv1pz1U6wxwyFE
        Qt4y4mhRX+cWKsUdTy1uJpmhWh3qiRuREj8WCB4XtvBoaKWMGsxM=
X-Received: by 2002:a17:90b:4b0c:b0:20d:233f:5dea with SMTP id lx12-20020a17090b4b0c00b0020d233f5deamr30474214pjb.241.1666490934611;
        Sat, 22 Oct 2022 19:08:54 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM618i2VOUVwKcFjPt4cd8TCwTQ441RgVBvlLk5fztFUDwWKpFQQG4F3JkRMo7mgCqUcHtS4duAgAhoJKaUeWv8=
X-Received: by 2002:a17:90b:4b0c:b0:20d:233f:5dea with SMTP id
 lx12-20020a17090b4b0c00b0020d233f5deamr30474187pjb.241.1666490934285; Sat, 22
 Oct 2022 19:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <Y1PydJnbL/9CRFFn@sol.ermione.com>
In-Reply-To: <Y1PydJnbL/9CRFFn@sol.ermione.com>
From:   Slade Watkins <srw@sladewatkins.net>
Date:   Sat, 22 Oct 2022 22:08:43 -0400
Message-ID: <CA+pv=HNmYsh_y1+so_p=MNePNyV-A-FQ-iX2ivvSWDuyYcPnSQ@mail.gmail.com>
Subject: Re: mmc: sdhci-pci-core: Disable ES for ASUS BIOS on Jasper Lake
To:     Andrea Baldoni <erm25d019@ermione.com>
Cc:     Patrick Thompson <ptf@google.com>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, Oct 22, 2022 at 8:36 PM Andrea Baldoni <erm25d019@ermione.com> wrote:
>
> Hello.
> I am not subscribed to the list so please CC to my address.
>
> I recently bought a new ASUS Laptop E210KA-GJ059WS with
>
> 00:1a.0 SD Host controller: Intel Corporation Device 4dc4 (rev 01) (prog-if 01)
>         Subsystem: ASUSTeK Computer Inc. Device 1842
>         Flags: bus master, fast devsel, latency 0, IRQ 16, IOMMU group 7
>         Memory at 6001129000 (64-bit, non-prefetchable) [size=4K]
>         Capabilities: [80] Power Management version 3
>         Capabilities: [90] Vendor Specific Information: Len=14 <?>
>         Kernel driver in use: sdhci-pci
>
> I tried to install Linux (vanilla kernel 5.19.4) and found that the internal
> 128GB eMMC SSD was unuseable, unable to make a filesystem on it, dmesg shown
>
> mmc0: running CQE recovery
> and
> mmc0: cqhci: timeout for tag 0
> followed by register dump
>
> (unfortunately I don't have the exact log now).
>
> I found the patch to drivers/mmc/host/sdhci-pci-core.c posted by
> Patrick Thompson date Thu, 13 Oct 2022 17:00:17 -0400, and applied it,
> but the only way to make the eMMC work was to disable
> CQE in its entirety by commenting

This one I assume?[1]

>
> slot->host->mmc->caps2 |= MMC_CAP2_CQE;
> and
> slot->host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>
> If someone would like me to do any targeted test to be able to solve the
> issue better, I will be happy to do it.
>
> At the moment I am also searching how to get the touchpad to work, I would
> appreciate any hint and/or a contact with someone who has experience on
> this.
>
> I think the relevant device should be this one, but it doesn't show in
> /proc/bus/input/devices.
>
> P: /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
> E: DEVPATH=/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/device:6c/ASUE1409:00
> E: ID_VENDOR_FROM_DATABASE=Asuscom Network Inc
> E: MODALIAS=acpi:ASUE1409:PNP0C50:
> E: SUBSYSTEM=acpi
> E: USEC_INITIALIZED=10378637
>
> Thank you.
>
> Best regards,
> Andrea Baldoni

Also looping in +acpi and mmc lists, +Patrick Thompson here.

[1] https://lore.kernel.org/linux-mmc/20221013210017.3751025-1-ptf@google.com/

Best,
-srw
