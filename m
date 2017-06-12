From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/6] mmc: dw_mmc: remove the multiple slot concept
Date: Tue, 13 Jun 2017 07:13:49 +0900
Message-ID: <cf875307-a21f-216b-9244-b34d205b6347@samsung.com>
References: <CGME20170605044137epcas1p4e7e2b74aa17ea7d7137da7b677bfb282@epcas1p4.samsung.com>
        <20170605044135.18304-1-jh80.chung@samsung.com>
        <CAPDyKFqj7Y59_4buqxc0iG9gp=H_urSEipkF7zDk8uM8DPVbXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:10359 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752224AbdFLWNx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jun 2017 18:13:53 -0400
In-reply-to: <CAPDyKFqj7Y59_4buqxc0iG9gp=H_urSEipkF7zDk8uM8DPVbXw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

On 06/08/2017 10:52 PM, Ulf Hansson wrote:
> On 5 June 2017 at 06:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> DWMMC IP is provided the multiple slot.
>> It's only used the one slot per an IP in mmc subsystem.
>> If we can consider only one slot, then dwmmc controller codes can be more simpler than now.
>> This patchset is the first step to remove the multiple slot.
>>
>> In future work,
>>    - Remove the entire slot structure.
>>    - Move to slot's members into dwmci host.
>>
>> Jaehoon Chung (6):
>>   mmc: dw_mmc: deprecated the "num-slots" property
>>   mmc: dw_mmc: remove the loop about finding slots
>>   mmc: dw_mmc: change the array of slots
>>   mmc: dw_mmc: remove the 'id' arguments about functions relevant to
>>     slot
>>   mmc: dw_mmc: use the 'slot' instead of 'cur_slot'
>>   mmc: dw_mmc: remove the unnecessary slot variable
>>
>>  drivers/mmc/host/dw_mmc-exynos.c |   4 +-
>>  drivers/mmc/host/dw_mmc.c        | 165 +++++++++++++--------------------------
>>  drivers/mmc/host/dw_mmc.h        |   7 +-
>>  3 files changed, 57 insertions(+), 119 deletions(-)
>>
>> --
>> 2.10.2
>>
> 
> This looks good to me, however I couldn't apply them cleanly on my next branch.
> 
> Perhaps you have something additional for dw_mmc in you local tree?
> Then never mind, I can pick these via your regular pull request.

Will send PR..Thanks!

Best Regards,
Jaehoon Chung

> 
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

