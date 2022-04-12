Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14115C433FE
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Apr 2022 23:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiDLX0M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Apr 2022 19:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiDLXZx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2022 19:25:53 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF89D1103
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 15:11:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id g20so180661edw.6
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2022 15:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FgvCys/ehU+zE5XyhrxTQ6p/VJvNapmjh6tDNrzZkT0=;
        b=f0Kp0RGf2sfFO5uqbbSQM0E+mlrY/5GhjYLTC4GojO9TRWmKDVzX/7+/WgjZT9jc6u
         HDCjwK7yAUO2FixaPCqXmfv0D4UlI1eCAAKMrEqO4AtW4WJExvQYZYl7oSvxarGXGCDb
         UEoxDk+e7tnbfbpct6lQ6Jm9OiJUHpSC7d39QBY6Q/rnfcWfJrKEvh/lhxcbp6MIB+7V
         VwhNgRtxNMcUdzCva0fDjsvvdX7AOYMYFDiNx1uioelPg19AyN2EaO5LFY/F5iRleXQn
         bLP8dL0pk5LBuMZ2sLGrqc8CU8a13UbjL2EWG3AXFD/7EBraTUh8+pgym7N214l0LT1r
         mhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FgvCys/ehU+zE5XyhrxTQ6p/VJvNapmjh6tDNrzZkT0=;
        b=DMI/oxT/artW5ItNoxnFUxpmRojOcSc85R7eQetFu8l2VmojHKLZeq/889hODSGUpM
         O2W5thH2AwKdpYDVkhdiqzWSYGkAeBKBB7Y2tyE8+/1QACmXWAiFEb1iYqW54PK+j0IM
         DNh6seC9xc2nyhb98qrFw2mw69sU92Sj9jLZnxakapCK52m0PE1WUpZNkXFpm9XLvQcG
         u//H/XIsHpnpuH2SSgaIVaysSNuBcR5zTADmy/fSHVKA3dvKJr5Gc6dCLLWJw4XPxFI/
         cs4VqAeUFTAMZKBtgBeZtHhKKCJS1Wsl/o8Z/ND/T0vfPSbuGzX/C1pHzT3T3A+fEws7
         5zVA==
X-Gm-Message-State: AOAM5331aCD1aLm78aRkcn+LC6Pes41oPJt3I0jnqNGDdXf21yJi9IXj
        MzCUqMk1/H93GnT/+oAPQLYgqJWsiDntxHpytxiTmCtd
X-Google-Smtp-Source: ABdhPJyYtdJq1lnHh+SctcqdoAx7Ds/t3nvHWp4dgUpK+WzxwXbs50kD3epvyaSTbh51U+wzxG/JXAEiIiNgT4+FG28=
X-Received: by 2002:a17:906:7714:b0:6ba:8a6a:b464 with SMTP id
 q20-20020a170906771400b006ba8a6ab464mr35502749ejm.613.1649799523472; Tue, 12
 Apr 2022 14:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <CAHCN7xK_fr_gREVsOzN=atcS08mwufr-=7q1JAN=CCyVk_k-dA@mail.gmail.com>
 <YlR9TCeV8FJVu38U@ninjato> <CAHCN7xLso6kwWxeT3VuRQBcs9oKZMctGbsWmd1T=mwgHx0T+SA@mail.gmail.com>
 <YlVApjtNOBLgA0hy@ninjato> <YlWUV1SW4lVLjIZi@shikoro>
In-Reply-To: <YlWUV1SW4lVLjIZi@shikoro>
From:   Adam Ford <aford173@gmail.com>
Date:   Tue, 12 Apr 2022 16:38:32 -0500
Message-ID: <CAHCN7x+6ftnQ7WaPKYLccA8Zdc=RgUYoXY+cbPwmWZi86JY6Bg@mail.gmail.com>
Subject: Re: RZ/G2M Hangs when booting some SD cards
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Adam Ford <aford173@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Apr 12, 2022 at 10:01 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Anyhow, I'll report back with results from today.
>
> So, no news here. When the board is "cold" (hasn't been used for some
> days), probing the SD card occasionally fails, but after some reboots it
> just works. I don't see a pattern.

Thanks for looking into it.  I should be back in my office next week,
and I am going to add a bunch of debug code to U-Boot to get an idea
of that's going on in the tuning to see what the various registers
look like.  I'll then add some similar debugging to see how the same
registers compare in Linux.

Hopefully that will give us some ideas of what might be happening
differently between them.

adam
>
