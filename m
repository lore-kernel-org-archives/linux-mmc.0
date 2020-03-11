Return-Path: <SRS0=h93R=44=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A8C10F27
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E76A520650
	for <linux-mmc@archiver.kernel.org>; Wed, 11 Mar 2020 14:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgCKOo3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:44:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:8344 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729198AbgCKOo3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 11 Mar 2020 10:44:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 07:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="441701450"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.167]) ([10.237.72.167])
  by fmsmga005.fm.intel.com with ESMTP; 11 Mar 2020 07:44:26 -0700
Subject: Re: [PATCH] mmc: mmc: Fix the timing for clock changing in mmc
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        "Seo, Kyungmin" <kyungmin.seo@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200212024220.GA32111@seokyung-mobl1>
 <CAPDyKFr9H2XcgCk9AmHgJfHC+PySh66KxegMJ4yb4aqKSVt3kg@mail.gmail.com>
 <BYAPR11MB269638142E2BF2C6E108B40A9CE20@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFr=hE6diZmaVy-os3rFScHe+8OphBS+edkVGK+Z-J_=HA@mail.gmail.com>
 <BYAPR11MB2696D160D6F5B7C98E0503E79CFF0@BYAPR11MB2696.namprd11.prod.outlook.com>
 <CAPDyKFqqDWMsHEb493p__FNzYaEzE6Ry0bkd-2ng7cdM886zjw@mail.gmail.com>
 <5f3b8cb9-5e55-ee47-46e5-af019d6328b6@intel.com>
 <CAPDyKFosrju6y5mOKePsNwqgDr=QeBozFTrWKz4MNpsMmeZdCA@mail.gmail.com>
 <1583892806.24941.7.camel@mhfsdcap03>
 <CAPDyKFrdiiVUrCKR2N=Xbtfy3NhXSaq4m_ziXScdJU3x8G2F+w@mail.gmail.com>
 <053fc1c1-465a-e68a-39cb-796addf808e0@intel.com>
 <CAPDyKFrTx-5DWjAUO-Lt-ZPcMAZhn2DWdUr9d=qXG-TsKBpr+A@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <d355ac11-21d6-e8f7-d03f-65c55e10aea2@intel.com>
Date:   Wed, 11 Mar 2020 16:43:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrTx-5DWjAUO-Lt-ZPcMAZhn2DWdUr9d=qXG-TsKBpr+A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/03/20 4:06 pm, Ulf Hansson wrote:
> On Wed, 11 Mar 2020 at 11:00, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> On 11/03/20 10:57 am, Ulf Hansson wrote:
>>> On Wed, 11 Mar 2020 at 03:13, Chaotian Jing <chaotian.jing@mediatek.com> wrote:
>>>>
>>>> On Tue, 2020-03-10 at 16:41 +0100, Ulf Hansson wrote:
>>>>> On Tue, 10 Mar 2020 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>>>>>
>>>>>> On 10/03/20 11:05 am, Ulf Hansson wrote:
>>>>>>> On Tue, 10 Mar 2020 at 05:28, Seo, Kyungmin <kyungmin.seo@intel.com> wrote:
>>>>>>>>
>>>>>>>> I read the link and patch of Chaotian Jing.
>>>>>>>> I also point out what Chaotian said.
>>>>>>>> Most host controllers have DLL tuning values for each mode. When host controller is set as HS400 mode with 50MHz clock, host controller uses DLL value which is tuned with 200MHz clock.
>>>>>>>>
>>>>>>>> If DLL value in HS400 mode doesn't have the pass range in HS mode, command transfer failing may fail.
>>>>>>>> In order to make robust sdhci driver, I think the patch needs to be considered.
>>>>>>>
>>>>>>> I have, but I am not picking it up in its current form.
>>>>>>>
>>>>>>>> Of course, CMD6 with HS400 mode and 200MHz clock should not cause any problem because it's correct configuration.
>>>>>>>
>>>>>>> Yes, but not for all cases, as I said in my reply in those email-threads.
>>>>>>>
>>>>>>> What I had in mind, is that I I think we should inform
>>>>>>> mmc_hs400_to_hs200() about under what situation it's getting called.
>>>>>>> Depending on that, we should either decrease the clock rate before or
>>>>>>> after we send the CMD6.
>>>>>>>
>>>>>>> Would that work for your case?
>>>>>>
>>>>>> Ulf, would you consider a new call back e.g.
>>>>>
>>>>> That could work, but I am not sure what's best, honestly.
>>>>>
>>>>> The problem may be generic or it could be specific to some host
>>>>> controller? I think we need to answer that question first.
>>>>>
>>>>> What do you think?
>>>>>
>>>>> Br
>>>>> Uffe
>>>>>
>>>> When start to send CMD6 to switch to HS mode, both Host & eMMC device
>>>> are working on HS400 mode, so the timing used is MUST at HS400 mode and
>>>> the clock MUST keep at current clock(usually 200Mhz). after received the
>>>> response of CMD6, Never use CMD13 to polling card status for timing
>>>> switch. if host has ops->card_busy() or caps WAIT_WHILE_BUSY, then use
>>>> it, if not,just do mmc_delay() for specific time.
>>>
>>> The CMD13 is currently not used when polling, because we set the
>>> send_status parameter to false in the calls to __mmc_switch(). So this
>>> should already be covered, according to your suggestions. Right?
>>>
>>> When it comes to keeping the clock rate as is, before sending the CMD6
>>> - I fully agree that it's a good idea when doing a periodic retuning.
>>> As you would expect things to work as they are.
>>>
>>> The problem is, when you have received a CRC error and the re-tuning
>>> is being triggered because of that. In that case it may be a better
>>> option to decrease the clock rate, at least that is what I recall
>>> Adrian needs for his cases. Adrian?
>>
>> It seems hardware supports HS400 only at the expected 200MHz frequency.
> 
> Yes, that's my understanding as well.
> 
>> The assumption then is that the command will be seen by the card but the
>> response may have a CRC error.  So we would need to ignore CRC errors, but
>> it would also be worth waiting the timeout if the card is still busy whether
>> or not there is an error.
> 
> Alright, so you're saying that keeping the clock rate to HS400 speed
> (decrease it after CMD6) could be fine, if we implement the above
> instead?

Yes, but I would like to try adding a simple retry at the lower frequency as
well and see how well that works.  I will test that tomorrow.

> 
>>
>> The only way to mitigate errors then is to increase the number of retries.
> 
> We already use MMC_CMD_RETRIES for CMD6. Is that sufficient you think
> (again assuming we implement to allow CRC errors for these CMD6
> commands)?

That is only 3.  If the CRC errors are random, then trying more times might
help.

> 
> Or are you suggesting we may need a re-try of the hole re-tune thing?
> Maybe a better option is then to simply bail out and do full re-init
> of the card?

The block driver will try that at some point.  I will see if I can test how
well that works in this case.

> 
>>
>>>
>>> What will happen when you receive a CRC error and there is re-tuning
>>> triggered, is that something you have seen happening on you boards?
>>>
>>>>
>>>> the next step is that call mmc_set_ios() to set current timing to HS
>>>> mode and clock to 50Mhz to let Host driver that eMMC device has been
>>>> switched to HS mode and Host can switch to HS mode at 50Mhz(may apply
>>>> parameters for this low speed).
>>>
>>> Yep, makes sense.
>>>
>>>>>>
>>>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>>>> index c2abd417a84a..1bc18fe2632f 100644
>>>>>> --- a/drivers/mmc/core/mmc.c
>>>>>> +++ b/drivers/mmc/core/mmc.c
>>>>>> @@ -1237,7 +1237,10 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>>>>>
>>>>>>         /* Reduce frequency to HS */
>>>>>>         max_dtr = card->ext_csd.hs_max_dtr;
>>>>>> -       mmc_set_clock(host, max_dtr);
>>>>>> +       if (host->ops->hs400_to_hs200_prep)
>>>>>> +               host->ops->hs400_to_hs200_prep(host, max_dtr);
>>>>>> +       else
>>>>>> +               mmc_set_clock(host, max_dtr);
>>>>>>
>>>>>>         /* Switch HS400 to HS DDR */
>>>>>>         val = EXT_CSD_TIMING_HS;
>>>>>>
>>>>>>
> 
> Kind regards
> Uffe
> 

