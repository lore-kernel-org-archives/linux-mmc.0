From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Update dw-mmc controller
Date: Fri, 11 Dec 2015 09:14:50 +0100
Message-ID: <CAPDyKFr0E+yL9=k4Nrh4jo51UxR5XrSG+3sUX-DjnScOgq-8eg@mail.gmail.com>
References: <566A579C.4000104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:34475 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754228AbbLKIOv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Dec 2015 03:14:51 -0500
Received: by qgz52 with SMTP id 52so2846749qgz.1
        for <linux-mmc@vger.kernel.org>; Fri, 11 Dec 2015 00:14:50 -0800 (PST)
In-Reply-To: <566A579C.4000104@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

On 11 December 2015 at 05:57, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear, Ulf
>
> Could you pull this patch on your repository? Sorry for late.
> Also I will send the some patches at mailing on this weekend..

Thanks! Pulled into my next branch.

Kind regards
Uffe

>
> Best Regards,
> Jaehoon Chung
>
> The following changes since commit 5acbb99e3883a0353609bfefd02c056cc92d1a9d:
>
>   mmc: core: fix __mmc_switch timeout caused by preempt (2015-12-04 15:43:18 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 007230a6b5841b1e5a3f1a46d97ee6e8343879f3:
>
>   mmc: dw_mmc: use resource_size_t to store physical address (2015-12-09 22:35:52 +0900)
>
> ----------------------------------------------------------------
> Arnd Bergmann (1):
>       mmc: dw_mmc: use resource_size_t to store physical address
>
>  drivers/mmc/host/dw_mmc-pltfm.c | 2 +-
>  drivers/mmc/host/dw_mmc.c       | 2 +-
>  include/linux/mmc/dw_mmc.h      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
