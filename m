From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 1/3] MAINTAINERS: mmc: Update filepath to cover all files
 for sdhci-s3c
Date: Mon, 16 Mar 2015 11:11:59 +0900
Message-ID: <55063BEF.9050507@samsung.com>
References: <1426251093-10885-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1426251093-10885-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>
Cc: linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: linux-mmc@vger.kernel.org

Hi, Ulf.

If Ben is oK, I will want to maintain all files of sdhci-s3c*.
(sdhci-s3c is Samsung specific driver code. So i can maintain it.)
I think he didn't maintain sdhci-s3c. How about?

Best Regards,
Jaehoon Chung

On 03/13/2015 09:51 PM, Ulf Hansson wrote:
> Cc: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6239a30..78a22aa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8680,7 +8680,7 @@ SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) SAMSUNG DRIVER
>  M:	Ben Dooks <ben-linux@fluff.org>
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
> -F:	drivers/mmc/host/sdhci-s3c.c
> +F:	drivers/mmc/host/sdhci-s3c*
>  
>  SECURE DIGITAL HOST CONTROLLER INTERFACE (SDHCI) ST SPEAR DRIVER
>  M:	Viresh Kumar <viresh.linux@gmail.com>
> 
