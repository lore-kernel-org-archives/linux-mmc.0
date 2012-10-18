From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 3/6] mmc: core: sdio_bus.c: Fixed lines > 80 chars
Date: Fri, 19 Oct 2012 08:54:34 +0900
Message-ID: <508096BA.6070706@samsung.com>
References: <n@samsung.com>
 <1350577919-2750-1-git-send-email-antiroot@gmail.com>
 <1350577919-2750-3-git-send-email-antiroot@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:43363 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096Ab2JRXzH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Oct 2012 19:55:07 -0400
In-reply-to: <1350577919-2750-3-git-send-email-antiroot@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sangho Yi <antiroot@gmail.com>
Cc: paul.gortmaker@windriver.com, stefan.xk.nilsson@stericsson.com, linus.walleij@linaro.org, ulf.hansson@stericsson.com, rjw@sisk.pl, girish.shivananjappa@linaro.org, cjb@laptop.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

your patch[1/3] is also "Fixed lines > 80chars".
Why do you separate with patch[1/6] and patch[3/6]?

Best Regards,
Jaehoon Chung

On 10/19/2012 01:31 AM, Sangho Yi wrote:
> I fixed lines over 80 characters per line.
> 
> Signed-off-by: Sangho Yi <antiroot@gmail.com>
> ---
>  drivers/mmc/core/sdio_bus.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
> index 13146d2..efa30eb 100644
> --- a/drivers/mmc/core/sdio_bus.c
> +++ b/drivers/mmc/core/sdio_bus.c
> @@ -27,7 +27,7 @@
>  /* show configuration fields */
>  #define sdio_config_attr(field, format_string)				\
>  static ssize_t								\
> -field##_show(struct device *dev, struct device_attribute *attr, char *buf)				\
> +field##_show(struct device *dev, struct device_attribute *attr, char *buf)\
>  {									\
>  	struct sdio_func *func;						\
>  									\
> @@ -39,7 +39,8 @@ sdio_config_attr(class, "0x%02x\n");
>  sdio_config_attr(vendor, "0x%04x\n");
>  sdio_config_attr(device, "0x%04x\n");
>  
> -static ssize_t modalias_show(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
>  {
>  	struct sdio_func *func = dev_to_sdio_func (dev);
>  
> 

