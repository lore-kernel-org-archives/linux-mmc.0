Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11626C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 15:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89D623D50
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 15:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbgLJPLa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:11:30 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47615 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732352AbgLJPLT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 10:11:19 -0500
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id E3ED01BF217;
        Thu, 10 Dec 2020 15:10:35 +0000 (UTC)
Date:   Thu, 10 Dec 2020 16:10:35 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mmc: atmel-mci: =?utf-8?Q?Redu?=
 =?utf-8?Q?ce_scope_for_the_variable_=E2=80=9Cslot?= =?utf-8?B?4oCd?= in
 atmci_request_end()
Message-ID: <20201210151035.GC1578121@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hello,

On 10/12/2020 16:01:44+0100, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 10 Dec 2020 15:56:13 +0100
> 
> A local variable was used only within an if branch.
> Thus move the definition for the variable “slot” into the corresponding
> code block.
> 

What is the improvement here?

This makes the code harder to read.

> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/mmc/host/atmel-mci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 444bd3a0a922..6a0d999ee82e 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -1558,7 +1558,6 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
>  	__releases(&host->lock)
>  	__acquires(&host->lock)
>  {
> -	struct atmel_mci_slot	*slot = NULL;
>  	struct mmc_host		*prev_mmc = host->cur_slot->mmc;
> 
>  	WARN_ON(host->cmd || host->data);
> @@ -1579,8 +1578,9 @@ static void atmci_request_end(struct atmel_mci *host, struct mmc_request *mrq)
>  	host->cur_slot->mrq = NULL;
>  	host->mrq = NULL;
>  	if (!list_empty(&host->queue)) {
> -		slot = list_entry(host->queue.next,
> -				struct atmel_mci_slot, queue_node);
> +		struct atmel_mci_slot *slot = list_entry(host->queue.next,
> +							 struct atmel_mci_slot,
> +							 queue_node);
>  		list_del(&slot->queue_node);
>  		dev_vdbg(&host->pdev->dev, "list not empty: %s is next\n",
>  				mmc_hostname(slot->mmc));
> --
> 2.29.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
