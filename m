Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1AFC433ED
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 027DB61480
	for <linux-mmc@archiver.kernel.org>; Tue, 11 May 2021 10:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhEKK7X (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 11 May 2021 06:59:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhEKK7X (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 11 May 2021 06:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620730696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=01MRooZonNsxUDswS+wppTzdu95btW90uPQ0/7TOrdA=;
        b=WA+kuFO9UsVfSSWI+/7RMb9PHYHaonfmEFhyXnKBdbCDCHnbp2f9HwCrNO3mSU3bPBvGFY
        z+D69TSCnOdV2BmGFy8eprAXRk6iA8+QDU0gBkRzxM66GnXxeRoktvGsSgwhpRinS8icvz
        61worQo0cDWxbl8tYkPSxuE7MKUVhYM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-8qt0r3xONp-aOKW3IU_ucA-1; Tue, 11 May 2021 06:58:15 -0400
X-MC-Unique: 8qt0r3xONp-aOKW3IU_ucA-1
Received: by mail-ej1-f69.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso5838215ejb.12
        for <linux-mmc@vger.kernel.org>; Tue, 11 May 2021 03:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=01MRooZonNsxUDswS+wppTzdu95btW90uPQ0/7TOrdA=;
        b=mm6EcaXYSC6Vnpaiob+pPO/sWmYsU0RDV4HOzdW4uE6GayA6tZxKobgMgK9V5HfV32
         VEu1+v0G0i5jRnWz0rSYmhXrtWs1dFPdJ+CG0YyNXcTTaqrNIdJs2LJhLTiLubhuvWpF
         U7dL585aM/jDqi3Q/2TTwBjTW6eyZGuYQCLxf7dPdpkl0GpxkgWKiKWRKpqVkcbwD3+H
         4/WjubTrWjRYl1h4PZv7yOWi36CRGMo7Zyte8YmvH77U/lTVO+91vAqt+1p99twKQfhV
         PtJV+UOS++Umgjmk19nxw5QGOjqxjffSq28gQDkDG9DVdg2B+dr4qBcWg6vMbuhwAroi
         Qu8Q==
X-Gm-Message-State: AOAM5309uX2ebtmsXG6j5JvBq/85z0ZLkzBMlGtGPu2SDqOR0VAroMl/
        MGVgANhNxDDDsK+o3W1FauQrvw/snAPWgTwXVg2SbmzAMm62LrJOFpZ4D+UAh2CDGU+qDd5VgiH
        2DY1L+TrLl6bNP2ABdbWBxCI4M7ku90LL8UUwvy4v7idi4xKQ0AM2rD069ZAs1/RlziXW8R/5
X-Received: by 2002:a17:906:f6d0:: with SMTP id jo16mr30841819ejb.461.1620730693930;
        Tue, 11 May 2021 03:58:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGYQR1uQ5GcdhT1JQJZ3FeoEuzIQ77cQDpjfiVMlLX6U8Fj50VQx9uGcH+vo3eQpqY70T3+Q==
X-Received: by 2002:a17:906:f6d0:: with SMTP id jo16mr30841806ejb.461.1620730693711;
        Tue, 11 May 2021 03:58:13 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t9sm14868073edf.70.2021.05.11.03.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 May 2021 03:58:13 -0700 (PDT)
Subject: Re: [PATCH] mmc: sdhci-acpi: Disable write protect detection on
 Toshiba Encore 2 WT8-B
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
References: <20210503092157.5689-1-hdegoede@redhat.com>
 <CAPDyKFq2+SgWE7XAMWAQsC4Ud5YNx0E-CCsMgeDzN3b_wvwL-g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <7c72c70b-8e5c-77e1-70c2-bf93e66fb407@redhat.com>
Date:   Tue, 11 May 2021 12:58:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFq2+SgWE7XAMWAQsC4Ud5YNx0E-CCsMgeDzN3b_wvwL-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 5/11/21 12:56 PM, Ulf Hansson wrote:
> On Mon, 3 May 2021 at 11:22, Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> On the Toshiba Encore 2 WT8-B the  microSD slot always reports the card
>> being write-protected even though microSD cards do not have a write-protect
>> switch at all.
>>
>> Add a new DMI_QUIRK_SD_NO_WRITE_PROTECT quirk entry to sdhci-acpi.c's
>> DMI quirk table for this.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> 
> Applied for next, thanks!
> 
> Should we tag this for stable?

Yes please.

Thanks & Regards,

Hans




>> ---
>>  drivers/mmc/host/sdhci-acpi.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
>> index b6574e7fd26b..9e4358d7a0a6 100644
>> --- a/drivers/mmc/host/sdhci-acpi.c
>> +++ b/drivers/mmc/host/sdhci-acpi.c
>> @@ -820,6 +820,17 @@ static const struct dmi_system_id sdhci_acpi_quirks[] = {
>>                 },
>>                 .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
>>         },
>> +       {
>> +               /*
>> +                * The Toshiba WT8-B's microSD slot always reports the card being
>> +                * write-protected.
>> +                */
>> +               .matches = {
>> +                       DMI_MATCH(DMI_SYS_VENDOR, "TOSHIBA"),
>> +                       DMI_MATCH(DMI_PRODUCT_NAME, "TOSHIBA ENCORE 2 WT8-B"),
>> +               },
>> +               .driver_data = (void *)DMI_QUIRK_SD_NO_WRITE_PROTECT,
>> +       },
>>         {} /* Terminating entry */
>>  };
>>
>> --
>> 2.31.1
>>
> 

