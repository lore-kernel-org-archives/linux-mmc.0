Return-Path: <SRS0=5xTW=4I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BE7C11D00
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 07:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943AE24656
	for <linux-mmc@archiver.kernel.org>; Thu, 20 Feb 2020 07:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z15g5taC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgBTHvw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 02:51:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35972 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgBTHvw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 02:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=fole7G1LoPJJ9Kcv9zicmaNbVVxxXaVUsyPoa8xBYzc=; b=Z15g5taCayUEDs5hVIno9ttZ01
        PjaQ01TEtHw2ZaVVrn51LXxOguZLGkz7FDeYGEilWzrXtORRSpxVKFSv06iotvNL/vOBieIR0I+Ol
        ANU+aEg/S5/LCz08yo6Rzd7dTzIr07sEPCXHd/kYbJUR+kBYXrgkmbv2V68x7XmmZ5qwc9BG73Ijo
        mnrTye5wvV5jpbNKCULFQSaXHycid40JkkM1w1CwZpSOGgp/l54beXBGJYB2XDC8IkUZ7EVnerfHh
        wYyKhavmQq4Ljp40JytCF1jcWeP3ZuH7FwfLisEvmFM8rDZHaqcJjQ108cpcACVUI1JTDmFRq71oK
        iCByTUKA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4gch-0004qm-Kn; Thu, 20 Feb 2020 07:51:51 +0000
Subject: Re: linux-next: Tree for Feb 20 (mmc/mmc_hsq.c)
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20200220144408.359a7e02@canb.auug.org.au>
 <dba0c486-46e9-0b96-bd71-b9e81b362c85@infradead.org>
 <CADBw62q08iYfm+g2y5GBUH74-TwTGRzforbuyZ_tTZQ6RQ9fzA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <13aa04b3-c1d3-175d-bad7-a8ebd502f535@infradead.org>
Date:   Wed, 19 Feb 2020 23:51:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CADBw62q08iYfm+g2y5GBUH74-TwTGRzforbuyZ_tTZQ6RQ9fzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2/19/20 10:01 PM, Baolin Wang wrote:
> Hi Randy,
> 
> On Thu, Feb 20, 2020 at 1:55 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> On 2/19/20 7:44 PM, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> Changes since 20200219:
>>>
>>
>> on i386:
>>
>> WARNING: modpost: missing MODULE_LICENSE() in drivers/mmc/host/mmc_hsq.o
> 
> I've already sent out a patch to fix the warning, can you try it?
> Sorry for troubles.
> https://lore.kernel.org/patchwork/patch/1196938/

Yes, that works for me.  Thanks.

-- 
~Randy

