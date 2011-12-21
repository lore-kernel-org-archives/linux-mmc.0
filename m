From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Fix voltage select in DDR mode
Date: Wed, 21 Dec 2011 09:35:32 +0530
Message-ID: <CAGxe1ZGQ4x8r5wETvDPMaX7=67vjaEs=-cQwcRVEodNmOeQNTg@mail.gmail.com>
References: <1323950262-2160-1-git-send-email-girish.shivananjappa@linaro.org>
	<000001ccbb4b$e65ce250$b316a6f0$@org>
	<4B285605-295A-4C43-A60D-777C5D6EA4CB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51636 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750947Ab1LUEFf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Dec 2011 23:05:35 -0500
Received: by eaad14 with SMTP id d14so863280eaa.19
        for <linux-mmc@vger.kernel.org>; Tue, 20 Dec 2011 20:05:33 -0800 (PST)
In-Reply-To: <4B285605-295A-4C43-A60D-777C5D6EA4CB@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>

Hi Chris,
can you add this in your pull request. Its been Acked by the authors
for the correction

regards
Girish K S

On 19 December 2011 22:49, Philip Rakity <prakity@marvell.com> wrote:
>
> On Dec 15, 2011, at 9:06 AM, Subhash Jadavani wrote:
>
>>
>>
>>> -----Original Message-----
>>> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
>>> owner@vger.kernel.org] On Behalf Of Girish K S
>>> Sent: Thursday, December 15, 2011 5:28 PM
>>> To: linux-mmc@vger.kernel.org
>>> Cc: patches@linaro.org; linux-samsung-soc@vger.kernel.org; Girish K=
 S;
>>> Philip Rakity; Arindam Nath; Chris Ball
>>> Subject: [PATCH] mmc: core: Fix voltage select in DDR mode
>>>
>>> This patch fixes the wrong comparison before setting the interface
>>> voltage in DDR mode.
>>>
>>> The assignment to the variable ddr before comaprison is either
>>> ddr =3D MMC_1_2V_DDR_MODE; or ddr =3D=3D MMC_1_8V_DDR_MODE. But the
>>> comparison
>>> is done wth the extended csd value if (ddr =3D=3D
>>> EXT_CSD_CARD_TYPE_DDR_1_2V)
>>>
>>> cc: Philip Rakity <prakity@marvell.com>
>>> cc: Arindam Nath <arindam.nath@amd.com>
>>> cc: Chris Ball <cjb@laptop.org>
>>> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>
>>> ---
>>> drivers/mmc/core/mmc.c | =A0 =A02 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>> index 006e932..f0a9f1f 100644
>>> --- a/drivers/mmc/core/mmc.c
>>> +++ b/drivers/mmc/core/mmc.c
>>> @@ -1058,7 +1058,7 @@ static int mmc_init_card(struct mmc_host *hos=
t,
>>> u32 ocr,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * WARNING: eMMC rules a=
re NOT the same as SD DDR
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ddr =3D=3D EXT_CSD_CAR=
D_TYPE_DDR_1_2V) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ddr =3D=3D MMC_1_2V_DD=
R_MODE) {
>>
>> Looks fine.
>> Acked-by: Subhash Jadavani <subhashj@codeaurora.org>
>
> Acked-by: Philip Rakity <prakity@marvell.com>
>
> NOTE: =A0standard sdhci controller (version 3.0) does not support 1.2=
v signaling.
>
>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D =
mmc_set_signal_voltage(host,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0MMC_SIGNAL_VOLTAGE_120, 0);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
>>> --
>>> 1.7.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>
>
