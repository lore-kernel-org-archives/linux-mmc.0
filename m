Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098F7C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 21:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE9B60D43
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 21:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbhJ2Vt5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbhJ2Vt4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 17:49:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B951EC061570;
        Fri, 29 Oct 2021 14:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=9nDAyc2CEQnQbldKt9DkGeYslg1kSi1u4+9mTf4hmOU=; b=U03hNFRjzzqmMGdfaNDvAi+PC/
        sMi8qnty/SIi8RZeyRF+OQ9pZJsHtS7yvDTcADBP/RhifuaqKN4yf3v2/RE2gaGSINkenep3Oy7D5
        1kyPmjhVhlqHePk3XMkhfNgpAHgc6fEDX56DCiX2CUbQqiNM1CIOBLWxxlG3w5VyZCqk1eAPKZl9I
        OWN0vpL5Ed9y+R3ns19WmIM2MXjUs3pUE0dJTS+cDkIdVRLm1NL0CSDhzaRE3KD2owTdsW3Vrietk
        47Zlhyr35TZMk8tM0HMujz7DMf8glfCWPOVrfOyFKemEtOwQItcfbTxd66vfovsOSuSUMVvfB/nno
        9gRFmVcQ==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mgZif-00CPI9-Vz; Fri, 29 Oct 2021 21:47:26 +0000
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <20211029120709.79366-1-ulf.hansson@linaro.org>
 <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <c9deee06-dd78-22fc-2d93-7c70e1f6522b@infradead.org>
Date:   Fri, 29 Oct 2021 14:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/29/21 11:04 AM, Linus Torvalds wrote:
> On Fri, Oct 29, 2021 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>>   - winbond: Silences build errors on M68K
> 
> I think this one is wrong.
> 
> I think the problem is that m68k declares "claim_dma_lock()" in the
> wrong header file. It's in <asm/floppy.h> instead of <asm/dma.h>
> 
> I'm somewhat surprised that this doesn't hit m68k in other places -
> there are other drivers that use that same ISA DMA interface.

I moved claim_dma_lock() and release_dma_lock() fro asm/floppy.h
to asm/dma.h (for arch/m68k/). I spent a few hours trying to fix
the resulting fallout.  Guess I'm just slow.

FWIW, the biggest problem I had was the variety of types of DMA that
M68K supports (once a driver includes <asm/dma.h>, things get messy).

> I've pulled this, but I hate how random that fix is.


-- 
~Randy
