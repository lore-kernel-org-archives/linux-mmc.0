Return-Path: <SRS0=AZQG=43=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2081C10F27
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 10:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A7B2071B
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Mar 2020 10:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgCJKow (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:44:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:10392 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726170AbgCJKow (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 10 Mar 2020 06:44:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 03:44:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,536,1574150400"; 
   d="scan'208";a="415149407"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by orsmga005.jf.intel.com with ESMTP; 10 Mar 2020 03:44:49 -0700
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        "Seo, Kyungmin" <kyungmin.seo@intel.com>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200212024220.GA32111@seokyung-mobl1>
 <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
 <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com>
Date:   Tue, 10 Mar 2020 12:44:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/03/20 11:05 am, Ulf Hansson wrote:
> On Tue, 10 Mar 2020 at 05:28, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
>>
>> I read the link and patch of Chaotian Jing.
>> I also point out what Chaotian said.
>> Most host controllers have DLL tuning values for each mode. When host controller is set as HS400 mode with 50MHz clock, host controller uses DLL value which is tuned with 200MHz clock.
>>
>> If DLL value in HS400 mode doesn't have the pass range in HS mode, command transfer failing may fail.
>> In order to make robust sdhci driver, I think the patch needs to be considered.
> 
> I have, but I am not picking it up in its current form.
> 
>> Of course, CMD6 with HS400 mode and 200MHz clock should not cause any problem because it's correct configuration.
> 
> Yes, but not for all cases, as I said in my reply in those email-threads.
> 
> What I had in mind, is that I I think we should inform
> mmc_hs400_to_hs200() about under what situation it's getting called.
> Depending on that, we should either decrease the clock rate before or
> after we send the CMD6.
> 
> Would that work for your case?

Ulf, would you consider a new call back e.g.

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c2abd417a84a..1bc18fe2632f 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1237,7 +1237,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
 
 	/* Reduce frequency to HS */
 	max_dtr = card->ext_csd.hs_max_dtr;
-	mmc_set_clock(host, max_dtr);
+	if (host->ops->hs400_to_hs200_prep)
+		host->ops->hs400_to_hs200_prep(host, max_dtr);
+	else
+		mmc_set_clock(host, max_dtr);
 
 	/* Switch HS400 to HS DDR */
 	val = EXT_CSD_TIMING_HS;


> 
> Kind regards
> Uffe
> 
>>
>> Thanks
>>
>> -----Original Message-----
>> From: Ulf Hansson <ulf.hansson@linaro.org>
>> Sent: Friday, March 6, 2020 12:18 AM
>> To: Seo, Kyungmin <kyungmin.seo@intel.com>; Hunter, Adrian <adrian.hunter@intel.com>; Chaotian Jing <chaotian.jing@mediatek.com>
>> Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
>> Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
>>
>> + Adrian, Chaotian
>>
>> On Thu, 5 Mar 2020 at 09:57, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
>>>
>>> The mmc_hs400_to_hs200 function is called only in HS400 mode.
>>> I saw the clock change from 200MHz to 52MHz via oscilloscope on real platform.
>>>
>>> I think CMD6 is sent in HS400 mode with 200MHz clock, but it's not.
>>> First CMD6 in mmc_hs400_to_hs200 function is sent with 52MHz clock.
>>
>> I had a vague memory that we have discussed a similar problem as your are pointing out on the mailing list already. And I was right.
>>
>> Please read up on the below references, [1], [2] for the earlier discussions. I suggested a solution for Chaotian to try, but it seems like he never managed to give it a go, as I don't recall new patch being posted.
>>
>> Perhaps you can pick up were Chaotian left and see if you can implement the suggested solution(s). My main concern is breaking other host drivers, as that seems quite likely to happen, if we aren't careful about this.
>>
>> Kind regards
>> Uffe
>>
>> [1]
>> https://lore.kernel.org/linux-mmc/1548921212-5219-1-git-send-email-chaotian.jing@mediatek.com/
>> [2]
>> https://lore.kernel.org/linux-mmc/CAPDyKFquyyXx1MqNLVXuFxcEDB9nKzN8LGGNUP2yxoVMQrWiUg@mail.gmail.com/
>>
>>
>>
>>>
>>> Thanks
>>> KM
>>>
>>> -----Original Message-----
>>> From: Ulf Hansson <ulf.hansson@linaro.org>
>>> Sent: Wednesday, March 4, 2020 8:09 PM
>>> To: Seo, Kyungmin <kyungmin.seo@intel.com>
>>> Cc: linux-mmc@vger.kernel.org; Linux Kernel Mailing List
>>> <linux-kernel@vger.kernel.org>
>>> Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in
>>> mmc
>>>
>>> On Wed, 12 Feb 2020 at 03:40, Kyungmin Seo <kyungmin.seo@intel.com> wrote:
>>>>
>>>> The clock has to be changed after sending CMD6 for HS mode selection
>>>> in
>>>> mmc_hs400_to_hs200() function.
>>>>
>>>> The JEDEC 5.0 and 5.1 said that "High-speed" mode selection has to
>>>> enable the the high speed mode timing in the Device, before chaning
>>>> the clock frequency to a frequency between 26MHz and 52MHz.
>>>
>>> I think that is based upon the assumption that you are using a lower frequency to start with.
>>>
>>> For example, assume that you are running with 400KHz during card initialization, then you want to send the CMD6 to switch to HS mode and that should be done, before updating the clock rate.
>>>
>>> mmc_hs400_to_hs200() goes the opposite direction, so I think the current code looks correct to me.
>>>
>>> Kind regards
>>> Uffe
>>>
>>>>
>>>> Signed-off-by: Kyungmin Seo <kyungmin.seo@intel.com>
>>>> ---
>>>>  drivers/mmc/core/mmc.c | 8 ++++----
>>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
>>>> 3486bc7fbb64..98640b51c73e 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1196,10 +1196,6 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>>>         int err;
>>>>         u8 val;
>>>>
>>>> -       /* Reduce frequency to HS */
>>>> -       max_dtr = card->ext_csd.hs_max_dtr;
>>>> -       mmc_set_clock(host, max_dtr);
>>>> -
>>>>         /* Switch HS400 to HS DDR */
>>>>         val = EXT_CSD_TIMING_HS;
>>>>         err = __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>> EXT_CSD_HS_TIMING, @@ -1210,6 +1206,10 @@ int
>>>> mmc_hs400_to_hs200(struct mmc_card *card)
>>>>
>>>>         mmc_set_timing(host, MMC_TIMING_MMC_DDR52);
>>>>
>>>> +       /* Reduce frequency to HS */
>>>> +       max_dtr = card->ext_csd.hs_max_dtr;
>>>> +       mmc_set_clock(host, max_dtr);
>>>> +
>>>>         err = mmc_switch_status(card);
>>>>         if (err)
>>>>                 goto out_err;
>>>> --
>>>> 2.17.1
>>>>

