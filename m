Return-Path: <SRS0=bPLn=CF=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5BCC433DF
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 06:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B3820786
	for <linux-mmc@archiver.kernel.org>; Thu, 27 Aug 2020 06:07:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2jA0oE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0GHm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 Aug 2020 02:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0GHm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 Aug 2020 02:07:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F28C061249;
        Wed, 26 Aug 2020 23:07:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i14so2276528lfl.12;
        Wed, 26 Aug 2020 23:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=hmc6+AVmLvdvLf4AWknXtDxmdplb2vMzVZzZc7Kg5z4=;
        b=H2jA0oE+Ihn1WFLUhVm7op19MAw8Wy8UcsbgxCHfj8FbzYmDfURkbsShZwBuaeOu0p
         KNl+J1XgJDeBSK4+JEPXMKRRkZf3U93brXbm01l1pNqh0/WbAJugp4jXJwozU5jFeHEd
         UpBiRdTOjCH2v2IqC64BZVRiJbiyt0KKXUQSZFlzU81n9sJTnHpOFeVi5xVwIFY7lwlG
         /fhOpMicIRxEmO6c9yW30olvvApi7ymwQk7nq0x9DU+zCIzzFkQWY6uJauyO0HlEivB4
         p2i5XLxBkjg7w7eM++ccT0E4TkFQeq8Kv55XvqgHhTcFXMzbtXP3t4ExhCDc3R4zvIFa
         S3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=hmc6+AVmLvdvLf4AWknXtDxmdplb2vMzVZzZc7Kg5z4=;
        b=lv8FRr6ZRiymq06nTwRhmjDBQLvZ3sXgzdUIHB3YWWgJs+yg5P1+N/BZNrYYDj+RlJ
         bJF5pbuYp/+cpBytJtuZ1hJmCwyRxL0qUp83ehjW5Eyt+itA+NR1Lgknir9gGRpLEfZk
         vV1igYZZILBlaL+rTUNMO6IwDk+D5gG98YYs5OfsoBBVpRaORgUFe6AAyYECLy9rCMQK
         41hLxnzWoM46c57w5c42pNVdPmVUM03+DkLdsBogmQ9ynFCEe2Z4gImETub0cIxBlouJ
         j2qEyqCXOIz08QQXs5oGdULiw1h2B+EdrLfXiN66dIieIHHvpR/8c+QLJqsUq6v4qKHp
         tmbQ==
X-Gm-Message-State: AOAM530N7ZwOKwg07LsTCjijaATH17kCLFSCyX5K6x0WyfLWRwsTQif7
        XOYUaaVJYbOyARiMnX95buJ2goBKQ58=
X-Google-Smtp-Source: ABdhPJxfP3/WeM+nNrONYy5RkpF1jXFUKZ0YL60JfgugUzDtPXTFWQ+3Ddys9O4LVjZ4wtKt5X7Rsw==
X-Received: by 2002:a19:e07:: with SMTP id 7mr8964725lfo.6.1598508459278;
        Wed, 26 Aug 2020 23:07:39 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id b29sm255876lfq.69.2020.08.26.23.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 23:07:38 -0700 (PDT)
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list@cypress.com,
        brcm80211-dev-list.pdl@broadcom.com,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Subject: Broadcom WiFi SDIO performance regression after commit "mmc: sdhci:
 Remove finish_tasklet"
Message-ID: <5cf1af89-6026-09ad-7f20-82e19ad49fa1@gmail.com>
Date:   Thu, 27 Aug 2020 09:07:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello!

I was debugging WiFi performance problems on Acer A500 tablet device
that has BCM4329 WiFi chip which is connected to NVIDIA Terga20 SoC via
SDIO and found that the following commit causes a solid 5-10 Mbit/s of
WiFi throughput regression after 5.2 kernel:

commit c07a48c2651965e84d35cf193dfc0e5f7892d612
Author: Adrian Hunter <adrian.hunter@intel.com>
Date:   Fri Apr 5 15:40:20 2019 +0300

    mmc: sdhci: Remove finish_tasklet

    Remove finish_tasklet. Requests that require DMA-unmapping or
sdhci_reset
    are completed either in the IRQ thread or a workqueue if the
completion is
    not initiated by the IRQ.

Reverting the offending commit on top of recent linux-next resolves the
problem.

Ulf / Adrian, do you have any ideas what could be done in regards to
restoring the SDIO performance? Should we just revert the offending commit?
