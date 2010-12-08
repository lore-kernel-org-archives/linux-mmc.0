From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH V2 3/3] sdhci: support H/W clock gating in Marvell PXA driver
Date: Wed, 8 Dec 2010 11:31:17 +0900
Message-ID: <AANLkTimy8SgLXf4Lyv=RMHjd90G4jaFbxiaWpHraW47M@mail.gmail.com>
References: <192979DE-DB3E-467B-BD5B-B52049248CC6@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63061 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754770Ab0LHCbS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Dec 2010 21:31:18 -0500
Received: by wwa36 with SMTP id 36so666203wwa.1
        for <linux-mmc@vger.kernel.org>; Tue, 07 Dec 2010 18:31:17 -0800 (PST)
In-Reply-To: <192979DE-DB3E-467B-BD5B-B52049248CC6@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Nicolas Pitre <nico@fluxnic.net>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>

Hi,

what's the difference between previous 2/3 patch?

Thank you,
Kyungmin Park

On Wed, Dec 8, 2010 at 2:56 AM, Philip Rakity <prakity@marvell.com> wro=
te:
>
> Define callback (platform_hw_clk_gate) that is called when H/W clock =
gating
> is defined. The adaptation layer is responsible for enabling hw clock
> gating by:
>
> a) setting mmc->caps |=3D MMC_CAP_HW_CLOCK_GATING to enable h/w gatin=
g
> b) defining the callback.
>
> This code tested in the Marvell Linux.
>
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> Signed-off-by: Mark F. Brown <markb@marvell.com>
> ---
> =A0drivers/mmc/host/sdhci.c | =A0 =A06 ++++++
> =A0drivers/mmc/host/sdhci.h | =A0 =A01 +
> =A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8a74fcb..c2e7c9e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1188,6 +1188,12 @@ static void sdhci_set_ios(struct mmc_host *mmc=
, struct mmc_ios *ios)
> =A0 =A0 =A0 =A0if (host->ops->platform_send_init_74_clocks)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->ops->platform_send_init_74_clock=
s(host, ios->power_mode);
>
> +#ifdef CONFIG_MMC_CLKGATE
> + =A0 =A0 =A0 if ((mmc->caps & MMC_CAP_HW_CLOCK_GATING)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 && host->ops->platform_hw_clk_gate)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->platform_hw_=
clk_gate(host);
> +#endif
> +
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * If your platform has 8-bit width support but is not=
 a v3 controller,
> =A0 =A0 =A0 =A0 * or if it requires special setup code, you should im=
plement that in
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 1efe7dc..26a8c09 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -221,6 +221,7 @@ struct sdhci_ops {
> =A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host=
 *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 power_mode);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host)=
;
> + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0(*platform_hw_clk_gate)(str=
uct sdhci_host *host);
> =A0};
>
> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
