From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Help needed: Enabling HPI causes some eMMC devices to stop working
Date: Wed, 25 Feb 2015 15:41:44 +0100
Message-ID: <54EDDF28.2030700@redhat.com>
References: <54E4E4BF.3090507@redhat.com> <54EDB5B8.2020800@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47810 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751866AbbBYOlz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 25 Feb 2015 09:41:55 -0500
In-Reply-To: <54EDB5B8.2020800@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

Hi,

On 25-02-15 12:44, Jaehoon Chung wrote:
> Hi.
>
> On 02/19/2015 04:15 AM, Hans de Goede wrote:
>> Hi,
>>
>> As part of the Linux Allwinner SoC support work I do in my
>> spare time, I'm working on getting stock Linux running on
>> the Utoo P66 Allwinner A13 based tablet.
>>
>> This tablet is interesting because it uses an eMMC rather then
>> raw nand as is typically seen on Allwinner tablets.
>>
>> It has taken me a while to get the kernel to talk to the eMMC,
>> in the end the following hack does the trick:
>>
>>
>> From: Hans de Goede <hdegoede@redhat.com>
>> Date: Wed, 18 Feb 2015 20:04:03 +0100
>> Subject: [PATCH] mmc: HACK: disable HPI
>>
>> HACK: trying to enable HPI breaks EMMC access on the Utoo P66 tablet I'm
>> trying to get supported, so disable it. FIXME: come up with a proper fix.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/mmc/core/mmc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 1d41e85..b343587 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1418,7 +1418,7 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>>          /*
>>           * Enable HPI feature (if supported)
>>           */
>> -       if (card->ext_csd.hpi) {
>> +       if (0 && card->ext_csd.hpi) {
>>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>                                  EXT_CSD_HPI_MGMT, 1,
>>                                  card->ext_csd.generic_cmd6_time);
>>
>> This patch has one good thing going for it, which it is that it makes
>> the eMMC work, without this talking to the eMMC fails as soon as the
>> kernel tries to read the partition table, with response-timeout errors
>> when doing a mmc command 18 to read sector 0.
>
> I don't understand what response-timeout error related with HPI?

If I do not apply the above patch / hack, which is in the early mmc init
code, then after that any attempts to read something from the card results
in a RTO error. It is not the actual use of HPI which breaks things,
things break way earlier, as soon as the above piece of code executes.

>> So this is as far as I've come, and beyond this my mmc knowledge is simply
>> not good enough. Could this be a controller specific problem ? IOW do
>> we need a controller flag to not enable HPi, like we've
>> MMC_CAP2_BOOTPART_NOACC ? Or is this likely more something specific to the eMMC
>> used.
>>
>> Assuming for now it is something specific to the eMMC used, how do we fix this?
>>
>> Is there maybe some way to figure out that enabling HPI is not a good idea on
>> this eMMC?
>
> According to eMMC spec, HPI feature is mandatory. And it only needs to consider how the feature use.
> Do you use the BKOPS or other use-case?

HPI is not being used, if it were to be used it would be the non BKOPS case (e.g.
interrupting an erase) as this card does not have BKOPS. This card does support
erase, otherwise we could simply make the HPI enable code only run if the card
supported either BKOPS and/or erase, but that will not help here.

We could delay enabling HPI until we do the first erase, but I'm not sure if that
is going to be of much help, since eventually we do want to use trim on emmc
-s by default and thus erase.

Regards,

Hans
