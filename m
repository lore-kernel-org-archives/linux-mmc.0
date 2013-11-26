From: "Ray Jui" <rjui@broadcom.com>
Subject: Re: [PATCH v2] mmc: fix host release issue after discard
 operation
Date: Tue, 26 Nov 2013 14:35:52 -0800
Message-ID: <52952248.6060700@broadcom.com>
References: <1382810624-17659-1-git-send-email-rjui@broadcom.com>
 <87fvqig6nl.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mms1.broadcom.com ([216.31.210.17]:4366 "EHLO mms1.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758190Ab3KZWgJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 26 Nov 2013 17:36:09 -0500
In-Reply-To: <87fvqig6nl.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On 11/26/2013 2:06 PM, Chris Ball wrote:
> Hi Ray,
>
> On Sat, Oct 26 2013, Ray Jui wrote:
>> Under function mmc_blk_issue_rq, after an MMC discard operation,
>> the MMC request data structure may be freed in memory. Later in
>> the same function, the check of req->cmd_flags & MMC_REQ_SPECIAL_MASK
>> is dangerous and invalid. It causes the MMC host not to be released
>> when it should
>>
>> This patch fixes the issue by marking the special request down before
>> the discard/flush operation
>>
>> Reported by: Harold (SoonYeal) Yang <haroldsy@broadcom.com>
>> Signed-off-by: Ray Jui <rjui@broadcom.com>
>> Reviewed-by: Seungwon Jeon <tgih.jun@samsung.com>
>
> Thanks, pushed to mmc-next for 3.14 and -stable.
>
> - Chris.
>
Great!

Thanks,

Ray

