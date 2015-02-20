From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH v2] mmc: dw_mmc: fix bug that cause mmc_test failture
Date: Fri, 20 Feb 2015 13:43:16 -0800
Message-ID: <CAD=FV=Vz6Rq9wFjvKAnzuKgXAqeVE2FafoOhtf3VaYO63bRUAA@mail.gmail.com>
References: <1422273849-29773-1-git-send-email-addy.ke@rock-chips.com>
	<1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:39743 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbbBTVnR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Feb 2015 16:43:17 -0500
Received: by iecvy18 with SMTP id vy18so11098104iec.6
        for <linux-mmc@vger.kernel.org>; Fri, 20 Feb 2015 13:43:17 -0800 (PST)
In-Reply-To: <1424400925-3867-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Addy Ke <addy.ke@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Olof Johansson <olof@lixom.net>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Tao Huang <huangtao@rock-chips.com>, lintao <lintao@rock-chips.com>, Eddie Cai <cf@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Addy,

On Thu, Feb 19, 2015 at 6:55 PM, Addy Ke <addy.ke@rock-chips.com> wrote:
> The STOP command can terminate a data transfer between a memory card and
> mmc controller.
>
> As show in Synopsys DesignWare Cores Mobile Stroage Host Databook:
> Data timeout and Data end-bit error will terminate further data transfer
> by mmc controller. So we should not send abort command to terminate a
> data transfer again if we got DRTO and EBE interrupt.
>
> After this patch, all mmc_test cases can pass on RK3288-Pink2 board.
>
> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> ---
> Changes in v2:
> - DRTO and EBE are both set, should not send abort command too,
>   suggested by Doug Anderson.
>
>  drivers/mmc/host/dw_mmc.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

I also suggested that you change the subject to "mmc: dw_mmc: fix
mmc_test by not sending abort for DRTO / EBE errors" which you didn't
do.  ...I guess that's not critical.  Perhaps Jaehoon (who is
collecting patches for Ulf now I think) can adjust the subject when he
applies.

In any case, v2 fixes my problems and seems OK to me.

Reviewed-by: Doug Anderson <dianders@chromium.org>

On rk3288 on a 3.14 kernel w/ lotsa backports:
Tested-by: Doug Anderson <dianders@chromium.org>
