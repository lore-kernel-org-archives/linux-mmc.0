From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: block: Change MMC_IOC_MAX_BYTES
Date: Fri, 21 Oct 2016 15:38:54 +0900
Message-ID: <75a76bcc-14a5-ea84-36a7-2a7d4064c110@samsung.com>
References: <CGME20161019113147epcas1p23270c03a8ea440a88dd0d6ab85af8051@epcas1p2.samsung.com>
 <0d4301d229fc$607a9770$216fc650$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:49646 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932196AbcJUGi7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Oct 2016 02:38:59 -0400
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OFD00QFRX4RX7D0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 21 Oct 2016 15:38:54 +0900 (KST)
In-reply-to: <0d4301d229fc$607a9770$216fc650$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy Kim <jh4u.kim@samsung.com>, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org

Hi,

On 10/19/2016 08:31 PM, Jeremy Kim wrote:
>>From 27d46f5697434542ad9cafbc6a9630dc14915f91 Mon Sep 17 00:00:00 2001
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

Looks good to me.

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

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
> 
> 

