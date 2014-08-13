From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH RFC 5/5] mmc: mmci: move ST specific sdio setup under a condition
Date: Wed, 13 Aug 2014 10:58:45 +0200
Message-ID: <CACRpkdY-rhuqMgY7ZRB8YEi+AiNMV_SLbSGJy7Nw+ytyjQXMnA@mail.gmail.com>
References: <1407844950-8072-1-git-send-email-srinivas.kandadgatla@linaro.org>
	<1407845127-8448-1-git-send-email-srinivas.kandadgatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:58157 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbaHMI6p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 04:58:45 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so8237773oag.16
        for <linux-mmc@vger.kernel.org>; Wed, 13 Aug 2014 01:58:45 -0700 (PDT)
In-Reply-To: <1407845127-8448-1-git-send-email-srinivas.kandadgatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Russell King <linux@arm.linux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>

On Tue, Aug 12, 2014 at 2:05 PM, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch moves ST specific sdio setup under a vendor id condition,
> this will ensure that the ST specfic setup is not done on other vendor
> like Qualcomm.
>
> Originally the issue was detected while testing WLAN ath6kl on IFC6410
> board with APQ8064 SOC.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

So instead of again checking hw_designer (I think that's a bit
messy) and instead of having the flag bool sdio from patch
1, why not introduce 2 flags in vendor_data:

bool st_sdio;
bool qcom_sdio;

> +++ b/drivers/mmc/host/mmci.c
> @@ -828,7 +828,8 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
>                          * otherwise the transfer will not start. The threshold
>                          * depends on the rate of MCLK.
>                          */
> -                       if (data->flags & MMC_DATA_WRITE &&
> +                       if (host->hw_designer == AMBA_VENDOR_ST &&
> +                           data->flags & MMC_DATA_WRITE &&

And this becomes just

if (variant->st_sdio)...

>                             (host->size < 8 ||
>                              (host->size <= 8 && host->mclk > 50000000)))
>                                 clk = host->clk_reg & ~variant->clkreg_enable;

Yours,
Linus Walleij
