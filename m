From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 1/2] mmc: mediatek: Change signal voltage error to dev_dbg()
Date: Thu, 3 Mar 2016 09:57:42 -0800
Message-ID: <CAD=FV=XEFHNrJrSruVSaWb8UnrZ9ud--ykj0n-PD3yr5Kbvh8g@mail.gmail.com>
References: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:33037 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942AbcCCR5n (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Mar 2016 12:57:43 -0500
Received: by mail-vk0-f54.google.com with SMTP id k1so13044458vkb.0
        for <linux-mmc@vger.kernel.org>; Thu, 03 Mar 2016 09:57:43 -0800 (PST)
In-Reply-To: <1457000385-2317-1-git-send-email-drinkcat@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Nicolas,

On Thu, Mar 3, 2016 at 2:19 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> In commit ceae98f20e36 ("mmc: core: Try other signal levels
> during power up") we can see that there are times when it's
> valid to try several signal voltages.  Don't print an ugly
> error in the logs when that happens.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>
> Similar to b19caf379c82e99737c29bc15d7b7fd7d24279f9
> mmc: dw_mmc: Change signal voltage error to dev_dbg()
>
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
