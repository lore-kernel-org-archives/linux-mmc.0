Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77A6C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE452073B
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 11:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Jrlh2wIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCFLfq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:35:46 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53289 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFLfq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 06:35:46 -0500
Received: by mail-wm1-f65.google.com with SMTP id g134so2009650wme.3
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2020 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YwwwLNX1CXOU0ZBHV3s8PDBeUJoPf7oJHgRV74rJjRQ=;
        b=Jrlh2wICT5K5yhllPkFqI8nn/DvghAuGDmSj+88Z7Aa6urAm3LbbNc/+hMQVmZXSPS
         NxxHP1UeQBTlypxj4gSDNgNYdU39JFSR8U6JxfipijIKpaJsLQbG1MKHgCc7y0sqx3bB
         ivpXtFammEqcKh/d/KN/KiBgMsF0zt7Hs7pZu/2UptrxuvgQ0HR0dNk+us1H6BF/93OR
         Kog68o3hYLqFv2Fy3wC31opvE/I6zPa0qT/SOSG0DXNPBXET7I+ZnM6IJ1tKXPpRl4Io
         chyzuPo5DTHb5li2ynkuf5GKs8dPb8PruzQbgJ1Tcokg9m0fKSFGXYBjefuKqgyG1A+y
         vmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YwwwLNX1CXOU0ZBHV3s8PDBeUJoPf7oJHgRV74rJjRQ=;
        b=W9AqZdOWkw7IIFLjdNrGuansSOkGM/X8Z6/W5hLfDR8guCgaeKgQ530Xen1xMEQIJa
         jQeO6uJ0y4uhk0kfRN5YfEpw1MqCc+QypMzTDc5zsq7w3Q3f5IaCGkwfYDtGD3Y9LmYU
         9ULDiyU5+t4tkKpyTyZswPZYa8e/Hg3Kxu6J8ZLBAbZ4krTTmszoRfmbod5+h08mOTql
         moTkHbKbfoOpYGrNOw/4uIRyRdcnlBWEhrkW6qMMj3KqbiLbv2a+YFjo8qGWv81obnnL
         b7OjpQC76jQqRrH9yBvMvXTccu9nZOqGwk7zoMGQatO20LvUhymFeoPsZauDo47JRw/e
         R0lA==
X-Gm-Message-State: ANhLgQ3fnF/YHPbtoGX261YZSsL2oKuQBtlwtBCpVYJrxXjKtW6EY30U
        czsmowdGSWbYFC22kJY9jO5oEw==
X-Google-Smtp-Source: ADFU+vtajALTunRI9+k7Dx/6W5obCkqH7zM/5zlzYGwA7WqVEvNK3wjhMdZ71xpQPhSmqHFk3unyug==
X-Received: by 2002:a1c:c2c5:: with SMTP id s188mr3535597wmf.162.1583494544504;
        Fri, 06 Mar 2020 03:35:44 -0800 (PST)
Received: from ?IPv6:2a00:1098:3142:14:3ca7:8f7d:279:5ab9? ([2a00:1098:3142:14:3ca7:8f7d:279:5ab9])
        by smtp.gmail.com with ESMTPSA id u11sm600875wrb.10.2020.03.06.03.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 03:35:44 -0800 (PST)
Subject: Re: [PATCH 10/10] ARM: dts: bcm2711: Add vmmc regulator in emmc2
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Cc:     ulf.hansson@linaro.org, f.fainelli@gmail.com, phil@raspberrypi.org,
        adrian.hunter@intel.com, linux-kernel@vger.kernel.org
References: <20200306103857.23962-1-nsaenzjulienne@suse.de>
 <20200306103857.23962-11-nsaenzjulienne@suse.de>
 <408aa93f-b5c8-c4b3-384b-c8d018a8d549@i2se.com>
From:   Phil Elwell <phil@raspberrypi.com>
Message-ID: <714c41ef-85ea-da2b-1701-9132703a832c@raspberrypi.com>
Date:   Fri, 6 Mar 2020 11:35:43 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <408aa93f-b5c8-c4b3-384b-c8d018a8d549@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nicolas, Stefan,

On 06/03/2020 11:07, Stefan Wahren wrote:
> Hi Nicolas,
> 
> On 06.03.20 11:38, Nicolas Saenz Julienne wrote:
>> The SD card power can be controlled trough a pin routed into the board's
>> external GPIO expander. Turn that into a regulator and provide it to
>> emmc2.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>> ---
>>   arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> index e26ea9006378..8e98e917f9f4 100644
>> --- a/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> +++ b/arch/arm/boot/dts/bcm2711-rpi-4-b.dts
>> @@ -56,6 +56,16 @@ sd_io_1v8_reg: sd_io_1v8_reg {
>>   			  3300000 0x0>;
>>   		status = "okay";
>>   	};
>> +
>> +	sd_vcc_reg: sd_vcc_reg {
>> +		compatible = "regulator-fixed";
>> +		regulator-name = "vcc-sd";
>> +		regulator-min-microvolt = <3300000>;
>> +		regulator-max-microvolt = <3300000>;
>> +		regulator-boot-on;
>> +		enable-active-high;
>> +		gpio = <&expgpio 6 GPIO_ACTIVE_HIGH>;
> this new GPIO has an empty GPIO label, please add it.

The correct name would be "SD_PWR_ON".

>> +	};
>>   };
>>   
>>   &firmware {
>> @@ -174,6 +184,7 @@ brcmf: wifi@1 {
>>   /* EMMC2 is used to drive the SD card */
>>   &emmc2 {
>>   	vqmmc-supply = <&sd_io_1v8_reg>;
>> +	vmmc-supply = <&sd_vcc_reg>;
>>   	broken-cd;
>>   	status = "okay";
>>   };
