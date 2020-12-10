Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662F8C433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 18:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2229823BE5
	for <linux-mmc@archiver.kernel.org>; Thu, 10 Dec 2020 18:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392901AbgLJSWm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Dec 2020 13:22:42 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:51879 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390976AbgLJSWd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Dec 2020 13:22:33 -0500
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5F5E924000D;
        Thu, 10 Dec 2020 18:21:50 +0000 (UTC)
Date:   Thu, 10 Dec 2020 19:21:50 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] mmc: atmel-mci: =?utf-8?Q?Redu?=
 =?utf-8?Q?ce_scope_for_the_variable_=E2=80=9Cslot?= =?utf-8?B?4oCd?= in
 atmci_request_end()
Message-ID: <20201210182150.GE1578121@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
 <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
 <20201210170723.GD1578121@piout.net>
 <2667790c-fad2-aaa9-36e8-6be66949ac8d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2667790c-fad2-aaa9-36e8-6be66949ac8d@web.de>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 10/12/2020 18:23:05+0100, Markus Elfring wrote:
> >> Can the extra null pointer initialisation trigger a source code analysis warning
> >> like “Addresses-Coverity: ("Unused value")” for this function implementation?
> >>
> >
> > Did you check, does it? It doesn't.
> >
> > Are you wasting maintainer and reviewer's time? Yes you are.
> 
> How do you think about a patch like “staging: speakup: remove redundant initialization
> of pointer p_key” for comparison?
> https://lore.kernel.org/patchwork/patch/1199128/
> https://lore.kernel.org/driverdev-devel/20200223153954.420731-1-colin.king@canonical.com/
> 
> Would you tolerate to omit the initialisation for the variable “slot”?
> 

If you were able to provide one good technical reason.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
