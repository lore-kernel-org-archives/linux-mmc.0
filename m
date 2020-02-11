Return-Path: <SRS0=tDgF=37=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9894EC352A3
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 13:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE6120714
	for <linux-mmc@archiver.kernel.org>; Tue, 11 Feb 2020 13:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUNavadq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgBKNSJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 Feb 2020 08:18:09 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43625 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBKNSJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 Feb 2020 08:18:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so7845424qtj.10
        for <linux-mmc@vger.kernel.org>; Tue, 11 Feb 2020 05:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8MTBahWQhIWE4rLY33Xf9ttE1eV9wHmfUjN0AmJuU2E=;
        b=QUNavadqKHenuwPnL8+75MeBK3tTAc4bmSOL/u1DTzMOrkrcnMtAne6Ybr9/98eQWv
         e8t7z5AVqLRJf+RCuUfqiT8aZZJAeiw0Cku9WE3l2cLe6pABUNUqCtU1CAKxlDXo0YbM
         iCLJxwSPcMhOHaX5LUMjkHb0dwIRLMbXrlOeyTfh+/ZqT0Tk8wonURzyPZRkhSiwVKTb
         XDUsjpBaMj/EMaDf7Zod+Tjt56GAz0obM/VAckw47stgbWS4XcoBV8m2/OOO34flB2vG
         M0vJ+RXYsZ0ClSnA3EhnD7gqJjHHDnFZ0bkMEhk1FZJdLHH1deIT2w54bMljUsajtdWq
         H1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8MTBahWQhIWE4rLY33Xf9ttE1eV9wHmfUjN0AmJuU2E=;
        b=q+FDyt5CbAcMgDM7dJf+St/iYXvkov1dYgX0lg0EHX4PtMXe8yO1gaNhMW4jowC1J0
         d0ydHLfzjXTvqTScRwWfoRPaqr/idUkWH2Q522GE/QwqVWs7p3yx2NCInzN0nNCn5QW1
         2nSU+/JQaAnE0oQ+Iv/oE8z8cHAqmsFh9dRSMGW7GPoSct1RwMhFYtSsQqe8UA/6SqD1
         eOQZmLa/vTFKbIJ8XNfaFTN+pwcfNzm7ydywytqQ9gVowwjZ1HJ9ROeVRpNe4g0NBwsN
         B/+U/sXs+7Ya48fcCPgdsQ0mNwdes6Isg5r9eWLCp3DmTevoQfUe5fGuE1UU5NW9fWZt
         cMcw==
X-Gm-Message-State: APjAAAXiluykLuhyLw4/gLh3xdQyaGsEkq33GL/O16nRpkwbmJp2HAWf
        vNeHJ3qZdqsEXXyWPulo9r6BvZwNVO59XjgxIbCTcgxG
X-Google-Smtp-Source: APXvYqz1lnwiHwwrRn7wNv7yn5wFwu2kO/eclHSbOd63h5/GDJvN7FDj1xcqvPhZ7OfVzaS193MEwbpUwvlYSbcbprA=
X-Received: by 2002:aed:2202:: with SMTP id n2mr15360036qtc.4.1581427088681;
 Tue, 11 Feb 2020 05:18:08 -0800 (PST)
MIME-Version: 1.0
References: <20200204085449.32585-1-ulf.hansson@linaro.org>
In-Reply-To: <20200204085449.32585-1-ulf.hansson@linaro.org>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Tue, 11 Feb 2020 21:17:57 +0800
Message-ID: <CADBw62o+9aasHDJtOLAXkhvV3DSVXHePwqy707DMQNo2O-+YmQ@mail.gmail.com>
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

Hi Ulf,

On Tue, Feb 4, 2020 at 4:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
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

That will be help if you can supply one git branch to fetch these
patches :), and I will help to do some testing on my platform.

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
