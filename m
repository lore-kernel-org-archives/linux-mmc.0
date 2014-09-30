From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: add new au6601 driver
Date: Tue, 30 Sep 2014 13:00:45 +0200
Message-ID: <CAPDyKFoAzeYjvuP=5W8r7NQjnL9OzWXP=+Y+b_1ZZgWRbUXsZg@mail.gmail.com>
References: <1399543099-31613-1-git-send-email-linux@rempel-privat.de>
	<CAPDyKFoy9DLQe1235suEwEmGSxxriBfuWSyN+ZG14OmUjrrb8w@mail.gmail.com>
	<53B3D562.1030707@rempel-privat.de>
	<CAPDyKFpZVKu-uHwNfXocVb7FbgEN3NxiLHCPR38bSh_zsA4w6Q@mail.gmail.com>
	<542A81EC.40708@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:64452 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750992AbaI3LAq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Sep 2014 07:00:46 -0400
Received: by mail-qc0-f175.google.com with SMTP id w7so217150qcr.6
        for <linux-mmc@vger.kernel.org>; Tue, 30 Sep 2014 04:00:45 -0700 (PDT)
In-Reply-To: <542A81EC.40708@rempel-privat.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Oleksij Rempel <linux@rempel-privat.de>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 30 September 2014 12:11, Oleksij Rempel <linux@rempel-privat.de> wrote:
> Am 09.07.2014 um 14:52 schrieb Ulf Hansson:
>> [snip]
>>
>>>>
>>>> I am just a bit curious, does this controller support hardware busy
>>>> detection on DAT1 line while waiting for command completion?
>>>
>>> Do you mean AU6601_REG_BUS_STATUS?
>>> See at the beginning of patch.
>>
>> While reviewing the code, it seems like the controller are handling
>> hardware busy detection on DAT1. On the other hand you don't enable
>> MMC_CAP_WAIT_WHILE_BUSY, shouldn't you be doing that?
>
> Hi Ulf,
>
> what is better way to use sg with dma? This controller support only
> 0x4000 alight addresses. It is possible to solve it per driver basis,
> but i have seen already more then one driver which need it. Should it be
> done in  mmc block code? Any other suggestions?

I don't quite follow. Does your DMA controller put constraints on
buffer alignment/length or is it the mmc controller?

I am aware of that drivers may have special treatments of buffer
alignment/length to be able to handle some corner cases. And yes we
don't have a common interface in the mmc core to handle that. I am not
sure how that could be done? Do you have any suggestions?

Kind regards
Uffe
