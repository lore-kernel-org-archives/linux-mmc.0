From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: use the use_hold_reg bit in CMD register
Date: Wed, 13 Jun 2012 12:03:11 +0530
Message-ID: <CAGxe1ZGZMgpfq+iudkA3SW8VAa0TM8z2fLphi1WCr=hhi_+q0A@mail.gmail.com>
References: <4E859DEF.7090308@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:47039 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab2FMGdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Jun 2012 02:33:12 -0400
Received: by wgbds11 with SMTP id ds11so5081037wgb.1
        for <linux-mmc@vger.kernel.org>; Tue, 12 Jun 2012 23:33:11 -0700 (PDT)
In-Reply-To: <4E859DEF.7090308@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, kyungmin.park@samsung.com, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On 30 September 2011 16:16, Jaehoon Chung <jh80.chung@samsung.com> wrot=
e:
> This patch is added the use_hold_reg bit in CMD register.
>
> In 2.40a, bit[29] of CMD register is used the use_hold_reg.
> Some SoC is affected by this bit.
> (This bit means whether use hold register when send data and cmd.
> =A0And related with cclk_in_drv phase)
> if set IMPLEMENT_HOLD_REG in HCON register, i think fine that set thi=
s
> bit by default.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 =A09 +++++++++
> =A0drivers/mmc/host/dw_mmc.h =A0| =A0 =A01 +
> =A0include/linux/mmc/dw_mmc.h | =A0 =A01 +
> =A03 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0ed1d28..544a616 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -276,6 +276,13 @@ static void dw_mci_start_command(struct dw_mci *=
host,
> =A0 =A0 =A0 =A0mci_writel(host, CMDARG, cmd->arg);
> =A0 =A0 =A0 =A0wmb();
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If use HOLD register,
> + =A0 =A0 =A0 =A0* CMD and DATA sent to card through HOLD register.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->use_hold_reg)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd_flags |=3D SDMMC_CMD_USE_HOLD_REG;
> +
sorry for seeing the patch very late.
I think its not just enough to check the HCON register. it is also
necessary to check whether CLKSEL[18:16] field is not 0 in combination
with HCON

> =A0 =A0 =A0 =A0mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
> =A0}
>
> @@ -1886,6 +1893,8 @@ static int dw_mci_probe(struct platform_device =
*pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data_shift =3D 2;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 host->use_hold_reg =3D (mci_readl(host, HCON) >> 22) & =
0x1;
> +
> =A0 =A0 =A0 =A0/* Reset all blocks */
> =A0 =A0 =A0 =A0if (!mci_wait_reset(&pdev->dev, host)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D -ENODEV;
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index bfa3c1c..8c4edca 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -102,6 +102,7 @@
> =A0#define SDMMC_INT_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A00xbfc2
> =A0/* Command register defines */
> =A0#define SDMMC_CMD_START =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0BIT(31)
> +#define SDMMC_CMD_USE_HOLD_REG =A0 =A0 =A0 =A0 BIT(29)
> =A0#define SDMMC_CMD_CCS_EXP =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(23)
> =A0#define SDMMC_CMD_CEATA_RD =A0 =A0 =A0 =A0 =A0 =A0 BIT(22)
> =A0#define SDMMC_CMD_UPD_CLK =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(21)
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 6b46819..d6d1515 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -147,6 +147,7 @@ struct dw_mci {
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 current_sp=
eed;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 num_slots;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifoth_val=
;
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0use_hold_re=
g;
> =A0 =A0 =A0 =A0struct platform_device =A0*pdev;
> =A0 =A0 =A0 =A0struct dw_mci_board =A0 =A0 *pdata;
> =A0 =A0 =A0 =A0struct dw_mci_slot =A0 =A0 =A0*slot[MAX_MCI_SLOTS];
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
