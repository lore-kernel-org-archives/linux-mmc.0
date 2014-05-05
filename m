From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/6] mmc: drop the speed mode of card's state
Date: Mon, 5 May 2014 10:02:02 +0200
Message-ID: <CAPDyKFo7p-TtEdPeepc=ng7OERZ191+vB5VUgX0YymJ=fy15BA@mail.gmail.com>
References: <1383653403-10049-1-git-send-email-ulf.hansson@linaro.org>
	<006701cf2a58$c628e050$527aa0f0$%jun@samsung.com>
	<000a01cf5ecb$15fedcf0$41fc96d0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:56876 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754778AbaEEICD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 5 May 2014 04:02:03 -0400
Received: by mail-qc0-f177.google.com with SMTP id i17so6615113qcy.36
        for <linux-mmc@vger.kernel.org>; Mon, 05 May 2014 01:02:02 -0700 (PDT)
In-Reply-To: <000a01cf5ecb$15fedcf0$41fc96d0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-wireless@vger.kernel.org, Chris Ball <chris@printf.net>, Jaehoon Chung <jh80.chung@samsung.com>, Jackey Shen <jackey.shen@amd.com>, Alim Akhtar <alim.akhtar@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Fariya Fatima <fariyaf@gmail.com>

On 23 April 2014 10:07, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Timing mode identifier has same role and can take the place
> of speed mode. This change removes all related speed mode.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Chris Ball <chris@printf.net>
> ---
>  drivers/mmc/core/bus.c                  |    8 ++++----
>  drivers/mmc/core/core.c                 |    3 +--
>  drivers/mmc/core/mmc.c                  |   11 +++--------
>  drivers/mmc/core/sd.c                   |   16 +++-------------
>  drivers/mmc/core/sd.h                   |    1 -
>  drivers/mmc/core/sdio.c                 |    8 ++------
>  drivers/net/wireless/rsi/rsi_91x_sdio.c |    4 +---
>  include/linux/mmc/card.h                |   23 ++++++-----------------
>  include/linux/mmc/host.h                |   23 +++++++++++++++++++++++
>  9 files changed, 43 insertions(+), 54 deletions(-)

Hi John,

We would like to queue this patch through Chris' mmc tree for 3.16.

Since it touches the rsi wireless driver, could you please have a look
and let's us know if you have any concerns.

Kind regards
Ulf Hansson
