Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE0C83017
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 09:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B7EB21D7F
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Dec 2020 09:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388346AbgLAJ2o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:28:44 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:39436 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S2388339AbgLAJAh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2020 04:00:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 09D65200E20A;
        Tue,  1 Dec 2020 16:59:35 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6Fl7dA4AyUbw; Tue,  1 Dec 2020 16:59:34 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id D8F2A200E233;
        Tue,  1 Dec 2020 16:59:34 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.227])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 653CEC019E2;
        Tue,  1 Dec 2020 16:59:34 +0800 (HKT)
Subject: Re: [PATCH] mmc: core: MMC_CAP2_HS200_1_8V_SDR with mmc-hs400-1_8v
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Chris Ball <chris@printf.net>,
        Seungwon Jeon <tgih.jun@samsung.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201127044044.1127-1-chris.ruehl@gtsys.com.hk>
 <DM6PR04MB65753FC7EE5058C4A20F6D6FFCF60@DM6PR04MB6575.namprd04.prod.outlook.com>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <788655aa-ac05-54c4-a5ee-d2b08f464d66@gtsys.com.hk>
Date:   Tue, 1 Dec 2020 16:59:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB65753FC7EE5058C4A20F6D6FFCF60@DM6PR04MB6575.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

I have to callback my patch,
The mmc.c logic needs the MMC_CAP2_HS200_1_8V_SDR in the current implementation.

If I want to precise use mmc-hs400-1_8v or mmc-hs200-1_8v have their
explicit code-path its needs a bigger effort.

On it.

@Avri Altman , I have to reject your ACK. :)

Chris


On 29/11/2020 8:28 pm, Avri Altman wrote:
>   
>> This patch remove the MMC_CAP2_HS200_1_8V_SDR capacity from
>> host->cap2 when the dt property mmc-hs400-1v8 set. It cause
>> error and occasionally hang on boot and reboot.
>> Board with this issue: rk3399 with SanDisk DG4008 eMMC.
>>
>> This patch did not change the mmc-hs400-1_2v host->cap2
>> added the MMC_CAP2_HS200_1_2V_SDR.
>>
>> Log shows a boot process with a HS400 5.1 capable SanDisk 8G
>> with mmc-hs400-1_8v dt property and the MMC_CAP2_HS200_1_8V_SDR
>> append to the host->cap2.
>>
>> [    1.775721] mmc1: CQHCI version 5.10
>> [    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci]
>> using ADMA
>> [    2.007581] mmc1: mmc_select_hs200 failed, error -110
>> [    2.007589] mmc1: error -110 whilst initialising MMC card
>> [    2.413559] mmc1: mmc_select_hs200 failed, error -110
>> [    2.413562] mmc1: error -110 whilst initialising MMC card
>> [    3.183343] mmc1: Command Queue Engine enabled
>> [    3.183355] mmc1: new HS400 MMC card at address 0001
>> [    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB
>> [    3.197256] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
>> [    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
>> [    3.197479] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev
>> (242:0)
>>
>> after patch applied
>> [    1.746691] mmc1: CQHCI version 5.10
>> [    1.773316] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci]
>> using ADMA
>> [    1.858410] mmc1: Command Queue Engine enabled
>> [    1.858418] mmc1: new HS400 MMC card at address 0001
>> [    1.858897] mmcblk1: mmc1:0001 DG4008 7.28 GiB
>> [    1.859002] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
>> [    1.859097] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
>> [    1.859182] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev
>> (242:0)
>>
>> Fixes: c373eb489b27b mmc: core: add DT bindings for eMMC HS400 1.8/1.2V
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
> Acked-by: Avri Altman <avri.altman@wdc.com>
> 

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html
