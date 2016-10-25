From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] Update dw-mmc controller
Date: Tue, 25 Oct 2016 10:48:01 +0200
Message-ID: <CAPDyKFpc2KOKLjK5DFarg91yB=X3OKVmGsuxpuZZmVfueZp99w@mail.gmail.com>
References: <010f8179-56e4-88d2-1a6f-1c477a1d3f4a@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36641 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753422AbcJYIsE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Oct 2016 04:48:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id b80so150210511wme.1
        for <linux-mmc@vger.kernel.org>; Tue, 25 Oct 2016 01:48:03 -0700 (PDT)
In-Reply-To: <010f8179-56e4-88d2-1a6f-1c477a1d3f4a@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 24 October 2016 at 00:52, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your mmc-next?
>
> The following changes since commit 2a688788ba1dd1dc905c24bf5b617aefdff4a68b:
>
>   mmc: core: Don't use ->card_busy() and CMD13 in combination when polling (2016-10-21 10:18:07 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git for-ulf
>
> for you to fetch changes up to 0a9bd53611e862d2a5e2f68513b2677b13b7b379:
>
>   mmc: dw_mmc: remove system PM callback (2016-10-24 07:13:07 +0900)
>
> ----------------------------------------------------------------
> Shawn Lin (9):
>       mmc: dw_mmc: add runtime PM callback
>       mmc: dw_mmc-rockchip: add runtime PM support
>       mmc: core: expose the capability of gpio card detect
>       mmc: dw_mmc: disable biu clk if possible
>       mmc: dw_mmc-k3: deploy runtime PM facilities
>       mmc: dw_mmc-exynos: deploy runtime PM facilities
>       mmc: dw_mmc-pci: deploy runtime PM facilities
>       mmc: dw_mmc-pltfm: deploy runtime PM facilities
>       mmc: dw_mmc: remove system PM callback
>
>  drivers/mmc/core/slot-gpio.c       |  8 +++++++
>  drivers/mmc/host/dw_mmc-exynos.c   | 24 +++++++++-----------
>  drivers/mmc/host/dw_mmc-k3.c       | 39 ++++++++------------------------
>  drivers/mmc/host/dw_mmc-pci.c      | 29 ++++++++----------------
>  drivers/mmc/host/dw_mmc-pltfm.c    | 28 +++++++----------------
>  drivers/mmc/host/dw_mmc-rockchip.c | 42 +++++++++++++++++++++++++++++++---
>  drivers/mmc/host/dw_mmc.c          | 46 +++++++++++++++++++++++++-------------
>  drivers/mmc/host/dw_mmc.h          |  6 ++---
>  include/linux/mmc/slot-gpio.h      |  1 +
>  9 files changed, 117 insertions(+), 106 deletions(-)
>
> Best Regards,
> Jaehoon Chung

Thanks, pulled into my next branch.
I noticed that you probably forgot to add your sob-tag to the changes,
so I did that. Pleas tell me if that wasn't okay.

Kind regards
Uffe
