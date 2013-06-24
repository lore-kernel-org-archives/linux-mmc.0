From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: don't queue up a card detect at slot startup
Date: Mon, 24 Jun 2013 17:04:25 +0900
Message-ID: <001401ce70b1$71c325e0$554971a0$%jun@samsung.com>
References: <1371772064-7505-1-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1371772064-7505-1-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Olof Johansson' <olof@lixom.net>, 'Andrew Bresticker' <abrestic@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Fri, June 21 2013, Doug Anderson wrote:
> The MMC subsystem handles looking for a card at probe time.  Queuing
> up our own can race with the rest of the MMC subsystem and cause
> problems if we get unlucky with timing.  Just remove our own
> detection.
This patch looks good to me. I agree above.
Card detection procedure of mmc subsystem will be started by mmc_start_host during probe time.
There is no need to do same in host driver.
Could you describe the race point of this problem and why the duplication makes the problem?
What is described below is not clear.
If a actual detection of card is triggered during probe, similar problem may be occurred in spite of this patch.

Thanks,
Seungwon Jeon
> 
> Specifically, I found that with just the right set of printouts in my
> system that one of the three SD/MMC devices in my system was having
> trouble probing.  It would get an err -123 (-ENOMEDIUM) during probe.
> I found that the source of the error was in
> dw_mci_work_routine_card().  Adding more printouts to the code
> sometimes made this error go away, so it's a little touchy.
> 
> You can see a snippet with my printouts in it (printouts were in
> set_ios() on an exynos5420 board with some of our local patches):
> 
> [    4.216595] dwmmc_exynos 12210000.dwmmc1: Using internal DMA controller.
> [    4.395935] dwmmc_exynos 12210000.dwmmc1: Version ID is 250a
> [    4.401948] dwmmc_exynos 12210000.dwmmc1: DW MMC controller at irq 108, 64 bit host data width, 64
> deep fifo
> [    4.424430] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
> [    4.453975] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
> [    4.459592] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 400000Hz, actual 400000HZ div
> = 125)
> [    4.484258] dwmmc_exynos 12210000.dwmmc1: 1 slots initialized
> [    4.485406] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
> [    4.487606] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
> [    4.489794] dwmmc_exynos 12210000.dwmmc1: sdr0 mode (irq=108, width=0)
> [    4.509757] mmc1: error -123 whilst initialising SDIO card
> 
> While digging I found that doing our own card detection at init time
> didn't appear to be necessary.  If I remove this code then cards that
> are in the system at bootup are still detected just fine.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index bc3a1bc..c3a6fe9 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2016,12 +2016,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>  	/* Card initially undetected */
>  	slot->last_detect_state = 0;
> 
> -	/*
> -	 * Card may have been plugged in prior to boot so we
> -	 * need to run the detect tasklet
> -	 */
> -	queue_work(host->card_workqueue, &host->card_work);
> -
>  	return 0;
> 
>  err_setup_bus:
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
