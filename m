Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98FFC433E6
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 677E064E9B
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Feb 2021 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbhBALWA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Feb 2021 06:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbhBALVy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 1 Feb 2021 06:21:54 -0500
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF65C061573
        for <linux-mmc@vger.kernel.org>; Mon,  1 Feb 2021 03:21:14 -0800 (PST)
Received: by mail-ua1-x935.google.com with SMTP id g13so5776901uaw.5
        for <linux-mmc@vger.kernel.org>; Mon, 01 Feb 2021 03:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9KkCLmvjMnlubofGgeBkNJL0xD2TKVDySauCo+UwnCU=;
        b=P+G19ViITrcwJgEbXhgHDkWNibqf6RhwUQh9iaUUB2CxCvQ6CjVi9T6GSW5MEfVM14
         L5OUMRbczykc5AOyQiJTSZgOcJbTvpEX689VdF5OTVZcpIiPFl7tZKJI2Dh2SEiZRrtR
         UGT1N+L903GsbCivddi5xlnBms29MV9fzTE+4TKhEI0t+vltmbASq+ut3YK4INFifOP2
         OCjXe6VEAci9MNG1BpEec3F/hulJ1HnQU71TNDc15rIYCFc3ETNzw4qPMhOEqMWoyc0Z
         +PYAUOjCZZ5rh0z68Dz3bnZdAZuIBWTP6S2pq4RyMdohPmbLGGOtnSAJTn214F8zuQ7C
         emMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9KkCLmvjMnlubofGgeBkNJL0xD2TKVDySauCo+UwnCU=;
        b=sqmQSqcBKufZFUtnCeTu1qvi1GYelhjWa1HduOx3rArHUGtcTa0cQBj2PapJKGUJrR
         VAUCmR4qsrSpkwcvrPi8rPlDFahoTSM6AzkzIHjeaGJbGIsF5dFRAiouBW4ijjJ4gWX+
         qY6VJal0DGfUPU4na6TYQlQOe3XLTp0lr/OtmLzuOomlVD8utnqX7FuDcn+J+ZtQEEEz
         +m3TD1FvVPR5cRL7RjeK5CGlkO9ci4CKmpMHOp2HXWSadNuw4Rys18RklCiJPvEvBTXQ
         anrqXOp1nLCzMd65NWl3NsiVoWfdjG3K7wSvomPg1oj2KBervDgmfNplBz83Q8IY/Puq
         MYvg==
X-Gm-Message-State: AOAM532V/ffI1PjLZkSSNv9cxAJlqECVL342ZWTeUqsBWdZlfgneywZK
        lG9VdqkHvxYpkgIB0/oVz8+MyRY/8RaWRklcB0S6qLT0HQvs3f+s
X-Google-Smtp-Source: ABdhPJwJllLDrNdIbVOs6UnYOX1hgrNSSSuiTD6cgG5MOxYC8zeHsenVkTCUVToDDMz2nQFZCLq7DOLeTdAExm0SF6o=
X-Received: by 2002:ab0:1c10:: with SMTP id a16mr9512305uaj.100.1612178473539;
 Mon, 01 Feb 2021 03:21:13 -0800 (PST)
MIME-Version: 1.0
References: <1c123f6f-705b-8e47-1a01-dc6a61e6d416@abv.bg>
In-Reply-To: <1c123f6f-705b-8e47-1a01-dc6a61e6d416@abv.bg>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 1 Feb 2021 12:20:37 +0100
Message-ID: <CAPDyKFpFCTcuW1=NrojEos=3+0DzEaXq-TqvBE5iyLOabNRQrQ@mail.gmail.com>
Subject: Re: Realtek USB Card Reader Driver issues
To:     Dimitar Kosev <buboleck@abv.bg>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Ricky Wu <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Rui, Ricky

On Tue, 26 Jan 2021 at 14:42, Dimitar Kosev <buboleck@abv.bg> wrote:
>
> Hello,
>
> It seems there is some issue with the rtsx_usb module. I'm using Gentoo
> with kernel 5.7.9 at the moment as the card reader driver does not work
> with 5.9 and 5.10 kernels, I don't know if the issue is there with 5.8
> kernels as it was causing issues with my vga, my card reader info below:
>
> Bus 002 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
> Card Reader Controller
>
> The module detect the reader but does not detect the sd cards inserted,
> the same cards work with 5.7 so I assume something was broken i the driver.
>

From the drivers/mmc/host/rtsx_usb_sdmmc.c perspective, nothing has
changed for quite a while and likewise for
drivers/misc/cardreader/rtsx_usb.c.

However, I think you probably need to run a "git bisect" to point out
the offending commit. And it looks like you already have some good
starting point to use for the git bisect.

I have also looped in some of the developers from Realtek/Realsil,
please keep them in the loop, as they know this HW and driver.

Kind regards
Uffe
