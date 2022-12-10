Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39EC4332F
	for <linux-mmc@archiver.kernel.org>; Sat, 10 Dec 2022 18:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLJS4o (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 10 Dec 2022 13:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiLJS4n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 10 Dec 2022 13:56:43 -0500
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499531789C
        for <linux-mmc@vger.kernel.org>; Sat, 10 Dec 2022 10:56:43 -0800 (PST)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id 451cprUINGPMs451cpi102; Sat, 10 Dec 2022 19:56:41 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Dec 2022 19:56:41 +0100
X-ME-IP: 86.243.100.34
Message-ID: <2c481903-74be-6dbd-8ef9-5f01301792a7@wanadoo.fr>
Date:   Sat, 10 Dec 2022 19:56:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/3] mmc: sunlpus: Fix an error handling path in
 spmmc_drv_probe()
To:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        Li-hao Kuo <lhjeff911@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mmc@vger.kernel.org
References: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
Content-Language: fr, en-US
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <7c686fecb11b4ec1f55cd7075dc7cfcdd9b445ba.1670697358.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Le 10/12/2022 à 19:36, Christophe JAILLET a écrit :
> If an error occurs after successful clk_prepare_enable() call in the probe,
> the clk is not clk_disable_unprepare()'ed.
> 
> Use devm_clk_get_enabled() instead of devm_clk_get() to fix, and simplify
> the probe and the remove function accordingly.
> 
> Fixes: 4e268fed8b18 ("mmc: Add mmc driver for Sunplus SP7021")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This changes the order of resource releasing when the driver is removed,
> but it looks ok to me.
> ---
>   drivers/mmc/host/sunplus-mmc.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 

Hi, in the whole serie, the subject was supposed to be sunplus, not sunlpus.
Could also be SP7021, or sunplus-SP7021, or whatever else.

I'll wait for potential comments on the patches themselves before 
sending a v2 to fix the subject (and I hope it could be fixed when 
applied if there is no comment :))

CJ

