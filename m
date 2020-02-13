Return-Path: <SRS0=nQxR=4B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E62C2BA83
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750A724649
	for <linux-mmc@archiver.kernel.org>; Thu, 13 Feb 2020 13:56:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/GZN67c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730127AbgBMN4n (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:56:43 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36790 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgBMN4m (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 13 Feb 2020 08:56:42 -0500
Received: by mail-vs1-f68.google.com with SMTP id a2so3957391vso.3
        for <linux-mmc@vger.kernel.org>; Thu, 13 Feb 2020 05:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCoft5ObisT71H4xmSYRVNKBPX8Jl8Mr5dppLPtilek=;
        b=Q/GZN67crjT8Xs6iOqA4ZpaNNgkuaruNKfj3stKYuI1PmiVlj4To/buvTkLMP4nyfo
         6QjMFqJ8oF2lpFv+W9pwdAAYNh0H11t0X6C3DXFZinyJiS5JhZrJ93t0LydGcYKpQQ16
         QKYOsVMopJacgNgxcN8UrE3thjVRr6HztEQLHAv6mIIjkHxrnfkJKcsNMPOCaU8qpr3O
         h4meXVjeoQGkwD9y4PBTOg3mWD5XPab2yXFC8L+3TT5KDjoTww0N3pc59jCZR7Rt7ri1
         bBTBcjcRUh3eUKW+SDN7yrZQLwIFEI/jvip5Wclto+E0ugQ3Hvh7Qu/3FeyGBofWAt9z
         41dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCoft5ObisT71H4xmSYRVNKBPX8Jl8Mr5dppLPtilek=;
        b=Qn/9zgbbBDaad7hNY19CW562knEL73s/1OzvmlgX7LWRQwJqgkbW3D054xAxrwvrTE
         qoXEE88tt9M2RnEwm4EPaNKk5JhEWYObHexJiUST/A6fGm+9aKgi1RPdgDwofzzdeBg8
         a6b8sjNOwknkr2dvglw1umHGVpC4wjBPk4/h5P4WRkp2TAFX8tQe7HL+ShID/HUvLGud
         hPcy58RcGojPWSNz3e23gHiF3PJWSSPXz4wxUjRlPfmp+UahUbC0VUsewpA+29VVCHED
         AbZwZ7Yil+/zercI7fMImuTa6efcFmZbj2iYxc7OF1HLOeR6an0Nf86br6kurncLDI4N
         EzNQ==
X-Gm-Message-State: APjAAAVB7llL/Yj/krQEaglS6vAoRGy0D4vNd6yDljg6snaFPBr8TJfC
        I9DFYl/XfD6qRQKHBooFinMzLUNVsJ/KCHBGcesxAQ==
X-Google-Smtp-Source: APXvYqzQbZ5bwymEDWh1zy9a2prr4kVYX5IT0scZFKGQpBOFt4KixIzGS3syqqyoz0UW0bsqYw5/pCJMrPLpBLXQRHs=
X-Received: by 2002:a67:ee02:: with SMTP id f2mr14962183vsp.165.1581602201921;
 Thu, 13 Feb 2020 05:56:41 -0800 (PST)
MIME-Version: 1.0
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 13 Feb 2020 14:56:06 +0100
Message-ID: <CAPDyKFqS+9j++9RugFxNS4gKWuH_TpgbL-RXuudg92b-j_kvtQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Enhancements and Bug Fixes in ZynqMP SDHCI
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 21 Jan 2020 at 11:21, Manish Narani <manish.narani@xilinx.com> wrote:
>
> This patch series includes:
> -> Mark the Tap Delay Node as valid for ioctl calls
> -> Add support for DLL reset in firmware driver
> -> Add support to reset DLL from Arasan SDHCI driver for ZynqMP platform
> -> Fix incorrect base clock reporting issue
>
> Manish Narani (4):
>   firmware: xilinx: Add ZynqMP Tap Delay setup ioctl to the valid list
>   firmware: xilinx: Add DLL reset support
>   mmc: sdhci-of-arasan: Add support for DLL reset for ZynqMP platforms
>   sdhci: arasan: Remove quirk for broken base clock
>
>  drivers/firmware/xilinx/zynqmp.c     |  2 +
>  drivers/mmc/host/sdhci-of-arasan.c   | 59 +++++++++++++++++++++++++++-
>  include/linux/firmware/xlnx-zynqmp.h |  9 ++++-
>  3 files changed, 68 insertions(+), 2 deletions(-)
>
> --
> 2.17.1
>

Applied for next, thanks!

Kind regards
Uffe
