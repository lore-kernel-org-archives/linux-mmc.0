From: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: Re: [Linux-kernel] [PATCH mmc 0/4] Cleanup fixes for tmio_mmc
Date: Tue, 05 May 2015 11:37:24 +0300
Message-ID: <55488144.1000808@codethink.co.uk>
References: <1430089220.5802.17.camel@xylophone.i.decadent.org.uk> <CAPDyKFrzTpU2JcOm70W3uxN-fvU+BY0UMSQ_9R_-iC=7BACtRg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ducie-dc1.codethink.co.uk ([185.25.241.215]:34394 "EHLO
	ducie-dc1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753332AbbEEIh2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:37:28 -0400
In-Reply-To: <CAPDyKFrzTpU2JcOm70W3uxN-fvU+BY0UMSQ_9R_-iC=7BACtRg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Ian Molton <ian@mnementh.co.uk>, linux-mmc <linux-mmc@vger.kernel.org>

On 05/05/15 11:34, Ulf Hansson wrote:
> On 27 April 2015 at 01:00, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
>> Ian, these are some of your fixes for tmio_mmc that didn't make it
>> upstream yet, plus an update to MAINTAINERS.  Assuming you're still
>> intending to maintain it, please can you ack these?
>>
>> Ben.
>>
>> Ben Hutchings (1):
>>   MAINTAINERS: Update Ian Molton's address for tmio_mmc driver
>>
>> Ian Molton (3):
>>   mmc: TMIO: Ensure MFD cell is disabled on probe error path
>>   mmc: TMIO: Fix I/O mapping leak on error using devm_ioremap()
>>   mmc: TMIO: Use devm_request_irq()
>>
>>  MAINTAINERS                     |    2 +-
>>  drivers/mmc/host/tmio_mmc.c     |   10 ++++++----
>>  drivers/mmc/host/tmio_mmc_pio.c |    5 ++---
>>  3 files changed, 9 insertions(+), 8 deletions(-)
>>
>> --
>> 1.7.10.4
>>
> 
> Thanks, applied.
> 
> I decided to apply patch 4 without Ian's ack, since a prefer a valid
> email address. If Ian no longer are able to maintain this driver,
> let's deal with that separately.

I contacted Ian earlier to mention that this is an issue, however I
believe he is very busy at the moment and may have not had a chance
to ack it.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
