From: Roger Tseng <rogerable@realtek.com>
Subject: Re: [PATCH] mmc: rtsx: add card power off during probe
Date: Thu, 18 Sep 2014 07:19:47 +0000
Message-ID: <1411024883.27455.11.camel@debian-rtk5880>
References: <1410485999-10939-1-git-send-email-micky_ching@realsil.com.cn>
 <CAPDyKFqcbK9OuQXbegignwiS7rz3L8resQ7Jfc8WvqXEKTcWVA@mail.gmail.com>
 <54195036.2010409@realsil.com.cn>
 <CAPDyKFrbMaDxU3VkhMO63+tLRMipKPqGvYC5cT2PTeVU1CTTQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFrbMaDxU3VkhMO63+tLRMipKPqGvYC5cT2PTeVU1CTTQg@mail.gmail.com>
Content-Language: zh-TW
Content-ID: <95890B71182D7543B66998E6F2AB86B3@realtek.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei_wang <wei_wang@realsil.com.cn>, "driverdev-devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 2014-09-17 at 21:29 +0200, Ulf Hansson wrote:
> On 17 September 2014 11:11, micky <micky_ching@realsil.com.cn> wrote:
> > On 09/17/2014 02:01 AM, Ulf Hansson wrote:
> >>
> >> On 12 September 2014 03:39,  <micky_ching@realsil.com.cn> wrote:
> >>>
> >>> From: Roger Tseng <rogerable@realtek.com>
> >>>
> >>> Some platform have both UEFI driver and MFD/mmc driver, if entering
> >>> linux while card in the slot, the card power is already on, and rtsx-mmc
> >>> driver have no chance to make card power off. This will lead UHSI card
> >>> failed to enter UHSI mode.
> >>>
> >>> It is hard to control the UEFI driver leaving state, so we power off the
> >>> card power during probe.
> >>>
> >>> Signed-off-by: Roger Tseng <rogerable@realtek.com>
> >>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
> >>> ---
> >>>   drivers/mmc/host/rtsx_pci_sdmmc.c |    7 ++++++-
> >>>   1 file changed, 6 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
> >>> b/drivers/mmc/host/rtsx_pci_sdmmc.c
> >>> index dfde4a2..57b0796 100644
> >>> --- a/drivers/mmc/host/rtsx_pci_sdmmc.c
> >>> +++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
> >>> @@ -1341,8 +1341,13 @@ static int rtsx_pci_sdmmc_drv_probe(struct
> >>> platform_device *pdev)
> >>>          host->pcr = pcr;
> >>>          host->mmc = mmc;
> >>>          host->pdev = pdev;
> >>> -       host->power_state = SDMMC_POWER_OFF;
> >>>          INIT_WORK(&host->work, sd_request);
> >>> +       sd_power_off(host);
> >>> +       /*
> >>> +        * ref: SD spec 3.01: 6.4.1.2 Power On or Power Cycle
> >>> +        */
> >>> +       usleep_range(1000, 2000);
> >>> +
> >>
> >> This won't work in cases were you power off eMMC cards, unless you can
> >> do a full power cycle - cut both VCC and VCCQ. Can you?
> >
> > Hi Uffe,
> >
> > VCCQ will poweroff at the same time.
> 
> In that case, don't forget to enable MMC_CAP2_FULL_PWR_CYCLE.
> 
> >
> > if MMC_CAP2_NO_PRESCAN_POWERUP enable, will call mmc_power_off() at start,
> > then it will check ios.power_mode, but the state is MMC_POWER_OFF and just
> > return.
> 
> Uhh, that's right! So, I wonder why we invokes mmc_power_off() from
> that path at all.
> 
> Hmm, I think we should change the behavior in mmc_start_host(), like below:
> 1) Add a "MMC_POWER_UNDEFINED" state which is what the power state
> should be assigned to at allocation.
> 2 ) From mmc_start_host(), invoke mmc_power_off() when
> MMC_CAP2_NO_PRESCAN_POWERUP and MMC_CAP2_FULL_PWR_CYCLE is set.
> 
> Would that work?
Yes. I have confirmed this by following changes. The MMC_POWER_UNDEFINED
designation in mmc_start_host() will eventually cause a power-off
operation.

But I wonder if we need to additionally check MMC_CAP2_FULL_PWR_CYCLE
before calling mmc_power_off()?

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d03a080fb9cd..3457b0f74b71 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2489,7 +2489,9 @@ void mmc_start_host(struct mmc_host *host)
 {
        host->f_init = max(freqs[0], host->f_min);
        host->rescan_disable = 0;
-       if (host->caps2 & MMC_CAP2_NO_PRESCAN_POWERUP)
+       host->ios.power_mode = MMC_POWER_UNDEFINED;
+       if (host->caps2 & (MMC_CAP2_NO_PRESCAN_POWERUP |
+           MMC_CAP2_FULL_PWR_CYCLE))
                mmc_power_off(host);
        else
                mmc_power_up(host, host->ocr_avail);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c
b/drivers/mmc/host/rtsx_pci_sdmmc.c
index dfde4a210238..d49460b5ff07 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1292,6 +1292,7 @@ static void realtek_init_host(struct
realtek_pci_sdmmc *host)
        mmc->caps = MMC_CAP_4_BIT_DATA | MMC_CAP_SD_HIGHSPEED |
                MMC_CAP_MMC_HIGHSPEED | MMC_CAP_BUS_WIDTH_TEST |
                MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
+       mmc->caps2 = MMC_CAP2_NO_PRESCAN_POWERUP |
MMC_CAP2_FULL_PWR_CYCLE;
        mmc->max_current_330 = 400;
        mmc->max_current_180 = 800;
        mmc->ops = &realtek_pci_sdmmc_ops;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 7960424d0bc0..b3bfa609816a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -42,6 +42,7 @@ struct mmc_ios {
 #define MMC_POWER_OFF          0
 #define MMC_POWER_UP           1
 #define MMC_POWER_ON           2
+#define MMC_POWER_UNDEFINED    3
 
        unsigned char   bus_width;              /* data bus width */

> Kind regards
> Uffe
> 
> > Best Regards.
> > micky.
> >
> >> There are also another option you might want to use,
> >> MMC_CAP2_NO_PRESCAN_POWERUP. But again, it must only be used for those
> >> hosts that you are able to do a full power cycle for.
> >>
> >> Kind regards
> >> Uffe
> >>
> >>>          platform_set_drvdata(pdev, host);
> >>>          pcr->slots[RTSX_SD_CARD].p_dev = pdev;
> >>>          pcr->slots[RTSX_SD_CARD].card_event = rtsx_pci_sdmmc_card_event;
> >>> --
> >>> 1.7.9.5
> >>>
> >> .
> >>
> >
> 
> ------Please consider the environment before printing this e-mail.

-- 
Best regards,
Roger Tseng
