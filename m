Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF7C433FE
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 03:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FF423A5B
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Dec 2020 03:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgLHDY0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 7 Dec 2020 22:24:26 -0500
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:60670 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgLHDY0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Dec 2020 22:24:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 5668F2003A7D;
        Tue,  8 Dec 2020 11:23:39 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tFy-bk8hPOh7; Tue,  8 Dec 2020 11:23:39 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 30B012003A51;
        Tue,  8 Dec 2020 11:23:39 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.188.227])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 5B8E5C01F98;
        Tue,  8 Dec 2020 11:23:38 +0800 (HKT)
Subject: Re: [PATCH 2/3] mmc: core: make hs400 independent from hs200 init
To:     Avri Altman <Avri.Altman@wdc.com>
Cc:     Jack <jack.lo@gtsys.com.hk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Krishna Konda <kkonda@codeaurora.org>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201203093338.10480-1-chris.ruehl@gtsys.com.hk>
 <20201203093338.10480-3-chris.ruehl@gtsys.com.hk>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <c5fc72e6-a6b6-8351-97b1-f2b1771395c3@gtsys.com.hk>
Date:   Tue, 8 Dec 2020 11:23:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201203093338.10480-3-chris.ruehl@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 3/12/2020 5:33 pm, Chris Ruehl wrote:
> Move mmc_select_hs400() out from hs200 init path and make hs400
> independent.
> 
> The patch makes quite some changes and needs to be reviewed carefully.
> 
> In function mmc_select_timing() call for mmc_select_hs400().
> HS400 requires a host bus with of 8bit, if not supported we
> return with -ENOTSUPP, there is no retry.
> If the host controller can't switch to 8bit (dts: bus-width = <4>)
> it can't recover on next power-up init failed.
> Have the controller set to HS mode, make the hs400 tuning prepare
> if any and run mmc tuning before switching to HS400.
> 
> This patch resolve the problem if hs400-1_8v is set but extended
> strobe is not.
> 
> &sdhci { // eMMC
>          bus-width = <8>;
>          mmc-hs400-1_8v;
>          // mmc-hs400-enhanced-strobe;
>          non-removable;
>          status = "okay";
> };
> 
> [    1.775721] mmc1: CQHCI version 5.10
> [    1.802342] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
> [    2.007581] mmc1: mmc_select_hs200 failed, error -110
> [    2.007589] mmc1: error -110 whilst initialising MMC card
> [    2.413559] mmc1: mmc_select_hs200 failed, error -110
> [    2.413562] mmc1: error -110 whilst initialising MMC card
> [    3.183343] mmc1: Command Queue Engine enabled
> [    3.183355] mmc1: new HS400 MMC card at address 0001
> [    3.197163] mmcblk1: mmc1:0001 DG4008 7.28 GiB
> [    3.197256] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
> [    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
> [    3.197360] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
> [    3.197479] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)
> 
> [    1.743386] mmc1: CQHCI version 5.10
> [    1.769952] mmc1: SDHCI controller on fe330000.sdhci [fe330000.sdhci] using ADMA
> [    1.846223] mmc1: Command Queue Engine enabled
> [    1.846230] mmc1: new HS400 MMC card at address 0001
> [    1.846557] mmcblk1: mmc1:0001 DG4008 7.28 GiB
> [    1.846650] mmcblk1boot0: mmc1:0001 DG4008 partition 1 4.00 MiB
> [    1.846742] mmcblk1boot1: mmc1:0001 DG4008 partition 2 4.00 MiB
> [    1.846825] mmcblk1rpmb: mmc1:0001 DG4008 partition 3 4.00 MiB, chardev (242:0)
> 
> Tested with rk3399 customized board.
> 

Find that patch missed something
-       } else if (!mmc_card_hs400es(card)) {
+       } else if (!mmc_card_hs400es(card) && !mmc_card_hs400(card)) {

will update my patches and resend v2

Chris
