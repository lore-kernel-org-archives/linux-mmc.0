Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60693C61DA4
	for <linux-mmc@archiver.kernel.org>; Wed, 15 Mar 2023 10:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjCOKVi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 15 Mar 2023 06:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbjCOKVN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Mar 2023 06:21:13 -0400
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [IPv6:2a01:e0c:1:1599::13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540D883159
        for <linux-mmc@vger.kernel.org>; Wed, 15 Mar 2023 03:20:31 -0700 (PDT)
Received: from [IPV6:2a02:8428:2a4:1a01:41fa:9273:29e6:e64f] (unknown [IPv6:2a02:8428:2a4:1a01:41fa:9273:29e6:e64f])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 8C4F819F59E;
        Wed, 15 Mar 2023 11:20:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678875627;
        bh=nWSEty1byYWo8qP4mOf1GIvttLCcvIlo2/PFs/Pp+u4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GVN6b8pYo2aJTLMoR78vO3Rn+3H8rkkay6KXmr7Yl0Xu8kUvtBAWUU4BXyQMqTYHo
         OiNhUTrNcXdESVHXgMuDqymD1S3WRe2YoRXxbxjLiUtxtt4jBsLPxYhfMZtzk4TkXY
         LvJ8lVTLJGqUuZRT7CBrnZzZFJ8DmkS9Tr7HErcshFZ/LgIPiO9WoQbVp37Zfcp0Zg
         CvMz7edKGP24XdlgFeSquvFFc6ocQ66S2f4IR1Ig4ESLEp49KrKceGow/0Kq7hzF0G
         4bV54pbhTd8Ib9k6fgblFyI1sQ4KVdKdDoTRT5ZVsfg3AB5DkCF0xremmjMXbSiBHT
         I4r64/2i6pFug==
Message-ID: <b6971cd6-80f2-522a-64fb-82b126500010@free.fr>
Date:   Wed, 15 Mar 2023 11:20:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
 <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
Content-Language: fr, en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
In-Reply-To: <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 14/03/2023 20:45, Heiner Kallweit wrote:

> On 14.03.2023 18:24, Marc Gonzalez wrote:
> 
>> With the default power-up delay, on small kernels, the host probes
>> too soon, and mmc_send_io_op_cond() times out.
> 
> Looking at mmc_power_up() and how power_delay_ms is used
> I wonder what you mean with "host probes too soon".

Hello Heiner,

Thanks for your interest in my patch! :)

I should have added a link to the thread that led to the patch.
https://patchwork.kernel.org/project/linux-wireless/patch/c1a215cf-94be-871b-2a8a-3cc381588f83@free.fr/
Start at "I have run into another issue."

Basically, I have an S905X2-based board.
I built a small kernel for it (with only a few drivers), that boots really fast.

mmc2 (SDIO controller hooked to WiFi chip) would not probe at all,
unless I added lots of printks.
Basically, calling mmc_send_io_op_cond() too soon after the controller
has been reset leads to the CMD5 request timing out.


> Are you sure that the additional delay is needed for the Amlogic MMC
> block IP in general? Or could it be that your issue is caused by
> a specific regulator and you need to add a delay there?

The eternal question...

I have only one type of board. (Actually, I have a reference design
that is slightly different, so I should test on that one as well.)

In vendor kernels, they add delays to the WiFi drivers.
Maybe they have run into the issue, and they're just fixing the symptom?

Default value for ios.power_delay_ms is 10 ms.
msleep(ios.power_delay_ms) is called twice in mmc_power_up().
So raising the delay from 10 to 20 adds 20 ms
to the latency of initializing SDIO/SD/MMC controllers.

Would you be willing to test if the problem manifests on your board?

Regards


