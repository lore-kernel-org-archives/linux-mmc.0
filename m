From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/4] mmc: dw_mmc: mmc_test related fixes
Date: Thu, 30 Jun 2011 14:26:48 +0900
Message-ID: <4E0C0918.1080006@samsung.com>
References: <4E0AE1FC.3070201@imgtec.com>
 <BANLkTimAwoDybg8TdbMa6rjFY9H9vzGnHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36409 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753153Ab1F3F0u (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Jun 2011 01:26:50 -0400
In-reply-to: <BANLkTimAwoDybg8TdbMa6rjFY9H9vzGnHg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: James Hogan <james.hogan@imgtec.com>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

Tested-by: Jaehoon Chung <jh80.chung@samsung.com>

Will Newton wrote:
> On Wed, Jun 29, 2011 at 9:27 AM, James Hogan <james.hogan@imgtec.com> wrote:
>> More improvements and fixes for the Synopsys DesignWare MCI driver so
>> that it passes the mmc_test suite:
>>
>> [PATCH 1/4] mmc: dw_mmc: fix stop when fallen back to PIO
>>        Fixes a hang after an error/timeout in PIO mode.
>> [PATCH 2/4] mmc: dw_mmc: remove unnecessary error messages
>>        Removes some dev_err's since an errno is sufficient.
>> [PATCH 3/4] mmc: dw_mmc: handle "no CRC status" error
>>        Fixes "Correct xfer_size at write" tests.
>> [PATCH 4/4] mmc: dw_mmc: reset FIFO after an error
>>        Fixes modified "Correct xfer_size at write" tests (3 blocks
>>        instead of 2).
>>
>>  drivers/mmc/host/dw_mmc.c  |   41 +++++++++++++++++++++++++++++++----------
>>  include/linux/mmc/dw_mmc.h |    2 ++
>>  2 files changed, 33 insertions(+), 10 deletions(-)
> 
> These all look good to me.
> 
> Acked-by: Will Newton <will.newton@imgtec.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

