Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239FDC35646
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025A320656
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 14:43:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgBUOnt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:43:49 -0500
Received: from smtprelay0079.hostedemail.com ([216.40.44.79]:50272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728837AbgBUOnt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Feb 2020 09:43:49 -0500
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 09:43:48 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 5CC0E1801A5FB
        for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2020 14:38:24 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 70FCC182CED2A;
        Fri, 21 Feb 2020 14:38:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shoes55_83332b2bd2b05
X-Filterd-Recvd-Size: 2507
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 21 Feb 2020 14:38:21 +0000 (UTC)
Message-ID: <6e0f3988435bf55df19af2873314f283f25f72c6.camel@perches.com>
Subject: Re: [PATCH] mmc: core: Fix indentation
From:   Joe Perches <joe@perches.com>
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Fri, 21 Feb 2020 06:36:56 -0800
In-Reply-To: <20200221104341.583028-1-Jerome.Pouiller@silabs.com>
References: <20200221104341.583028-1-Jerome.Pouiller@silabs.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 2020-02-21 at 11:43 +0100, Jerome Pouiller wrote:
> sdio_single_irq_set() was indented with a mix of tabs and spaces.
[]
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
[]
> @@ -278,12 +278,12 @@ static void sdio_single_irq_set(struct mmc_card *card)
>  	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
>  	    card->host->sdio_irqs == 1)
>  		for (i = 0; i < card->sdio_funcs; i++) {
> -		       func = card->sdio_func[i];
> -		       if (func && func->irq_handler) {
> -			       card->sdio_single_irq = func;
> -			       break;
> -		       }
> -	       }
> +			func = card->sdio_func[i];
> +			if (func && func->irq_handler) {
> +				card->sdio_single_irq = func;
> +				break;
> +			}
> +		}
>  }

Perhaps it'd be better to add braces around the for loop too.
---
 drivers/mmc/core/sdio_irq.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 7ca7b9..3086ed 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -260,14 +260,15 @@ static void sdio_single_irq_set(struct mmc_card *card)
 
 	card->sdio_single_irq = NULL;
 	if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
-	    card->host->sdio_irqs == 1)
+	    card->host->sdio_irqs == 1) {
 		for (i = 0; i < card->sdio_funcs; i++) {
-		       func = card->sdio_func[i];
-		       if (func && func->irq_handler) {
-			       card->sdio_single_irq = func;
-			       break;
-		       }
-	       }
+			func = card->sdio_func[i];
+			if (func && func->irq_handler) {
+				card->sdio_single_irq = func;
+				break;
+			}
+		}
+	}
 }
 
 /**


