From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3] mmc: sleep notification
Date: Mon, 15 Jun 2015 10:23:46 +0200
Message-ID: <CAPDyKFoZuNoYB1KA4bt64+qoeEmjioW9qCnwkhYAnnSD4jMxag@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE64FAAD701@SACMBXIP02.sdcorp.global.sandisk.com>
	<CAPDyKFoPqwDC_w1QTe7zQtJfH_5m2Gp_5uewJKy=x_LeaFqYhA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343C1F6EA@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:35769 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754035AbbFOIXr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Jun 2015 04:23:47 -0400
Received: by qkhq76 with SMTP id q76so50113492qkh.2
        for <linux-mmc@vger.kernel.org>; Mon, 15 Jun 2015 01:23:46 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53343C1F6EA@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 8 June 2015 at 15:17, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Ulf,
>
> [...]
>
>>
>> One of my comments for v2, was that I think you should remove all code which
>> was related to HPI to interrupt sleep notification from the runtime PM resume
>> path. Instead I wanted you to add that functionality as separate patch based on
>> top of this patch.
>>
>> You haven't done that in v3, why?
>
> The sleep_notify call was moved to suspend() per your recommendation.
> As far as I understand, no new requests should be sent during mmc_suspend() process,
> thus HPI support is not needed anymore.
> Is this the correct assumption?

Yes.

I don't think you need mmc_card_set_sleep_notify() and the
corresponding new MMC_STATE_SLEEP_NOTIFY , mmc_device_prg_state(),
etc.

Overall, I think this patch could be simplified yet another step.

> The only case where HPI is used in this patch - is during sleep_notify timeout error.

Why?

One final question, I noticed that you have removed the check for
MMC_CAP2_FULL_PWR_CYCLE in the _mmc_suspend() function, why?

Kind regards
Uffe
