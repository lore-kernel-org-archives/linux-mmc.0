Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BC4C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Oct 2021 04:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E64B961247
	for <linux-mmc@archiver.kernel.org>; Mon, 18 Oct 2021 04:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhJREVH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 18 Oct 2021 00:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbhJREVG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Oct 2021 00:21:06 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B440C06161C;
        Sun, 17 Oct 2021 21:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=3/fgOoju9O1FCmKf2ic6WkSHjmY0bL+2HDrOcfuO7jg=; b=xedvsy42ckjJPwRVTQauJBtDUj
        /2FXlDxI3x7D875Efwkj7pND+2tsDmI8rKDxVm3CpsIEgudoESeSeXfdw7P3CdfhtI8prqcux3rEC
        CXmrACTaq2grXKJkNs0sOw0kg1peQo2YunQoiq2+u6k5CzFniKyC0JVg+pDTl3p6HGz8Oxik3Y1XY
        DqmpkLlPymQGd7mJE/2AsQHJ52uPZHpdcceJM7ZKVuO8A0h/qsSzuER7GH+V98yFVhhBxNpAsiBot
        63rFlYuWs22+LSQBpn3qMD3Zz1xTmohHysICndOaVI1E3n7B47QbIZqHERFVljV/DpZN1YRpzI6Nd
        fjYIg7Bg==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcK6w-00DzLS-Qv; Mon, 18 Oct 2021 04:18:54 +0000
Subject: Re: [PATCH] mmc: winbond: don't build on M68K
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211017175949.23838-1-rdunlap@infradead.org>
 <CAK8P3a1WHPnLNE7=4872iaVcL708NcVmMhRvAR0OLujP=Y3Tjw@mail.gmail.com>
 <a8e1bb2d-4993-0059-f850-438ab8ff69aa@infradead.org>
Message-ID: <0ecac99e-d92f-c665-159c-aaf14c4549ce@infradead.org>
Date:   Sun, 17 Oct 2021 21:18:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <a8e1bb2d-4993-0059-f850-438ab8ff69aa@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/17/21 12:31 PM, Randy Dunlap wrote:
> On 10/17/21 12:20 PM, Arnd Bergmann wrote:
>> On Sun, Oct 17, 2021 at 7:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>> The Winbond MMC driver fails to build on ARCH=m68k so prevent
>>> that build config. Silences these build errors:
>>>
>>> ../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
>>> ../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
>>>    212 |                 dmaflags = claim_dma_lock();
>>> ../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>>>    215 |                 release_dma_lock(dmaflags);
>>>
>>
>> It looks like m68k and sparc declare this function in asm/floppy.h,
>> while everyone
>> else has it in asm/dma.h.
>>
>> Not sure if it's worth fixing in a better way, but I suspect sparc
>> would have the
>> same issue here.
> 
> Ah, I should have seen that.
> I'll look into a different patch.
> 
> thanks.


OK, I have spent several hours on moving dma functions from floppy.h
to dma.h (for m68k), and it fixes a few things, but there are still
quite a few problems, and I don't see any end in sight (it's either
a maze of twisty tunnels or a twisty maze of tunnels), and it's just
not worth spending more time on it IMO.

-- 
~Randy
