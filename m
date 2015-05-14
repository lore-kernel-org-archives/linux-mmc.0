From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/4] mmc: dw_mmc: rockchip: Fix modalias to make module
 auto-loading work
Date: Thu, 14 May 2015 08:22:11 -0700
Message-ID: <CAD=FV=UmHArJYSjfj1roL6y_gyu9G8jZQ0qT1fbvN7c6T5UyUQ@mail.gmail.com>
References: <1431593987-455-1-git-send-email-zhangfei.gao@linaro.org>
	<1431593987-455-4-git-send-email-zhangfei.gao@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:34486 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933364AbbENPWM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2015 11:22:12 -0400
Received: by iecmd7 with SMTP id md7so63285275iec.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2015 08:22:11 -0700 (PDT)
In-Reply-To: <1431593987-455-4-git-send-email-zhangfei.gao@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Thu, May 14, 2015 at 1:59 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Make the modalias match driver name, this is required to make module
> auto-loading work.
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> CC: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks!  Reviewed-by: Doug Anderson <dianders@chromium.org>
