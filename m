From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 1/2] mmc: dw_mmc: add hw_reset support
Date: Mon, 26 Oct 2015 08:47:24 +0800
Message-ID: <562D781C.1090203@rock-chips.com>
References: <1445494740-16778-1-git-send-email-shawn.lin@rock-chips.com>
 <1445494785-16864-1-git-send-email-shawn.lin@rock-chips.com>
 <562A230A.80409@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <562A230A.80409@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

=E5=9C=A8 2015/10/23 20:07, Jaehoon Chung =E5=86=99=E9=81=93:
> Hi, Shawn.
>
> On 10/22/2015 03:19 PM, Shawn Lin wrote:
>> This patch implement hw_reset function for DesignWare
>> MMC controller. By adding this feature, mmc blk can
>> do some basic recovery if emmc device cannot work any
>> more for unknown reasons.
>
> Are there any other issue before applied this patch?
>

yes, but don't relate to dw_mmc itself. In some
low and high temperature test, I get reports that some emmcs don't
work properly for a very very small probability. I don't know what=20
happend to them, but reset them can slove the problem. So I have to=20
guess that these emmcs are not so robust at least for temperature test.

>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>   drivers/mmc/host/dw_mmc.c | 29 +++++++++++++++++++++++++++++
>>   drivers/mmc/host/dw_mmc.h |  4 ++++
>>   2 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 6e600e8..8a0f2995 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1478,6 +1478,34 @@ static int dw_mci_get_cd(struct mmc_host *mmc=
)
>>   	return present;
>>   }
>>
>> +static void dw_mci_hw_reset(struct mmc_host *mmc)
>> +{
>> +	struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> +	struct dw_mci *host =3D slot->host;
>> +
>> +	if (host->use_dma =3D=3D TRANS_MODE_IDMAC)
>> +		dw_mci_idmac_reset(host);
>> +
>> +	if (!dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET) ||
>> +	    (!dw_mci_ctrl_reset(host, SDMMC_CTRL_FIFO_RESET)))
>
> Why does it reset twice? Can't reset together with DMA and FIFO?
> dw_mci_ctrl_reset(host, SDMMC_CTRL_DMA_RESET | SDMMC_CTRL_FIFO_RESET)=
?
>

I reset these by the order provided by the instruction of dw databook.
I can setup my experiment to re-test to see if we can merge these two r=
eset.

Need a few days to test it, I will feedback later. :)

>> +		return;
>> +
>> +	/* CARD_RESET
>> +	 * According to eMMC spec
>> +	 * tRstW >=3D 1us:   RST_n pulse width
>> +	 * tRSCA >=3D 200us: RST_n to Command time
>> +	 * tRSTH >=3D 1us:   RST_n high period
>> +	 * Note: add some margin to make rst timing not too
>> +	 * "spec" for some bad qulity eMMC devices.
>
> some bad quality? Which devices are bad quality devices?

I test the diff reset time for the emmcs I mentioned above to see
the minimal requirment for them. As spec just say we need to make sure=20
the tRstW>1us, but I find 2us is enough for most of emmcs but still som=
e=20
need more than 4 us. So I make it 5us at least here.

>
>> +	 */
>> +	 mci_writel(slot->host, RST_N, SDMMC_RST_HWRESET);
>> +	 wmb(); /* drain writebuffer */
>> +	 usleep_range(5, 10);
>> +	 mci_writel(slot->host, RST_N, SDMMC_RST_HWACTIVE);
>> +	 wmb(); /* drain writebuffer */
>> +	 usleep_range(500, 1000);
>
> Need to drain writebuffer at here?
> I don't know why you choose those values..Just some margin?
> And if you want to apply this, i recommend to use the shift with card=
 number.
>

Just some margin.
okay, I will use the card number shift here.

> Best Regards,
> Jaehoon Chung
>
>> +}
>> +
>>   static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card=
 *card)
>>   {
>>   	struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> @@ -1564,6 +1592,7 @@ static const struct mmc_host_ops dw_mci_ops =3D=
 {
>>   	.set_ios		=3D dw_mci_set_ios,
>>   	.get_ro			=3D dw_mci_get_ro,
>>   	.get_cd			=3D dw_mci_get_cd,
>> +	.hw_reset               =3D dw_mci_hw_reset,
>>   	.enable_sdio_irq	=3D dw_mci_enable_sdio_irq,
>>   	.execute_tuning		=3D dw_mci_execute_tuning,
>>   	.card_busy		=3D dw_mci_card_busy,
>> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
>> index f2a88d4..9df18c1 100644
>> --- a/drivers/mmc/host/dw_mmc.h
>> +++ b/drivers/mmc/host/dw_mmc.h
>> @@ -46,6 +46,7 @@
>>   #define SDMMC_VERID		0x06c
>>   #define SDMMC_HCON		0x070
>>   #define SDMMC_UHS_REG		0x074
>> +#define SDMMC_RST_N		0x078
>>   #define SDMMC_BMOD		0x080
>>   #define SDMMC_PLDMND		0x084
>>   #define SDMMC_DBADDR		0x088
>> @@ -169,6 +170,9 @@
>>   #define SDMMC_IDMAC_ENABLE		BIT(7)
>>   #define SDMMC_IDMAC_FB			BIT(1)
>>   #define SDMMC_IDMAC_SWRESET		BIT(0)
>> +/* H/W reset*/
>> +#define SDMMC_RST_HWACTIVE		0x1
>> +#define SDMMC_RST_HWRESET		0x0
>>   /* Version ID register define */
>>   #define SDMMC_GET_VERID(x)		((x) & 0xFFFF)
>>   /* Card read threshold */
>>
>
>
>
>


--=20
Best Regards
Shawn Lin
