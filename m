Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3367C433DB
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9123364E2C
	for <linux-mmc@archiver.kernel.org>; Tue,  2 Feb 2021 10:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhBBKcH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:32:07 -0500
Received: from pop31.abv.bg ([194.153.145.221]:45998 "EHLO pop31.abv.bg"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhBBKcG (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 2 Feb 2021 05:32:06 -0500
Received: from smtp.abv.bg (localhost [127.0.0.1])
        by pop31.abv.bg (Postfix) with ESMTP id F215218053FF;
        Tue,  2 Feb 2021 12:29:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=abv.bg; s=smtp-out;
        t=1612261800; bh=gA7vMMdOydq2agNzCYgSJg/VodZ1lLjOsSe3IufOKyk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=kFqVpt/uku8aFZnXF7nntlnsl+v3GBK+HlPRekMXrFSiaiO/sKRvcE0jtxgtuSrvW
         SfIbLvgFjbNlSj8CelNoNBMfPc+sq+HeGKo6U/TKMTxuOnCsURY0TRMIdhhUlD6yi1
         KwNBhp9uZoEDbBmQEnCgwWz1CPOTaKi6kH26lpf8=
X-HELO: [192.168.1.115]
Authentication-Results: smtp.abv.bg; auth=pass (plain) smtp.auth=buboleck@abv.bg
Received: from 46-249-79-198.net1.bg (HELO [192.168.1.115]) (46.249.79.198)
 by smtp.abv.bg (qpsmtpd/0.96) with ESMTPSA (ECDHE-RSA-AES256-GCM-SHA384 encrypted); Tue, 02 Feb 2021 12:29:59 +0200
Subject: Re: Realtek USB Card Reader Driver issues
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Rui Feng <rui_feng@realsil.com.cn>,
        Ricky Wu <ricky_wu@realtek.com>
References: <1c123f6f-705b-8e47-1a01-dc6a61e6d416@abv.bg>
 <CAPDyKFpFCTcuW1=NrojEos=3+0DzEaXq-TqvBE5iyLOabNRQrQ@mail.gmail.com>
From:   Dimitar Kosev <buboleck@abv.bg>
Message-ID: <3fcae81a-e754-2e0f-e01f-f8c4a113d542@abv.bg>
Date:   Tue, 2 Feb 2021 12:29:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFpFCTcuW1=NrojEos=3+0DzEaXq-TqvBE5iyLOabNRQrQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello Ulf,

Red herring. Apparently the issue is not in the card reader driver but 
in some other new kernel option. If I build the new (5.10.10) kernel 
using the 5.7 config and make oldconfig giving no to all new things then 
the cards are not detected. If I copy the 5.7 config and use make 
xconfig and just save it then it works. I just wonder what this option 
might be and why it is not selected automatically if it is required.

Kind regards.

On 2/1/21 1:20 PM, Ulf Hansson wrote:
> + Rui, Ricky
>
> On Tue, 26 Jan 2021 at 14:42, Dimitar Kosev <buboleck@abv.bg> wrote:
>> Hello,
>>
>> It seems there is some issue with the rtsx_usb module. I'm using Gentoo
>> with kernel 5.7.9 at the moment as the card reader driver does not work
>> with 5.9 and 5.10 kernels, I don't know if the issue is there with 5.8
>> kernels as it was causing issues with my vga, my card reader info below:
>>
>> Bus 002 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129
>> Card Reader Controller
>>
>> The module detect the reader but does not detect the sd cards inserted,
>> the same cards work with 5.7 so I assume something was broken i the driver.
>>
> >From the drivers/mmc/host/rtsx_usb_sdmmc.c perspective, nothing has
> changed for quite a while and likewise for
> drivers/misc/cardreader/rtsx_usb.c.
>
> However, I think you probably need to run a "git bisect" to point out
> the offending commit. And it looks like you already have some good
> starting point to use for the git bisect.
>
> I have also looped in some of the developers from Realtek/Realsil,
> please keep them in the loop, as they know this HW and driver.
>
> Kind regards
> Uffe
>

