Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02245C352A3
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 06:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3404206D7
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 06:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDy5Je42"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgBMGYB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:24:01 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43545 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgBMGYB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 01:24:01 -0500
Received: by mail-qt1-f195.google.com with SMTP id d18so3603562qtj.10
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2020 22:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOmCRPYeLVcd5zzuzfoTMsaqXEv3bNrWCJK+3ieWhf8=;
        b=qDy5Je42r4mrYbPLIVUQ2/xwUGG6QddkjaXx5dbeiZn5JCM3x2SgPBqCeOOnn8ch+N
         Y5G70houMNNZsSYJf26bwURdcyOA5CJeRQG7Fq835yEatI8TD2+6nzVATmhAJKrXj4Fo
         FKuzASPG/53EB+k/+gAw4tIs3memAJKkf8UNpGvVKPPcciF7/nLoNyowcMNV8Y7HXOex
         lhJtvJTxHsuVaIAYpTcPxFcBaXEXc25dz2MolEHBDEzfnL7yV8z58aezppAumo6j+0ny
         h5B/7ptG1fYREtpEgCnbgoTf2A1Vx/dWfbs1QWWWeLBS+3Ah020o36fVfbQ3MT1cavbK
         3crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOmCRPYeLVcd5zzuzfoTMsaqXEv3bNrWCJK+3ieWhf8=;
        b=AXTNGakCDNeDtbRjbELMjlCe5a6rmdzHOO3qmHvtHR8QM7rwqacEaj6t0HwCKfLH4u
         JD2CCJ/sEIfpTWWzZ2XM4t42hFzobiPHgVI1NbxEIuknXe3PYA0DqR4p2wR7sj8Fk/8x
         25CjH7zbQi2e6K3Igtbh1w9GUqx5wyirjL7Fqpi1RjM8vP/b9GLGGKHVyFAb1c/SGtqd
         85nxrcaIKbRz8/JHRXo66tlR7raV2WzufnQ4jGvRXmwQbK5ZZsCV1UJYrA+bcExKdb13
         CyxTRT9u3MsI3qnxyj6azUJKhcsXGo9e2iSI/AkqWO1zr1cNUgTvMcXjfY/JJiA5Ldz6
         MDFg==
X-Gm-Message-State: APjAAAXfDrED7rJAMrQdxjsopqofrbR+7/X64ADeA+oatW+kdxq0h1Lx
        FCu6ifi0AsmWiSehOsz1UD7/ETQfEKZ8YJRsoK8=
X-Google-Smtp-Source: APXvYqwFR4JkoynG9UmaUbyE9YHEEQb7TybtSgZpZ8NvH6AW29cvFjuBOTIzijkOrPBnbvfysiyDRpe8XBaJwT1xwfM=
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr9953288qth.85.1581575040171;
 Wed, 12 Feb 2020 22:24:00 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org> <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com>
In-Reply-To: <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Thu, 13 Feb 2020 14:23:49 +0800
Message-ID: <CADBw62rXMEq2mE43aJn=rq8CKX=1sM6hMBKuiqUbwmsDGJM5pw@mail.gmail.com>
Subject: Re: [PATCH 00/12] mmc: core: Improve code for polling and HW busy detect
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>, mirq-linux@rere.qmqm.pl
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Feb 11, 2020 at 9:17 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> Hi Ulf,
>
> On Tue, Feb 4, 2020 at 4:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > There exists several separate variants of polling loops, used to detect when
> > the card stop signals busy for various operations, in the mmc core. All of them
> > have different issues that needs to be fixed.
> >
> > The intent with this series, is to address some of these problems, via first
> > improving the mmc_poll_for_busy() function, then consolidate code by moving
> > more users to it.
> >
> > While I was working on this, I stumbled over some code here and there, that
> > deserved some cleanup, hence I also folded in a couple of patches for this.
> >
> > So far, I have only managed to extensively test the updated mmc_poll_for_busy()
> > function for CMD6 commands. Some tests for erase/trim/discard and for
> > HPI+sanitize are needed.
> >
> > Note that, there are still separate polling loops in the mmc block layer, but
> > moving that to mmc_poll_for_busy() involves some additional work. I am looking
> > into that as a next step.
> >
> > Please help review and test!
>
> That will be help if you can supply one git branch to fetch these
> patches :), and I will help to do some testing on my platform.

I've tested on my platform, incuding reading, writing, mounting and
running all cases in mmc_test.c, and I did not find any problem. So
please feel free to add my test tag. Thanks.

Tested-by: Baolin Wang <baolin.wang7@gmail.com>

> > Ulf Hansson (12):
> >   mmc: core: Throttle polling rate for CMD6
> >   mmc: core: Drop unused define
> >   mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
> >   mmc: core: Drop redundant in-parameter to __mmc_switch()
> >   mmc: core: Split up mmc_poll_for_busy()
> >   mmc: core: Enable re-use of mmc_blk_in_tran_state()
> >   mmc: core: Update CMD13 busy check for CMD6 commands
> >   mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
> >   mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
> >   mmc: core: Convert to mmc_poll_for_busy() for HPI commands
> >   mmc: core: Fixup support for HW busy detection for HPI commands
> >   mmc: core: Re-work the error path for the eMMC sanitize command
> >
> >  drivers/mmc/core/block.c   |  55 +++++--------
> >  drivers/mmc/core/core.c    |  53 +------------
> >  drivers/mmc/core/mmc.c     |  38 ++++-----
> >  drivers/mmc/core/mmc_ops.c | 159 ++++++++++++++++++++++---------------
> >  drivers/mmc/core/mmc_ops.h |  13 ++-
> >  include/linux/mmc/core.h   |   3 -
> >  include/linux/mmc/mmc.h    |  10 +++
> >  7 files changed, 157 insertions(+), 174 deletions(-)
> >
> > --
> > 2.17.1
> >
