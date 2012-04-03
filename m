From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't support UHS modes.
Date: Mon, 02 Apr 2012 20:42:27 -0400
Message-ID: <87r4w5ir2k.fsf@laptop.org>
References: <1331927657-2849-1-git-send-email-acooper@gmail.com>
	<CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48359 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751691Ab2DCAmW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Apr 2012 20:42:22 -0400
In-Reply-To: <CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
	(Alan Cooper's message of "Mon, 2 Apr 2012 14:29:18 -0400")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cooper <alcooperx@gmail.com>
Cc: linux-mmc@vger.kernel.org, Girish K S <girish.shivananjappa@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, "Nath, Arindam" <Arindam.Nath@amd.com>, Philip Rakity <prakity@marvell.com>

Hi Al,

On Mon, Apr 02 2012, Alan Cooper wrote:
> Still hoping for comments on the patch.

Thanks for the reminder; adding a few potential reviewers to CC:.

- Chris.

> On Fri, Mar 16, 2012 at 3:54 PM, Al Cooper <acooper@gmail.com> wrote:
>> The driver should not try to switch to 1.8V when the SD 3.0 host
>> controller does not have any UHS capabilities bits set (SDR50, DDR50
>> or SDR104). See page 72 of "SD Specifications Part A2 SD Host
>> Controller Simplified Specification Version 3.00" under
>> "1.8V Signaling Enable". Instead of setting SDR12 and SDR25 in the h=
ost
>> capabilities data structure for all V3.0 host controllers, only set =
them
>> if SDR104, SDR50 or DDR50 is set in the host capabilities register. =
This
>> will prevent the switch to 1.8V later.
>>
>> Signed-off-by: Al Cooper <acooper@gmail.com>
>> ---
>> =C2=A0drivers/mmc/host/sdhci.c | =C2=A0 =C2=A05 +++--
>> =C2=A01 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 8d66706..cdf900e 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2762,8 +2762,9 @@ int sdhci_add_host(struct sdhci_host *host)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_card_is_removable(mmc))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->caps |=3D=
 MMC_CAP_NEEDS_POLL;
>>
>> - =C2=A0 =C2=A0 =C2=A0 /* UHS-I mode(s) supported by the host contro=
ller. */
>> - =C2=A0 =C2=A0 =C2=A0 if (host->version >=3D SDHCI_SPEC_300)
>> + =C2=A0 =C2=A0 =C2=A0 /* Any UHS-I mode in caps implies SDR12 and S=
DR25 support. */
>> + =C2=A0 =C2=A0 =C2=A0 if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_S=
UPPORT_SDR50 |
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0SDHCI_SUPPORT_DDR50))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc->caps |=3D=
 MMC_CAP_UHS_SDR12 | MMC_CAP_UHS_SDR25;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SDR104 supports also implies SDR50 sup=
port */
>> --
>> 1.7.6

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
