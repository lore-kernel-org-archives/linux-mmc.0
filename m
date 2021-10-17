Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41840C433EF
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1598661039
	for <linux-mmc@archiver.kernel.org>; Sun, 17 Oct 2021 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhJQTdv (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 17 Oct 2021 15:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJQTdu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Oct 2021 15:33:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EFAC06161C;
        Sun, 17 Oct 2021 12:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=JEe45AzlRC5WweIr2hd7JTxBI1gTTImaMBX4JW0IIx8=; b=HyG8jXoWT1S+X7n1So04BNRYen
        YPj8C8uMxIetmRzEZ/R1wxRSdAIyLj7R7rOiNGMELOBnWMrSGXMF4mMKsnpPZo5TNjgEuCAESztHY
        TLeUPXNo9YRTJIMKXxEQVR/Sc8C+NS+4Fwqp70J+ZzR878OLIsSyxpY37ZIZxaywcHp4cIOw4IBCs
        acSHFCUExsLoO+dzarvEdTuJa0xedqotiHSSGStCnCLdI+sigkTZnwd3LJfyPQqFfDChrMlX4mjE3
        4dQ5W7JB3aMybq/MykvgVjwfKh7sqCuB2G8EiBzmA6+8mIpfv99aDyf2q+ZZTjrJIZ1gSFKYY+uls
        OLzVjDHw==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mcBsh-00DDDv-2D; Sun, 17 Oct 2021 19:31:39 +0000
Subject: Re: [PATCH] mmc: winbond: don't build on M68K
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pierre Ossman <pierre@ossman.eu>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211017175949.23838-1-rdunlap@infradead.org>
 <CAK8P3a1WHPnLNE7=4872iaVcL708NcVmMhRvAR0OLujP=Y3Tjw@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <a8e1bb2d-4993-0059-f850-438ab8ff69aa@infradead.org>
Date:   Sun, 17 Oct 2021 12:31:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1WHPnLNE7=4872iaVcL708NcVmMhRvAR0OLujP=Y3Tjw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/17/21 12:20 PM, Arnd Bergmann wrote:
> On Sun, Oct 17, 2021 at 7:59 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> The Winbond MMC driver fails to build on ARCH=m68k so prevent
>> that build config. Silences these build errors:
>>
>> ../drivers/mmc/host/wbsd.c: In function 'wbsd_request_end':
>> ../drivers/mmc/host/wbsd.c:212:28: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
>>    212 |                 dmaflags = claim_dma_lock();
>> ../drivers/mmc/host/wbsd.c:215:17: error: implicit declaration of function 'release_dma_lock'; did you mean 'release_task'? [-Werror=implicit-function-declaration]
>>    215 |                 release_dma_lock(dmaflags);
>>
> 
> It looks like m68k and sparc declare this function in asm/floppy.h,
> while everyone
> else has it in asm/dma.h.
> 
> Not sure if it's worth fixing in a better way, but I suspect sparc
> would have the
> same issue here.

Ah, I should have seen that.
I'll look into a different patch.

thanks.
-- 
~Randy
