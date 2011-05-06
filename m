From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 11/15] mmc: sdhci: add support for retuning mode 1
Date: Fri, 6 May 2011 06:40:51 -0400
Message-ID: <BANLkTi=sZZxhDY603Rx_219WZxCU+bJqLg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-12-git-send-email-arindam.nath@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61120 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab1EFKkv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 May 2011 06:40:51 -0400
Received: by mail-vx0-f174.google.com with SMTP id 39so3291153vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 06 May 2011 03:40:51 -0700 (PDT)
In-Reply-To: <1304578151-1775-12-git-send-email-arindam.nath@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arindam Nath <arindam.nath@amd.com>
Cc: cjb@laptop.org, prakity@marvell.com, subhashj@codeaurora.org, linux-mmc@vger.kernel.org, henry.su@amd.com, aaron.lu@amd.com, anath.amd@gmail.com

On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> wro=
te:
> Host Controller v3.00 can support retuning modes 1,2 or 3 depending o=
n
> the bits 46-47 of the Capabilities register. Also, the timer count fo=
r
> retuning is indicated by bits 40-43 of the same register. We initiali=
ze
> timer_list for retuning the first time we execute tuning procedure. T=
his
> condition is indicated by SDHCI_NEEDS_RETUNING not being set. Since
> retuning mode 1 sets a limit of 4MB on the maximum data length, we se=
t
> max_blk_count appropriately. Once the tuning timer expires, we set
> SDHCI_NEEDS_RETUNING flag, and if the flag is set, we execute tuning
> procedure before sending the next command. We need to restore mmc_req=
uest
> structure after executing retuning procedure since host->mrq is used
> inside the procedure to send CMD19. We also disable and re-enable thi=
s
> flag during suspend and resume respectively, as per the spec v3.00.
>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> Tested-by: Philip Rakity <prakity@marvell.com>

Acked-by: Zhangfei Gao<zhangfei.gao@marvell.com>
Verified with Toshiba uhs card and general hs card,   on mmp2 in SDMA m=
ode.
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0113 +++++++++++++++++++++++++++++=
+++++++++++++++-
> =A0drivers/mmc/host/sdhci.h =A0| =A0 =A06 ++-
> =A0include/linux/mmc/sdhci.h | =A0 =A06 ++
> =A03 files changed, 122 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 8ed2e1b..3c04547 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -46,6 +46,8 @@ static void sdhci_finish_data(struct sdhci_host *);
>
> =A0static void sdhci_send_command(struct sdhci_host *, struct mmc_com=
mand *);
> =A0static void sdhci_finish_command(struct sdhci_host *);
> +static int sdhci_execute_tuning(struct mmc_host *mmc);
> +static void sdhci_tuning_timer(unsigned long data);
>
> =A0static void sdhci_dumpregs(struct sdhci_host *host)
> =A0{
> @@ -1206,8 +1208,28 @@ static void sdhci_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
> =A0 =A0 =A0 =A0if (!present || host->flags & SDHCI_DEVICE_DEAD) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mrq->cmd->error =3D -ENOMEDIUM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&host->finish_tasklet=
);
> - =A0 =A0 =A0 } else
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 present_state;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 present_state =3D sdhci_readl(host, SDH=
CI_PRESENT_STATE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Check if the re-tuning timer has a=
lready expired and there
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* is no on-going data transfer. If s=
o, we need to execute
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* tuning procedure before sending co=
mmand.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_NEEDS_RETUNING=
) &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_state & (SDHCI_DOING_=
WRITE |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_DOING_READ))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(=
&host->lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tuning(mm=
c);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host=
->lock, flags);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore original mmc=
_request structure */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mrq =3D mrq;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_send_command(host, mrq->cmd);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0mmiowb();
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> @@ -1679,6 +1701,37 @@ static int sdhci_execute_tuning(struct mmc_hos=
t *mmc)
> =A0 =A0 =A0 =A0}
>
> =A0out:
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* If this is the very first time we are here, we sta=
rt the retuning
> + =A0 =A0 =A0 =A0* timer. Since only during the first time, SDHCI_NEE=
DS_RETUNING
> + =A0 =A0 =A0 =A0* flag won't be set, we check this condition before =
actually starting
> + =A0 =A0 =A0 =A0* the timer.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (!(host->flags & SDHCI_NEEDS_RETUNING) && host->tuni=
ng_count &&
> + =A0 =A0 =A0 =A0 =A0 (host->tuning_mode =3D=3D SDHCI_TUNING_MODE_1))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&host->tuning_timer, jiffies =
+ host->tuning_count *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HZ);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Tuning mode 1 limits the maximum dat=
a length to 4MB */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D (4 * 1024 * 1024=
) / mmc->max_blk_size;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_NEEDS_RETUNING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Reload the new initial value for tim=
er */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->tuning_mode =3D=3D SDHCI_TUNI=
NG_MODE_1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&host->tuning=
_timer, jiffies +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->t=
uning_count * HZ);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case tuning fails, host controllers which suppo=
rt re-tuning can
> + =A0 =A0 =A0 =A0* try tuning again at a later time, when the re-tuni=
ng timer expires.
> + =A0 =A0 =A0 =A0* So for these controllers, we return 0. Since there=
 might be other
> + =A0 =A0 =A0 =A0* controllers who do not have this capability, we re=
turn error for
> + =A0 =A0 =A0 =A0* them.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (err && host->tuning_count &&
> + =A0 =A0 =A0 =A0 =A0 (host->tuning_mode =3D=3D SDHCI_TUNING_MODE_1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> +
> =A0 =A0 =A0 =A0sdhci_clear_set_irqs(host, SDHCI_INT_DATA_AVAIL, ier);
> =A0 =A0 =A0 =A0spin_unlock(&host->lock);
> =A0 =A0 =A0 =A0enable_irq(host->irq);
> @@ -1781,6 +1834,10 @@ static void sdhci_tasklet_finish(unsigned long=
 param)
>
> =A0 =A0 =A0 =A0del_timer(&host->timer);
>
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer(&host->tuning_timer);
> +
> +
> =A0 =A0 =A0 =A0mrq =3D host->mrq;
>
> =A0 =A0 =A0 =A0/*
> @@ -1854,6 +1911,20 @@ static void sdhci_timeout_timer(unsigned long =
data)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
> =A0}
>
> +static void sdhci_tuning_timer(unsigned long data)
> +{
> + =A0 =A0 =A0 struct sdhci_host *host;
> + =A0 =A0 =A0 unsigned long flags;
> +
> + =A0 =A0 =A0 host =3D (struct sdhci_host *)data;
> +
> + =A0 =A0 =A0 spin_lock_irqsave(&host->lock, flags);
> +
> + =A0 =A0 =A0 host->flags |=3D SDHCI_NEEDS_RETUNING;
> +
> + =A0 =A0 =A0 spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> =A0/*****************************************************************=
************\
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 *
> =A0* Interrupt handling =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> @@ -2128,6 +2199,15 @@ int sdhci_suspend_host(struct sdhci_host *host=
, pm_message_t state)
>
> =A0 =A0 =A0 =A0sdhci_disable_card_detection(host);
>
> + =A0 =A0 =A0 /* Disable tuning since we are suspending */
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_300) &&
> + =A0 =A0 =A0 =A0 =A0 host->tuning_count &&
> + =A0 =A0 =A0 =A0 =A0 (host->tuning_mode =3D=3D SDHCI_TUNING_MODE_1))=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags &=3D ~SDHCI_NEEDS_RETUNING;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mod_timer(&host->tuning_timer, jiffies =
+
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_count * HZ=
);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -2169,6 +2249,12 @@ int sdhci_resume_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0ret =3D mmc_resume_host(host->mmc);
> =A0 =A0 =A0 =A0sdhci_enable_card_detection(host);
>
> + =A0 =A0 =A0 /* Set the re-tuning expiration flag */
> + =A0 =A0 =A0 if ((host->version >=3D SDHCI_SPEC_300) &&
> + =A0 =A0 =A0 =A0 =A0 host->tuning_count &&
> + =A0 =A0 =A0 =A0 =A0 (host->tuning_mode =3D=3D SDHCI_TUNING_MODE_1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_NEEDS_RETUNING;
> +
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> @@ -2420,6 +2506,21 @@ int sdhci_add_host(struct sdhci_host *host)
> =A0 =A0 =A0 =A0if (caps[1] & SDHCI_DRIVER_TYPE_D)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_DRIVER_TYPE_D;
>
> + =A0 =A0 =A0 /* Initial value for re-tuning timer count */
> + =A0 =A0 =A0 host->tuning_count =3D (caps[1] & SDHCI_RETUNING_TIMER_=
COUNT_MASK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SDHCI_RETUN=
ING_TIMER_COUNT_SHIFT;
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* In case Re-tuning Timer is not disabled, the actua=
l value of
> + =A0 =A0 =A0 =A0* re-tuning timer will be 2 ^ (n - 1).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->tuning_count)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_count =3D 1 << (host->tuni=
ng_count - 1);
> +
> + =A0 =A0 =A0 /* Re-tuning mode supported by the Host Controller */
> + =A0 =A0 =A0 host->tuning_mode =3D (caps[1] & SDHCI_RETUNING_MODE_MA=
SK) >>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_RETUNI=
NG_MODE_SHIFT;
> +
> =A0 =A0 =A0 =A0ocr_avail =3D 0;
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * According to SD Host Controller spec v3.00, if the =
Host System
> @@ -2565,9 +2666,15 @@ int sdhci_add_host(struct sdhci_host *host)
>
> =A0 =A0 =A0 =A0setup_timer(&host->timer, sdhci_timeout_timer, (unsign=
ed long)host);
>
> - =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0init_waitqueue_head(&host->buf_ready_i=
nt);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Initialize re-tuning timer */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 init_timer(&host->tuning_timer);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_timer.data =3D (unsigned l=
ong)host;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_timer.function =3D sdhci_t=
uning_timer;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0ret =3D request_irq(host->irq, sdhci_irq, IRQF_SHARED,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(mmc), host);
> =A0 =A0 =A0 =A0if (ret)
> @@ -2661,6 +2768,8 @@ void sdhci_remove_host(struct sdhci_host *host,=
 int dead)
> =A0 =A0 =A0 =A0free_irq(host->irq, host);
>
> =A0 =A0 =A0 =A0del_timer_sync(&host->timer);
> + =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 del_timer_sync(&host->tuning_timer);
>
> =A0 =A0 =A0 =A0tasklet_kill(&host->card_tasklet);
> =A0 =A0 =A0 =A0tasklet_kill(&host->finish_tasklet);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0208164..fb74dc6 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -191,7 +191,11 @@
> =A0#define =A0SDHCI_DRIVER_TYPE_A =A0 0x00000010
> =A0#define =A0SDHCI_DRIVER_TYPE_C =A0 0x00000020
> =A0#define =A0SDHCI_DRIVER_TYPE_D =A0 0x00000040
> -#define =A0SDHCI_USE_SDR50_TUNING =A0 =A0 =A0 =A00x00002000
> +#define =A0SDHCI_RETUNING_TIMER_COUNT_MASK =A0 =A0 =A0 0x00000F00
> +#define =A0SDHCI_RETUNING_TIMER_COUNT_SHIFT =A0 =A0 =A08
> +#define =A0SDHCI_USE_SDR50_TUNING =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x00002000
> +#define =A0SDHCI_RETUNING_MODE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A00x000=
0C000
> +#define =A0SDHCI_RETUNING_MODE_SHIFT =A0 =A0 =A0 =A0 =A0 =A0 14
> =A0#define =A0SDHCI_CLOCK_MUL_MASK =A00x00FF0000
> =A0#define =A0SDHCI_CLOCK_MUL_SHIFT 16
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index a88a799..e902618 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -112,6 +112,7 @@ struct sdhci_host {
> =A0#define SDHCI_REQ_USE_DMA =A0 =A0 =A0(1<<2) =A0/* Use DMA for this=
 req. */
> =A0#define SDHCI_DEVICE_DEAD =A0 =A0 =A0(1<<3) =A0/* Device unrespons=
ive */
> =A0#define SDHCI_SDR50_NEEDS_TUNING (1<<4) =A0 =A0 =A0 =A0/* SDR50 ne=
eds tuning */
> +#define SDHCI_NEEDS_RETUNING =A0 (1<<5) =A0/* Host needs retuning */
>
> =A0 =A0 =A0 =A0unsigned int version; =A0 /* SDHCI spec. version */
>
> @@ -152,6 +153,11 @@ struct sdhci_host {
> =A0 =A0 =A0 =A0wait_queue_head_t =A0 =A0 =A0 buf_ready_int; =A0/* Wai=
tqueue for Buffer Read Ready interrupt */
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0tuning_done; =A0 =A0=
/* Condition flag set when CMD19 succeeds */
>
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tuning_count; =A0 /=
* Timer count for re-tuning */
> + =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0 =A0 =A0tuning_mode; =A0 =A0=
/* Re-tuning mode supported by host */
> +#define SDHCI_TUNING_MODE_1 =A0 =A00
> + =A0 =A0 =A0 struct timer_list =A0 =A0 =A0 tuning_timer; =A0 /* Time=
r for tuning */
> +
> =A0 =A0 =A0 =A0unsigned long private[0] ____cacheline_aligned;
> =A0};
> =A0#endif /* __SDHCI_H */
> --
> 1.7.1
>
>
