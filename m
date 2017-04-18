From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] Cavium MMC driver smatch fixes
Date: Tue, 18 Apr 2017 21:15:45 +0200
Message-ID: <CAPDyKFrdzj1tN5uW+oMeWpTTHV18QTWkrRxHGBFvy4PASwAtWQ@mail.gmail.com>
References: <20170413121051.10507-1-jglauber@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36155 "EHLO
        mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755483AbdDRTPs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Apr 2017 15:15:48 -0400
Received: by mail-vk0-f45.google.com with SMTP id q78so1299288vke.3
        for <linux-mmc@vger.kernel.org>; Tue, 18 Apr 2017 12:15:47 -0700 (PDT)
In-Reply-To: <20170413121051.10507-1-jglauber@cavium.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jglauber@cavium.com>
Cc: David Daney <david.daney@cavium.com>, "Steven J . Hill" <steven.hill@cavium.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 13 April 2017 at 14:10, Jan Glauber <jglauber@cavium.com> wrote:
> Hi Ulf,
>
> here are two cosmetical changes for the reported smatch errors.
>
> Jan Glauber (2):
>   mmc: cavium: Remove redundant pointer check
>   mmc: cavium: Check pointer before de-reference
>
>  drivers/mmc/host/cavium.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> --
> 2.9.0.rc0.21.g7777322
>

Thanks, applied for next!

Kind regards
Uffe
