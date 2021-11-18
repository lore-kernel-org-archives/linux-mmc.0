Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C82D1C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 20:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC1F6137F
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 20:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhKRU7w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Nov 2021 15:59:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229905AbhKRU7w (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2021 15:59:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637269010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=unQKitJKhE8CiwWk7oD7qjBW8RzHNdc0OJrMyXYxXfc=;
        b=gHeyE71fUYvSyzOgsJ9hHQPRyHQzPB7oiwM5TFRA5i9aXfuC6uQPXzn1/GIBBH8Anyojhd
        wcI5bqiE/xGg+fLl/pKMyA9KaTUtffyaU//w1qi26Y92x+IlFAqib5iHnYqvYo5JhCSkv5
        rEXXK/UNA0Y0gJciaXjry/nzoAylqUM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-Fzj-hLoCMDiLccNPRJ5dmw-1; Thu, 18 Nov 2021 15:56:49 -0500
X-MC-Unique: Fzj-hLoCMDiLccNPRJ5dmw-1
Received: by mail-ed1-f69.google.com with SMTP id y9-20020aa7c249000000b003e7bf7a1579so6423151edo.5
        for <linux-mmc@vger.kernel.org>; Thu, 18 Nov 2021 12:56:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=unQKitJKhE8CiwWk7oD7qjBW8RzHNdc0OJrMyXYxXfc=;
        b=dQVXNenDbxfj+bqCZnvwsM9q6lWfVUAnz/t5jxcX0cjJwMkCw4MGvy4PAvO8b/bc0+
         TTQkY/CV0CMVcc8V60/BU5ZT5ixzjS3n5vqVmI+pHO9a1iT9DeZme8J4NR7Ypr6Fb2+h
         +bZk1Wq3Hc6lDUCQfonRY6Zvueem7F639epv4g71HP6mK2uaUMCxjaKy9lRc+YxiRzbL
         LmDHZfo2woiycpzoeNH5M8AWH1p/tTaNkxiG21u54NufiYTruQ/WJiLAmmxjfS57mkpx
         7CNYEZHxo8CfjrMnvFnQZXyvDGV5Rl2lHW9p0sSG7rSitSoSWyXJ5lRTn8l5lFvETr5Z
         kdlQ==
X-Gm-Message-State: AOAM530daNpRUvHxajEIddMIzHlQNpWTMBOCw3KKbGmbnU/Srpn/y0XA
        hbGYdrzWrqpJunE+VHl/qIBY98a1yEh5Zcy2aU0t0a/NkIJxo3+VOvkBY8bKQeu80dzEGtvOQ5r
        zvRdaBFP23SnGylupd3mK
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr549034ejc.57.1637269007806;
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxa6DtEvWfkZlwTUJAFc0kRx/YnRxDlZ/alE2N8LFGxKcmMwP3FCWwBsY9SarA/6ytxRMme1w==
X-Received: by 2002:a17:907:7da9:: with SMTP id oz41mr549012ejc.57.1637269007662;
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id di4sm373349ejc.11.2021.11.18.12.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 12:56:47 -0800 (PST)
Message-ID: <307175ba-e289-6b2f-bcf2-cd0c5cf70296@redhat.com>
Date:   Thu, 18 Nov 2021 21:56:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some
 unused objects during scan
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20211117220118.408953-1-hdegoede@redhat.com>
 <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
 <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
 <4363288.LvFx2qVVIh@kreacher>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <4363288.LvFx2qVVIh@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 11/18/21 15:51, Rafael J. Wysocki wrote:
> On Thursday, November 18, 2021 12:15:28 PM CET Hans de Goede wrote:
>> Hi,
>>
>> On 11/18/21 12:08, Rafael J. Wysocki wrote:
>>> On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
>>>> unused objects") adds a:
>>>>
>>>>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
>>>>
>>>> call to acpi_scan_init(). On some devices with buggy DSDTs calling
>>>> _PS3 for one device may result in it turning off another device.
>>>
>>> Well, I'm going to revert this commit.  I'm sending a pull request
>>> with the revert later today.
>>>
>>>> Specifically the DSDT of the GPD win and GPD pocket devices has a
>>>> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
>>>> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
>>>>
>>>> I've an earlier, in some ways simpler, fix for this here:
>>>> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
>>>>
>>>> But the sdhci-acpi.c MMC host code already has an older workaround
>>>> for it to not toggle power on this broken ACPI object; and this
>>>> simpler fix would require keeping that workaround. So then we would
>>>> have 2 workarounds for the same issue in the kernel.
>>>>
>>>> Thus instead I've come up with a slightly different approach which
>>>> IMHO has ended up pretty well.
>>>>
>>>> Patches 1-3 of this series are this different approach and assuming
>>>> they are considered ok must be merged into 5.16 to fix the regression
>>>> caused by commit c10383e8ddf4 on these devices.
>>>
>>> So I'll have a look at these and if they look good, we can do that
>>> instead of the problematic commit in 5.17.
>>
>> I'm a bit confused now, if the problematic commit is going to get
>> reversed then technically we don't need this series anymore ?
> 
> That's correct.
> 
>> Or are you planning on re-introducing it in some form for 5.17 ?
> 
> I have been considering this.
> 
>> With that said getting this series merged would still be good,
>> patch 1 + 2 make the existing always_present quirk code more generic
>> which might be useful later. And then patch 3 (which is small)
>> allows dropping some ugliness from the sdhci-acpi.c code since
>> the DSDT bug we are hitting will now be solved by the
>> new acpi-dev-status-override mechanism.
> 
> OK, so this would be applicable for 5.17, but a couple of changelogs
> need to be updated if I'm not mistaken.
> 
> Can you please do that and resend the series?

I will update some of the commit messages and send a v2 tomorrow.

Regards,

Hans

