Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58410C48BCF
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 03:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F76135D
	for <linux-mmc@archiver.kernel.org>; Wed,  9 Jun 2021 03:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236123AbhFIDKP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Jun 2021 23:10:15 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41860 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbhFIDKM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Jun 2021 23:10:12 -0400
Received: by mail-pg1-f171.google.com with SMTP id l184so2692066pgd.8;
        Tue, 08 Jun 2021 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lhOA0nGrbjhRPVswA/mywNHLTKJKSXnKV9s3KRuT9b0=;
        b=eEmOANjFoGPTyGNLvXOsBxdb0fTnjiOwL3tROU9dOMmgDoC4VLjtO4w3cbWVHjP/hK
         wahkSdOQe6292A4Zn72SHDGSDQaqSZvso7WyW9u34Vwqv2L5DHF5rRaf9WSCKL+42j6D
         sTsko0XWv/xQ3arflI694ZIhCh54TuUiXuSReVeG4nsdfYAx1jK8QJf8lwJC1b0ugrvg
         +RP1QuPDBGV1ZSp/zvIsyRKloDrOWI3p2hrm/8AVOXa2zEeXEX82q0sCAb2jGwMuXF4g
         /2ReUEHOTSgMrDGy+jyIek6skxY2OZkHy6r6YEa3aAzhdybCiZjSqeTZNjJQ8d8nSY2S
         ot4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lhOA0nGrbjhRPVswA/mywNHLTKJKSXnKV9s3KRuT9b0=;
        b=bqt8TZL46XHlspCSjlpLQ1Al5XNLlGflPKlT1r08WJ/3pUdoKgz4wYawK9DiLGHsV1
         9HxgAU7BfHW+WMGsBJLpUwuWY67jWELkxlhUTrfc/G0Jps4t6uB0l/myZeMQPG6PRQfG
         JcpSBvLSshGvH1RHr8MaTqBDuY2SzqgQTY9lR3zva1hPhZtLA9Byfp1A3FMHSpqS5l05
         ikBT0B0lWgsITjeY27eljw8hW74NVWz5efm1MrfwgKPzB5zM6HouGSOGPsCLCnkgH0FD
         JKHDkEWYKa++c5wNwhJvQOyxeB/kA/0eOJHSDnyGCpuvMDpClXk5hyET7yCaiYhbAxPW
         6C+Q==
X-Gm-Message-State: AOAM531UNyqxfYRqVqG16ay5S+fzR9X93ImTIG4wPGyzYFh9z+csqyJ6
        rlY8nFRMb2l3xJAHdTDxOG8=
X-Google-Smtp-Source: ABdhPJwrg5MzG8QRD1JUtBgAuC+Cuk6MZaXdsiHLg5dbQBqrcdPsR4+dfoUF+OL919y4bNLZoHDv+A==
X-Received: by 2002:a63:7e11:: with SMTP id z17mr1517467pgc.9.1623208028225;
        Tue, 08 Jun 2021 20:07:08 -0700 (PDT)
Received: from [192.168.1.67] (99-44-17-11.lightspeed.irvnca.sbcglobal.net. [99.44.17.11])
        by smtp.gmail.com with ESMTPSA id 78sm12733364pgg.73.2021.06.08.20.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 20:07:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] mmc: sdhci-iproc: Add support for the legacy sdhci
 controller on the BCM7211
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Al Cooper <alcooperx@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Ray Jui <rjui@broadcom.com>, Rob Herring <robh+dt@kernel.org>,
        Scott Branden <sbranden@broadcom.com>
References: <20210602192758.38735-1-alcooperx@gmail.com>
 <20210602192758.38735-2-alcooperx@gmail.com>
 <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fe956941-bb39-413e-f051-d9f353f64eda@gmail.com>
Date:   Tue, 8 Jun 2021 20:07:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPDyKFrynST66yA_T3iroiJsfmNuBOEiiBnb=vNoyP6QpvZ7aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 6/8/2021 5:40 AM, Ulf Hansson wrote:
> On Wed, 2 Jun 2021 at 21:28, Al Cooper <alcooperx@gmail.com> wrote:
>>
>> Add support for the legacy Arasan sdhci controller on the BCM7211 and
>> related SoC's. This includes adding a .shutdown callback to increase
>> the power savings during S5.
> 
> Please split this into two separate changes.
> 
> May I also ask about the ->shutdown() callback and in relation to S5.
> What makes the ->shutdown callback only being invoked for S5?

It is not only called for S5 (entered via poweroff on a prompt) but also
during kexec or reboot. The poweroff path is via:

kernel_power_off() -> kernel_shutdown_prepare() -> device_shutdown() ->
.shutdown()

For kexec or reboot we do not really care about power savings since we
are about to load a new image anyway, however for S5/poweroff we do care
about quiescing the eMMC controller in a way that its clocks and the
eMMC device can be put into low power mode since we will stay in that
mode for seconds/hours/days until someone presses a button on their
remote (or other wake-up sources).
-- 
Florian
