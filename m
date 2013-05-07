From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 17/22] mmc: sdhci-pxa: remove unnecessary platform_set_drvdata()
Date: Tue, 7 May 2013 09:50:29 +0800
Message-ID: <CAN1soZzhf8QKHwO=q9pYbDYt+P-ORWCK8WKQsRZZhinzr=1vbQ@mail.gmail.com>
References: <005c01ce4a23$b1d43bb0$157cb310$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:33196 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932275Ab3EGBua (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 21:50:30 -0400
Received: by mail-ee0-f49.google.com with SMTP id d17so14068eek.36
        for <linux-mmc@vger.kernel.org>; Mon, 06 May 2013 18:50:29 -0700 (PDT)
In-Reply-To: <005c01ce4a23$b1d43bb0$157cb310$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Kevin Liu <kliu5@marvell.com>

On Mon, May 6, 2013 at 2:34 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/mmc/host/sdhci-pxav2.c |    2 --
>  drivers/mmc/host/sdhci-pxav3.c |    2 --
>  2 files changed, 0 insertions(+), 4 deletions(-)
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
