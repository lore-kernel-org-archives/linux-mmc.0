From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] mmc: dw_mmc: simplify the
 SDMMC_CLKEN_LOW_PWR logic
Date: Mon, 17 Aug 2015 07:52:00 +0200
Message-ID: <CAOMqctQ8DHj6qPg8zR93OGRHXAZDd0yUmG_J8Vz7dGFuDpCgRQ@mail.gmail.com>
References: <cover.1439381423.git.hramrach@gmail.com> <3d03bfe2c18789eefa038018467c9c63c94ae4a2.1439381423.git.hramrach@gmail.com>
 <55D13F07.70309@samsung.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCQMLUOX54MBBJ7NYWXAKGQEL3VYN3A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55D13F07.70309-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Seungwon Jeon <tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hello,

On 17 August 2015 at 03:55, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Hi, Michal.
>
> On 08/12/2015 09:23 PM, Michal Suchanek wrote:
>> The driver has open-coded test for SDIO cards. Use the mmc core provided
>> MMC_QUIRK_BROKEN_CLK_GATING flag instead.
>
> Did you use the clock-gating for SDIO cards?
> Doesn't MMC_CAP_SDIO_IRQ bit set? Which case is broken?
> Could you explain to me more?

The core flag for disabling power saving is MMC_QUIRK_BROKEN_CLK_GATING.

It may coincide with MMC_CAP_SDIO_IRQ but that's different flag for
different purpose.

MMC_QUIRK_BROKEN_CLK_GATING is currently set for all SDIO cards except
for cards on a whitelist.

I don't know any particular SDIO card that has problems when the clock
is off and does not use an IRQ.

Thanks

Michal

>
> Best Regards,
> Jaehoon Chung
>
>>
>> As a bonus this may enable clock gating on SDIO cards that are known to
>> work with it.
>>
>> Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  drivers/mmc/host/dw_mmc.c | 33 +++++++++++++++------------------
>>  1 file changed, 15 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 40e9d8e..3bc9fd7 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1335,27 +1335,24 @@ static void dw_mci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>>        * description of the CLKENA register we should disable low power mode
>>        * for SDIO cards if we need SDIO interrupts to work.
>>        */
>> -     if (mmc->caps & MMC_CAP_SDIO_IRQ) {
>> -             const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
>> -             u32 clk_en_a_old;
>> -             u32 clk_en_a;
>> +     const u32 clken_low_pwr = SDMMC_CLKEN_LOW_PWR << slot->id;
>> +     u32 clk_en_a_old;
>> +     u32 clk_en_a;
>>
>> -             clk_en_a_old = mci_readl(host, CLKENA);
>> +     clk_en_a_old = mci_readl(host, CLKENA);
>>
>> -             if (card->type == MMC_TYPE_SDIO ||
>> -                 card->type == MMC_TYPE_SD_COMBO) {
>> -                     set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>> -                     clk_en_a = clk_en_a_old & ~clken_low_pwr;
>> -             } else {
>> -                     clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>> -                     clk_en_a = clk_en_a_old | clken_low_pwr;
>> -             }
>> +     if (card->quirks & MMC_QUIRK_BROKEN_CLK_GATING) {
>> +             set_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>> +             clk_en_a = clk_en_a_old & ~clken_low_pwr;
>> +     } else {
>> +             clear_bit(DW_MMC_CARD_NO_LOW_PWR, &slot->flags);
>> +             clk_en_a = clk_en_a_old | clken_low_pwr;
>> +     }
>>
>> -             if (clk_en_a != clk_en_a_old) {
>> -                     mci_writel(host, CLKENA, clk_en_a);
>> -                     mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>> -                                  SDMMC_CMD_PRV_DAT_WAIT, 0);
>> -             }
>> +     if (clk_en_a != clk_en_a_old) {
>> +             mci_writel(host, CLKENA, clk_en_a);
>> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>> +                             SDMMC_CMD_PRV_DAT_WAIT, 0);
>>       }
>>  }
>>
>>
>
