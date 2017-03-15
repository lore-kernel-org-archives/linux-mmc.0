From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: Re: [RFC PATCH] mmc: core: HS DDR switch, don't change timing before
 checking status
Date: Wed, 15 Mar 2017 12:48:04 +0100
Message-ID: <133e7fc9-2d01-79a2-8f1e-08ce2ebf835f@microchip.com>
References: <98664253-9a68-fa59-7f17-438b0d522fe8@microchip.com>
 <20170310142117.6060-1-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170310142117.6060-1-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, ulf.hansson@linaro.org
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, Thorsten Leemhuis <regressions@leemhuis.info>, linux-mmc@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Le 10/03/2017 =E0 15:21, Ludovic Desroches a =E9crit :
> From: Ludovic Desroches <ludovic.desroches@microchip.com>
> =

> The commit e173f8911f09 mmc: core: Update CMD13 polling policy when
> switch to HS DDR mode in addition to fix the management of CRC error,
> changes the place where the DDR52 timing is set.
> =

> Before this commit, the sequence was:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - check the status
> - set width to 8 with MMC_DDR52 timing
> - send the switch command
> - check the status
> Now:
> - set width to 8 with MMC_HS timing
> - send the switch command
> - set width to 8 with MMC_DDR52 timing
> - check the status
> =

> It may lead to get an error when checking the status with some devices.
> =

> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>

On sama5d2 Xplained (eMMC on sdhci).

Note that without this patch the system is unable to boot. Even if it
was present on 4.10 but we didn't spot it, I see now this as a regression.

We would also need to add the tags:
Cc: stable <stable@vger.kernel.org> #4.10+
Fixes: e173f8911f09 ("mmc: core: Update CMD13 polling policy when switch
to HS DDR mode")


Best regards,

> ---
>  drivers/mmc/core/mmc.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> =

> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 0fccca0..b837148 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1062,7 +1062,7 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  			   EXT_CSD_BUS_WIDTH,
>  			   ext_csd_bits,
>  			   card->ext_csd.generic_cmd6_time,
> -			   MMC_TIMING_MMC_DDR52,
> +			   0,
>  			   true, true, true);
>  	if (err) {
>  		pr_err("%s: switch to bus width %d ddr failed\n",
> @@ -1106,6 +1106,9 @@ static int mmc_select_hs_ddr(struct mmc_card *card)
>  	if (err)
>  		err =3D __mmc_set_signal_voltage(host, MMC_SIGNAL_VOLTAGE_330);
>  =

> +	if (!err)
> +		mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
> +
>  	return err;
>  }
>  =

> =



-- =

Nicolas Ferre
