From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 2/2] mmc: dw_mmc: add a quirk for Security Management Unit
Date: Fri, 28 Jun 2013 11:15:58 +0900
Message-ID: <001601ce73a5$6db91fd0$492b5f70$%jun@samsung.com>
References: <1369389873-15018-1-git-send-email-yuvaraj.cd@samsung.com>
 <1369389873-15018-3-git-send-email-yuvaraj.cd@samsung.com>
 <001101ce708b$170bd6e0$452384a0$%jun@samsung.com>
 <CAKuRcO+fy9=TCx2mJmX4=v_kw6B=cj+58F99yRhEBnZjjwK4Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45279 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753743Ab3F1CQB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Jun 2013 22:16:01 -0400
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MP200BFHZLQD4G0@mailout3.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Jun 2013 11:15:59 +0900 (KST)
In-reply-to: <CAKuRcO+fy9=TCx2mJmX4=v_kw6B=cj+58F99yRhEBnZjjwK4Ug@mail.gmail.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Yuvaraj Kumar' <yuvaraj.cd@gmail.com>
Cc: 'linux-mmc' <linux-mmc@vger.kernel.org>

On Thur, June 27, 2013, Yuvaraj Kumar wrote:
> On Mon, Jun 24, 2013 at 8:59 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> > On Fri, May 24 2013, Yuvaraj Kumar C D wrote:
> >> Exynos5420 Mobile Storage Host controller has a Security Management Unit
> >> (SMU) for channel 0 and channel 1 (mainly for eMMC). This patch adds a
> >> quirk to bypass SMU as it is not being used yet.
> >>
> >> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> >> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
> >> ---
> >>  .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |    2 ++
> >>  drivers/mmc/host/dw_mmc-exynos.c                   |   35 ++++++++++++++++++++
> >>  drivers/mmc/host/dw_mmc.c                          |   10 ++++++
> >>  drivers/mmc/host/dw_mmc.h                          |    2 ++
> >>  include/linux/mmc/dw_mmc.h                         |    2 ++
> >>  5 files changed, 51 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> >> b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> >> index 726fd21..e2f33b5 100644
> >> --- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> >> +++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> >> @@ -55,6 +55,8 @@ Optional properties:
> >>
> >>  * broken-cd: as documented in mmc core bindings.
> >>
> >> +* bypass-smu: Bypass Security Management Unit of eMMC channel 0 and channel 1
> >> +
> >>  Aliases:
> >>
> >>  - All the MSHC controller nodes should be represented in the aliases node using
> >> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> >> index f883b17..b2332c8 100644
> >> --- a/drivers/mmc/host/dw_mmc-exynos.c
> >> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> >> @@ -33,6 +33,25 @@
> >>
> >>  #define SDMMC_CMD_USE_HOLD_REG               BIT(29)
> >>
> >> +/* Block number in eMMC */
> >> +#define DWMCI_BLOCK_NUM                      0xFFFFFFFF
> >> +
> >> +#define DWMCI_EMMCP_BASE             0x1000
> >> +#define DWMCI_MPSECURITY             (DWMCI_EMMCP_BASE + 0x0010)
> >> +#define DWMCI_MPSBEGIN0                      (DWMCI_EMMCP_BASE + 0x0200)
> >> +#define DWMCI_MPSEND0                        (DWMCI_EMMCP_BASE + 0x0204)
> >> +#define DWMCI_MPSCTRL0                       (DWMCI_EMMCP_BASE + 0x020C)
> >> +
> >> +/* SMU control bits */
> >> +#define DWMCI_MPSCTRL_SECURE_READ_BIT                BIT(7)
> >> +#define DWMCI_MPSCTRL_SECURE_WRITE_BIT               BIT(6)
> >> +#define DWMCI_MPSCTRL_NON_SECURE_READ_BIT    BIT(5)
> >> +#define DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT   BIT(4)
> >> +#define DWMCI_MPSCTRL_USE_FUSE_KEY           BIT(3)
> >> +#define DWMCI_MPSCTRL_ECB_MODE                       BIT(2)
> >> +#define DWMCI_MPSCTRL_ENCRYPTION             BIT(1)
> >> +#define DWMCI_MPSCTRL_VALID                  BIT(0)
> >> +
> >>  #define EXYNOS4210_FIXED_CIU_CLK_DIV 2
> >>  #define EXYNOS4412_FIXED_CIU_CLK_DIV 4
> >>
> >> @@ -92,6 +111,21 @@ static int dw_mci_exynos_priv_init(struct dw_mci *host)
> >>       return 0;
> >>  }
> >>
> >> +/*
> >> + * By-pass Security Management Unit
> >> + */
> >> +void dw_mci_exynos_cfg_smu(struct dw_mci *host)
> > It would be better to rename the function name involving a meaning of bypass.
> >
> >> +{
> >> +     /* Set the start and end region to configure */
> >> +     __raw_writel(0, host->regs + DWMCI_MPSBEGIN0);
> >> +     __raw_writel(DWMCI_BLOCK_NUM, host->regs + DWMCI_MPSEND0);
> >> +     __raw_writel(DWMCI_MPSCTRL_SECURE_READ_BIT |
> >> +             DWMCI_MPSCTRL_SECURE_WRITE_BIT |
> >> +             DWMCI_MPSCTRL_NON_SECURE_READ_BIT |
> >> +             DWMCI_MPSCTRL_NON_SECURE_WRITE_BIT |
> >> +             DWMCI_MPSCTRL_VALID, host->regs + DWMCI_MPSCTRL0);
> >> +}
> >> +
> >>  static int dw_mci_exynos_setup_clock(struct dw_mci *host)
> >>  {
> >>       struct dw_mci_exynos_priv_data *priv = host->priv;
> >> @@ -173,6 +207,7 @@ static const struct dw_mci_drv_data exynos_drv_data = {
> >>       .prepare_command        = dw_mci_exynos_prepare_command,
> >>       .set_ios                = dw_mci_exynos_set_ios,
> >>       .parse_dt               = dw_mci_exynos_parse_dt,
> >> +     .cfg_smu                = dw_mci_exynos_cfg_smu,
> > I think smu implementation is applicable to only for Exynos.
> > Synopsys controller doesn't have this feature.
> > So, adding to common structure is not a good introduction.
> > We can handle this feature in dw_mmc-exynos internally.
> Do you mean in any  one of dw_mci_drv_data member function?
> > Actually, it might be added in dw_mci_exynos_priv_data.
> if we add here, we need to refer to the function pointer from one of
> the  dw_mci_drv_data
> member function whose functionalities are different from bypass smu.
Yes, it might be.
Your guess may be probably right.
But currently, security functionality isn't common part on dw_mmc.
I think another helper function which can be common is needed for specific handling.
Other variant host controllers based on dw_mmc may have own register which should be set properly during probing.
Accordingly, for example, I guess 'post_init' function could be introduced for vendor specific setting.
Then, your implementation will be included there.
I hope that it helps your intention.

> >
> > Thanks,
> > Seungwon Jeon
> >
> >>  };
> >>
> >>  static const struct of_device_id dw_mci_exynos_match[] = {
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index bc3a1bc..a047ecf 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -1959,6 +1959,9 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
> >>               mmc->caps |= MMC_CAP_4_BIT_DATA;
> >>       }
> >>
> >> +     if (host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU)
> >> +             drv_data->cfg_smu(host);
> >> +
> >>       if (host->pdata->quirks & DW_MCI_QUIRK_HIGHSPEED)
> >>               mmc->caps |= MMC_CAP_SD_HIGHSPEED | MMC_CAP_MMC_HIGHSPEED;
> >>
> >> @@ -2114,6 +2117,9 @@ static struct dw_mci_of_quirks {
> >>       }, {
> >>               .quirk  = "broken-cd",
> >>               .id     = DW_MCI_QUIRK_BROKEN_CARD_DETECTION,
> >> +     }, {
> >> +             .quirk  = "bypass-smu",
> >> +             .id     = DW_MCI_QUIRK_BYPASS_SMU,
> >>       },
> >>  };
> >>
> >> @@ -2460,6 +2466,7 @@ EXPORT_SYMBOL(dw_mci_suspend);
> >>
> >>  int dw_mci_resume(struct dw_mci *host)
> >>  {
> >> +     const struct dw_mci_drv_data *drv_data = host->drv_data;
> >>       int i, ret;
> >>
> >>       if (host->vmmc) {
> >> @@ -2479,6 +2486,9 @@ int dw_mci_resume(struct dw_mci *host)
> >>       if (host->use_dma && host->dma_ops->init)
> >>               host->dma_ops->init(host);
> >>
> >> +     if (host->pdata->quirks & DW_MCI_QUIRK_BYPASS_SMU)
> >> +             drv_data->cfg_smu(host);
> >> +
> >>       /* Restore the old value at FIFOTH register */
> >>       mci_writel(host, FIFOTH, host->fifoth_val);
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> >> index 0b74189..67059e3 100644
> >> --- a/drivers/mmc/host/dw_mmc.h
> >> +++ b/drivers/mmc/host/dw_mmc.h
> >> @@ -190,6 +190,7 @@ extern int dw_mci_resume(struct dw_mci *host);
> >>   * @prepare_command: handle CMD register extensions.
> >>   * @set_ios: handle bus specific extensions.
> >>   * @parse_dt: parse implementation specific device tree properties.
> >> + * @cfg_smu: to configure security management unit
> >>   *
> >>   * Provide controller implementation specific extensions. The usage of this
> >>   * data structure is fully optional and usage of each member in this structure
> >> @@ -202,5 +203,6 @@ struct dw_mci_drv_data {
> >>       void            (*prepare_command)(struct dw_mci *host, u32 *cmdr);
> >>       void            (*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
> >>       int             (*parse_dt)(struct dw_mci *host);
> >> +     void            (*cfg_smu)(struct dw_mci *host);
> >>  };
> >>  #endif /* _DW_MMC_H_ */
> >> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> >> index 198f0fa..1415ac9 100644
> >> --- a/include/linux/mmc/dw_mmc.h
> >> +++ b/include/linux/mmc/dw_mmc.h
> >> @@ -209,6 +209,8 @@ struct dw_mci_dma_ops {
> >>  #define DW_MCI_QUIRK_HIGHSPEED                       BIT(2)
> >>  /* Unreliable card detection */
> >>  #define DW_MCI_QUIRK_BROKEN_CARD_DETECTION   BIT(3)
> >> +/* Bypass the security management unit */
> >> +#define DW_MCI_QUIRK_BYPASS_SMU                      BIT(4)
> >>
> >>  /* Slot level quirks */
> >>  /* This slot has no write protect */
> >> --
> >> 1.7.9.5
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

