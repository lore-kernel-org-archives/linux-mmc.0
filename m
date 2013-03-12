From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: Make dw_mci_exynos_probe static
Date: Tue, 12 Mar 2013 09:03:51 -0400
Message-ID: <8738w0ixc8.fsf@octavius.laptop.org>
References: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:59461 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753114Ab3CLNED (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Mar 2013 09:04:03 -0400
In-Reply-To: <1361177589-23953-1-git-send-email-sachin.kamat@linaro.org>
	(Sachin Kamat's message of "Mon, 18 Feb 2013 14:23:08 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, jh80.chung@samsung.com, patches@linaro.org, tgih.jun@samsung.com

Hi,

On Mon, Feb 18 2013, Sachin Kamat wrote:
> Silences the following sparse warning:
> drivers/mmc/host/dw_mmc-exynos.c:218:5: warning:
> symbol 'dw_mci_exynos_probe' was not declared. Should it be static?
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 72fd0f2..5a09c77 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -215,7 +215,7 @@ static const struct of_device_id dw_mci_exynos_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, dw_mci_exynos_match);
>  
> -int dw_mci_exynos_probe(struct platform_device *pdev)
> +static int dw_mci_exynos_probe(struct platform_device *pdev)
>  {
>  	const struct dw_mci_drv_data *drv_data;
>  	const struct of_device_id *match;

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
