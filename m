Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415DFC433E6
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 10:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19D564E13
	for <linux-mmc@archiver.kernel.org>; Mon,  1 Mar 2021 10:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234627AbhCAKlM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 1 Mar 2021 05:41:12 -0500
Received: from mga18.intel.com ([134.134.136.126]:57425 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234595AbhCAKkj (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 1 Mar 2021 05:40:39 -0500
IronPort-SDR: gsBYChLr/UzojokRrKEQyQGunhPtZotDrmfusAFxcf1D1sgt/rZUyXQToUDqTgsQsXbZ+CQHCS
 YrozqnkA6hmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9909"; a="174057717"
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="174057717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2021 02:39:54 -0800
IronPort-SDR: vtgdJqbvL0QZTSaHa3bM1m0FC8lJX7Rw9MpAKlINtSTWE1Z1hj9uRfiJy9YXLTUFiOgEvyfP/Y
 jfUPVpoWrRlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,215,1610438400"; 
   d="scan'208";a="585452919"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.76]) ([10.237.72.76])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2021 02:39:52 -0800
Subject: Re: [PATCH] mmc: Try power cycling card if command request times out
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <marten.lindahl@axis.com>
Cc:     kernel@axis.com,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210216224252.22187-1-marten.lindahl@axis.com>
 <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <8a6bf147-d449-d32e-1969-ef9463859b9b@intel.com>
Date:   Mon, 1 Mar 2021 12:40:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoASx=U8b1Oqtuo6ikiM=gXfL2x1Gsz=rfAn9zxP0y_iA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 1/03/21 10:50 am, Ulf Hansson wrote:
> + Adrian
> 
> On Tue, 16 Feb 2021 at 23:43, Mårten Lindahl <marten.lindahl@axis.com> wrote:
>>
>> Sometimes SD cards that has been run for a long time enters a state
>> where it cannot by itself be recovered, but needs a power cycle to be
>> operational again. Card status analysis has indicated that the card can
>> end up in a state where all external commands are ignored by the card
>> since it is halted by data timeouts.
>>
>> If the card has been heavily used for a long time it can be weared out,
>> and should typically be replaced. But on some tests, it shows that the
>> card can still be functional after a power cycle, but as it requires an
>> operator to do it, the card can remain in a non-operational state for a
>> long time until the problem has been observed by the operator.
>>
>> This patch adds function to power cycle the card in case it does not
>> respond to a command, and then resend the command if the power cycle
>> was successful. This procedure will be tested 1 time before giving up,
>> and resuming host operation as normal.
> 
> I assume the context above is all about the ioctl interface?
> 
> So, when the card enters this non functional state, have you tried
> just reading a block through the regular I/O interface. Does it
> trigger a power cycle of the card - and then makes it functional
> again?
> 
>>
>> Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
>> ---
>> Please note: This might not be the way we want to handle these cases,
>> but at least it lets us start the discussion. In which cases should the
>> mmc framework deal with error messages like ETIMEDOUT, and in which
>> cases should it be handled by userspace?
>> The mmc framework tries to recover a failed block request
>> (mmc_blk_mq_rw_recovery) which may end up in a HW reset of the card.
>> Would it be an idea to act in a similar way when an ioctl times out?
> 
> Maybe, it's a good idea to allow the similar reset for ioctls as we do
> for regular I/O requests. My concern with this though, is that we
> might allow user space to trigger a HW resets a bit too easily - and
> that could damage the card.
> 
> Did you consider this?
> 
>>
>>  drivers/mmc/core/block.c | 20 ++++++++++++++++++--
>>  1 file changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
>> index 42e27a298218..d007b2af64d6 100644
>> --- a/drivers/mmc/core/block.c
>> +++ b/drivers/mmc/core/block.c
>> @@ -976,6 +976,7 @@ static inline void mmc_blk_reset_success(struct mmc_blk_data *md, int type)
>>   */
>>  static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>>  {
>> +       int type = rq_data_dir(req) == READ ? MMC_BLK_READ : MMC_BLK_WRITE;
>>         struct mmc_queue_req *mq_rq;
>>         struct mmc_card *card = mq->card;
>>         struct mmc_blk_data *md = mq->blkdata;
>> @@ -983,7 +984,7 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>>         bool rpmb_ioctl;
>>         u8 **ext_csd;
>>         u32 status;
>> -       int ret;
>> +       int ret, retry = 1;
>>         int i;
>>
>>         mq_rq = req_to_mmc_queue_req(req);
>> @@ -994,9 +995,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
>>         case MMC_DRV_OP_IOCTL_RPMB:

SD cards do not have RPMB.  Did you mean eMMC?


>>                 idata = mq_rq->drv_op_data;
>>                 for (i = 0, ret = 0; i < mq_rq->ioc_count; i++) {
>> +cmd_do:
>>                         ret = __mmc_blk_ioctl_cmd(card, md, idata[i]);
>> -                       if (ret)
>> +                       if (ret == -ETIMEDOUT) {
>> +                               dev_warn(mmc_dev(card->host),
>> +                                        "error %d sending command\n", ret);
>> +cmd_reset:
>> +                               mmc_blk_reset_success(md, type);

mmc_blk_reset_success() is called upon success, not failure.  The reset will
not be attempted twice in a row, for a given type, without a "success" in
between.

>> +                               if (retry--) {
>> +                                       dev_warn(mmc_dev(card->host),
>> +                                                "power cycling card\n");
>> +                                       if (mmc_blk_reset
>> +                                           (md, card->host, type))
>> +                                               goto cmd_reset;
>> +                                       mmc_blk_reset_success(md, type);
>> +                                       goto cmd_do;
>> +                               }
>>                                 break;
>> +                       }
>>                 }
>>                 /* Always switch back to main area after RPMB access */
>>                 if (rpmb_ioctl)
>> --
>> 2.11.0
>>
> 
> Kind regards
> Uffe
> 

