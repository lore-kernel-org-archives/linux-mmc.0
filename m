From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: moxart: Remove unneeded version.h inclusion
Date: Tue, 27 May 2014 16:41:31 +0530
Message-ID: <CAK9yfHwJ5Hn_ojAgd8ZsvYJXmQNcJNS5=5QX+re8Ps0JVs1YDA@mail.gmail.com>
References: <1400731605-1261-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:37488 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaE0LLb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 27 May 2014 07:11:31 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so8868869obc.26
        for <linux-mmc@vger.kernel.org>; Tue, 27 May 2014 04:11:31 -0700 (PDT)
In-Reply-To: <1400731605-1261-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "chris@printf.net" <chris@printf.net>, Sachin Kamat <sachin.kamat@linaro.org>, Jonas Jensen <jonas.jensen@gmail.com>

On 22 May 2014 09:36, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> version.h inclusion is not needed as suggested by versioncheck.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jonas Jensen <jonas.jensen@gmail.com>
> ---
>  drivers/mmc/host/moxart-mmc.c |    1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
> index 74924a04026e..b4b1efbf6c16 100644
> --- a/drivers/mmc/host/moxart-mmc.c
> +++ b/drivers/mmc/host/moxart-mmc.c
> @@ -13,7 +13,6 @@
>   * warranty of any kind, whether express or implied.
>   */
>
> -#include <linux/version.h>
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> --
> 1.7.9.5
>

Gentle ping.

-- 
With warm regards,
Sachin
