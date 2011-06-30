From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: mmc_test related fixes
Date: Thu, 30 Jun 2011 09:01:22 +0100
Message-ID: <4E0C2D52.80303@imgtec.com>
References: <4E0AE1FC.3070201@imgtec.com> <BANLkTimAwoDybg8TdbMa6rjFY9H9vzGnHg@mail.gmail.com> <4E0C0918.1080006@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:36887 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758620Ab1F3IB2 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Jun 2011 04:01:28 -0400
In-Reply-To: <4E0C0918.1080006@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Will Newton <will.newton@gmail.com>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On 06/30/2011 06:26 AM, Jaehoon Chung wrote:
> Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks for testing

Cheers
James

> 
> Will Newton wrote:
>> On Wed, Jun 29, 2011 at 9:27 AM, James Hogan <james.hogan@imgtec.com> wrote:
>>> More improvements and fixes for the Synopsys DesignWare MCI driver so
>>> that it passes the mmc_test suite:
>>>
>>> [PATCH 1/4] mmc: dw_mmc: fix stop when fallen back to PIO
>>>        Fixes a hang after an error/timeout in PIO mode.
>>> [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
>>>        Removes some dev_err's since an errno is sufficient.
>>> [PATCH 3/4] mmc: dw_mmc: handle "no CRC status" error
>>>        Fixes "Correct xfer_size at write" tests.
>>> [PATCH 4/4] mmc: dw_mmc: reset FIFO after an error
>>>        Fixes modified "Correct xfer_size at write" tests (3 blocks
>>>        instead of 2).
>>>
>>>  drivers/mmc/host/dw_mmc.c  |   41 +++++++++++++++++++++++++++++++----------
>>>  include/linux/mmc/dw_mmc.h |    2 ++
>>>  2 files changed, 33 insertions(+), 10 deletions(-)
>>
>> These all look good to me.
>>
>> Acked-by: Will Newton <will.newton@imgtec.com>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 

