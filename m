From: Cong Wang <amwang@redhat.com>
Subject: Re: [PATCH 20/62] mmc: remove the second argument of k[un]map_atomic()
Date: Fri, 02 Dec 2011 10:10:49 +0800
Message-ID: <4ED833A9.8040707@redhat.com>
References: <1322371662-26166-1-git-send-email-amwang@redhat.com>	<1322371662-26166-21-git-send-email-amwang@redhat.com> <87vcq0jfin.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:28245 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755776Ab1LBCN0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Dec 2011 21:13:26 -0500
In-Reply-To: <87vcq0jfin.fsf@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, Nicolas Ferre <nicolas.ferre@atmel.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Alex Dubov <oakad@yahoo.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org

=E4=BA=8E 2011=E5=B9=B412=E6=9C=8802=E6=97=A5 02:47, Chris Ball =E5=86=99=
=E9=81=93:
> Hi,
>
> On Sun, Nov 27 2011, Cong Wang wrote:
>> Signed-off-by: Cong Wang<amwang@redhat.com>
>> ---
>>   drivers/mmc/host/at91_mci.c |    8 ++++----
>>   drivers/mmc/host/msm_sdcc.c |    6 +++---
>>   drivers/mmc/host/sdhci.c    |    4 ++--
>>   drivers/mmc/host/tifm_sd.c  |   16 ++++++++--------
>>   drivers/mmc/host/tmio_mmc.c |    1 -
>>   drivers/mmc/host/tmio_mmc.h |    4 ++--
>>   6 files changed, 19 insertions(+), 20 deletions(-)
>
> Looks good, thanks, pushed to mmc-next for 3.3.
>

Hello, Chris,

I am still not sure if Andrew wants to take all the patches together. :=
-/

But there should be no problem if you take this alone, after re-reading
the original code, it can still compile even without 01/62.

/*
  * Make both: kmap_atomic(page, idx) and kmap_atomic(page) work.
  */
#define kmap_atomic(page, args...) __kmap_atomic(page)

Regards.
