From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH V6 2/2] mmc: host: Adds support for eMMC 4.5 HS200 mode
Date: Tue, 20 Dec 2011 10:10:16 +0530
Message-ID: <CAGxe1ZF1RxdCxrnANriAaY9Fyba6o31xm-TFEmqek+QGpG3U4A@mail.gmail.com>
References: <1324276594-16412-1-git-send-email-girish.shivananjappa@linaro.org>
	<1324276594-16412-3-git-send-email-girish.shivananjappa@linaro.org>
	<808294D9-162C-4BC6-8581-54711A338BFD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:49021 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab1LTEkR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 23:40:17 -0500
In-Reply-To: <808294D9-162C-4BC6-8581-54711A338BFD@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 19 December 2011 22:24, Philip Rakity <prakity@marvell.com> wrote:
>
> HI,
>
> minor comments below.
>
> Philip
>
> On Dec 18, 2011, at 10:36 PM, Girish K S wrote:
>
>> This patch adds support for the HS200 mode on the host side.
>> Also enables the tuning feature required when the HS200 mode
>> is selected.
>>
>> cc: Chris Ball <cjb@laptop.org>
>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>> ---
>> drivers/mmc/host/sdhci.c =A0| =A0 43 +++++++++++++++++++++++++++++++=
++----------
>> drivers/mmc/host/sdhci.h =A0| =A0 =A01 +
>> include/linux/mmc/host.h =A0| =A0 11 ++++++++++-
>> include/linux/mmc/sdhci.h | =A0 =A01 +
>> 4 files changed, 45 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ab6018f..049d51d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -49,7 +49,7 @@ static void sdhci_finish_data(struct sdhci_host *)=
;
>>
>> static void sdhci_send_command(struct sdhci_host *, struct mmc_comma=
nd *);
>> static void sdhci_finish_command(struct sdhci_host *);
>> -static int sdhci_execute_tuning(struct mmc_host *mmc);
>> +static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
>> static void sdhci_tuning_timer(unsigned long data);
>>
>> #ifdef CONFIG_PM_RUNTIME
>> @@ -1016,7 +1016,8 @@ static void sdhci_send_command(struct sdhci_ho=
st *host, struct mmc_command *cmd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_INDEX;
>>
>> =A0 =A0 =A0 /* CMD19 is special in that the Data Present Select shou=
ld be set */
>> - =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BLOCK=
))
>> + =A0 =A0 if (cmd->data || (cmd->opcode =3D=3D MMC_SEND_TUNING_BLOCK=
) ||
>> + =A0 =A0 =A0 =A0 (cmd->opcode =3D=3D MMC_SEND_TUNING_BLOCK_HS200))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags |=3D SDHCI_CMD_DATA;
>>
>> =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_CMD(cmd->opcode, flags), S=
DHCI_COMMAND);
>> @@ -1287,7 +1288,7 @@ static void sdhci_request(struct mmc_host *mmc=
, struct mmc_request *mrq)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((host->flags & SDHCI_NEEDS_RETUNING)=
 &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(present_state & (SDHCI_DOING_W=
RITE | SDHCI_DOING_READ))) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&=
host->lock, flags);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tuning(mmc);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_execute_tuning(mmc, =
mrq->cmd->opcode);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host-=
>lock, flags);
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore original mmc_=
request structure */
>> @@ -1375,7 +1376,8 @@ static void sdhci_do_set_ios(struct sdhci_host=
 *host, struct mmc_ios *ios)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_U=
HS_SDR104) ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_U=
HS_DDR50) ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_U=
HS_SDR25) ||
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_UHS=
_SDR12))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_UHS=
_SDR12) ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ios->timing =3D=3D MMC_TIMING_MMC=
_HS200))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_HIS=
PD;
>
> move to first test so speed ordering is maintained.
Sure
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_=
CONTROL2);
>> @@ -1435,6 +1437,8 @@ static void sdhci_do_set_ios(struct sdhci_host=
 *host, struct mmc_ios *ios)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=
=3D SDHCI_CTRL_UHS_SDR104;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=
=3D MMC_TIMING_UHS_DDR50)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=
=3D SDHCI_CTRL_UHS_DDR50;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (ios->timing =3D=3D=
 MMC_TIMING_MMC_HS200)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D=
 SDHCI_CTRL_HS_SDR200;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, ctrl_=
2, SDHCI_HOST_CONTROL2);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> same as above
Sure
>
>>
>> @@ -1673,7 +1677,7 @@ static int sdhci_start_signal_voltage_switch(s=
truct mmc_host *mmc,
>> =A0 =A0 =A0 return err;
>> }
>>
>> -static int sdhci_execute_tuning(struct mmc_host *mmc)
>> +static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
>> {
>
> Can one deduce the type of tuning needed by the speed ? =A0 is the op=
code really needed?

Yes Its needed, because the SD specification defines tuining command
as 19 and eMMC specification defines the same tuning command as 21. If
opcode is not passed as the parameter then the host has to be informed
about the card type (whether SD or MMC).
You can check the previous review comments for the same by subhash.

>
>> =A0 =A0 =A0 struct sdhci_host *host;
>> =A0 =A0 =A0 u16 ctrl;
>> @@ -1694,10 +1698,13 @@ static int sdhci_execute_tuning(struct mmc_h=
ost *mmc)
>> =A0 =A0 =A0 =A0* Host Controller needs tuning only in case of SDR104=
 mode
>> =A0 =A0 =A0 =A0* and for SDR50 mode when Use Tuning for SDR50 is set=
 in
>> =A0 =A0 =A0 =A0* Capabilities register.
>> + =A0 =A0 =A0* If the Host Controller supports the HS200 mode then t=
uning
>> + =A0 =A0 =A0* function has to be executed.
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 if (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL_UHS_=
SDR104) ||
>> =A0 =A0 =A0 =A0 =A0 (((ctrl & SDHCI_CTRL_UHS_MASK) =3D=3D SDHCI_CTRL=
_UHS_SDR50) &&
>> - =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)))
>> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_SDR50_NEEDS_TUNING)) ||
>> + =A0 =A0 =A0 =A0 (host->flags & SDHCI_HS200_NEEDS_TUNING))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
>> =A0 =A0 =A0 else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->lock);
>> @@ -1733,7 +1740,7 @@ static int sdhci_execute_tuning(struct mmc_hos=
t *mmc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!tuning_loop_counter && !timeout)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>>
>> - =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D MMC_SEND_TUNING_BLOCK;
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmd.opcode =3D opcode;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.arg =3D 0;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd.retries =3D 0;
>> @@ -1748,7 +1755,17 @@ static int sdhci_execute_tuning(struct mmc_ho=
st *mmc)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* block to the Host Controller. So we=
 set the block size
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* to 64 here.
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64)=
, SDHCI_BLOCK_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cmd.opcode =3D=3D MMC_SEND_TUNING_BLOC=
K_HS200) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mmc->ios.bus_width =3D=
=3D MMC_BUS_WIDTH_8)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writ=
ew(host, SDHCI_MAKE_BLKSZ(7, 128),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (mmc->ios.bus_widt=
h =3D=3D MMC_BUS_WIDTH_4)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writ=
ew(host, SDHCI_MAKE_BLKSZ(7, 64),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0SDHCI_BLOCK_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writew(host, SDHCI_M=
AKE_BLKSZ(7, 64),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SDHCI_BLOCK_SIZE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* The tuning block is sent by the car=
d to the host controller.
>> @@ -2131,12 +2148,14 @@ static void sdhci_show_adma_error(struct sdh=
ci_host *host) { }
>>
>> static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>> {
>> + =A0 =A0 u32 command;
>> =A0 =A0 =A0 BUG_ON(intmask =3D=3D 0);
>>
>> =A0 =A0 =A0 /* CMD19 generates _only_ Buffer Read Ready interrupt */
>> =A0 =A0 =A0 if (intmask & SDHCI_INT_DATA_AVAIL) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (SDHCI_GET_CMD(sdhci_readw(host, SDHCI_=
COMMAND)) =3D=3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_SEND_TUNING_BLOCK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 command =3D SDHCI_GET_CMD(sdhci_readw(host=
, SDHCI_COMMAND));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((command =3D=3D MMC_SEND_TUNING_BLOCK)=
 ||
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (command =3D=3D MMC_SEND_TUNING_BL=
OCK_HS200)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->tuning_done =3D 1;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up(&host->buf_ready=
_int);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> @@ -2741,6 +2760,10 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps[1] & SDHCI_USE_SDR50_TUNING)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_SDR50_NEEDS_TUNIN=
G;
>>
>> + =A0 =A0 /* Does the host needs tuning for HS200? */
>> + =A0 =A0 if (mmc->caps2 & MMC_CAP2_HS200)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_HS200_NEEDS_TUNING;
>> +
>> =A0 =A0 =A0 /* Driver Type(s) (A, C, D) supported by the host */
>> =A0 =A0 =A0 if (caps[1] & SDHCI_DRIVER_TYPE_A)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->caps |=3D MMC_CAP_DRIVER_TYPE_A;
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index a04d4d0..46fd2ac 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -158,6 +158,7 @@
>> #define =A0 SDHCI_CTRL_UHS_SDR50 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00=
02
>> #define =A0 SDHCI_CTRL_UHS_SDR104 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0003
>> #define =A0 SDHCI_CTRL_UHS_DDR50 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00=
04
>> +#define =A0 SDHCI_CTRL_HS_SDR200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0005=
 /*reserved value in SDIO spec */
>> #define =A0SDHCI_CTRL_VDD_180 =A0 =A0 =A0 =A0 =A0 0x0008
>> #define =A0SDHCI_CTRL_DRV_TYPE_MASK =A0 =A0 0x0030
>> #define =A0 SDHCI_CTRL_DRV_TYPE_B =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0000
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 9a03d03..606c8c3 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -56,10 +56,13 @@ struct mmc_ios {
>> #define MMC_TIMING_UHS_SDR50 =A03
>> #define MMC_TIMING_UHS_SDR104 4
>> #define MMC_TIMING_UHS_DDR50 =A05
>> +#define MMC_TIMING_MMC_HS200 6
>>
>> #define MMC_SDR_MODE =A0 =A0 =A0 =A0 =A00
>> #define MMC_1_2V_DDR_MODE =A0 =A0 1
>> #define MMC_1_8V_DDR_MODE =A0 =A0 2
>> +#define MMC_1_2V_SDR_MODE =A0 =A03
>> +#define MMC_1_8V_SDR_MODE =A0 =A04
>>
>> =A0 =A0 =A0 unsigned char =A0 signal_voltage; =A0 =A0 =A0 =A0 /* sig=
nalling voltage (1.8V or 3.3V) */
>>
>> @@ -148,7 +151,9 @@ struct mmc_host_ops {
>> =A0 =A0 =A0 void =A0 =A0(*init_card)(struct mmc_host *host, struct m=
mc_card *card);
>>
>> =A0 =A0 =A0 int =A0 =A0 (*start_signal_voltage_switch)(struct mmc_ho=
st *host, struct mmc_ios *ios);
>> - =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc_host *host);
>> +
>> + =A0 =A0 /* The tuning command opcode value is different for SD and=
 eMMC cards */
>> + =A0 =A0 int =A0 =A0 (*execute_tuning)(struct mmc_host *host, u32 o=
pcode);
>> =A0 =A0 =A0 void =A0 =A0(*enable_preset_value)(struct mmc_host *host=
, bool enable);
>> =A0 =A0 =A0 int =A0 =A0 (*select_drive_strength)(unsigned int max_dt=
r, int host_drv, int card_drv);
>> =A0 =A0 =A0 void =A0 =A0(*hw_reset)(struct mmc_host *host);
>> @@ -242,6 +247,10 @@ struct mmc_host {
>> #define MMC_CAP2_CACHE_CTRL =A0 (1 << 1) =A0 =A0 =A0 =A0/* Allow cac=
he control */
>> #define MMC_CAP2_POWEROFF_NOTIFY (1 << 2) =A0 =A0 /* Notify poweroff=
 supported */
>> #define MMC_CAP2_NO_MULTI_READ =A0 =A0 =A0 =A0(1 << 3) =A0 =A0 =A0 =A0=
/* Multiblock reads don't work */
>> +#define MMC_CAP2_HS200_1_8V_SDR =A0 =A0 =A0(1 << 4) =A0 =A0 =A0 =A0=
/* can support */
>> +#define MMC_CAP2_HS200_1_2V_SDR =A0 =A0 =A0(1 << 5) =A0 =A0 =A0 =A0=
/* can support */
>> +#define MMC_CAP2_HS200 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (MMC_CAP2_HS200_=
1_8V_SDR | \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MMC_CAP=
2_HS200_1_2V_SDR)
>>
>> =A0 =A0 =A0 mmc_pm_flag_t =A0 =A0 =A0 =A0 =A0 pm_caps; =A0 =A0 =A0 =A0=
/* supported pm features */
>> =A0 =A0 =A0 unsigned int =A0 =A0 =A0 =A0power_notify_type;
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index e4b6935..d9a2222 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -121,6 +121,7 @@ struct sdhci_host {
>> #define SDHCI_AUTO_CMD23 =A0 =A0 =A0(1<<7) =A0/* Auto CMD23 support =
*/
>> #define SDHCI_PV_ENABLED =A0 =A0 =A0(1<<8) =A0/* Preset value enable=
d */
>> #define SDHCI_SDIO_IRQ_ENABLED =A0 =A0 =A0 =A0(1<<9) =A0/* SDIO irq =
enabled */
>> +#define SDHCI_HS200_NEEDS_TUNING (1<<10) =A0 =A0 /* HS200 needs tun=
ing */
>>
>> =A0 =A0 =A0 unsigned int version; =A0 /* SDHCI spec. version */
>>
>> --
>> 1.7.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
