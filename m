Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5A0C11F68
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 07:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC7FF613EE
	for <linux-mmc@archiver.kernel.org>; Fri,  2 Jul 2021 07:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhGBHF4 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 2 Jul 2021 03:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:43576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229542AbhGBHFz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 2 Jul 2021 03:05:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52E3B613EE;
        Fri,  2 Jul 2021 07:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625209404;
        bh=Hh2zjhoHGPBbQkmc5JkFShU5GroINP9pj1TtKufCft0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eAV+6pZEUQCt6Akyb9vHYG3FiGspEBCTfZSZjQ9dW/cpaUUyni4haD4qeGDuGpYUE
         Z5T73JaF39kFb+TwupMevjiacIArYXtJHTgFvRFpT1fbFFKKH/IOoRLwj5bx2uYpie
         AhlqYVnOP1uxHZcmGTV0ZIQxh+LI17kv2oN9FuyU2YEbdBV3LxK3GTjTG3+4uVRBq8
         SE/rtJ94qVMDHKyZN21u4gg3XuqClRG9Cvebe2moT6PfNM2K3WKPU5VtKZ8SOyzxsJ
         X0jYEBSqLCvzFz9zjw6Fe/EPaTR189NGvjo2CwD2UnbW+LmMJY4LAM5gbOHqE3MDag
         Ej5Y7SSTozYlQ==
Received: by mail-wr1-f51.google.com with SMTP id i94so11180729wri.4;
        Fri, 02 Jul 2021 00:03:24 -0700 (PDT)
X-Gm-Message-State: AOAM531Ayj/tyx4+syAceJh7t724jY7PDh00dS4AcYO325BLGhTcTIkr
        QJLp4Es+LBDLlda17VxENWqXBIO7mL0t5O8TKPU=
X-Google-Smtp-Source: ABdhPJxJCdbg7r+5UkmMwcMIkFiHhvxiov8e5VyyE6aFngrPSPZNtyIEv6XRRmbcegVjpQuK6UbSfra67wONqq/OojM=
X-Received: by 2002:a5d:5012:: with SMTP id e18mr4167208wrt.286.1625209402965;
 Fri, 02 Jul 2021 00:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210630122057.2795882-1-arnd@kernel.org> <6a5d06db-92af-7df0-2c71-e25bad08ee0c@rock-chips.com>
In-Reply-To: <6a5d06db-92af-7df0-2c71-e25bad08ee0c@rock-chips.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 2 Jul 2021 09:03:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
Message-ID: <CAK8P3a3UjLfKpsg2M-RP3AO3CVCnZrbD71uaLf0+iiJ9RJsHCQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gbW1jOiB3YXJuIGZvciBpbnZhbGlkIFNESU8gZGF0YSBidWZmZXJz?=
        =?UTF-8?B?44CQ6K+35rOo5oSP77yM6YKu5Lu255SxbGludXgtbW1jLW93bmVyQHZnZXIua2VybmVsLm9yZ+S7ow==?=
        =?UTF-8?B?5Y+R44CR?=
To:     Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jul 2, 2021 at 3:02 AM Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2021/6/30 20:20, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Jernej Skrabec reported a problem with the cw1200 driver failing on
> > arm64 systems with CONFIG_VMAP_STACK=y.
> >
> > The driver in this case passes a pointer to a stack variable (in vmalloc
> > space) into the sdio layer, which gets translated into an invalid DMA
> > address.
> >
> > Even without CONFIG_VMAP_STACK, the driver is still unreliable, as
> > cache invalidations on the DMA buffer may cause random data corruption
> > in adjacent stack slots.
> >
> > This could be worked around in the SDIO core, but in the discussion we
> > decided that passing a stack variable into SDIO should always be considered
> > a bug, as it is for USB drivers.
> >
> > Change the sdio core to produce a one-time warning for any on-stack
> > (both with and without CONFIG_VMAP_STACK) as well as any vmalloc
> > or module-local address that would have the same translation problem.
>
> This was the previous comment about the same topic.
> Should we check for mmc_io_rw_direct?
>
> https://www.spinics.net/lists/linux-mmc/msg41794.html

Hi Shawn,

thank you for remembering that previous discussion, that is a
good question. Looking at the code though, I don't actually
see any part of mmc_io_rw_direct() doing DMA on a caller-provided
buffer. The only thing I see in the code is a 'u8 *out' argument, but
that is just a pointer to a single byte that is set by this function.

Do you see any other issue with that function, or does that mean
we don't have to change it?

       Arnd
