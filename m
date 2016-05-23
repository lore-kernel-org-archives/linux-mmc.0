From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [GIT PULL] dw-mmc controller fixes for v4.7
Date: Mon, 23 May 2016 11:55:58 +0200
Message-ID: <CAPDyKFqUjhHNww7Zo9XAg7p_B5cauviPvAm3Pm3DS6sM1FEUeg@mail.gmail.com>
References: <5742650E.4090702@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37983 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752704AbcEWJz7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 May 2016 05:55:59 -0400
Received: by mail-wm0-f43.google.com with SMTP id n129so64867069wmn.1
        for <linux-mmc@vger.kernel.org>; Mon, 23 May 2016 02:55:58 -0700 (PDT)
In-Reply-To: <5742650E.4090702@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>, Doug Anderson <dianders@chromium.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Jae hoon Chung <jh80.chung@gmail.com>

On 23 May 2016 at 04:03, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Dear Ulf,
>
> Could you pull these patches into your "fixes" branch?
>
> Best Regards,
> Jaehoon Chung
>

Hi Jaehoon,

Thanks for the pull-request. Applied for fixes!

Kind regards
Uffe

>
> The following changes since commit e5bbf30733f930a1d17b4ccf19eac88e30a39cc7:
>
>   mmc: sdhci-acpi: Ensure connected devices are powered when probing (2016-05-20 16:00:25 +0200)
>
> are available in the git repository at:
>
>   https://github.com/jh80chung/dw-mmc.git fixes
>
> for you to fetch changes up to a5cd9a42e6a952f7828742ec4595ed8312ac3063:
>
>   mmc: dw_mmc: rockchip: Set the drive phase properly (2016-05-23 09:10:03 +0900)
>
> ----------------------------------------------------------------
> Douglas Anderson (1):
>       mmc: dw_mmc: rockchip: Set the drive phase properly
>
> Jaehoon Chung (1):
>       mmc: dw_mmc: fix the wrong max_blk_size
>
> Shawn Lin (1):
>       mmc: dw_mmc-rockchip: add MMC_CAP_CMD23 capabilities
>
>  drivers/mmc/host/dw_mmc-rockchip.c | 72 +++++++++++++++++++++++++++++++++++---
>  drivers/mmc/host/dw_mmc.c          |  6 ++--
>  2 files changed, 71 insertions(+), 7 deletions(-)
