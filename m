From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 14:59:59 +0100
Message-ID: <3154671.7LPLgq8X4K@wuerfel>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <001c01cf11ed$039b6270$0ad22750$%jun@samsung.com> <52D6938A.9050806@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:51931 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaAOOAU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 09:00:20 -0500
In-Reply-To: <52D6938A.9050806@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wednesday 15 January 2014 21:56:26 zhangfei wrote:
> However, in our board cd =0 when card is deteced while cd=1 when card is
> removed.
> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> set, as well as new property "caps2-mmc-cd-active-low".
> 
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -73,6 +73,8 @@ Optional properties:
> +* caps2-mmc-cd-active-low: cd pin is low when card active
> +
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
> +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> +

The MMC_CAP2_CD_ACTIVE_HIGH flag should only be required for
legacy platforms. With DT parsing, you can normally specify
the polarity of the GPIO line in the GPIO specifier in DT.


	Arnd
