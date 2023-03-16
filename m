Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D41C6FD1F
	for <linux-mmc@archiver.kernel.org>; Thu, 16 Mar 2023 13:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjCPNCa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 16 Mar 2023 09:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjCPNCa (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Mar 2023 09:02:30 -0400
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34B8ABAE4
        for <linux-mmc@vger.kernel.org>; Thu, 16 Mar 2023 06:02:27 -0700 (PDT)
Received: from [192.168.108.81] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 680712003F3;
        Thu, 16 Mar 2023 14:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1678971746;
        bh=cuBdFodgiC7pFNZppqxzrLVS/5uvhqsnwEVP8Da2VBs=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=IHdr8bngx4kQQdeeYA6dZU4eWsUhudMub82nA4Ul2a+ZrFMGWFNRD2DfR3/0TWUJB
         mrVd2b/oSCwT7Wwa1zORuct9YiOcnReAVJR+fDlcpJ529Jo5IMdJ9swMFNKLM2eb/7
         iWsNVnlRf/T92b2OXOfHEQOZirt4QJzPeRnCWMMvsV6NpTCohmkLPVzDq088larwHB
         KcEQm4mnivS9KNTdiIWlLFQm7nr8TP7xoU+Dl6q0q02Xo+Jo6gz8RHBWlg9t597DO+
         DnPHdUdmm8cfR6QdKVnOml0i3cFjS+1VgtQvySbgBlFo7ArQ/5EDnhDLTwaEaJZzM5
         q3GNM+1XmN9zg==
Message-ID: <08471594-1c19-5123-4563-efbe8156bd74@free.fr>
Date:   Thu, 16 Mar 2023 14:02:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mmc: meson-gx: increase power-up delay
Content-Language: en-US
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Pierre-Hugues Husson <phh@phh.me>,
        Rong Chen <rong.chen@amlogic.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     MMC <linux-mmc@vger.kernel.org>,
        AML <linux-amlogic@lists.infradead.org>
References: <11a8a0c8-a5b1-8f38-a139-97172ab7be68@free.fr>
 <0696106f-8d70-6410-999a-fcda6c5b39c2@gmail.com>
 <b6971cd6-80f2-522a-64fb-82b126500010@free.fr>
 <1jcz5axc8j.fsf@starbuckisacylon.baylibre.com>
 <15b12187-abcc-b77f-6538-ffae5988bd2b@gmail.com>
 <36feb359-e59b-d28a-8651-3178b37eccf7@free.fr>
In-Reply-To: <36feb359-e59b-d28a-8651-3178b37eccf7@free.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 16/03/2023 13:32, Marc Gonzalez wrote:

> On 15/03/2023 22:14, Heiner Kallweit wrote:
> 
>> Then you mention "too soon after reset", but add a delay to power-up.
>> If the delay would be needed after reset, then shouldn't it be in
>> meson_mmc_probe() after the call to device_reset_optional()?
> 
> The first mmc_power_up() is called from:
> 
> [    0.916446]  mmc_power_up+0x2c/0xe4
> [    0.926186]  mmc_start_host+0x94/0xa0
> [    0.926197]  mmc_add_host+0x84/0xf0
> [    0.926205]  meson_mmc_probe+0x374/0x3f4
> [    0.933086]  platform_probe+0x68/0xe0
> [    0.940159]  really_probe+0xbc/0x2f0
> [    0.948008]  __driver_probe_device+0x78/0xe0
> [    0.955080]  driver_probe_device+0xd8/0x160
> [    0.955087]  __driver_attach_async_helper+0x4c/0xc0
> [    0.965689]  async_run_entry_fn+0x34/0xe0
> [    0.965699]  process_one_work+0x1cc/0x320
> [    0.972847]  worker_thread+0x14c/0x450
> [    0.972855]  kthread+0x10c/0x110
> [    1.018906]  ret_from_fork+0x10/0x20
> 
> 
> The second mmc_power_up() (prematurely exited) is called from:
> 
> [    1.061686]  mmc_power_up+0x2c/0xe4
> [    1.065136]  mmc_rescan+0x18c/0x310
> [    1.068586]  process_one_work+0x1cc/0x320
> [    1.072553]  worker_thread+0x14c/0x450
> [    1.076262]  kthread+0x10c/0x110
> [    1.086528]  ret_from_fork+0x10/0x20
> 
> 
> I'm confused about device_reset_optional() vs mmc_power_up().
> Do they both reset the controller?

NB: adding 500 ms delay after device_reset_optional() DOES NOT
fix the issue:

[    0.875494] >ffe03000.sd
[    0.875823] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    1.027111] >ffe07000.mmc
[    1.027430] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.405170] +mmc2
[    1.405389] -mmc2
[    1.405413] <ffe03000.sd
[    1.405500] +mmc2
[    1.412957] Q
[    1.420317] R
[    1.422590] mmc2: YO no device WTF

We enter mmc_power_up at 1.405170
We enter mmc_attach_sdio at 1.412957
Empirically, 8 ms is not enough time for the SDIO bus to be ready.



Reverting to default power_delay_ms.

[    0.879842] >ffe03000.sd
[    0.880189] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    1.031635] >ffe07000.mmc
[    1.031958] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.405284] +mmc2
[    1.430499] -mmc2
[    1.430525] <ffe03000.sd
[    1.430616] +mmc2
[    1.438065] Q
[    1.445404] R
[    1.447677] mmc2: YO no device WTF

We enter mmc_power_up at 1.405284
We enter mmc_attach_sdio at 1.438065
Empirically, 33 ms is not enough time for the SDIO bus to be ready.



Increasing power_delay_ms to 15.

[    0.879788] >ffe03000.sd
[    0.880092] meson-gx-mmc ffe03000.sd: allocated mmc-pwrseq
[    1.031437] >ffe07000.mmc
[    1.031767] meson-gx-mmc ffe07000.mmc: allocated mmc-pwrseq
[    1.405262] +mmc2
[    1.442981] -mmc2
[    1.443007] <ffe03000.sd
[    1.443099] +mmc2
[    1.450549] Q
[    1.565950] +mmc1
[    1.584306] mmc2: new ultra high speed SDR50 SDIO card at address 0001

We enter mmc_power_up at 1.405262
We enter mmc_attach_sdio at 1.450549
Empirically, 45 ms *is* enough time for the SDIO bus to be ready.


My gut feeling is that the problem with SDIO devices exists on all boards.
(I am well aware that I may be wrong.)

Would you be willing to test a small kernel?
I can provide a kernel defconfig and/or a buildroot defconfig.


Regards

