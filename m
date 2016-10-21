From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: Change MMC_IOC_MAX_BYTES
Date: Fri, 21 Oct 2016 10:21:42 +0200
Message-ID: <CAPDyKFrZcH3pAHuQStGrfFosA5uscKWT3k6D11muhC_FPrTY8A@mail.gmail.com>
References: <0d4301d229fc$607a9770$216fc650$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35970 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754228AbcJUIVp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 04:21:45 -0400
Received: by mail-lf0-f48.google.com with SMTP id b75so130769968lfg.3
        for <linux-mmc@vger.kernel.org>; Fri, 21 Oct 2016 01:21:44 -0700 (PDT)
In-Reply-To: <0d4301d229fc$607a9770$216fc650$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy Kim <jh4u.kim@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>

On 19 October 2016 at 13:31, Jeremy Kim <jh4u.kim@samsung.com> wrote:
> From 27d46f5697434542ad9cafbc6a9630dc14915f91 Mon Sep 17 00:00:00 2001
> From: Jeonghan Kim <jh4u.kim@samsung.com>
> Date: Wed, 19 Oct 2016 19:48:02 +0900
> Subject: [PATCH] mmc: block: Change MMC_IOC_MAX_BYTES
>
> It is used for limitation of buffer size during IOCTL such as FFU.
> However, eMMC FW size is bigger than (512L*256).
> (For instance, currently, Samsung eMMC FW size is over 300KB.)
> So, it needs to increase to execute FFU.
>
> Signed-off-by: Jeonghan Kim <jh4u.kim@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  include/uapi/linux/mmc/ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/uapi/linux/mmc/ioctl.h b/include/uapi/linux/mmc/ioctl.h
> index 7e385b8..700a551 100644
> --- a/include/uapi/linux/mmc/ioctl.h
> +++ b/include/uapi/linux/mmc/ioctl.h
> @@ -69,6 +69,6 @@ struct mmc_ioc_multi_cmd {
>   * is enforced per ioctl call.  For larger data transfers, use the normal
>   * block device operations.
>   */
> -#define MMC_IOC_MAX_BYTES  (512L * 256)
> +#define MMC_IOC_MAX_BYTES  (512L * 1024)
>  #define MMC_IOC_MAX_CMDS    255
>  #endif /* LINUX_MMC_IOCTL_H */
> --
> 1.9.1
>
>
