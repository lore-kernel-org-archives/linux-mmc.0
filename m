From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: Fix DDR mode support.
Date: Fri, 5 Aug 2011 22:35:36 +0100
Message-ID: <CAELcNGTNA83nD3kCh=-BJ6DxRqnNaRznn3mTd5PVY_fRArp+fA@mail.gmail.com>
References: <1312515303-17169-1-git-send-email-tgih.jun@samsung.com>
	<CAFbHwiT3p3pSC1q4xQRYkLzSG7tPuGLXB4KKwC-8HWMmtF+fhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:56915 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701Ab1HEVfi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Aug 2011 17:35:38 -0400
In-Reply-To: <CAFbHwiT3p3pSC1q4xQRYkLzSG7tPuGLXB4KKwC-8HWMmtF+fhA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-kernel@vger.kernel.org

Hi Seungwon

This patch is looks fine to me..

Just ask to you...Don't you want to locate MMC_CAP_MMC_HIGHSPEED in pla=
tdata?

Regards,
Jaehoon Chung


2011/8/5 Will Newton <will.newton@gmail.com>:
> On Fri, Aug 5, 2011 at 4:35 AM, Seungwon Jeon <tgih.jun@samsung.com> =
wrote:
>> Host driver can't get a hint of DDR mode through ios->ddr flag anymo=
re.
>> ios->timing is currently used to inform DDR mode as a substitute.
>> And capability of MMC_CAP_MMC_HIGHSPEED is added for DDR support.
>>
>> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
>> ---
>> =A0drivers/mmc/host/dw_mmc.c | =A0 =A04 ++--
>> =A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index d65511e..b412a1d 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -699,7 +699,7 @@ static void dw_mci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios)
>> =A0 =A0 =A0 =A0}
>>
>> =A0 =A0 =A0 =A0/* DDR mode set */
>> - =A0 =A0 =A0 if (ios->ddr) {
>> + =A0 =A0 =A0 if (ios->timing =3D=3D MMC_TIMING_UHS_DDR50) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs =3D mci_readl(slot->host, UHS_RE=
G);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regs |=3D (0x1 << slot->id) << 16;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(slot->host, UHS_REG, regs)=
;
>> @@ -1646,7 +1646,7 @@ static int __init dw_mci_init_slot(struct dw_m=
ci *host, unsigned int id)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CA=
P_4_BIT_DATA;
>>
>> =A0 =A0 =A0 =A0if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_SD_HIGHSPEED | =
MMC_CAP_MMC_HIGHSPEED;
>>
>> =A0#ifdef CONFIG_MMC_DW_IDMAC
>> =A0 =A0 =A0 =A0mmc->max_segs =3D host->ring_size;
>> --
>> 1.7.0.4
>
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
