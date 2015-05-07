From: Meng Wang <meng@tupleapes.com>
Subject: Re: execution order of packed command in eMMC
Date: Thu, 7 May 2015 10:38:00 -0400
Message-ID: <CAP3VVE0+qkr+4wDQfRaVMdSL_Q0JkiE2FSyMRyg=tBA66Xp3-Q@mail.gmail.com>
References: <CAP3VVE1idbQ2fLw1wpEBnuJiprGa0L46OuzR_Ng6zc_yxyfcRg@mail.gmail.com>
	<554B0DE8.5000806@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:36078 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbbEGOiB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 7 May 2015 10:38:01 -0400
Received: by oift201 with SMTP id t201so34937035oif.3
        for <linux-mmc@vger.kernel.org>; Thu, 07 May 2015 07:38:00 -0700 (PDT)
In-Reply-To: <554B0DE8.5000806@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Konstantin Dorfman <kdorfman@codeaurora.org>
Cc: linux-mmc@vger.kernel.org

On Thu, May 7, 2015 at 3:02 AM, Konstantin Dorfman
<kdorfman@codeaurora.org> wrote:
> Hello,
>
> On 05/06/2015 09:16 PM, Meng Wang wrote:
>>
>> sequence that they are listed in the packed command header. So when
>> error happens, I can safely assert it is completed for the first
>> PACKED_FAILURE_INDEX commands in one pack. Is my understanding
>> correct?
>
>
> Yes, mmc_blk_end_packed_req() will complete packed requests till idx_failure
> index.
>
> From mmc_blk_issue_rw_rq():
>
> case MMC_BLK_PARTIAL:
>                         /*
>                          * A block was successfully transferred.
>                          */
>                         mmc_blk_reset_success(md, type);
>
>                         if (mmc_packed_cmd(mq_rq->cmd_type)) {
>                                 ret = mmc_blk_end_packed_req(mq_rq);
>                                 break;
>                         } else {
>                                 ret = blk_end_request(req, 0,
>                                                 brq->data.bytes_xfered);
>                         }
>
> Then, reminder will be re-issued with mmc_start_req():
>
> ...
>                 if (ret) {
>                         if (mmc_packed_cmd(mq_rq->cmd_type)) {
>                                 if (!mq_rq->packed->retries)
>                                         goto cmd_abort;
>                                 mmc_blk_packed_hdr_wrq_prep(mq_rq, card,
> mq);
>                                 mmc_start_req(card->host,
>                                               &mq_rq->mmc_active, NULL);
>
>
Thanks.

> --
> Qualcomm Israel, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
