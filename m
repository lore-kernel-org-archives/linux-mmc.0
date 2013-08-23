From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [RFC V2 4/4] mmc: dw_mmc: exynos: add a quirk for SMU.
Date: Fri, 23 Aug 2013 18:44:09 +0530
Message-ID: <CAKuRcOL6snChU-vgXJNYrpsKU+5NzpYrdh2n=0WGTvwKhsFCbg@mail.gmail.com>
References: <1377256509-18922-1-git-send-email-yuvaraj.cd@samsung.com>
	<1377256509-18922-5-git-send-email-yuvaraj.cd@samsung.com>
	<52175BB3.5020301@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:64370 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab3HWNOK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 09:14:10 -0400
In-Reply-To: <52175BB3.5020301@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-samsung-soc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Seungwon Jeon <tgih.jun@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, ks.giri@samsung.com, Tomasz Figa <t.figa@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>

Hi Jaehoon,

Yes,Its depend on the below patch.
mmc: dw_mmc: exynos: Add a new compatible string for exynos5420
http://permalink.gmane.org/gmane.linux.kernel.mmc/21060

Best Regards
Yuvaraj

On Fri, Aug 23, 2013 at 6:25 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi Yuvaraj,
>
> Is there dependency with other patch?
> I didn't see the defined "DW_MCI_TYPE_EXYNOS5420".
> If i missed something, let me know.
>
> Best Regards,
> Jaehoon Chung
>
> On 08/23/2013 08:15 PM, Yuvaraj Kumar C D wrote:
>> Exynos5420 Mobile Storage Host controller has Security Management Unit
>> (SMU) for channel 0 and channel 1 (mainly for eMMC).This patch adds a
>> quirk to bypass SMU as it is not being used yet.
>>
>> This patch is on top of the below patch by Doug Anderson.
>> mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
>>
>> changes since V1:
>>       1.avoid code duplication by calling dw_mci_exynos_priv_init in
>>         resume path.
>>
>> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>> ---
>>  drivers/mmc/host/dw_mmc-exynos.c |   33 +++++++++++++++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc.c        |    3 +++
>>  include/linux/mmc/dw_mmc.h       |    2 ++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>> index 19c845b..8e70fc6 100644
>> --- a/drivers/mmc/host/dw_mmc-exynos.c
>> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>> @@ -35,6 +35,25 @@
>>  #define EXYNOS4210_FIXED_CIU_CLK_DIV 2
>>  #define EXYNOS4412_FIXED_CIU_CLK_DIV 4
>>
>> +/* Block number in eMMC */
>> +#define DWMCI_BLOCK_NUM                      0xFFFFFFFF
>> +
>> +#define SDMMC_EMMCP_BASE             0x1000
>> +#define SDMMC_MPSECURITY             (SDMMC_EMMCP_BASE + 0x0010)
>> +#define SDMMC_MPSBEGIN0                      (SDMMC_EMMCP_BASE + 0x0200)
>> +#define SDMMC_MPSEND0                        (SDMMC_EMMCP_BASE + 0x0204)
>> +#define SDMMC_MPSCTRL0                       (SDMMC_EMMCP_BASE + 0x020C)
>> +
>> +/* SMU control bits */
>> +#define DWMCI_MPSCTRL_SECURE_READ_BIT                BIT(7)
>> +#define DWMCI_MPSCTRL_SECURE_WRITE_BIT               BIT(6)
>> +#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT    BIT(5)
>> +#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT   BIT(4)
>> +#define DWMCI_MPSCTRL_USE_FUSE_KEY           BIT(3)
>> +#define DWMCI_MPSCTRL_ECB_MODE                       BIT(2)
>> +#define DWMCI_MPSCTRL_ENCRYPTION             BIT(1)
>> +#define DWMCI_MPSCTRL_VALID                  BIT(0)
>> +
>>  /* Variations in Exynos specific dw-mshc controller */
>>  enum dw_mci_exynos_type {
>>       DW_MCI_TYPE_EXYNOS4210,
>> @@ -74,6 +93,16 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>>  {
>>       struct dw_mci_exynos_priv_data *priv = host->priv;
>>
>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 &&
>> +             host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU) {
>> +             mci_writel(host, MPSBEGIN0, 0);
>> +             mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
>> +             mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
>> +                     DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
>> +                     DWMCI_MPSCTRL_VALID |
>> +                     DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
>> +     }
>> +
>>       return 0;
>>  }
>>
>> @@ -106,7 +135,11 @@ static int dw_mci_exynos_suspend(struct device *dev)
>>  static int dw_mci_exynos_resume(struct device *dev)
>>  {
>>       struct dw_mci *host = dev_get_drvdata(dev);
>> +     struct dw_mci_exynos_priv_data *priv = host->priv;
>>
>> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420 &&
>> +             host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU)
>> +             dw_mci_exynos_priv_init(host);
>>       return dw_mci_resume(host);
>>  }
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0c0cada..49df69f 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2107,6 +2107,9 @@ static struct dw_mci_of_quirks {
>>       }, {
>>               .quirk  = "broken-cd",
>>               .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
>> +     }, {
>> +             .quirk  = "bypass-smu",
>> +             .id     = DW_MCI_QUIRK_BYPASS_SMU,
>>       },
>>  };
>>
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 198f0fa..2d3f83f 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -209,6 +209,8 @@ struct dw_mci_dma_ops {
>>  #define DW_MCI_QUIRK_HIGHSPEED                       BIT(2)
>>  /* Unreliable card detection */
>>  #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION   BIT(3)
>> +/*Bypass the Security management unit*/
>> +#define DW_MCI_QUIRK_BYPASS_SMU                      BIT(4)
>>
>>  /* Slot level quirks */
>>  /* This slot has no write protect */
>>
>
