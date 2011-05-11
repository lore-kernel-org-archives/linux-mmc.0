From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 12/15] sdhci pxa add platform specific code for UHS signaling
Date: Wed, 11 May 2011 05:28:02 -0400
Message-ID: <BANLkTikRynkL0vLZ4oJyAkafM27qKc6-xQ@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-13-git-send-email-arindam.nath@amd.com>
	<BANLkTikdwJ3KOhxtJu9Msq6G-SmutGaSHg@mail.gmail.com>
	<1D15C758-EA6C-446C-9A49-2F7279806697@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:46974 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752954Ab1EKQih convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 May 2011 12:38:37 -0400
Received: by vxi39 with SMTP id 39so482319vxi.19
        for <linux-mmc@vger.kernel.org>; Wed, 11 May 2011 09:38:36 -0700 (PDT)
In-Reply-To: <1D15C758-EA6C-446C-9A49-2F7279806697@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arindam Nath <arindam.nath@amd.com>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Wed, May 11, 2011 at 4:52 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> \
> On May 11, 2011, at 1:48 AM, zhangfei gao wrote:
>
>> On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com> =
wrote:
>>> Marvell controller requires 1.8V bit in UHS control register 2
>>> be set when doing UHS. =A0eMMC does not require 1.8V for DDR.
>>> add platform code to handle this.
>>>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
>>> ---
>>> =A0drivers/mmc/host/sdhci-pxa.c | =A0 36 ++++++++++++++++++++++++++=
++++++++++
>>> =A01 files changed, 36 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhci-=
pxa.c
>>> index 5a61208..b52c3e6 100644
>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>> @@ -69,7 +69,40 @@ static void set_clock(struct sdhci_host *host, u=
nsigned int clock)
>>> =A0 =A0 =A0 =A0}
>>> =A0}
>>>
>>> +static int set_uhs_signaling(struct sdhci_host *host, unsigned int=
 uhs)
>>> +{
>>> + =A0 =A0 =A0 u16 ctrl_2;
>>> +
>>> + =A0 =A0 =A0 /*
>>> + =A0 =A0 =A0 =A0* Set V18_EN -- UHS modes do not work without this=
=2E
>>> + =A0 =A0 =A0 =A0* does not change signaling voltage
>>> + =A0 =A0 =A0 =A0*/
>>> + =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Select Bus Speed Mode for host */
>>> + =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
>>> + =A0 =A0 =A0 if (uhs =3D=3D MMC_TIMING_UHS_SDR12)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
>>> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR25)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
>>> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR50) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_SDR104) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_DDR50) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>> + =A0 =A0 =A0 }
>>> + =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>> + =A0 =A0 =A0 pr_debug("%s:%s uhs =3D %d, ctrl_2 =3D %04X\n",
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mmc_hostname(host->mmc), uh=
s, ctrl_2);
>>> + =A0 =A0 =A0 return 0;
>>> +}
>>
>> Why move common register accessing from sdhci.c to specific driver?
>
> In general case you do not know what the specific host controller wor=
k arounds are required.
> on mmp2 this code works (no need for V18 for low speed UHS)
> but other controllers it could be different

Sorry, not understand, the patch is for sd uhs card or for emmc?
=46or sd uhs card, no workaround is needed on mmp2, but require externa=
l
pmic to provide 1.8v io voltage.

>
>>
>>> +
>>> =A0static struct sdhci_ops sdhci_pxa_ops =3D {
>>> + =A0 =A0 =A0 .set_uhs_signaling =3D set_uhs_signaling,
>>> =A0 =A0 =A0 =A0.set_clock =3D set_clock,
>>> =A0};
>>>
>>> @@ -141,6 +174,9 @@ static int __devinit sdhci_pxa_probe(struct pla=
tform_device *pdev)
>>> =A0 =A0 =A0 =A0if (pdata->quirks)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>>>
>>> + =A0 =A0 =A0 /* enable 1/8V DDR capable */
>>> + =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>>> +
>>> =A0 =A0 =A0 =A0/* If slot design supports 8 bit data, indicate this=
 to MMC. */
>>> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT_D=
ATA;
>>> --
>>> 1.7.1
>>>
>>>
>
>
