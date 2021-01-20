Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E46C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D671523109
	for <linux-mmc@archiver.kernel.org>; Wed, 20 Jan 2021 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbhATAKD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Jan 2021 19:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbhATAJy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Jan 2021 19:09:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124F9C061573;
        Tue, 19 Jan 2021 16:09:10 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id o20so4953810pfu.0;
        Tue, 19 Jan 2021 16:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=V5YHJkFxhunLqV6CPGKvgfuLAmKTp+/k0HHgDvIvemY=;
        b=sNcnOik9sw1yCSXb406//QrZQb/LCBa1Bhit0HUuKy49CMLCwyETefkPCaSLOj6zjt
         A5kEOP0vNB8f5ZGMJjC+cs3PElttRJOMy0+JnB0QYqZc+FsZ/UyDw1y90sA4kwMyFePH
         k4pI+Uu1n3RrhCcaE7FhJC7YAkvX/hjAmY66Yls1uSA+aKbQSD5/b99vLoTX5tsYqcab
         gJvIlYc9E/03IvJ4C2/9LVi5bqJqssNt5KE/Z8GguUU88XOJdq55k0FrHqyTg90s+2Yv
         b3mwLl4OFaFU2uE/SdW5KdSejlOrpg2w1TpJc/8n7tAqgsmtC1wZi2pCtOQdDxI8aQKG
         sFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5YHJkFxhunLqV6CPGKvgfuLAmKTp+/k0HHgDvIvemY=;
        b=NaLCiFzXPFkoelqqDaG6Z3GEonn++2iRSxGPZeQE71WhNG9NXqk+YehB5nk9rv7ykZ
         wN7Oh507DMi5DWZYwG7TIj/FqPc56vT6YQi5o5MZQLGaqPC0lAbx6JillsmsmELevort
         Ioo4WeZvXUPr9AibreKHPhf8Wh8MliiO5cRopkHBz5VW/M8Rb7J3hmYGxVE4+o+FubHs
         aM8uce7eOsw1rgnJoqs1fcXf38oviZ/9uggaQsS/HlQlxhbj+lfxFfeabJZVp/9twEGJ
         7JFyl38em1SayGV2Smc/Y52zoFDdRHeasdFVuC1FiayjU2DeoUE14vp483Eqo5T/om+l
         aMbQ==
X-Gm-Message-State: AOAM533r3OHpMbPSBjDDd6mSjuXjj5gy9FKGOMtSjSQ5PVje5v0nS/c8
        YKME8h0oU3S/DOZJgleUD38=
X-Google-Smtp-Source: ABdhPJxUWAAovWye3q/qo6iKmjw7gGrlRIY43Rf/4yd+kzhfLd2DopTotZ7DvE0rYy+2g5mY1/sdYA==
X-Received: by 2002:a62:79cd:0:b029:1a8:4d9b:921a with SMTP id u196-20020a6279cd0000b02901a84d9b921amr6231905pfc.33.1611101349568;
        Tue, 19 Jan 2021 16:09:09 -0800 (PST)
Received: from [10.230.29.29] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y26sm203732pgk.42.2021.01.19.16.09.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 16:09:08 -0800 (PST)
Subject: Re: [PATCH v2] mmc: sdhci-iproc: Add ACPI bindings for the rpi
To:     Jeremy Linton <jeremy.linton@arm.com>, linux-mmc@vger.kernel.org
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com, stefan.wahren@i2se.com,
        nsaenzjulienne@suse.de, ardb@kernel.org
References: <20210120000406.1843400-1-jeremy.linton@arm.com>
 <20210120000406.1843400-2-jeremy.linton@arm.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <95a92ce1-f64a-1eea-c29a-2d0f97011fb0@gmail.com>
Date:   Tue, 19 Jan 2021 16:09:06 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210120000406.1843400-2-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1/19/2021 4:04 PM, Jeremy Linton wrote:
> The RPi4 has an Arasan controller it carries over
> from the RPi3 and a newer eMMC2 controller.
> Because of a couple of quirks, it seems wiser to bind
> these controllers to the same driver that DT is using
> on this platform rather than the generic sdhci_acpi
> driver with PNP0D40.
> 
> So, BCM2847 describes the older Arasan and
> BRCME88C describes the newer eMMC2. The older
> Arasan is reusing an existing ACPI _HID used
> by other OSs booting these tables on the RPi.
> 
> With this change, Linux is capable of utilizing the
> SD card slot, and the wifi when booted with
> UEFI+ACPI on the rpi4.

This is uber nit picking, but can you try to be consistent in how you
capitalize words throughout your commit subject and use common writing
such as: RPi, Wi-Fi, OSes.

> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
