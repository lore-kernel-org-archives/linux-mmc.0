From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [RFC PATCH 1/1] dw_mmc: add quirk about using only one slot
Date: Fri, 25 Mar 2011 19:26:04 +0900
Message-ID: <4D8C6DBC.9060003@samsung.com>
References: <4D8C2F83.4040403@samsung.com>
 <AANLkTimEsgDF+4j0d_UccyqjsbgriFW4AqBfmE5rPrRH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52741 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934109Ab1CYK1E (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Mar 2011 06:27:04 -0400
Received: from epmmp2 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LIL004WIZP2EE60@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 19:27:02 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LIL00582ZP2Z3@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 25 Mar 2011 19:27:02 +0900 (KST)
In-reply-to: <AANLkTimEsgDF+4j0d_UccyqjsbgriFW4AqBfmE5rPrRH@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>


Hi Will

Will Newton wrote:
> On Fri, Mar 25, 2011 at 6:00 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> If assume only using one slot, i think that dw_mci_queue_request() need not.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com
>> ---
>>  drivers/mmc/host/dw_mmc.c  |    9 +++++++--
>>  include/linux/mmc/dw_mmc.h |    3 ++-
>>  2 files changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 882d004..e3f26ea 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -673,8 +673,13 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
>>                return;
>>        }
>>
>> -       /* We don't support multiple blocks of weird lengths. */
>> -       dw_mci_queue_request(host, slot, mrq);
>> +       if (host->quirks & DW_MCI_QUIRK_FORCE_ONE_SLOT) {
> 
> Do we really need a quirk for this? Why not use host->num_slots

Yes, you'r right. if using this patch, can use host->num_slots.

> 
>> +               slot->mrq = mrq;
>> +               host->state = STATE_SENDING_CMD;
> 
> I don't think it is safe to manipulate these structures without taking
> the host->lock. If we are to do this then I think I would like to know
> why (e.g. do we have performance numbers to support this change) and
> some analysis of what is protected by host->lock and which functions
> need the lock to be held. For example I do not think it is safe to
> call dw_mci_start_request without taking the lock.
> 

I know this patch didn't increase the performance.
BUt If we want to know some analysis..I should analysis what protected by host->lock.
Did you analysis what protect by host->lock?

>> +               dw_mci_start_request(host, slot);
>> +       } else
>> +               /* We don't support multiple blocks of weird lengths. */
> 
> This comment is obsolete I think and can be removed.

Anyway, Thanks for your comment.
 

Regards,
Jaehoon Chung
