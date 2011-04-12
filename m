From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Tue, 12 Apr 2011 13:05:01 -0500
Message-ID: <BANLkTin6Aya3KpY6NUYtHTWRpg7azO5nOg@mail.gmail.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-2-git-send-email-andreiw@motorola.com>
	<5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:48457 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757866Ab1DLSFD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 14:05:03 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.129.42])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CI3Dxk004325
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 14:03:14 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p3CHj9IO023289
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 14:03:13 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so7779746wwb.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Apr 2011 11:05:01 -0700 (PDT)
In-Reply-To: <5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>

On Tue, Apr 12, 2011 at 4:06 AM, Dong, Chuanxiao
<chuanxiao.dong@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-mmc-owner@vger.kernel.org
>> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Andrei Warkent=
in
>> Sent: Tuesday, April 12, 2011 5:14 AM
>> To: linux-mmc@vger.kernel.org
>> Cc: arnd@arndb.de; cjb@laptop.org; Andrei Warkentin
>> Subject: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERA=
SE.
>>
>> ERASE command needs R1B response, so fix R1B-type command
>> handling for SDHCI controller. For non-DAT commands using a busy
>> reponse, the cmd->cmd_timeout_ms (in ms) field is used for timeout
>> calculations.
>>
>> Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
>> ---
>> =A0drivers/mmc/host/sdhci.c | =A0 43 +++++++++++++++++++++++++++----=
------------
>> =A01 files changed, 27 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 9e15f41..173e980 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -40,7 +40,6 @@
>>
>> =A0static unsigned int debug_quirks =3D 0;
>>
>> -static void sdhci_prepare_data(struct sdhci_host *, struct mmc_data=
 *);
>> =A0static void sdhci_finish_data(struct sdhci_host *);
>>
>> =A0static void sdhci_send_command(struct sdhci_host *, struct mmc_co=
mmand *);
>> @@ -591,9 +590,10 @@ static void sdhci_adma_table_post(struct sdhci_=
host
>> *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->sg_len, direction);
>> =A0}
>>
>> -static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_da=
ta *data)
>> +static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_co=
mmand
>> *cmd)
>> =A0{
>> =A0 =A0 =A0 u8 count;
>> + =A0 =A0 struct mmc_data *data =3D cmd->data;
>> =A0 =A0 =A0 unsigned target_timeout, current_timeout;
>>
>> =A0 =A0 =A0 /*
>> @@ -605,12 +605,16 @@ static u8 sdhci_calc_timeout(struct sdhci_host=
 *host,
>> struct mmc_data *data)
>> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0xE;
>>
>> - =A0 =A0 /* timeout in us */
>> - =A0 =A0 target_timeout =3D data->timeout_ns / 1000 +
>> - =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_clks / host->clock;
>> + =A0 =A0 /* Unspecified timeout, assume max */
>> + =A0 =A0 if (!data && !cmd->cmd_timeout_ms)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0xE;
> Just a inline question here. I noticed cmd_timeout_ms only be set for=
 the ERASE command and SWITCH command, for other types of commands, thi=
s value is left not initialized. Cmd_timeout_ms may not be zero and als=
o not be initialized. And next, driver will use this value to calculate=
 the timeout. So I think using an uninitialized value here doesn't make=
 sense. If we want to use it, we have to make sure at this point, this =
value is already initialized.

=46irst, cmd_timeout only has meaning for non-DAT-transfer commands
using DAT as a busy indicator.  This is exactly why the cmd_timeout_ms
affects the "data timeout" on the host. Hence - cmd_timeout_ms only
makes sense for R1b commands. (R5b too, but that's SDIO land and I
don't want to push support for something I can't verify) Second - if
it's not initialized, it is zero (look in block.c, the entire brq is
cleared to 0, look in mmc_ops, sd_ops, sdio_ops).

Remember, if !data and !cmd_timeout, then this must be a busy-wait
command with no timeout specified, we pick the safe maximum of 0xE.
Also again, this timeout has any meaning (and is only calculated) only
if the command actually leverages the DAT line.

What commands are you interested in? There are not a lot of R1b
commands. This patch addressed missing DAT timeout for R1b commands
like erase, switch, etc.

>
>>
>> - =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>> - =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 1000;
>> + =A0 =A0 /* timeout in us */
>> + =A0 =A0 if (!data)
>> + =A0 =A0 =A0 =A0 =A0 =A0 target_timeout =3D cmd->cmd_timeout_ms * 1=
000;
> That is where I concerned about the uninitialized cmd_timeout_ms.

You claim it's uninitialized, but it is zero because all consumers of
mmc_command memset the structure to 0.

>
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 target_timeout =3D data->timeout_ns / 1000=
 +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_clks / host-=
>clock;
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Figure out needed cycles.
>> @@ -632,8 +636,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host *=
host,
>> struct mmc_data *data)
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 if (count >=3D 0xF) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Too large timeout=
 requested!\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc));
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Too large timeout=
 requested for
>> CMD%d!\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->opcode);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D 0xE;
>> =A0 =A0 =A0 }
>>
>> @@ -651,15 +656,21 @@ static void sdhci_set_transfer_irqs(struct sdh=
ci_host
>> *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clear_set_irqs(host, dma_irqs, pio=
_irqs);
>> =A0}
>>
>> -static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_=
data *data)
>> +static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_=
command
>> *cmd)
>> =A0{
>> =A0 =A0 =A0 u8 count;
>> =A0 =A0 =A0 u8 ctrl;
>> + =A0 =A0 struct mmc_data *data =3D cmd->data;
>> =A0 =A0 =A0 int ret;
>>
>> =A0 =A0 =A0 WARN_ON(host->data);
>>
>> - =A0 =A0 if (data =3D=3D NULL)
>> + =A0 =A0 if (data || (cmd->flags & MMC_RSP_BUSY)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D sdhci_calc_timeout(host, cmd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, count, SDHCI_TIMEOUT_CO=
NTROL);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!data)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>>
>> =A0 =A0 =A0 /* Sanity checks */
>> @@ -670,9 +681,6 @@ static void sdhci_prepare_data(struct sdhci_host=
 *host,
>> struct mmc_data *data)
>> =A0 =A0 =A0 host->data =3D data;
>> =A0 =A0 =A0 host->data_early =3D 0;
>>
>> - =A0 =A0 count =3D sdhci_calc_timeout(host, data);
>> - =A0 =A0 sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
>> -
>> =A0 =A0 =A0 if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_REQ_USE_DMA;
>>
>> @@ -920,7 +928,7 @@ static void sdhci_send_command(struct sdhci_host=
 *host,
>> struct mmc_command *cmd)
>>
>> =A0 =A0 =A0 host->cmd =3D cmd;
>>
>> - =A0 =A0 sdhci_prepare_data(host, cmd->data);
>> + =A0 =A0 sdhci_prepare_data(host, cmd);
>>
>> =A0 =A0 =A0 sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
>>
>> @@ -1867,6 +1875,9 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 if (caps & SDHCI_TIMEOUT_CLK_UNIT)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk *=3D 1000;
>>
>> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 1000;
>> +
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Set host parameters.
>> =A0 =A0 =A0 =A0*/
>> @@ -1879,7 +1890,7 @@ int sdhci_add_host(struct sdhci_host *host)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / SDHCI_MAX=
_DIV_SPEC_200;
>>
>> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
>> - =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
>> + =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* A controller may support 8-bit width, but the board=
 itself
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
