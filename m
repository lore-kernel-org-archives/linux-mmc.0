From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci_qcom_dml: include mmci_qcom_dml.h to fix sparse warnings
Date: Thu, 3 Aug 2017 12:51:25 +0200
Message-ID: <CAPDyKFp9CwsiovKW_GfVPkccRH1RZfMUvuZBxTLmWoWBr_Lc3A@mail.gmail.com>
References: <1501502394-13843-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:38367 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752014AbdHCKv1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Aug 2017 06:51:27 -0400
Received: by mail-qk0-f169.google.com with SMTP id x191so5079742qka.5
        for <linux-mmc@vger.kernel.org>; Thu, 03 Aug 2017 03:51:26 -0700 (PDT)
In-Reply-To: <1501502394-13843-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 31 July 2017 at 13:59, Masahiro Yamada <yamada.masahiro@socionext.com> wrote:
> This fixes the following sparse warnings:
>
>   CHECK   drivers/mmc/host/mmci_qcom_dml.c
> drivers/mmc/host/mmci_qcom_dml.c:57:6: warning: symbol 'dml_start_xfer' was not declared. Should it be static?
> drivers/mmc/host/mmci_qcom_dml.c:122:5: warning: symbol 'dml_hw_init' was not declared. Should it be static?
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>
>  drivers/mmc/host/mmci_qcom_dml.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/host/mmci_qcom_dml.c b/drivers/mmc/host/mmci_qcom_dml.c
> index 00750c9d3514..95de699853d2 100644
> --- a/drivers/mmc/host/mmci_qcom_dml.c
> +++ b/drivers/mmc/host/mmci_qcom_dml.c
> @@ -18,6 +18,7 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
>  #include "mmci.h"
> +#include "mmci_qcom_dml.h"
>
>  /* Registers */
>  #define DML_CONFIG                     0x00
> --
> 2.7.4
>
