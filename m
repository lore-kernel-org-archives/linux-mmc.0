From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 03/12] mmc: sdhci-pxav3: Move private driver data
 to driver source
Date: Mon, 27 Oct 2014 14:39:04 +0100
Message-ID: <CAPDyKFo+sSgc+J5uiNyhzwF69ncLmo7aoVgUB5O1JA4MrhhPbA@mail.gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
	<1413883364-681-4-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:39889 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbaJ0NjG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 09:39:06 -0400
Received: by mail-qa0-f48.google.com with SMTP id x12so3797870qac.35
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 06:39:05 -0700 (PDT)
In-Reply-To: <1413883364-681-4-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> struct sdhci_pxa is only used in sdhci_pxa driver itself, so move it
> there.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>

Thanks! Applied for next!

Kind regards
Uffe


> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav3.c          | 5 +++++
>  include/linux/platform_data/pxa_sdhci.h | 5 -----
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-=
pxav3.c
> index b55c807982fe..48bc8179c8fc 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -58,6 +58,11 @@
>  #define SDCE_MISC_INT          (1<<2)
>  #define SDCE_MISC_INT_EN       (1<<1)
>
> +struct sdhci_pxa {
> +       u8      clk_enable;
> +       u8      power_mode;
> +};
> +
>  /*
>   * These registers are relative to the second register region, for t=
he
>   * MBus bridge.
> diff --git a/include/linux/platform_data/pxa_sdhci.h b/include/linux/=
platform_data/pxa_sdhci.h
> index 27d3156d093a..9e20c2fb4ffd 100644
> --- a/include/linux/platform_data/pxa_sdhci.h
> +++ b/include/linux/platform_data/pxa_sdhci.h
> @@ -55,9 +55,4 @@ struct sdhci_pxa_platdata {
>         unsigned int    quirks2;
>         unsigned int    pm_caps;
>  };
> -
> -struct sdhci_pxa {
> -       u8      clk_enable;
> -       u8      power_mode;
> -};
>  #endif /* _PXA_SDHCI_H_ */
> --
> 2.1.1
>
