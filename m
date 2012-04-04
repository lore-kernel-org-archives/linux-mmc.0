From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don't support
 UHS modes.
Date: Wed, 4 Apr 2012 13:31:11 +0900
Message-ID: <CAGxe1ZFVg69i6AnW7eiOG4RkvddEysqynkMx+HhsKnyA7bLaEw@mail.gmail.com>
References: <1331927657-2849-1-git-send-email-acooper@gmail.com>
	<CAOGqxeWdOjkSTa2N5GwCvGb02zge+66_CT=0u7upznoWVfUCcw@mail.gmail.com>
	<87r4w5ir2k.fsf@laptop.org>
	<B0C59D0E4E9BA24EB5E08604F8E228540423DF0E@sausexdag03.amd.com>
	<0CC34BD4-748D-464A-A57B-C36565B9289E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:38449 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082Ab2DDEbM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Apr 2012 00:31:12 -0400
Received: by qadc11 with SMTP id c11so114101qad.19
        for <linux-mmc@vger.kernel.org>; Tue, 03 Apr 2012 21:31:11 -0700 (PDT)
In-Reply-To: <0CC34BD4-748D-464A-A57B-C36565B9289E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alan Cooper <alcooperx@gmail.com>, "Nath, Arindam" <Arindam.Nath@amd.com>, Ulf Hansson <ulf.hansson@stericsson.com>

On 4 April 2012 12:58, Philip Rakity <prakity@marvell.com> wrote:
>
> Acked-by: Philip Rakity <prakity@marvell.com>
>
> On Apr 3, 2012, at 8:46 PM, Nath, Arindam wrote:
>
>> Hi,
>>
>>
>>> -----Original Message-----
>>> From: Chris Ball [mailto:cjb@laptop.org]
>>> Sent: Tuesday, April 03, 2012 6:12 AM
>>> To: Alan Cooper
>>> Cc: linux-mmc@vger.kernel.org; Girish K S; Ulf Hansson; Nath, Arind=
am;
>>> Philip Rakity
>>> Subject: Re: [PATCH] mmc: Prevent 1.8V switch for SD hosts that don=
't
>>> support UHS modes.
>>>
>>> Hi Al,
>>>
>>> On Mon, Apr 02 2012, Alan Cooper wrote:
>>>> Still hoping for comments on the patch.
>>>
>>> Thanks for the reminder; adding a few potential reviewers to CC:.
>>
>> Acked-by: Arindam Nath <arindam.nath@amd.com>
>>
>> Regards,
>> Arindam
>>
>>>
>>> - Chris.
>>>
>>>> On Fri, Mar 16, 2012 at 3:54 PM, Al Cooper <acooper@gmail.com> wro=
te:
>>>>> The driver should not try to switch to 1.8V when the SD 3.0 host
>>>>> controller does not have any UHS capabilities bits set (SDR50, DD=
R50
>>>>> or SDR104). See page 72 of "SD Specifications Part A2 SD Host
>>>>> Controller Simplified Specification Version 3.00" under
>>>>> "1.8V Signaling Enable". Instead of setting SDR12 and SDR25 in th=
e
>>> host
>>>>> capabilities data structure for all V3.0 host controllers, only s=
et
>>> them
>>>>> if SDR104, SDR50 or DDR50 is set in the host capabilities registe=
r.
>>> This
>>>>> will prevent the switch to 1.8V later.
>>>>>
>>>>> Signed-off-by: Al Cooper <acooper@gmail.com>
>>>>> ---
>>>>> =A0drivers/mmc/host/sdhci.c | =A0 =A05 +++--
>>>>> =A01 files changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>>>> index 8d66706..cdf900e 100644
>>>>> --- a/drivers/mmc/host/sdhci.c
>>>>> +++ b/drivers/mmc/host/sdhci.c
>>>>> @@ -2762,8 +2762,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0mmc_card_is_removable(mmc))
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_NEEDS_POLL;
>>>>>
>>>>> - =A0 =A0 =A0 /* UHS-I mode(s) supported by the host controller. =
*/
>>>>> - =A0 =A0 =A0 if (host->version >=3D SDHCI_SPEC_300)
>>>>> + =A0 =A0 =A0 /* Any UHS-I mode in caps implies SDR12 and SDR25 s=
upport.
>>> */
>>>>> + =A0 =A0 =A0 if (caps[1] & (SDHCI_SUPPORT_SDR104 | SDHCI_SUPPORT=
_SDR50 |
>>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SDHCI_SUPPORT_DDR50)=
)
>>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc->caps |=3D MMC_CAP_UHS_SDR12 |=
 MMC_CAP_UHS_SDR25;
>>>>>
>>>>> =A0 =A0 =A0 =A0/* SDR104 supports also implies SDR50 support */
Cross checked with spec.
Acked By: Girish K S <girish.shivananjappa@linaro.org>
>>>>> --
>>>>> 1.7.6
>>>
>>> --
>>> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
>>> One Laptop Per Child
>>
>
