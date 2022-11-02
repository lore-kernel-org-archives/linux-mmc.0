Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 618F6C433FE
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 14:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKBOAX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 10:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiKBOAX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 10:00:23 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C705F56
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 07:00:18 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso3675297pjn.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2022 07:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsJlfOgqiHgUxbwmXIMpsu5a+7TfV6gKqVgE2IVuVWw=;
        b=AHEPyvF6yJhpDPvZ8ro4YgNh/1b3ocEAMuI5HfpiDWENSPwoMudTtWa89Cu9MNghcI
         XnvfBLm5zKyTIL++yTuLk18tUTZ4ZG3YCv5l4MUzk/otRcanr1rGZ/ppKm00oahLog9H
         +ubnqs+SdzlTzcuFg3ASbmFgvBF4t5KTwgI9JBt2jrcWpeUjS3Q5UsoN6GHnhA5ChtjE
         j7EkUBJLld3iBHt/oOI06qx0TSlwF52IWdr5cNBP5XQ6A+U3RD1IEzklyOcvIDL+JGCK
         yMGPPpz4BJExg/rZDmJsOnitiANXG+NGOx2WCMP9JjCCpsyoJBBOdIO5ztzfMY7dRWSX
         OXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsJlfOgqiHgUxbwmXIMpsu5a+7TfV6gKqVgE2IVuVWw=;
        b=hS+kfTr8ZUcFscK9S6gGSgpVrlx7qrm33CIMrSOGwVcRKxpO3EHHLD/MTKFD3EIk8d
         3EepFvSabDnXbF1FWzjG14qP1lUVoWo2Jy4hmVQNFcs93ZikSIuTTH15W3XHK0irwJAo
         II9h0uLuKvWQkbqKe+yvz6d2HKJka8jCtGe2QVCqsfqJrZYMye8EKBf5DQCrq1e0x5gu
         E709crXfS9ncTDWUrQ/BzZi/pmCwq67uYImHrS7oQylgtXDSRPQ1SS+sVu3274PHhEEw
         SmWK7Om9oN9WG1j4j1iUCjEPJrpHPslHaWoAgPwY9g0D2GF+r++TI4geOHuzOCCsBqlE
         /P/Q==
X-Gm-Message-State: ACrzQf3TOXW8TXkIHDUKhfzMMwP4uFzs1/YXXxWXPshsWx1E1ZrCjPjM
        TYm4X57jAI+ahQG10myxaM9X+Q==
X-Google-Smtp-Source: AMsMyM6yV8ivNbcxAFIU13pFb/62Dk7GdMTsYKKajObauYtzqrNkOCFepVJeBDJgkfsgk1NarljTIQ==
X-Received: by 2002:a17:902:ce82:b0:187:3591:edac with SMTP id f2-20020a170902ce8200b001873591edacmr9749767plg.153.1667397618240;
        Wed, 02 Nov 2022 07:00:18 -0700 (PDT)
Received: from [172.20.7.43] ([12.157.112.82])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b00176ba091cd3sm8294561plb.196.2022.11.02.07.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 07:00:17 -0700 (PDT)
Message-ID: <42b902eb-1ff3-2e44-8128-34d9a86ce8a1@monstr.eu>
Date:   Wed, 2 Nov 2022 07:00:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add support for dynamic
 configuration
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, saikrishna12468@gmail.com,
        git@amd.com
References: <20221019054857.8286-1-sai.krishna.potthuri@amd.com>
 <54973f0b-33ab-6cbb-82ce-be769fe82bd9@intel.com>
Content-Language: en-US
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <54973f0b-33ab-6cbb-82ce-be769fe82bd9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 11/2/22 02:37, Adrian Hunter wrote:
> On 19/10/22 08:48, Sai Krishna Potthuri wrote:
>> Add dynamic configuration support for Xilinx ZynqMP which takes care of
>> configuring the SD secure space configuration registers using EEMI APIs,
>> performing SD reset assert and deassert.
>> High level sequence:
>> - Check for the PM dynamic configuration support, if no error proceed with
>> SD dynamic configurations(next steps) otherwise skip the dynamic
>> configuration.
>> - Put the SD Controller in reset.
>> - Configure SD Fixed configurations.
>> - Configure the SD Slot Type.
>> - Configure the BASE_CLOCK.
>> - Configure the 8-bit support.
>> - Bring the SD Controller out of reset.
>> - Wait for 1msec delay.
>>
>> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> 
> Can we get an Ack from xilinx folks?
Xilinx was acquired by AMD some time ago. This has been tested and reviewed 
internally already. But

Acked-by: Michal Simek <michal.simek@amd.com>

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

