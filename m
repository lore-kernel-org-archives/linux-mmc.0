Return-Path: <SRS0=aPfc=5B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32BDFC0044D
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 16:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0462B2051A
	for <linux-mmc@archiver.kernel.org>; Mon, 16 Mar 2020 16:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OzkbdRLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgCPQKh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:10:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41603 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731867AbgCPQKh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2020 12:10:37 -0400
X-Greylist: delayed 462 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Mar 2020 12:10:36 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584375035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xBiMtKDvqJ9S5Ikm8bmeZZEG5ej887kTcf+i1PYZHek=;
        b=OzkbdRLWWbJsBlE1r+aqXqBvEb88V36yDuy7vtKHJZCe0F2NnjjfSaidmX3nsqGLnyYiMh
        rzAmxEtHrM9MkMNvxP2l3jDirlgVmiivmSO+NOqlhNYv6FXHEFYGNL1+3BEL9m8SWZeJhx
        RfCQ0ICTxdhzDyDwiuC1CyGSCNnMrmE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-cbk2pHwHO8eY2G48Rw-MUA-1; Mon, 16 Mar 2020 12:01:47 -0400
X-MC-Unique: cbk2pHwHO8eY2G48Rw-MUA-1
Received: by mail-wr1-f70.google.com with SMTP id 94so4569099wrr.3
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2020 09:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBiMtKDvqJ9S5Ikm8bmeZZEG5ej887kTcf+i1PYZHek=;
        b=rkukDC2bYV0G0EQ5YfCxMRGKjdhE8R6EHNoeaBbofuyEbeBTuU6l0NqW/hlZr4TGV3
         1PdzlgR+ypohxy2IsHslQwLZcX4Lxuszt5p6AnBSiSgbAGixO40u24vvZOo4/qGh6QNq
         xmcglU6o2daoicGKxNByVoTX+f8hHwVagTqHDI0vctXG6JvE1EMW4x/iLbaEeuQx/m9o
         pJRQzjSEQ765rS4syjpdQthlNX+GaqvBNKffurATDuyYR9w3lgSyJJSpElmBt18ynPOJ
         jnTq57oL9uh+vtRb9O7bXoAUHA7ry3wpi1rLks2t/3EfkMAEYRIL6OCjE5M+hsCnEL9J
         wA7A==
X-Gm-Message-State: ANhLgQ12IQfVXxvTCb03d5mWb9tEVvDOzsV0Np+l0d+Q+xwx7gUViPp3
        JDIcaUmIJ45Rl9Nniqe3pfx0cSBGkackO5BNskP5Ohb0noouMwT2RDWNU5jxbaAInwd9ak3ktnL
        iJbGG8QMZNrdxyo2lG0UF
X-Received: by 2002:a5d:5388:: with SMTP id d8mr66023wrv.270.1584374505634;
        Mon, 16 Mar 2020 09:01:45 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvaEOXt1NPe/bNwO4GiltBGCSgcEGi/EmRKMI4BDpKzrrMd6ua8pbeP/T5ewQwvYpzFvO0R9w==
X-Received: by 2002:a5d:5388:: with SMTP id d8mr66007wrv.270.1584374505453;
        Mon, 16 Mar 2020 09:01:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id t193sm222281wmt.14.2020.03.16.09.01.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 09:01:44 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mmc: sdhci-acpi: Switch signal voltage back to
 3.3V on suspend on external microSD on Lenovo Miix 320
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200306143100.164975-1-hdegoede@redhat.com>
 <1947780d-e2bf-1a3b-4603-a32c1b021e2f@intel.com>
 <ddeaf983-3ca9-c808-5623-7e29dbd948a5@redhat.com>
 <cbf40e3a-4879-8c13-8fc9-3f3a59d5a17c@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <573c10b8-db2f-832e-4413-35f430faab16@redhat.com>
Date:   Mon, 16 Mar 2020 17:01:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <cbf40e3a-4879-8c13-8fc9-3f3a59d5a17c@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

HI,

On 3/16/20 10:07 AM, Adrian Hunter wrote:
> On 14/03/20 3:59 pm, Hans de Goede wrote:
>> Hi,
>>
>> On 3/9/20 10:26 AM, Adrian Hunter wrote:
>>> Thanks for doing this.  A couple of questions below.

<snip>

>>>> @@ -823,17 +856,59 @@ static int sdhci_acpi_remove(struct platform_device
>>>> *pdev)
>>>>        return 0;
>>>>    }
>>>>    +static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
>>>> +    struct device *dev)
>>>> +{
>>>> +    struct sdhci_acpi_host *c = dev_get_drvdata(dev);
>>>> +    struct sdhci_host *host = c->host;
>>>> +
>>>> +    if (c->reset_signal_volt_on_suspend &&
>>>> +        host->mmc_host_ops.start_signal_voltage_switch ==
>>>> +                    intel_start_signal_voltage_switch &&
>>>
>>> This creates a unexpected dependency on
>>> host->mmc_host_ops.start_signal_voltage_switch.  Is it really necessary?
>>
>> Well we are directly invoking the intel_dsm here, although the
>> DMI match should only happen on a system which is using an
>> Intel SDHCI controller, I thought it would be better to check for
>> that rather then just assuming it.
>>
>> Also see the:
>>
>> +        struct intel_host *intel_host = sdhci_acpi_priv(c);
>>
>> Line, doing this on a non Intel SDHCI ACPI controller would be bad.
> 
> Then you need to add a comment to intel_probe_slot() to explain that
> sdhci_acpi_reset_signal_voltage_if_needed() is dependent on:
> 	host->mmc_host_ops.start_signal_voltage_switch =
> 					intel_start_signal_voltage_switch;

For v3 which I'm preparing now, I've decided that adding an "is_intel"
bool to sdhci_acpi_host is a cleaner way to deal with this.

Regards,

Hans

