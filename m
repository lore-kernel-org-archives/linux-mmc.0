From: Yuvaraj Kumar <yuvaraj.cd@gmail.com>
Subject: Re: [RFC V3 4/4] mmc: dw_mmc: exynos: configure SMU in exynos5420.
Date: Thu, 29 Aug 2013 15:40:42 +0530
Message-ID: <CAKuRcO+Jt3vJ3hOE-NZOuXfyjhrjwKvh1gDdib0yePgtO6t9EA@mail.gmail.com>
References: <1377691731-7226-1-git-send-email-yuvaraj.cd@samsung.com>
	<1377691731-7226-5-git-send-email-yuvaraj.cd@samsung.com>
	<000901cea491$06b8a360$1429ea20$%jun@samsung.com>
	<CAGOxZ53iuTNtY5jWMBNfdcp05QSwdbSY+-A4G6zrjV2ae8BJ6A@mail.gmail.com>
	<000f01cea49c$596667e0$0c3337a0$%jun@samsung.com>
	<CAKuRcO+R4G9LXdXGJOXFNGB+XZeJwvnVq1U5wtCKRPmNN8DWPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAKuRcO+R4G9LXdXGJOXFNGB+XZeJwvnVq1U5wtCKRPmNN8DWPA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Girish K S <ks.giri@samsung.com>, Tomasz Figa <t.figa@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 29, 2013 at 3:34 PM, Yuvaraj Kumar <yuvaraj.cd@gmail.com> wrote:
> On Thu, Aug 29, 2013 at 3:14 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> On Thu, August 29, 2013, Alim Akhtar wrote:
>>> Hi Seungwon,
>>>
>>> On Thu, Aug 29, 2013 at 1:53 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>>> > On Wed, August 28, 2013, Yuvaraj Kumar C D wrote:
>>> >> Exynos5420 Mobile Storage Host controller has Security Management Unit
>>> >> (SMU) for channel 0 and channel 1 (mainly for eMMC).This patch configures
>>> >> SMU for exynos5420.
>>> >>
>>> >> This patch is on top of the below patch by Doug Anderson.
>>> >> mmc: dw_mmc: Add exynos resume_noirq callback to clear WAKEUP_INT
>>> >>
>>> >> changes since V2:
>>> >>       1.Droppped the bypass-smu quirk.
>>> >>       2.Changed the subject line for this patch
>>> >>         add a quirk for SMU -> configure SMU in exynos5420
>>> >>
>>> >> changes since V1:
>>> >>       1.avoid code duplication by calling dw_mci_exynos_priv_init in
>>> >>         resume path.
>>> >>
>>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>>> >> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
>>> >> ---
>>> >>  drivers/mmc/host/dw_mmc-exynos.c |   29 +++++++++++++++++++++++++++++
>>> >>  1 file changed, 29 insertions(+)
>>> >>
>>> >> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
>>> >> index 19c845b..db28f10 100644
>>> >> --- a/drivers/mmc/host/dw_mmc-exynos.c
>>> >> +++ b/drivers/mmc/host/dw_mmc-exynos.c
>>> >> @@ -35,6 +35,25 @@
>>> >>  #define EXYNOS4210_FIXED_CIU_CLK_DIV 2
>>> >>  #define EXYNOS4412_FIXED_CIU_CLK_DIV 4
>>> >>
>>> >> +/* Block number in eMMC */
>>> >> +#define DWMCI_BLOCK_NUM                      0xFFFFFFFF
>>> >> +
>>> >> +#define SDMMC_EMMCP_BASE             0x1000
>>> >> +#define SDMMC_MPSECURITY             (SDMMC_EMMCP_BASE + 0x0010)
>>> >> +#define SDMMC_MPSBEGIN0                      (SDMMC_EMMCP_BASE + 0x0200)
>>> >> +#define SDMMC_MPSEND0                        (SDMMC_EMMCP_BASE + 0x0204)
>>> >> +#define SDMMC_MPSCTRL0                       (SDMMC_EMMCP_BASE + 0x020C)
>>> >> +
>>> >> +/* SMU control bits */
>>> >> +#define DWMCI_MPSCTRL_SECURE_READ_BIT                BIT(7)
>>> >> +#define DWMCI_MPSCTRL_SECURE_WRITE_BIT               BIT(6)
>>> >> +#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT    BIT(5)
>>> >> +#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT   BIT(4)
>>> >> +#define DWMCI_MPSCTRL_USE_FUSE_KEY           BIT(3)
>>> >> +#define DWMCI_MPSCTRL_ECB_MODE                       BIT(2)
>>> >> +#define DWMCI_MPSCTRL_ENCRYPTION             BIT(1)
>>> >> +#define DWMCI_MPSCTRL_VALID                  BIT(0)
>>> >> +
>>> >>  /* Variations in Exynos specific dw-mshc controller */
>>> >>  enum dw_mci_exynos_type {
>>> >>       DW_MCI_TYPE_EXYNOS4210,
>>> >> @@ -74,6 +93,15 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
>>> >>  {
>>> >>       struct dw_mci_exynos_priv_data *priv = host->priv;
>>> >>
>>> >> +     if (priv->ctrl_type == DW_MCI_TYPE_EXYNOS5420) {
>>> >> +             mci_writel(host, MPSBEGIN0, 0);
>>> >> +             mci_writel(host, MPSEND0, DWMCI_BLOCK_NUM);
>>> >> +             mci_writel(host, MPSCTRL0, DWMCI_MPSCTRL_SECURE_WRITE_BIT |
>>> >> +                     DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
>>> >> +                     DWMCI_MPSCTRL_VALID |
>>> >> +                     DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT);
>>> > Yuvaraj,
>>> >
>>> > Just one thing to check.
>>> > ch#0 and #1 of three hosts are only valid for SMU control.
>>> > Did you consider #2 host?
>>> > It seems not.
>>> >
>>>
>>> Only host#0 and host#1 has SMU (On exynos5420).
>>> Host #2 does not contain SMU.
>> Let me clear it.
>> I mean that current change allows for ch2 to access registers related to SMU,
>> even though ch2 doesn't actually has SMU. It's not valid IO area.
> No,host#0 and host#1 are compatible with "samsung,exynos5420-dw-mshc"
> but host#2 is compatible with the "samsung,exynos5250-dw-mshc".
 Below is the DT patch posted in another thread.(Sorry,earlier link
was bit older).
[PATCH V5] ARM: dts: Add dwmmc DT nodes for exynos5420 SOC
http://www.mail-archive.com/linux-samsung-soc@vger.kernel.org/msg22074.html
I will resubmit the DT patch[1] with reg = <0x12220000 0x1000> for host#2.
>
>>
>> Thanks,
>> Seungwon Jeon
>>
