Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022B2C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 18:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B884C23B19
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Jan 2021 18:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbhANSsb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Jan 2021 13:48:31 -0500
Received: from saphodev.broadcom.com ([192.19.232.172]:33960 "EHLO
        relay.smtp-ext.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726778AbhANSsa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Jan 2021 13:48:30 -0500
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jan 2021 13:48:30 EST
Received: from [10.136.13.65] (lbrmn-lnxub113.ric.broadcom.net [10.136.13.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id C0AE5828A;
        Thu, 14 Jan 2021 10:39:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com C0AE5828A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1610649567;
        bh=vVw8/2auuSxRv9y4posLdV4M5sVNdtpuhclyC43Ddos=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=OEQhWHBgUgY3j03v0pLf0ZDGRYB3LffE6yhRid/QXJUZ1Cbxhgx1Xc5yGp+43zrx/
         2r7KeYTQbkEdWRZ69ks/0yw0VkKLlUYJN+EmtrdQ3fm2jn6j1m1fPIDym/r/hoFOFw
         OOnjI6TxQMwJ79aHGVDYqfeww4zP5vxCc8zUT9AY=
Subject: Re: Bug Report Broadcom BCM57765/57785
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWFydMOtbiBYacO6aG5lbCBNb3JhIFJvbGTDoW4=?= 
        <necrodos@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
References: <CAG=_e5DcNhoVM3rbzsocpBKwuwt9C0x7-B-fLwrFwyN82zTvHQ@mail.gmail.com>
 <CAPDyKFoycHLO_c3xfpoHLmLKzri6vQa1zvuFUjGiB803XxkGUQ@mail.gmail.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f85c115f-5095-420a-e6b9-f971cefc8819@broadcom.com>
Date:   Thu, 14 Jan 2021 10:39:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPDyKFoycHLO_c3xfpoHLmLKzri6vQa1zvuFUjGiB803XxkGUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Martin/Uffe

On 2021-01-14 3:55 a.m., Ulf Hansson wrote:
> + Scott
>
> On Thu, 14 Jan 2021 at 02:50, Martín Xiúhnel Mora Roldán
> <necrodos@gmail.com> wrote:
>> Hi, I want to report a bug related to the drivers of the sd card
>> reader Broadcom Broadcom Corporation BCM57765/57785 SDXC/MMC Card
>> Reader. Basically It doesn't show the inserted cards, and even though
>> it has a workaround that has worked flawless for mac users, many acer
>> user seem to have problems like not being able to transfer large files
>> (larger than a couple or not being able to format the card. I know
>> this has been reported before but it keeps having problems. Thanks for
>> your help, here are some links to previous reports of this bug and
>> previous attempts to solve this issue. I experience this bug on a
>> laptop acer v5-131 with said sd card reader running elementary 5.1.7
>> Hera but I've encountered this same bug on all other ubuntu flavors on
>> this same device. All using Kernel 5.4
>>
>> Please, if I'm doing something wrong by trying to report this bug,
>> please let me know
>>
>> https://gist.github.com/samgooi4189/2e6e18fd1d562acaf39246e5e386d7cb
>>
>> https://askubuntu.com/questions/444484/broadcom-card-reader-bcm57765-bcm57785-doesnt-work-on-ubuntu-12-04-lts
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206005
>>
>> Thanks you so much for your attention
> Hi Martin,
>
> I am sorry, but this isn't really my cup of tea.
>
> It looks like the sd controller is based upon sdhci-pci. As far as I
> know, I don't think there have been any Broadcom engineers working on
> that driver ever, but I might not have the complete history.
>
> In any case, I have looped in Scott Branden from Broadcom, perhaps he
> can help to move this forward in some way or the other.
I'm sorry, but I don't know what a BCM57765/57785 even is but it is from some time in 2010 or earlier - nothing I have seen or worked on.
I looked at our groups internal bug database and we have experienced issues with card detection or high speed usage on other products in the past.
Some fixes needed have been resetting the SD card after the bootloader to get card into a known state, controlling gpios to set voltages for ultra high speed modes, DDR50 tuning, and what not.

I don't know what your specific issue for that card.
>
> Kind regards
> Uffe

