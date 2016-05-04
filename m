From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: prevent to set the wrong value
Date: Wed, 4 May 2016 18:35:34 +0800
Message-ID: <813b306b-4f32-bf13-dcdd-5bbb82d46661@rock-chips.com>
References: <1462346074-19113-1-git-send-email-jh80.chung@samsung.com>
 <1462346074-19113-2-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:52053 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcEDKfw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 May 2016 06:35:52 -0400
In-Reply-To: <1462346074-19113-2-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, ulf.hansson@linaro.org

=D4=DA 2016/5/4 15:14, Jaehoon Chung =D0=B4=B5=C0:
> If there is no vqmmc, real voltage should not change.
> Then it needs to maintain the previous status for UHS_REG register.
> It means that it doesn't need to set any bit.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 28602cc..6bd8018 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1418,7 +1418,19 @@ static int dw_mci_switch_voltage(struct mmc_ho=
st *mmc, struct mmc_ios *ios)
>  					 ret, uhs & v18 ? "1.8" : "3.3");
>  			return -EAGAIN;
>  		}
> +	} else {
> +		/*
> +		 * If there isn't vqmmc, it should fail to switch voltage.
> +		 * Then it needs to maintain the previous status.
> +		 * If ios->signal_voltage is 3.3v, it means that previous
> +		 * voltages was 1.8v.
> +		 */
> +		if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
> +			uhs |=3D v18;
> +		else
> +			uhs &=3D ~v18;

I think we can just set uhs after seting vqmmc correctly. So
how about changing like this?

         uhs =3D mci_readl(host, UHS_REG);

         if (!IS_ERR(mmc->supply.vqmmc)) {
                 ret =3D mmc_regulator_set_vqmmc(mmc, ios);
                 if (ret) {
                         dev_dbg(&mmc->class_dev,
                                 "Regulator set error %d - %s V\n",
                                  ret, uhs & v18 ? "3.3" : "1.8");
                         return -EAGAIN;
                 }
                 if (ios->signal_voltage =3D=3D MMC_SIGNAL_VOLTAGE_330)
                         uhs &=3D ~v18;
                 else
                         uhs |=3D v18;
         }
         mci_writel(host, UHS_REG, uhs);


>  	}
> +
>  	mci_writel(host, UHS_REG, uhs);
>
>  	return 0;
>


--=20
Best Regards
Shawn Lin

