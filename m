From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: block: Change MMC_IOC_MAX_BYTES
Date: Tue, 18 Oct 2016 19:51:33 +0900
Message-ID: <e99052e2-de80-57a2-30ae-0baea2328cce@samsung.com>
References: <CGME20161018103940epcas1p1da351e49f18c5707eea3b817a5d2f865@epcas1p1.samsung.com>
 <0bb501d2292b$e6a43760$b3eca620$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48775 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbcJRKvg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 18 Oct 2016 06:51:36 -0400
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout4.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0OF8008ENOTSAM80@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 18 Oct 2016 19:51:34 +0900 (KST)
In-reply-to: <0bb501d2292b$e6a43760$b3eca620$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy Kim <jh4u.kim@samsung.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org

Hi,

On 10/18/2016 07:39 PM, Jeremy Kim wrote:
> 
> It is used for limitation of buffer size during IOCTL such as FFU. However,
> eMMC FW size is bigger than (512L*256).
> (For instance, currently, Samsung eMMC FW size is over 300KB.)
> So, it needs to increase to execute FFU.
> 
> 
> Signed-off-by: Jeonghan Kim <jh4u.kim@samsung.com>
> ---
>  ioctl.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Where is ioctl.h? "include/uapi/linux/mmc/ioctl.h"?

Best Regards,
Jaehoon Chung

> 
> diff --git a/ioctl.h b/ioctl.h
> index 7e385b8..700a551 100644
> --- a/ioctl.h
> +++ b/ioctl.h
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

