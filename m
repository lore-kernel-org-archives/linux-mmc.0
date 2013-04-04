From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 1/2] mmc: dw_mmc: Check return value of regulator_enable
Date: Thu, 04 Apr 2013 14:49:53 +0900
Message-ID: <004401ce30f8$3afdfe70$b0f9fb50$%jun@samsung.com>
References: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:13260 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006Ab3DDFtz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Apr 2013 01:49:55 -0400
Received: from epcpsbgr2.samsung.com
 (u142.gpu120.samsung.co.kr [203.254.230.142])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MKP008FVUV50SL0@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Thu, 04 Apr 2013 14:49:54 +0900 (KST)
In-reply-to: <1364444747-16777-1-git-send-email-sachin.kamat@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Sachin Kamat' <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org
Cc: jh80.chung@samsung.com, cjb@laptop.org, patches@linaro.org

On Thursday, March 28, 2013, Sachin Kamat wrote:
> regulator_enable() is declared with __must_check attribute.
> Hence check the return value to ensure that the regulator is enabled.
> Fixes the following warning:
> drivers/mmc/host/dw_mmc.c:2461:19: warning:
> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared=
 with attribute
> warn_unused_result [-Wunused-result]
> drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_init_slot=E2=80=
=99:
> drivers/mmc/host/dw_mmc.c:1994:19: warning:
> ignoring return value of =E2=80=98regulator_enable=E2=80=99, declared=
 with attribute
> warn_unused_result [-Wunused-result]
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/mmc/host/dw_mmc.c |   20 ++++++++++++++++----
>  1 files changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a443820..1ba09d0 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1990,8 +1990,14 @@ static int dw_mci_init_slot(struct dw_mci *hos=
t, unsigned int id)
>  	if (IS_ERR(host->vmmc)) {
>  		pr_info("%s: no vmmc regulator found\n", mmc_hostname(mmc));
>  		host->vmmc =3D NULL;
> -	} else
> -		regulator_enable(host->vmmc);
> +	} else {
> +		ret =3D regulator_enable(host->vmmc);
> +		if (ret !=3D 0) {
Just for trivial style... if (ret) {
It looks like more simple?

> +			dev_err(host->dev,
> +				"failed to enable regulator: %d\n", ret);
> +			goto err_setup_bus;
> +		}
> +	}
>=20
>  	if (dw_mci_get_cd(mmc))
>  		set_bit(DW_MMC_CARD_PRESENT, &slot->flags);
> @@ -2457,8 +2463,14 @@ int dw_mci_resume(struct dw_mci *host)
>  {
>  	int i, ret;
>=20
> -	if (host->vmmc)
> -		regulator_enable(host->vmmc);
> +	if (host->vmmc) {
> +		ret =3D regulator_enable(host->vmmc);
> +		if (ret !=3D 0) {
As above,

Thanks,
Seungwon Jeon
> +			dev_err(host->dev,
> +				"failed to enable regulator: %d\n", ret);
> +			return ret;
> +		}
> +	}
>=20
>  	if (!mci_wait_reset(host->dev, host)) {
>  		ret =3D -ENODEV;
> --
> 1.7.4.1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

