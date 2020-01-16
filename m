Return-Path: <SRS0=GOb8=3F=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065AAC33CB1
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2481207E0
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Jan 2020 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jHQfIQfO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAPN0d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:26:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43735 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726329AbgAPN0d (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jan 2020 08:26:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579181191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+3AGmc0BahHufdHpF69iBoZFgq1eFHjpSf37Qonl1o8=;
        b=jHQfIQfOQecxvHJNs5/PYWjzAleuIde329q/zrWWJDIX+Vh2Y1NpZKeLAv00JLygOIbEXR
        65Pl7LfC8SNKQ//72L594yN2m9yI5K98BETDqUBEAns+lHXYv4d9uzgsSA8luNzTdPTORl
        D8w/7T3i9EgGR/CMsW/6TeDDynDvn3k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-W0u2ZOnRNxWTej-4FEmxSA-1; Thu, 16 Jan 2020 08:26:30 -0500
X-MC-Unique: W0u2ZOnRNxWTej-4FEmxSA-1
Received: by mail-wm1-f72.google.com with SMTP id h130so1197201wme.7
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jan 2020 05:26:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+3AGmc0BahHufdHpF69iBoZFgq1eFHjpSf37Qonl1o8=;
        b=MSQZ2ahZCnnDJ8s2tdKK+M3RKswD4rZjc162x4knIb3sIeIy8SxiI4PJSUmVQTk6iA
         E2EZGuqklqxs+lbCC0jiajI+59sZ35VTj4BjaMvaKDzJoI77xu0lE+f6g2SJ6eCERHRx
         wJrVk7y2O7LSDLylOy7jUSDKZwsvJ3QwpGL6HqZWKet2DESDYvmRi5etgN9kCgxhQyJK
         a5oZx2E+zlNQ+i9rBUyhu/Dx/kMIwwCxIuxftoRCbfGxJIudbW6uGCuDPaHMavK67tii
         Tpu1Ayj3rllzcmTi8svsnFdpoBry0uq0NbUoYTuoqZlv171R6UDitqjDPCaa9ApC4V2K
         rL/A==
X-Gm-Message-State: APjAAAVLh+w9WCNu25w3yMrvxXqio8yfK1dmGy/7qdMZWCjXueU1fvy/
        17GqAWb0gdhPqo+wYakFVVmzk9RrwbcF3g1XnHZpwrsu5kYAKk+OkYHaWnsS6wPuHIEODej7WMM
        7Idt2cuOZRNZgn4NnGmAJ
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr3194508wrr.32.1579181189031;
        Thu, 16 Jan 2020 05:26:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqw1iD4j1BsP7eJ2yZ0eF0yq23x+UsTMoWiCJ2tLhHjWn73VdOeAiDZOEFclxFTloAkQUqwQRQ==
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr3194488wrr.32.1579181188773;
        Thu, 16 Jan 2020 05:26:28 -0800 (PST)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id v17sm29044845wrt.91.2020.01.16.05.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 05:26:28 -0800 (PST)
Subject: Re: [PATCH 1/2] mmc: sdhci-acpi: Disable 1.8V modes on external
 microSD on Lenovo Miix 320
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-mmc@vger.kernel.org
References: <20200108093903.57620-1-hdegoede@redhat.com>
 <20200108093903.57620-2-hdegoede@redhat.com>
 <61bc9265-ece0-eeb6-d4a1-4631138ecf29@intel.com>
 <8d67882d-04a8-0607-be4e-c1430b7fda21@redhat.com>
 <84a32714-ba08-74a0-0c76-3c36db44dd68@intel.com>
 <93446e09-5f12-800a-62fa-bf3ecea7273d@redhat.com>
 <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <4cdff7d3-47cf-1193-c413-036c3a2824bf@redhat.com>
Date:   Thu, 16 Jan 2020 14:26:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <399ac7d5-2518-799a-595e-f6b6878cf4ab@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

HI,

On 16-01-2020 08:59, Adrian Hunter wrote:
> On 15/01/20 5:31 pm, Hans de Goede wrote:

<snip>

>>>> Note that the suspend/resume handling is broken also in the sense that
>>>> it does not disable the signal voltage during suspend.
>>>
>>> The bus power gets switched off if the card is runtime suspended.  The host
>>> controller should go to D3cold which means everything off.
>>
>> Right, what I mean is that the _PS3 method is broken in that it does
>> not turn off the voltage-regulator providing the signal voltage, as
>> it does do on other machines with a non buggy implementation.
> 
> Is that different to what you would get with Windows?

No Windows has the same problem.

> Also, you could possibly build a custom DSDT and fix the _PS0 and _PS3
> yourself.  That requires building it into a custom kernel also though.

I have not tried, but yes that should work, but until we get some generic
mechanism (*) in Linux / distro-s to provide DSDT overrides, that is not
helpful for regular Linux users.

*) which also has copyright issues, so the chances of this ever happening
are slim

<snip>

>>>>>> +static int quirks = -1;
>>>>>> +module_param(quirks, int, 0444);
>>>>>> +MODULE_PARM_DESC(quirks, "Override sdhci-acpi specific quirks");
>>>>>
>>>>> Why is a module parameter needed?
>>>>
>>>> The module parameter is purely to make testing if the same quirk(s)
>>>> help on other devices easier. Like the debug_quirks[2] params in sdhci.c
>>>
>>> Mmm, but we already have SDHCI_QUIRK2_NO_1_8_V
>>
>> True, but this only applies to the sdcard slot and not to the eMMC,
>> also you are asking for this to be changed to:
>>
>> SDHCI_ACPI_QUIRK_SD_SET_SIGNAL_3_3V_ON_SUSPEND
>>
>> Which is not duplicate. Anyways if you dislike the module parameter
>> bits I can drop them and make this only available through the DMI quirks.
>>
> 
> It isn't dislike, it is whether it will ever be needed.

For this specific issue, chances are not that big we will need it
on another device. The quirk added by the second patch, to disable
(broken) read-only detection OTOH might very well be useful on some
other devices.

And adding the option to override the quirks from the kernel commandline
requires very little extra code.

Anyways, it is your call. Please let me know if you want to drop the
module parameter for v2, or if you are ok with keeping it.

Regards,

Hans

