Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF90EC433DB
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 07:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA3164E49
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 07:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhCOHLo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 03:11:44 -0400
Received: from mga05.intel.com ([192.55.52.43]:64137 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhCOHLV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 15 Mar 2021 03:11:21 -0400
IronPort-SDR: 0miSnHwvMNzICocwgMlzjpOX07QWpCV8X2t7lTamOduTv8h7IMbHsD7z+wMEZlOt5AZgA6IM58
 RYJiHdujekow==
X-IronPort-AV: E=McAfee;i="6000,8403,9923"; a="274088569"
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="274088569"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2021 00:11:16 -0700
IronPort-SDR: hk6d821A7mYPCVvHFIN+xmMlUAkXp1U61h+sUoll09wKa650Hrrz7P35rnDfgM2fXxgUS/AsOR
 S95dCw95a+dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,249,1610438400"; 
   d="scan'208";a="590234443"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2021 00:11:14 -0700
Subject: Re: [EXT] Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
To:     "Luca Porzio (lporzio)" <lporzio@micron.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Luca Porzio <porzio@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "Zhan Liu (zliua)" <zliua@micron.com>
References: <20210215003249.GA12303@lupo-laptop>
 <CAPDyKFou4VdtUV66-c8y_tV9g9oaUCa8nphsLW6gH0_bi7y_dA@mail.gmail.com>
 <d9d7a7c7-dd26-8e07-e510-7e2493bff882@intel.com>
 <BN7PR08MB4753E077C122538BE9C116FCDC6D9@BN7PR08MB4753.namprd08.prod.outlook.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <0b4aea34-4759-14cf-cba3-3d85dbb3270e@intel.com>
Date:   Mon, 15 Mar 2021 09:11:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB4753E077C122538BE9C116FCDC6D9@BN7PR08MB4753.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 15/03/21 12:33 am, Luca Porzio (lporzio) wrote:
> Micron Confidential
> 
> 
> 
>> -----Original Message-----
>> From: Adrian Hunter <adrian.hunter@intel.com>
>> Sent: Wednesday, March 10, 2021 9:54 AM
>> To: Ulf Hansson <ulf.hansson@linaro.org>; Luca Porzio <porzio@gmail.com>
>> Cc: linux-mmc@vger.kernel.org; Zhan Liu (zliua) <zliua@micron.com>; Luca
>> Porzio (lporzio) <lporzio@micron.com>
>> Subject: [EXT] Re: [RFC PATCH 2/2] Make cmdq_en attribute writeable
>>
>> CAUTION: EXTERNAL EMAIL. Do not click links or open attachments unless
>> you recognize the sender and were expecting this message.
>>
>>
>> On 2/03/21 12:46 pm, Ulf Hansson wrote:
>>> + Adrian
>>>
>>> On Mon, 15 Feb 2021 at 01:33, Luca Porzio <porzio@gmail.com> wrote:
>>>>
>>>> cmdq_en attribute in sysfs now can now be written.
>>>> When 0 is written:
>>>>   CMDQ is disabled and kept disabled across device reboots.
>>>> When 1 is written:
>>>>   CMDQ mode is instantly reneabled (if supported).
>>>>
>>>> Signed-off-by: Luca Porzio <lporzio@micron.com>
>>>> Signed-off-by: Zhan Liu <zliua@micron.com>
>>>
>>> Luca, thanks for your patch! I am about to start to review this.
>>>
>>> I have also looped in Adrian to get his opinions.
>>>
>>> Get back to you soon!
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> ---
>>>>  drivers/mmc/core/mmc.c   | 152 ++++++++++++++++++++++++++++++-
>> --------
>>>>  include/linux/mmc/card.h |   1 +
>>>>  2 files changed, 118 insertions(+), 35 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
>>>> 0d80b72ddde8..5c7d5bac5c00 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -794,7 +794,120 @@ MMC_DEV_ATTR(enhanced_rpmb_supported,
>> "%#x\n",
>>>> MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
>>>> MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);  MMC_DEV_ATTR(rca,
>>>> "0x%04x\n", card->rca); -MMC_DEV_ATTR(cmdq_en, "%d\n",
>>>> card->ext_csd.cmdq_en);
>>>> +
>>>> +
>>>> +/* Setup command queue mode and CQE if underling hw supports it
>>>> + * and assuming force_disable_cmdq has not been set.
>>>> + */
>>>> +static int mmc_cmdq_setup(struct mmc_host *host, struct mmc_card
>>>> +*card) {
>>>> +       int err;
>>>> +
>>>> +       /* Check HW support */
>>>> +       if (!card->ext_csd.cmdq_support || !(host->caps2 &
>> MMC_CAP2_CQE))
>>>> +               card->force_disable_cmdq = true;
>>>> +
>>>> +       /* Enable/Disable  CMDQ mode */
>>>> +       if (!card->ext_csd.cmdq_en && !card->force_disable_cmdq) {
>>>> +               err = mmc_cmdq_enable(card);
>>>> +               if (err && err != -EBADMSG)
>>>> +                       return err;
>>>> +               if (err) {
>>>> +                       pr_warn("%s: Enabling CMDQ failed\n",
>>>> +                           mmc_hostname(card->host));
>>>> +                       card->ext_csd.cmdq_support = false;
>>>> +                       card->ext_csd.cmdq_depth = 0;
>>>> +               }
>>>> +
>>>> +       } else if (card->ext_csd.cmdq_en && card->force_disable_cmdq) {
>>>> +               err = mmc_cmdq_disable(card);
>>>> +               if (err) {
>>>> +                       pr_warn("%s: Disabling CMDQ failed, error %d\n",
>>>> +                           mmc_hostname(card->host), err);
>>>> +                       err = 0;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       /*
>>>> +        * In some cases (e.g. RPMB or mmc_test), the Command Queue
>> must be
>>>> +        * disabled for a time, so a flag is needed to indicate to re-enable the
>>>> +        * Command Queue.
>>>> +        */
>>>> +       card->reenable_cmdq = card->ext_csd.cmdq_en;
>>>> +
>>>> +       /* Enable/Disable Host CQE */
>>>> +       if (!card->force_disable_cmdq) {
>>>> +
>>>> +               if (host->cqe_ops && !host->cqe_enabled) {
>>>> +                       err = host->cqe_ops->cqe_enable(host, card);
>>>> +                       if (!err) {
>>>> +                               host->cqe_enabled = true;
>>
>> Re-initializing the card is also a recovery path for the block driver.
>> Changing host->cqe_enabled during a recovery reset, creates an unexpected
>> dependency for the block driver.  That should not be necessary, and given
>> that cqhci does memory allocation as part of enabling, it is better not to
>> disable / re-enable if it can be helped.
>>
> 
> Adrian,
> 
> This patch does nothing if the CMDQ maintains the same status (even 
> across reboots). It only take decision if CMDQ state is to be changed, thus
> the occurrence you mention should not happen.

It does if there are errors.

>  
>> From a design point of view, it is really the block driver that should control
>> the use of command queuing rather than expecting it to cope with changes
>> from a lower level.
>>
> 
> I see this is also related with comment from Ulf. I will propose a new patch 
> which addresses this one. Thanks for your comment here.
> 
>>>> +
>>>> +                               if (card->ext_csd.cmdq_en) {
>>>> +                                       pr_info("%s: Command Queue Engine enabled\n",
>>>> +                                           mmc_hostname(host));
>>>> +                               } else {
>>>> +                                       host->hsq_enabled = true;
>>>> +                                       pr_info("%s: Host Software Queue enabled\n",
>>>> +                                           mmc_hostname(host));
>>>> +                               }
>>>> +                       }
>>>> +               }
>>>> +
>>>> +       } else {
>>>> +
>>>> +               if (host->cqe_enabled) {
>>>> +                       host->cqe_ops->cqe_disable(host);
>>>> +                       host->cqe_enabled = false;
>>>> +                       pr_info("%s: Command Queue Engine disabled\n",
>>>> +                           mmc_hostname(host));
>>>> +               }
>>>> +
>>>> +               host->hsq_enabled = false;
>>
>> This looks quite wrong for hsq which is currently not used with cmdq.
>>
> 
> HSQ is really trying to speed up command adoption but in my use case
> (ie. multi cmd list with as low as possible interference from other sources)
> HSQ could mix commands and make problems, so I decided to stay safe 
> and prefer stability against speed of execution.
> 
> Do you agree? Any suggestion?

I just meant, do not break HSQ.
