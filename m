Return-Path: <SRS0=YSSR=4G=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56C8C34031
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D2024656
	for <linux-mmc@archiver.kernel.org>; Tue, 18 Feb 2020 23:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bwJMQtq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgBRXjW (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 18 Feb 2020 18:39:22 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35362 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgBRXjW (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Feb 2020 18:39:22 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so14281610vsc.2
        for <linux-mmc@vger.kernel.org>; Tue, 18 Feb 2020 15:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n8cRDggjs5qx8oA88rn51JOPfph9uPDByt63P42st5o=;
        b=bwJMQtq1T+Wr0ggkfEjwT+23ZeuuU+tDkpDOGxT7sjDEbMozddtZBYBJ1vPvttlNgN
         rny13Cc09oYacO8Pjno25PBeiHlsGSPBI+kcIFzwd991RMLQk/cfXo2rdzfIlH+Fvr0d
         KsTOn0FDdrPqK4+MzosYVn3hb/VdM6Rxcu6CGH0dj/LbyhCct3MUnCCvAzQezKLDx/7e
         eV/V/b+Lsm9P8fqf+xVFOtM2AEa6NzkMcRrk4n/MAWZ85jG93Bbp7fmOUPO3MuX/U8Ht
         K8OhFJDShff3aHgLQeW+nc1ovkF7GD5V63Z0s5S7GeaKT4g+CSV8uQyyYr7Tq4ndhhy3
         H3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n8cRDggjs5qx8oA88rn51JOPfph9uPDByt63P42st5o=;
        b=aT2saFxjx4u1ZKsmYRuQYPG0tHuABSp3bsFK19UCQ6y9L2xjZG/8cjPfeD2Ne93mfo
         cJ3RhhyIl0OcvICaC5TDJ2YirFOJ3XcAo/kp6vVXbPR49nt5lV/c/WlJkVcNcF0NmPqz
         I0ngdaH5PjRhctGfgTIGYbLmVnbq788fWyBOPh/m4LBur0JEMiXAlI77r7nuitMItiV6
         iMoIC3cZ1e1k8MK4JlXN0QaUef3yLw/SCQzfGgH1rfBD8edyE5p3DtP4uKacPlUknzbS
         jNE/6enG46Gn6txMR3pRiKeYMItq43odHgE+HJpdtGm+nPv55NepPtSboTLjjZQWM5R6
         0fJQ==
X-Gm-Message-State: APjAAAWeEApuwZZMGv74Woo00py/A3k8KBxVthYGmgSFshVjGtsNXfIa
        lkIkaYDG8aHT86n7EAkccDEbuc3Q+LkUOeL7anySKj2k
X-Google-Smtp-Source: APXvYqx8ihLfbmtBvLNbhHKhPN6i5B/EUR2w4N51sHavnEvZfDc/mwUU4WGRP5ORDUtjnOqzOtB4B1oYRR8RhQNDP8A=
X-Received: by 2002:a67:f591:: with SMTP id i17mr12513425vso.34.1582069159754;
 Tue, 18 Feb 2020 15:39:19 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 19 Feb 2020 00:38:43 +0100
Message-ID: <CAPDyKFoVKiXk0Cbj2fqbYB9ZtAJL2cO3k-YCJH0Eiyjb0zfUUg@mail.gmail.com>
Subject: Re: [PATCH 00/12] mmc: core: Improve code for polling and HW busy detect
To:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Ludovic Barre <ludovic.barre@st.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Feb 2020 at 09:55, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> There exists several separate variants of polling loops, used to detect when
> the card stop signals busy for various operations, in the mmc core. All of them
> have different issues that needs to be fixed.
>
> The intent with this series, is to address some of these problems, via first
> improving the mmc_poll_for_busy() function, then consolidate code by moving
> more users to it.
>
> While I was working on this, I stumbled over some code here and there, that
> deserved some cleanup, hence I also folded in a couple of patches for this.
>
> So far, I have only managed to extensively test the updated mmc_poll_for_busy()
> function for CMD6 commands. Some tests for erase/trim/discard and for
> HPI+sanitize are needed.
>
> Note that, there are still separate polling loops in the mmc block layer, but
> moving that to mmc_poll_for_busy() involves some additional work. I am looking
> into that as a next step.
>
> Please help review and test!
>
> Kind regards
> Ulf Hansson
>
>
> Ulf Hansson (12):
>   mmc: core: Throttle polling rate for CMD6
>   mmc: core: Drop unused define
>   mmc: core: Extend mmc_switch_status() to rid of __mmc_switch_status()
>   mmc: core: Drop redundant in-parameter to __mmc_switch()
>   mmc: core: Split up mmc_poll_for_busy()
>   mmc: core: Enable re-use of mmc_blk_in_tran_state()
>   mmc: core: Update CMD13 busy check for CMD6 commands
>   mmc: core: Convert to mmc_poll_for_busy() for erase/trim/discard
>   mmc: core: Drop redundant out-parameter to mmc_send_hpi_cmd()
>   mmc: core: Convert to mmc_poll_for_busy() for HPI commands
>   mmc: core: Fixup support for HW busy detection for HPI commands
>   mmc: core: Re-work the error path for the eMMC sanitize command
>
>  drivers/mmc/core/block.c   |  55 +++++--------
>  drivers/mmc/core/core.c    |  53 +------------
>  drivers/mmc/core/mmc.c     |  38 ++++-----
>  drivers/mmc/core/mmc_ops.c | 159 ++++++++++++++++++++++---------------
>  drivers/mmc/core/mmc_ops.h |  13 ++-
>  include/linux/mmc/core.h   |   3 -
>  include/linux/mmc/mmc.h    |  10 +++
>  7 files changed, 157 insertions(+), 174 deletions(-)
>
> --
> 2.17.1
>

FYI, I have queued up this series for next (except patch12 that
deserves another re-spin). I also amended the changelog for patch1,
according the comment from Ludovic.

Feel free to provide additional feedback and test-reports, while we
monitor how this cook in linux-next.

Kind regards
Uffe
