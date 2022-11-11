Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513F6C4332F
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Nov 2022 06:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbiKKGPG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 11 Nov 2022 01:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiKKGPF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2022 01:15:05 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEEFCCE08;
        Thu, 10 Nov 2022 22:15:03 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 11 Nov 2022 15:15:02 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 9C67B20584CE;
        Fri, 11 Nov 2022 15:15:02 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Fri, 11 Nov 2022 15:15:02 +0900
Received: from [10.212.156.100] (unknown [10.212.156.100])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 294CFB62A4;
        Fri, 11 Nov 2022 15:15:02 +0900 (JST)
Message-ID: <5ed33703-0f20-68d0-d3d5-1a53ab08a1b8@socionext.com>
Date:   Fri, 11 Nov 2022 15:15:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/4] mmc: f-sdh30: Add reset control support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221108082533.21384-1-hayashi.kunihiko@socionext.com>
 <20221108082533.21384-2-hayashi.kunihiko@socionext.com>
 <CAPDyKFoiowaut9EhDeBH0ci50WJ7y8UFivxqExxS0EfV_KAhpw@mail.gmail.com>
Content-Language: en-US
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
In-Reply-To: <CAPDyKFoiowaut9EhDeBH0ci50WJ7y8UFivxqExxS0EfV_KAhpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,


On 2022/11/09 21:15, Ulf Hansson wrote:
> On Tue, 8 Nov 2022 at 09:25, Kunihiko Hayashi
> <hayashi.kunihiko@socionext.com> wrote:
>>
>> Add reset control support for F_SDH30 controller. This is optional.
>>
>> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> 
> This needs an update to the DT doc too, which is also the case for patch4.
> 
> That said, please convert the DT doc into the yaml based format as the
> first step.

Yes, I also think the document to be converted in order to add new compatible.
I'm concerned about the maintainer and the filename.

I'll convert it anyway.

---
Best Regards
Kunihiko Hayashi
