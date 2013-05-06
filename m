From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 22/22] mmc: wmt-sdmmc: remove unnecessary platform_set_drvdata()
Date: Tue, 07 May 2013 06:53:40 +1200
Message-ID: <5187FC34.30104@prisktech.co.nz>
References: <006101ce4a24$98be27c0$ca3a7740$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:57429 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754968Ab3EFSxh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 6 May 2013 14:53:37 -0400
In-Reply-To: <006101ce4a24$98be27c0$ca3a7740$@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Chris Ball' <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 06/05/13 18:40, Jingoo Han wrote:
> The driver core clears the driver data to NULL after device_release
> or on probe failure, since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata = NULL when no driver is bound).
> Thus, it is not needed to manually clear the device driver data to NULL.
>
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>   drivers/mmc/host/wmt-sdmmc.c |    2 --
>   1 files changed, 0 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 442f576..34231d5 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -927,8 +927,6 @@ static int wmt_mci_remove(struct platform_device *pdev)
>   
>   	mmc_free_host(mmc);
>   
> -	platform_set_drvdata(pdev, NULL);
> -
>   	dev_info(&pdev->dev, "WMT MCI device removed\n");
>   
>   	return 0;
Acked-by: Tony Prisk <linux@prisktech.co.nz>
