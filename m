Return-Path: <SRS0=tDGl=5J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9917C43331
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967C32076E
	for <linux-mmc@archiver.kernel.org>; Tue, 24 Mar 2020 18:20:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PmXOw2hV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgCXSUa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:20:30 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40041 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgCXSUa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Mar 2020 14:20:30 -0400
Received: by mail-lj1-f193.google.com with SMTP id 19so19643828ljj.7
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2020 11:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXFNaMHE865KFMf7/FD9eexyYGXX3J3mTbjMUnsz/XY=;
        b=PmXOw2hVAghdVL5iXAMxkoaQOE+md30LjhqAjxYJ0W/CrfPUFb9DkbSClQr2v0XkRu
         +1QNTt4UOHmA4kMT32VUr7hMvwaF7aWcEWSooM+wGtbTh+trTYZpFZEypw4045uy4tmw
         W/TYv3FFjfMQX6bS4Cwvu9l2M7/cZW2YuZaghLQRBJmpf3msgH+VRPmrgPf9I54LLSan
         kkiHcwMu0vIn5tLBbsNWuttaQaiShPjNvvcLVFJGIbwBcL0/EptqiOvKBI4q3SUS4PrW
         i1CFFacZaVTriv0A7ciYiBvsonVuqcD5odxeG8GUqZ6s5/g9pUkU7yaX95l7bzJTVAVC
         mE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXFNaMHE865KFMf7/FD9eexyYGXX3J3mTbjMUnsz/XY=;
        b=GFVx51LJLXuF+zjichMWiqEcNhZF2xzow2HHECWnw/0NP3dFOJdFWmDynZmoo6Yoje
         9176Dp3UPttbwNDSPRp3P1SZ8HMfSWVQ0e2yqvrZj0yNMQyV1BbAJZa4gA2W1Syb8KWd
         eKAyKTQx4zkwRlY7a9txRj2MoSAAD48lweiN6cEWd4q0BuQGnJplcKWoBpfx3K4WPhCO
         R7c5A9H3/vmE1M1gMO9GwYcDuReGk26FBXenQ2PJct5gLC7I0zd2xwEBgZ2jI3TBzJCX
         b+L0kMJjKIwdorYpqd+FVj057ddtyeEHbx/fVNRhAccA+6NKA4syJccFMqnYx6gB0Xnc
         42Qg==
X-Gm-Message-State: ANhLgQ3KRPe9sBcqpthW9YrOoJz6P+elo1I5ZkYQ/Xx+ZBkZxpYbvCPz
        aNsChxSlP2/xGqpGb8Wzdl27NxGvrIgSKe/2bPjzrg==
X-Google-Smtp-Source: ADFU+vssKk0TvsuhAuqLni5jz9W0bZI1fwWvOHj7M1YWG8xxniszV5r5PVzLod3GdiLOtsGj2xMpUys86huxeYmxjDE=
X-Received: by 2002:a2e:811a:: with SMTP id d26mr17755811ljg.128.1585074026561;
 Tue, 24 Mar 2020 11:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200324180650.28819-1-ulf.hansson@linaro.org>
In-Reply-To: <20200324180650.28819-1-ulf.hansson@linaro.org>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Tue, 24 Mar 2020 19:20:15 +0100
Message-ID: <CADYN=9JsS-aTbun24PMOasBAK+2nwkkuvFZ6vSp88hjEnLQLmQ@mail.gmail.com>
Subject: Re: [PATCH 5.5.12 0/5] mmc: Fix some busy detect problems
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 24 Mar 2020 at 19:06, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> This series provides a couple of manually backported mmc changes that fixes some
> busy detect issues, for a couple of mmc host drivers (sdhci-tegra|omap).
>
> Ulf Hansson (5):
>   mmc: core: Allow host controllers to require R1B for CMD6
>   mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for erase/trim/discard
>   mmc: core: Respect MMC_CAP_NEED_RSP_BUSY for eMMC sleep command
>   mmc: sdhci-omap: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY
>   mmc: sdhci-tegra: Fix busy detection by enabling MMC_CAP_NEED_RSP_BUSY

Tested-by: Anders Roxell <anders.roxell@linaro.org>

I tested it on a beagleboard x15.

Cheers,
Anders

>
>  drivers/mmc/core/core.c        | 5 ++++-
>  drivers/mmc/core/mmc.c         | 7 +++++--
>  drivers/mmc/core/mmc_ops.c     | 8 +++++---
>  drivers/mmc/host/sdhci-omap.c  | 3 +++
>  drivers/mmc/host/sdhci-tegra.c | 3 +++
>  include/linux/mmc/host.h       | 1 +
>  6 files changed, 21 insertions(+), 6 deletions(-)
>
> --
> 2.20.1
>
