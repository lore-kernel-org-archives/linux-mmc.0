From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: pxa168/gplugd: Add support for SD port 1
Date: Mon, 18 Mar 2013 09:09:18 +0800
Message-ID: <CAN1soZyNjaG8b6aU+3FF1z_1Q3h8BTSzuBSa5vDctWWfJsRKmw@mail.gmail.com>
References: <1363544206-3671-1-git-send-email-tanmay.upadhyay@einfochips.com>
	<1363544406-3837-1-git-send-email-tanmay.upadhyay@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f173.google.com ([209.85.215.173]:43610 "EHLO
	mail-ea0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750849Ab3CRBJU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Mar 2013 21:09:20 -0400
Received: by mail-ea0-f173.google.com with SMTP id h14so2253711eak.4
        for <linux-mmc@vger.kernel.org>; Sun, 17 Mar 2013 18:09:19 -0700 (PDT)
In-Reply-To: <1363544406-3837-1-git-send-email-tanmay.upadhyay@einfochips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>, Chris Ball <cjb@laptop.org>
Cc: Miao Eric <eric.y.miao@gmail.com>, Philip Rakity <prakity@marvell.com>, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Mar 18, 2013 at 2:20 AM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - after sdhci-pxav1 driver is merged with sdhci-pxav2, pass
>      pxav1_controller = 1
>    - as sdhci device numbering now starts from 1, call
>      pxa168_add_sdh accordingly
>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/mach-mmp/gplugd.c |    6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/mach-mmp/gplugd.c b/arch/arm/mach-mmp/gplugd.c
> index 5c3d61e..d821368 100644
> --- a/arch/arm/mach-mmp/gplugd.c
> +++ b/arch/arm/mach-mmp/gplugd.c
> @@ -155,6 +155,11 @@ struct pxa168_eth_platform_data gplugd_eth_platform_data = {
>         .init        = gplugd_eth_init,
>  };
>
> +struct sdhci_pxa_platdata gplugd_sdh_platdata = {
> +       .delay_in_ms = 5,
> +       .pxav1_controller = 1,
> +};
> +
>  static void __init select_disp_freq(void)
>  {
>         /* set GPIO 35 & clear GPIO 85 to set LCD External Clock to 74.25 MHz */
> @@ -188,6 +193,7 @@ static void __init gplugd_init(void)
>         platform_device_register(&pxa168_device_gpio);
>
>         pxa168_add_eth(&gplugd_eth_platform_data);
> +       pxa168_add_sdh(1, &gplugd_sdh_platdata);
>  }
>
>  MACHINE_START(GPLUGD, "PXA168-based GuruPlug Display (gplugD) Platform")
> --
> 1.7.9.5
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
