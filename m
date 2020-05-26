Return-Path: <SRS0=LLi2=7I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65D8C433E0
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 13:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B2B2086A
	for <linux-mmc@archiver.kernel.org>; Tue, 26 May 2020 13:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v/WUFglD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgEZND5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 26 May 2020 09:03:57 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:23846 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726325AbgEZND4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 May 2020 09:03:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590498236; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YmwIjFl/c14iDt6fi1BUWfIyIuL8313MiVePI/ekEJ8=; b=v/WUFglDNxUmkBkNpTvjdT+tWSinmFAUWNBXniKBCj2tgI07IoTNullXAq4GQ3t9rbBG1tqy
 oh6GY0HRPOv5ens9rbBfpsLqN0YHzVncWbivlB+R5Kvpc/3DULLEFulnP+tCQDzTLLEIUdZW
 fh41je6JE+fN3qwfN4GHXqCoTS0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyJiYTcxMiIsICJsaW51eC1tbWNAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ecd134a76fccbb4c8ad2a45 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 13:02:02
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 51C4CC433CB; Tue, 26 May 2020 13:02:01 +0000 (UTC)
Received: from [192.168.0.106] (unknown [183.83.65.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vbadigan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 039DCC433C9;
        Tue, 26 May 2020 13:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 039DCC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vbadigan@codeaurora.org
Subject: Re: sdhci_msm issues with cold-plugged SD cards
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>
Cc:     kernelnewbies@kernelnewbies.org,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sarthak Garg <sartgarg@codeaurora.org>
References: <491cfef4-4a97-b6e8-0f41-d44e1c73eea4@gmail.com>
 <CAPDyKFqAWVPU=mJ=RzMyJsBiMTfSQqFTXw1oLqb=cZCM4e9ebw@mail.gmail.com>
From:   Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
Message-ID: <d268a70b-a938-ab37-cca1-9a1322ad3cae@codeaurora.org>
Date:   Tue, 26 May 2020 18:31:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqAWVPU=mJ=RzMyJsBiMTfSQqFTXw1oLqb=cZCM4e9ebw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/25/2020 2:44 PM, Ulf Hansson wrote:
> + Bjorn, Sarthak, Veerabhadrarao
>
> On Fri, 22 May 2020 at 17:51, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm trying to add SD Card support to a smartphone (Samsung Galaxy S5). After
>> configuring the sdhci-msm driver through DT, it all seems to work fine except
>> the case when the phone boots with the SD card inserted. If the card is
>> re-inserted, or the driver is polling, or the probe code is forcefully executed
>> a second time the card is properly detected.
>>
>> I logged the SD interrupts, commands and responses, and it looks like the
>> hardware is returning Command Index Error and/or Command End Bit Error via the
>> Error Interrupt Status Register, which gets converted to -EILSEQ error. On
>> a second attempt (due to re-insertion, polling or re-execution) these errors
>> are missing, and the card behaves correctly.
>>
>> On the downstream kernel, these errors resulting in EILSEQ do not appear, so it
>> might be related to setup. Also I see that sdhci-msm driver has hardcoded
>> a SDHCI_QUIRK_BROKEN_CARD_DETECTION quirk, which might imply that polling
>> should be used (instead Card Detection GPIO), in which case this issue won't
>> manifest itself. But polling wastes power, and the Card Detect pin works well,
>> at least for this device, so I feel it can be made better.
>>
>> Any suggestions on how to track this down are appreciated!
> I think the device is intended to be used with GPIO card detection.
> Polling mode shouldn't be needed if there is GPIO.
>
> Anyway, to me it sounds like the HW/controller isn't properly
> initialized during ->probe(), but I can't help you much more than
> that. I have looped in some of the recent active sdhci-msm developers
> to see if they have some ideas that we can try.
>
> Kind regards
> Uffe
Strange issue. We never encountered this issue internally.
Please define "post-power-on-delay-ms" dt property with some larger 
delay value (25ms?)
and see if that helps you...

If this doesn't work, let me know the Qcom SoC (name/number) present on 
that phone.
And the kernel that you are using.

Thanks
Veera


