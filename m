From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] [V3] mmc: mmci: add missing include of mmci_qcom_dml.h
Date: Fri, 17 Jun 2016 09:08:54 +0100
Message-ID: <5763B016.6050002@linaro.org>
References: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:37170 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbcFQII7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2016 04:08:59 -0400
Received: by mail-wm0-f50.google.com with SMTP id a66so89751008wme.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Jun 2016 01:08:58 -0700 (PDT)
In-Reply-To: <1466102852-10063-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Thanks for the patch.

On 16/06/16 19:47, Ben Dooks wrote:
> Fix the missing declarations of dml_start_xfer() and
> dml_hw_init() by including mmci_qcom_dml.h to fix the
> following warnings:
>
> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
>
> Since the module build doesn't export symbols, also
> export the symbols from the mmci_qcom_dml.c file as
> otherwise the module link process won't work.
>
> It is possible this also fixes up module loading when
> both drivers are built as modules and not inserted in
> the correct order.
>
> Note, since this is a very small addition to the mmci
> module, it would better to build it into the main mmci
> driver (either by direct copy, or multiple linked
> module)
>
Let's fix this in a go, making it possible to insert this as a module.
As this patch only fixes a part of the problem.

Some comments below.

> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> V1..V2:
>    - deal with module build errors
> V2..V3:
>    - add original authour and update list of recipients
> ---
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/mmc/host/mmci_qcom_dml.c | 3 +++
>   drivers/mmc/host/mmci_qcom_dml.h | 2 +-
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 2b7fc37..06858bd 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -18,6 +18,7 @@
>   #include <linux/mmc/host.h>
>   #include <linux/mmc/card.h>
>   #include "mmci.h"
also include
#include <linux/module.h>
> +#include "mmci_qcom_dml.h"
>
>   /* Registers */
>   #define DML_CONFIG			0x00
> @@ -97,6 +98,7 @@ void dml_start_xfer(struct mmci_host *host, struct mmc_data *data)
>   	/* make sure the dml is configured before dma is triggered */
>   	wmb();
>   }
> +EXPORT_SYMBOL_GPL(dml_start_xfer);
>
>   static int of_get_dml_pipe_index(struct device_node *np, const char *name)
>   {
> @@ -175,3 +177,4 @@ int dml_hw_init(struct mmci_host *host, struct device_node *np)
>
>   	return 0;
>   }
> +EXPORT_SYMBOL_GPL(dml_hw_init);

You would also need this at the end of the file, to be able to 
successfully insert the module.

MODULE_DESCRIPTION("QCOM DML Driver");
MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/mmci_qcom_dml.h b/drivers/mmc/host/mmci_qcom_dml.h
> index 6e405d0..d77873d 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.h
> +++ b/drivers/mmc/host/mmci_qcom_dml.h
> @@ -15,7 +15,7 @@
>   #ifndef __MMC_QCOM_DML_H__
>   #define __MMC_QCOM_DML_H__
>
> -#ifdef CONFIG_MMC_QCOM_DML
> +#if defined(CONFIG_MMC_QCOM_DML) || defined(CONFIG_MMC_QCOM_DML_MODULE)

should be
#if IS_ENABLED(CONFIG_MMC_QCOM_DML)

>   int dml_hw_init(struct mmci_host *host, struct device_node *np);
>   void dml_start_xfer(struct mmci_host *host, struct mmc_data *data);
>   #else
>
