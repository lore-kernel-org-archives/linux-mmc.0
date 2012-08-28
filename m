From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 0/2] mmc: core: pre-patch for next eMMC version
Date: Tue, 28 Aug 2012 13:33:05 +0900
Message-ID: <503C4A01.2030200@samsung.com>
References: <5036C96A.7070300@samsung.com>
 <CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:48950 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750876Ab2H1EdX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Aug 2012 00:33:23 -0400
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0M9G00KGH7B6H6L0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 13:33:08 +0900 (KST)
Received: from [10.90.51.55] by mmp1.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTPA id <0M9G0077K7B8YL70@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 28 Aug 2012 13:33:08 +0900 (KST)
In-reply-to: <CAPDyKFqJynoS5d3EmnRi4CxmUyOMYBRzy2spDgUTfT=7+0Xg6Q@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

Hi Ulf,

This patch is to support eMMC5.0.(already discussing on eMMC5.0.)
Revision value is defined the 0x7 into ext_csd register.(in eMMC5.0's case)

And case of Quirks is preparation patch to prevent the problem that should exist.
That Quirks can also use for backward compatibility.
(if card is greater version than eMMC4.5 and need to use only eMMC4.5 feature?
 then can use quirks and known_rev.)

Best Regards,
Jaehoon Chung


On 08/27/2012 09:04 PM, Ulf Hansson wrote:
> Hi Jaehoon,
> 
> I think this patches as of now does not really make sense. These types
> of devices is far from reaching the market and just saying that a
> later revision in the ext_csd is supported is too simple. Moreover,
> why shall we add a quirk for a problem that does not even exist.
> 
> Kind regards
> Ulf Hansson
> 
> On 24 August 2012 02:23, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> eMMC card revision have increased more faster than before.
>> We need to prepare the next eMMC revision(eMMCx.0).
>> Its revision is 0x7. (eMMC4.5 is 0x6 - can get the information at ext_csd register)
>>
>> Jaehoon Chung (2):
>>   mmc: core: prepare the next version of eMMC card
>>   mmc: core: add the quirk for broken revision
>>
>>  drivers/mmc/core/mmc.c     |   15 ++++++++++-----
>>  include/linux/mmc/card.h   |    1 +
>>  include/linux/mmc/host.h   |    1 +
>>  5 files changed, 17 insertions(+), 5 deletions(-)
>>
>> --
>> 1.7.4.1
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

