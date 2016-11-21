From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: delete packed command support
Date: Mon, 21 Nov 2016 16:17:53 +0100
Message-ID: <CAPDyKFrPhTi_9oGPfLFkO34GWZR561KHD5GebXUe2mq-rt1uRQ@mail.gmail.com>
References: <1479722937-19551-1-git-send-email-linus.walleij@linaro.org>
 <2697103.lML87IM8sj@wuerfel> <d0722644-2922-b580-9bfe-01dd3c38ec67@intel.com>
 <CAPDyKFrW+Jge-Kd=PhRJvHG1Y==MMYinXxgHM1ySSG8gOx3tyA@mail.gmail.com> <135cb4af-fbbe-d6a7-182b-73543f1c551a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34794 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753250AbcKUPRz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Nov 2016 10:17:55 -0500
Received: by mail-wm0-f50.google.com with SMTP id u144so22245006wmu.1
        for <linux-mmc@vger.kernel.org>; Mon, 21 Nov 2016 07:17:55 -0800 (PST)
In-Reply-To: <135cb4af-fbbe-d6a7-182b-73543f1c551a@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc <linux-mmc@vger.kernel.org>, Chunyan Zhang <zhang.chunyan@linaro.org>, Baolin Wang <baolin.wang@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <namjae.jeon@samsung.com>, Maya Erez <qca_merez@qca.qualcomm.com>, Luca Porzio <lporzio@micron.com>, Alex Lemberg <Alex.Lemberg@sandisk.com>

[...]

>>>
>>> SDHCIv4 has a feature (ADMA3) which is slightly similar to packed
>>> commands but it does not require card support.
>>>
>>> Why is it a problem for blk-mq to allow some extra requests to
>>> pick from for packing?
>>>
>>
>> In blk-mq, requests don't get picked from the queue, but instead those
>> gets "pushed" to the block device driver.
>>
>> First, to support packing, it seems like we would need to specify a
>> queue-depth > 1, more or less lie to blk-mq layer about the device's
>> capability. Okay, we can do that. But..
>>
>> I also believe, the implementation would become really complex, as you
>> would need to "hold" the first write request, while waiting for a
>> second to arrive. Then for how long shall you hold it? And then what
>> if you are unlucky so the next is read request, thus you can't pack
>> them. The solution will be suboptimal, won't it?
>
> It doesn't hold and wait now.  So why would it in the blk-mq case?

Because earlier the mmc block device driver *fetches* requests from
the queue and when finding more than one request, we could try to pack
them. If there are only one request, we just move on with it.

With blk-mq, we don't *fetch* request from the queue, but instead
those would get pushed to the mmc block device driver via the
implemented block-mq ops.

Please note, I am not an blk-mq expert, but this is my understanding.

Kind regards
Uffe
