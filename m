Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E6FC433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 11:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95EAD617E3
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Nov 2021 11:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343832AbhKRLUK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Nov 2021 06:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344092AbhKRLSc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Nov 2021 06:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLL+SXRUQtHOYzxbBR3+E0gRNLnRI75C+gDiy6tjAt8=;
        b=hrSgJCLKrJKdfBVPh4mUWlkwE118qWBtfaeZiFsRdLareT8eVkdXKXoTIsLbDd4IW1Ko1E
        C8fyWATPqJzRMR3tfT7v98uwVtWzsDutQWKrOrk4u2Y30wRkjA3hYpzcuEGe5K2G6ehA/J
        iBsv6YIbCuDrouJsKHGHdC9eX0NWyPw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-JYb1e9HDNUu8vAejK1Wdbw-1; Thu, 18 Nov 2021 06:15:30 -0500
X-MC-Unique: JYb1e9HDNUu8vAejK1Wdbw-1
Received: by mail-ed1-f71.google.com with SMTP id i19-20020a05640242d300b003e7d13ebeedso4974873edc.7
        for <linux-mmc@vger.kernel.org>; Thu, 18 Nov 2021 03:15:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=tLL+SXRUQtHOYzxbBR3+E0gRNLnRI75C+gDiy6tjAt8=;
        b=qPFPF4Y30sfo9lPdBZ1tHOYGNB/jxrC/K1ECIOtrcZBqFXpxq2OF+ss/RyMIDAo9C0
         zS8TiQlMs05guGxxeHiWeQ38daXYqPu3l9hcghStkXYhQpe6hINQ8kRIYkJOEMSr43oX
         zNMb5+dXyJ3m20cX2Ed4YzCW7l0U0RPJFriQFMnztISQLHGeCMts3MjiYpzgvcNNDp8l
         fEF9yg5hkdNvPv/iRR78wDzfM5DgxsMNxp7I5sbsnEKZFLjpDzto6b3tZusvZMCijUhc
         Or5h5LvqI0yP90eLdAV81VNSHizSxFSvWCjQcuSOiwibsCDhoaSADUvOz4i+oWeOXxJh
         oU9w==
X-Gm-Message-State: AOAM532SXedHfip5xgglZT69GOTMinnvgf13ypnE9wanx6EKY+KtspUA
        X38MAveNPO04YfXcYqFQlj0pVO4ynQ04MoWXTHY/Otlosv+UzJoumBU2xz49RtuY+5QiTAVPpVc
        /h1D2obIYhD82/nVcaqpL
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9950645edf.153.1637234129760;
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5/BQkcvD/uZZZVRUuLcyQyQ3pCqJV0hnk93SdCb0dVL3YaH/L93PMB3108ej+wxX65snoNw==
X-Received: by 2002:a05:6402:1e92:: with SMTP id f18mr9950618edf.153.1637234129565;
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id p10sm1378086edj.91.2021.11.18.03.15.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Nov 2021 03:15:29 -0800 (PST)
Message-ID: <937cf1fd-0cb1-1a12-7745-8cc2a2e3405a@redhat.com>
Date:   Thu, 18 Nov 2021 12:15:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 5.16 regression fix 0/5] ACPI: scan: Skip turning off some
 unused objects during scan
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20211117220118.408953-1-hdegoede@redhat.com>
 <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <CAJZ5v0hDWN4cKh+ZcB__wrWHChm=FjhwvCShXzseECQOFotM6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 11/18/21 12:08, Rafael J. Wysocki wrote:
> On Wed, Nov 17, 2021 at 11:01 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Hi Rafael,
>>
>> Commit c10383e8ddf4 ("ACPI: scan: Release PM resources blocked by
>> unused objects") adds a:
>>
>>         bus_for_each_dev(&acpi_bus_type, NULL, NULL, acpi_dev_turn_off_if_unused);
>>
>> call to acpi_scan_init(). On some devices with buggy DSDTs calling
>> _PS3 for one device may result in it turning off another device.
> 
> Well, I'm going to revert this commit.  I'm sending a pull request
> with the revert later today.
> 
>> Specifically the DSDT of the GPD win and GPD pocket devices has a
>> "\\_SB_.PCI0.SDHB.BRC1" device for a non existing SDIO wifi module
>> which _PS3 method sets a GPIO causing the PCI wifi card to turn off.
>>
>> I've an earlier, in some ways simpler, fix for this here:
>> https://fedorapeople.org/~jwrdegoede/0001-ACPI-scan-Skip-turning-off-some-unused-objects-durin.patch
>>
>> But the sdhci-acpi.c MMC host code already has an older workaround
>> for it to not toggle power on this broken ACPI object; and this
>> simpler fix would require keeping that workaround. So then we would
>> have 2 workarounds for the same issue in the kernel.
>>
>> Thus instead I've come up with a slightly different approach which
>> IMHO has ended up pretty well.
>>
>> Patches 1-3 of this series are this different approach and assuming
>> they are considered ok must be merged into 5.16 to fix the regression
>> caused by commit c10383e8ddf4 on these devices.
> 
> So I'll have a look at these and if they look good, we can do that
> instead of the problematic commit in 5.17.

I'm a bit confused now, if the problematic commit is going to get
reversed then technically we don't need this series anymore ?

Or are you planning on re-introducing it in some form for 5.17 ?

With that said getting this series merged would still be good,
patch 1 + 2 make the existing always_present quirk code more generic
which might be useful later. And then patch 3 (which is small)
allows dropping some ugliness from the sdhci-acpi.c code since
the DSDT bug we are hitting will now be solved by the
new acpi-dev-status-override mechanism.

Regards,

Hans

