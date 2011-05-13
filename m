From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v4 12/15] sdhci pxa add platform specific code for UHS signaling
Date: Fri, 13 May 2011 04:03:08 -0400
Message-ID: <BANLkTimA9RwuCie3+0yuS+WVgieLOi_-mg@mail.gmail.com>
References: <1304578151-1775-1-git-send-email-arindam.nath@amd.com>
	<1304578151-1775-13-git-send-email-arindam.nath@amd.com>
	<BANLkTikdwJ3KOhxtJu9Msq6G-SmutGaSHg@mail.gmail.com>
	<1D15C758-EA6C-446C-9A49-2F7279806697@marvell.com>
	<BANLkTikRynkL0vLZ4oJyAkafM27qKc6-xQ@mail.gmail.com>
	<BE2CEC2C-53ED-4D80-974F-6552107C2B66@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:42792 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757804Ab1EMIDK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 May 2011 04:03:10 -0400
Received: by vxi39 with SMTP id 39so1670712vxi.19
        for <linux-mmc@vger.kernel.org>; Fri, 13 May 2011 01:03:08 -0700 (PDT)
In-Reply-To: <BE2CEC2C-53ED-4D80-974F-6552107C2B66@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Arindam Nath <arindam.nath@amd.com>, "cjb@laptop.org" <cjb@laptop.org>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "henry.su@amd.com" <henry.su@amd.com>, "aaron.lu@amd.com" <aaron.lu@amd.com>, "anath.amd@gmail.com" <anath.amd@gmail.com>

On Wed, May 11, 2011 at 5:47 AM, Philip Rakity <prakity@marvell.com> wr=
ote:
>
> On May 11, 2011, at 2:28 AM, zhangfei gao wrote:
>
>> On Wed, May 11, 2011 at 4:52 AM, Philip Rakity <prakity@marvell.com>=
 wrote:
>>>
>>> \
>>> On May 11, 2011, at 1:48 AM, zhangfei gao wrote:
>>>
>>>> On Thu, May 5, 2011 at 2:49 AM, Arindam Nath <arindam.nath@amd.com=
> wrote:
>>>>> Marvell controller requires 1.8V bit in UHS control register 2
>>>>> be set when doing UHS. =A0eMMC does not require 1.8V for DDR.
>>>>> add platform code to handle this.
>>>>>
>>>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>>>> Reviewed-by: Arindam Nath <arindam.nath@amd.com>
>>>>> ---
>>>>> =A0drivers/mmc/host/sdhci-pxa.c | =A0 36 ++++++++++++++++++++++++=
++++++++++++
>>>>> =A01 files changed, 36 insertions(+), 0 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci-pxa.c b/drivers/mmc/host/sdhc=
i-pxa.c
>>>>> index 5a61208..b52c3e6 100644
>>>>> --- a/drivers/mmc/host/sdhci-pxa.c
>>>>> +++ b/drivers/mmc/host/sdhci-pxa.c
>>>>> @@ -69,7 +69,40 @@ static void set_clock(struct sdhci_host *host,=
 unsigned int clock)
>>>>> =A0 =A0 =A0 =A0}
>>>>> =A0}
>>>>>
>>>>> +static int set_uhs_signaling(struct sdhci_host *host, unsigned i=
nt uhs)
>>>>> +{
>>>>> + =A0 =A0 =A0 u16 ctrl_2;
>>>>> +
>>>>> + =A0 =A0 =A0 /*
>>>>> + =A0 =A0 =A0 =A0* Set V18_EN -- UHS modes do not work without th=
is.
>>>>> + =A0 =A0 =A0 =A0* does not change signaling voltage
>>>>> + =A0 =A0 =A0 =A0*/
>>>>> + =A0 =A0 =A0 ctrl_2 =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>>>> +
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Select Bus Speed Mode for host *=
/
>>>>> + =A0 =A0 =A0 ctrl_2 &=3D ~SDHCI_CTRL_UHS_MASK;
>>>>> + =A0 =A0 =A0 if (uhs =3D=3D MMC_TIMING_UHS_SDR12)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR12;
>>>>> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR25)
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR25;
>>>>> + =A0 =A0 =A0 else if (uhs =3D=3D MMC_TIMING_UHS_SDR50) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR50;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>>>> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_SDR104) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_SDR104;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>>>> + =A0 =A0 =A0 } else if (uhs =3D=3D MMC_TIMING_UHS_DDR50) {
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_UHS_DDR50;
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ctrl_2 |=3D SDHCI_CTRL_VDD_180;
>>>>> + =A0 =A0 =A0 }
>>>>> + =A0 =A0 =A0 sdhci_writew(host, ctrl_2, SDHCI_HOST_CONTROL2);
>>>>> + =A0 =A0 =A0 pr_debug("%s:%s uhs =3D %d, ctrl_2 =3D %04X\n",
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, mmc_hostname(host->mmc), =
uhs, ctrl_2);
>>>>> + =A0 =A0 =A0 return 0;
>>>>> +}
>>>>
>>>> Why move common register accessing from sdhci.c to specific driver=
?
>>>
>>> In general case you do not know what the specific host controller w=
ork arounds are required.
>>> on mmp2 this code works (no need for V18 for low speed UHS)
>>> but other controllers it could be different
>>
>> Sorry, not understand, the patch is for sd uhs card or for emmc?
>> For sd uhs card, no workaround is needed on mmp2, but require extern=
al
>> pmic to provide 1.8v io voltage.
>
>
> require 1.8V when setting UHS modes. =A0See latest MMP2 Documentation=
=2E

Do you mean set SDHCI_CTRL_VDD_180?
It is already set in sdhci_start_signal_voltage_switch, so does not
required in specific driver.

>>
>>>
>>>>
>>>>> +
>>>>> =A0static struct sdhci_ops sdhci_pxa_ops =3D {
>>>>> + =A0 =A0 =A0 .set_uhs_signaling =3D set_uhs_signaling,
>>>>> =A0 =A0 =A0 =A0.set_clock =3D set_clock,
>>>>> =A0};
>>>>>
>>>>> @@ -141,6 +174,9 @@ static int __devinit sdhci_pxa_probe(struct p=
latform_device *pdev)
>>>>> =A0 =A0 =A0 =A0if (pdata->quirks)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->quirks |=3D pdata->quirks;
>>>>>
>>>>> + =A0 =A0 =A0 /* enable 1/8V DDR capable */
>>>>> + =A0 =A0 =A0 host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>>>>> +
>>>>> =A0 =A0 =A0 =A0/* If slot design supports 8 bit data, indicate th=
is to MMC. */
>>>>> =A0 =A0 =A0 =A0if (pdata->flags & PXA_FLAG_SD_8_BIT_CAPABLE_SLOT)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mmc->caps |=3D MMC_CAP_8_BIT=
_DATA;
>>>>> --
>>>>> 1.7.1
>>>>>
>>>>>
>>>
>>>
>
>
