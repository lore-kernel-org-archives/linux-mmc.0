From: "Christian Daudt" <csd@broadcom.com>
Subject: Re: [PATCH 1/1] mmc: sdhci-sirf: Fix build breakage
Date: Fri, 21 Jun 2013 08:46:28 -0700
Message-ID: <51C47554.7040400@broadcom.com>
References: <1371545694-31877-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms3.broadcom.com ([216.31.210.19]:2870 "EHLO mms3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161367Ab3FUPqj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Jun 2013 11:46:39 -0400
In-Reply-To: <1371545694-31877-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, Barry Song <Baohua.Song@csr.com>

On 13-06-18 01:54 AM, Sachin Kamat wrote:
> Commit 0e74823429 ("mmc: sdhci: Add size for caller in init+register"=
)
> introduced size parameter to sdhci_pltfm_init(). This driver probably
> got left out during the conversion. Passing in zero as done for other
> drivers to avoid the following build error:
>
> drivers/mmc/host/sdhci-sirf.c: In function =E2=80=98sdhci_sirf_probe=E2=
=80=99:
> drivers/mmc/host/sdhci-sirf.c:78:2: error: too few arguments to funct=
ion
> =E2=80=98sdhci_pltfm_init=E2=80=99
>    host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Christian Daudt <csd@broadcom.com>
> Cc: Barry Song <Baohua.Song@csr.com>
> ---
> Compile tested on linux-next (20130618)
> ---
>   drivers/mmc/host/sdhci-sirf.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-sirf.c b/drivers/mmc/host/sdhci-s=
irf.c
> index 09805af..1a149eb 100644
> --- a/drivers/mmc/host/sdhci-sirf.c
> +++ b/drivers/mmc/host/sdhci-sirf.c
> @@ -75,7 +75,7 @@ static int sdhci_sirf_probe(struct platform_device =
*pdev)
>   		priv->gpio_cd =3D -EINVAL;
>   	}
>  =20
> -	host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata);
> +	host =3D sdhci_pltfm_init(pdev, &sdhci_sirf_pdata, 0);
>   	if (IS_ERR(host)) {
>   		ret =3D PTR_ERR(host);
>   		goto err_sdhci_pltfm_init;
Acked-by: Christian Daudt <csd@broadcom.com>

  Thanks,
    csd


