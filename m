From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [RFC PATCH 3.7.0-rc4 2/4] mm:exynos: use of_simple_module_id_table
 macro.
Date: Fri, 16 Nov 2012 19:00:34 +0530
Message-ID: <CAGxe1ZEGn7Oq+6NbWFKwEx53RPS-Xh3MvRdHKNj1sb2kT3vEVg@mail.gmail.com>
References: <1353072101-21816-1-git-send-email-srinivas.kandagatla@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:45688 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620Ab2KPNaf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Nov 2012 08:30:35 -0500
Received: by mail-vc0-f174.google.com with SMTP id fk26so2815069vcb.19
        for <linux-mmc@vger.kernel.org>; Fri, 16 Nov 2012 05:30:34 -0800 (PST)
In-Reply-To: <1353072101-21816-1-git-send-email-srinivas.kandagatla@st.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, viresh.linux@gmail.com, g.liakhovetski@gmx.de, ian@mnementh.co.uk, thomas.ab@samsung.com, spear-devel@list.st.com, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On 16 November 2012 18:51, Srinivas KANDAGATLA
<srinivas.kandagatla@st.com> wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@st.com>
>
> This patch uses of_simple_module_id_table macro to replace code like:
>
> #ifdef CONFIG_OF
>     static struct of_device_id xxx_of_match[] = {
>         { .compatible = "yyy,xxx" },
>         { },
>     };
>     MODULE_DEVICE_TABLE(of, xxx_of_match);
> #endif
>
> with
>         of_simple_module_id_table(xxx_of_match, "yyy,zzz");
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> ---
>  drivers/mmc/host/dw_mmc-exynos.c |    7 +------
>  1 files changed, 1 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 660bbc5..1e9596a 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -218,12 +218,7 @@ static struct dw_mci_drv_data exynos5250_drv_data = {
>         .setup_bus              = dw_mci_exynos_setup_bus,
>  };
>
> -static const struct of_device_id dw_mci_exynos_match[] = {
> -       { .compatible = "samsung,exynos5250-dw-mshc",
> -                       .data = (void *)&exynos5250_drv_data, },
> -       {},
> -};
Here's the problem. You are missing the driver data for the exynos
SoC. this is very much required.
where's the  .data = (void *)&exynos5250_drv_data,?

> -MODULE_DEVICE_TABLE(of, dw_mci_pltfm_match);
> +of_simple_module_id_table(dw_mci_pltfm_match, "samsung,exynos5250-dw-mshc");
>
>  int dw_mci_exynos_probe(struct platform_device *pdev)
>  {
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
