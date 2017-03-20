From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/4] mmc: pwrseq: add op reset to struct mmc_pwrseq_ops
Date: Mon, 20 Mar 2017 18:56:03 +0100
Message-ID: <CAPDyKFrhfteb8Nx2Tzi__VgmQrsWbvjAVnFmAPTOBtHohLXiUA@mail.gmail.com>
References: <75ad5eac-412b-fe73-ff53-3d8b975937e4@gmail.com>
 <c75c3e5c-c4e1-3f2f-267b-1c781052c55e@gmail.com> <CAPDyKFr6_Y3cSv5Q1WRSQBo7_bsyeVVQTYBQ01gykdMpVWNtXw@mail.gmail.com>
 <ac5f62eb-64c6-b66f-24cc-b6ae74a01697@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:35429 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756261AbdCTSZD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 20 Mar 2017 14:25:03 -0400
Received: by mail-ua0-f178.google.com with SMTP id q7so80695543uaf.2
        for <linux-mmc@vger.kernel.org>; Mon, 20 Mar 2017 11:25:02 -0700 (PDT)
In-Reply-To: <ac5f62eb-64c6-b66f-24cc-b6ae74a01697@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-amlogic@lists.infradead.org

[...]

>>> @@ -166,6 +166,7 @@ int mmc_wait_for_cmd(struct mmc_host *host, struct mmc_command *cmd,
>>>                 int retries);
>>>
>>>  int mmc_hw_reset(struct mmc_host *host);
>>> +void mmc_hw_reset_pwrseq(struct mmc_host *host);
>>
>> Don't you think we can make this transparent to mmc host drivers,
>> instead of them having to assign their host_ops->hw_reset() callback
>> to this new API? Because I guess that's the though!?
>>
>> In principle the mmc core already have all the information it needs,
>> as to understand when the eMMC pwrseq should be invoked. Or perhaps
>> the code may become a bit too messy for that?
>>
> The easiest way I could think of:
> If host->ops->hw_reset is NULL overwrite it with pwrseq->ops->reset
> in mmc_add_host. But host->ops is defined es being const, so the compiler
> won't allow us to do this. Of course we could do some casting but usually
> I try to avoid hacks like casting away const qualifiers.

No thanks. :-)

[...]

Kind regards
Uffe
