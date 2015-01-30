From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: Resolve BKOPS compatability issue
Date: Fri, 30 Jan 2015 11:25:07 +0100
Message-ID: <CAPDyKFrR2jne1C=R2phfesLMuZDhARiQgZxvkAcMHkMVrGXaiA@mail.gmail.com>
References: <1422521383-11436-1-git-send-email-alexey.skidanov@sandisk.com>
	<54CB3237.2050207@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:37115 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760298AbbA3KZI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 30 Jan 2015 05:25:08 -0500
Received: by mail-qc0-f178.google.com with SMTP id b13so19796292qcw.9
        for <linux-mmc@vger.kernel.org>; Fri, 30 Jan 2015 02:25:07 -0800 (PST)
In-Reply-To: <54CB3237.2050207@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Alexey Skidanov <alexey.skidanov@sandisk.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>

On 30 January 2015 at 08:26, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> Hi, Alexey.
>
> On 01/29/2015 05:49 PM, Alexey Skidanov wrote:
>> This patch is coming to fix compatibility issue of BKOPS_EN  field of EXT_CSD.
>> In eMMC-5.1, BKOPS_EN was changed, and now it has two operational bits:
>> Bit 0 - MANUAL_EN
>> Bit 1 - AUTO_EN
>> In previous eMMC revisions, only Bit 0 was supported.
>
> If "manual enable" is the same functionality with previous enable,
> I think it doesn't need to change the name..
> Just checking whether enable or not with Mask bit?
>
> If need to add the auto enable, only add the bkops_auto_en in future.
> This is just my preference..and i don't read the spec since i don't have eMMC5.1 spec.
>
> If manual-enable is difference with previous enable, how about using bkops-manual-en?

According to information I have got around the eMMC 5.1 spec, the old
value of MAN_EN will remain. That also means that bit will remain as
one time programmable.

The new AUTO_EN bit, will be multiple writeable with value kept after
power failure. But more importantly, the card seems to expect the host
to disable AUTO_EN before power failure. In other words we need to
disable AUTO_EN (if set) before entering system PM state an cutting
power to the card.

So, yes, we will have to deal with AUTO_EN sooner or later, thus I am
kind of happy Alexey's patch, as is.

Kind regards
Uffe
