From: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>
Subject: RE: [patchv3 2/4] MMC: SDHCI R1B command handling + MMC_CAP_ERASE.
Date: Wed, 13 Apr 2011 09:59:41 +0800
Message-ID: <5D8008F58939784290FAB48F5497519838C3288867@shsmsx502.ccr.corp.intel.com>
References: <BANLkTikA56sD_A6VVPF15SgA-AnKOZ2ZXw@mail.gmail.com>
	<1302556424-21951-2-git-send-email-andreiw@motorola.com>
	<5D8008F58939784290FAB48F54975198389075A5E9@shsmsx502.ccr.corp.intel.com>
 <BANLkTin6Aya3KpY6NUYtHTWRpg7azO5nOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38495 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932735Ab1DMCAc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Apr 2011 22:00:32 -0400
In-Reply-To: <BANLkTin6Aya3KpY6NUYtHTWRpg7azO5nOg@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "cjb@laptop.org" <cjb@laptop.org>



> -----Original Message-----
> From: Andrei Warkentin [mailto:andreiw@motorola.com]
> Sent: Wednesday, April 13, 2011 2:05 AM
> To: Dong, Chuanxiao
> Cc: linux-mmc@vger.kernel.org; arnd@arndb.de; cjb@laptop.org
> Subject: Re: [patchv3 2/4] MMC: SDHCI R1B command handling +
> MMC_CAP_ERASE.
>=20
> On Tue, Apr 12, 2011 at 4:06 AM, Dong, Chuanxiao
> <chuanxiao.dong@intel.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: linux-mmc-owner@vger.kernel.org
> >> [mailto:linux-mmc-owner@vger.kernel.org] On Behalf Of Andrei Warke=
ntin
> >> Sent: Tuesday, April 12, 2011 5:14 AM
> >> To: linux-mmc@vger.kernel.org
> >> Cc: arnd@arndb.de; cjb@laptop.org; Andrei Warkentin
> >> Subject: [patchv3 2/4] MMC: SDHCI R1B command handling +
> MMC_CAP_ERASE.
> >>
> >> ERASE command needs R1B response, so fix R1B-type command
> >> handling for SDHCI controller. For non-DAT commands using a busy
> >> reponse, the cmd->cmd_timeout_ms (in ms) field is used for timeout
> >> calculations.
> >>
> >> Based on patch by Chuanxiao Dong <chuanxiao.dong@intel.com>
> >> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> >> ---
> >> =A0drivers/mmc/host/sdhci.c | =A0 43
> +++++++++++++++++++++++++++----------------
> >> =A01 files changed, 27 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 9e15f41..173e980 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -40,7 +40,6 @@
> >>
> >> =A0static unsigned int debug_quirks =3D 0;
> >>
> >> -static void sdhci_prepare_data(struct sdhci_host *, struct mmc_da=
ta *);
> >> =A0static void sdhci_finish_data(struct sdhci_host *);
> >>
> >> =A0static void sdhci_send_command(struct sdhci_host *, struct mmc_=
command
> *);
> >> @@ -591,9 +590,10 @@ static void sdhci_adma_table_post(struct sdhc=
i_host
> >> *host,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->sg_len, direction);
> >> =A0}
> >>
> >> -static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_=
data *data)
> >> +static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_=
command
> >> *cmd)
> >> =A0{
> >> =A0 =A0 =A0 u8 count;
> >> + =A0 =A0 struct mmc_data *data =3D cmd->data;
> >> =A0 =A0 =A0 unsigned target_timeout, current_timeout;
> >>
> >> =A0 =A0 =A0 /*
> >> @@ -605,12 +605,16 @@ static u8 sdhci_calc_timeout(struct sdhci_ho=
st *host,
> >> struct mmc_data *data)
> >> =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_BROKEN_TIMEOUT_VAL)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0xE;
> >>
> >> - =A0 =A0 /* timeout in us */
> >> - =A0 =A0 target_timeout =3D data->timeout_ns / 1000 +
> >> - =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_clks / host->clock;
> >> + =A0 =A0 /* Unspecified timeout, assume max */
> >> + =A0 =A0 if (!data && !cmd->cmd_timeout_ms)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 0xE;
> > Just a inline question here. I noticed cmd_timeout_ms only be set f=
or the ERASE
> command and SWITCH command, for other types of commands, this value i=
s left
> not initialized. Cmd_timeout_ms may not be zero and also not be initi=
alized. And
> next, driver will use this value to calculate the timeout. So I think=
 using an
> uninitialized value here doesn't make sense. If we want to use it, we=
 have to make
> sure at this point, this value is already initialized.
>=20
> First, cmd_timeout only has meaning for non-DAT-transfer commands
> using DAT as a busy indicator.  This is exactly why the cmd_timeout_m=
s
> affects the "data timeout" on the host. Hence - cmd_timeout_ms only
> makes sense for R1b commands. (R5b too, but that's SDIO land and I
> don't want to push support for something I can't verify) Second - if
> it's not initialized, it is zero (look in block.c, the entire brq is
> cleared to 0, look in mmc_ops, sd_ops, sdio_ops).
>=20
> Remember, if !data and !cmd_timeout, then this must be a busy-wait
> command with no timeout specified, we pick the safe maximum of 0xE.
> Also again, this timeout has any meaning (and is only calculated) onl=
y
> if the command actually leverages the DAT line.
>=20
> What commands are you interested in? There are not a lot of R1b
> commands. This patch addressed missing DAT timeout for R1b commands
> like erase, switch, etc.
>=20
> >
> >>
> >> - =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> >> - =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 1000=
;
> >> + =A0 =A0 /* timeout in us */
> >> + =A0 =A0 if (!data)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 target_timeout =3D cmd->cmd_timeout_ms *=
 1000;
> > That is where I concerned about the uninitialized cmd_timeout_ms.
>=20
> You claim it's uninitialized, but it is zero because all consumers of
> mmc_command memset the structure to 0.
Yes, if all the consumers of mmc_command memset the structure to 0, the=
re will be no problem. But just reviewed the code, and found mmc_app_cm=
d() (in sd_ops.c) didn't memset the command structure. So I think if we=
 can make sure all the command structures will be initialized before us=
ing it, that would be better.

>=20
> >
> >> + =A0 =A0 else
> >> + =A0 =A0 =A0 =A0 =A0 =A0 target_timeout =3D data->timeout_ns / 10=
00 +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->timeout_clks / hos=
t->clock;
> >>
> >> =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Figure out needed cycles.
> >> @@ -632,8 +636,9 @@ static u8 sdhci_calc_timeout(struct sdhci_host=
 *host,
> >> struct mmc_data *data)
> >> =A0 =A0 =A0 }
> >>
> >> =A0 =A0 =A0 if (count >=3D 0xF) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Too large timeo=
ut requested!\n",
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(host->mmc))=
;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: Too large timeo=
ut requested for
> >> CMD%d!\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc),
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->opcode);
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D 0xE;
> >> =A0 =A0 =A0 }
> >>
> >> @@ -651,15 +656,21 @@ static void sdhci_set_transfer_irqs(struct s=
dhci_host
> >> *host)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 sdhci_clear_set_irqs(host, dma_irqs, p=
io_irqs);
> >> =A0}
> >>
> >> -static void sdhci_prepare_data(struct sdhci_host *host, struct mm=
c_data
> *data)
> >> +static void sdhci_prepare_data(struct sdhci_host *host, struct mm=
c_command
> >> *cmd)
> >> =A0{
> >> =A0 =A0 =A0 u8 count;
> >> =A0 =A0 =A0 u8 ctrl;
> >> + =A0 =A0 struct mmc_data *data =3D cmd->data;
> >> =A0 =A0 =A0 int ret;
> >>
> >> =A0 =A0 =A0 WARN_ON(host->data);
> >>
> >> - =A0 =A0 if (data =3D=3D NULL)
> >> + =A0 =A0 if (data || (cmd->flags & MMC_RSP_BUSY)) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 count =3D sdhci_calc_timeout(host, cmd);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 sdhci_writeb(host, count, SDHCI_TIMEOUT_=
CONTROL);
> >> + =A0 =A0 }
> >> +
> >> + =A0 =A0 if (!data)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> >>
> >> =A0 =A0 =A0 /* Sanity checks */
> >> @@ -670,9 +681,6 @@ static void sdhci_prepare_data(struct sdhci_ho=
st *host,
> >> struct mmc_data *data)
> >> =A0 =A0 =A0 host->data =3D data;
> >> =A0 =A0 =A0 host->data_early =3D 0;
> >>
> >> - =A0 =A0 count =3D sdhci_calc_timeout(host, data);
> >> - =A0 =A0 sdhci_writeb(host, count, SDHCI_TIMEOUT_CONTROL);
> >> -
> >> =A0 =A0 =A0 if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->flags |=3D SDHCI_REQ_USE_DMA;
> >>
> >> @@ -920,7 +928,7 @@ static void sdhci_send_command(struct sdhci_ho=
st
> *host,
> >> struct mmc_command *cmd)
> >>
> >> =A0 =A0 =A0 host->cmd =3D cmd;
> >>
> >> - =A0 =A0 sdhci_prepare_data(host, cmd->data);
> >> + =A0 =A0 sdhci_prepare_data(host, cmd);
> >>
> >> =A0 =A0 =A0 sdhci_writel(host, cmd->arg, SDHCI_ARGUMENT);
> >>
> >> @@ -1867,6 +1875,9 @@ int sdhci_add_host(struct sdhci_host *host)
> >> =A0 =A0 =A0 if (caps & SDHCI_TIMEOUT_CLK_UNIT)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk *=3D 1000;
> >>
> >> + =A0 =A0 if (host->quirks & SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->timeout_clk =3D host->clock / 1000=
;
> >> +
> >> =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* Set host parameters.
> >> =A0 =A0 =A0 =A0*/
> >> @@ -1879,7 +1890,7 @@ int sdhci_add_host(struct sdhci_host *host)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc->f_min =3D host->max_clk / SDHCI_M=
AX_DIV_SPEC_200;
> >>
> >> =A0 =A0 =A0 mmc->f_max =3D host->max_clk;
> >> - =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ;
> >> + =A0 =A0 mmc->caps |=3D MMC_CAP_SDIO_IRQ | MMC_CAP_ERASE;
> >>
> >> =A0 =A0 =A0 /*
> >> =A0 =A0 =A0 =A0* A controller may support 8-bit width, but the boa=
rd itself
> >> --
> >> 1.7.0.4
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-mm=
c" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at =A0http://vger.kernel.org/majordomo-info.ht=
ml
> >
