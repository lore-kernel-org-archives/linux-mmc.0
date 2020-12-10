Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47CA6C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 17:21:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B5D23DB3
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 17:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390049AbgLJRVH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 12:21:07 -0500
Received: from mslow2.mail.gandi.net ([217.70.178.242]:38566 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389954AbgLJRT3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 12:19:29 -0500
Received: from relay9-d.mail.gandi.net (unknown [217.70.183.199])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id EBFED3A5AD5;
        Thu, 10 Dec 2020 17:08:34 +0000 (UTC)
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 46927FF80D;
        Thu, 10 Dec 2020 17:07:24 +0000 (UTC)
Date:   Thu, 10 Dec 2020 18:07:23 +0100
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
Message-ID: <20201210170723.GD1578121@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
 <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/12/2020 17:35:31+0100, Markus Elfring wrote:
> >> A local variable was used only within an if branch.
> >> Thus move the definition for the variable “slot” into the corresponding
> >> code block.
> >>
> >
> > What is the improvement here?
> 
> A possible refactoring.
> https://refactoring.com/catalog/reduceScopeOfVariable.html
> 

I quote:
"Since declarations of variables in many cases costs computational
cycles, you may end up wasting time for nothing."

This is false, it doesn't.

I also quote:
"When I'm writing new code I find I don't scope my temps any less than
method scope. This is because I keep my methods short, so reducing scope
any further doesn't add much value. The value of this refactoring is in
breaking up a large method."

Is that function large? It is not.


> 
> > This makes the code harder to read.
> 
> Can the extra null pointer initialisation trigger a source code analysis warning
> like “Addresses-Coverity: ("Unused value")” for this function implementation?
> 

Did you check, does it? It doesn't.

Are you wasting maintainer and reviewer's time? Yes you are.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
