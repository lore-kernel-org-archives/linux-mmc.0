From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: Workaround for reducing the
 maximum speed on ls1021atwr
Date: Thu, 16 Nov 2017 08:34:01 +0100
Message-ID: <CAPDyKFotZ9eZkSCj603BGuHOTCXitd7GmaKk0XFsj_7=CnoDgg@mail.gmail.com>
References: <20171115090103.25366-1-yinbo.zhu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:39923 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758722AbdKPHeD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Nov 2017 02:34:03 -0500
Received: by mail-io0-f171.google.com with SMTP id x63so4268207ioe.6
        for <linux-mmc@vger.kernel.org>; Wed, 15 Nov 2017 23:34:03 -0800 (PST)
In-Reply-To: <20171115090103.25366-1-yinbo.zhu@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 15 November 2017 at 10:01,  <yinbo.zhu@nxp.com> wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>
> In SDHC high speed AC timing, the tshivkh parameter
> is defined as input setup times:SDHC_CMD, SDHC_DATx,
> to SDHC_CLK. The value of the tshivkh should be 2.5 ns
> considering the round trip delay, board/data skew.
> However, because of this erratum, it needs
> at least 4.1 ns.
>
> eSDHC cannot run at the maximum clock speed for the
> high speed mode, or there is a limit on the length
> of the trace on the board for data, command, and
> clock lines of the SDHC.
>
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 023c24bd0d94..2744dd58a573 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -498,6 +498,12 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
>                         clock -= 5000000;
>         }
>
> +       /* Workaround to reduce the clock frequency for ls1021a esdhc */
> +       if (of_find_compatible_node(NULL, NULL, "fsl,ls1021a-esdhc")) {

It's better to use the ->data pointer in the struct of_device_id for
this kind of variant data.

In ->probe() you then call of_match_device() and pick up the ->data
pointer and assign it to your driver private data.

Many drivers already do like this. Have a look at dw_mmc-exynos.c for example.

> +               if (clock == 50000000)
> +                       clock = 46500000;
> +       }
> +
>         temp = sdhci_readl(host, ESDHC_SYSTEM_CONTROL);
>         temp &= ~(ESDHC_CLOCK_SDCLKEN | ESDHC_CLOCK_IPGEN | ESDHC_CLOCK_HCKEN |
>                   ESDHC_CLOCK_PEREN | ESDHC_CLOCK_MASK);

Kind regards
Uffe
