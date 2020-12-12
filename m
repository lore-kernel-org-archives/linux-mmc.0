Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231E5C433FE
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 18:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8E3D2076A
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 18:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgLLStk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 12 Dec 2020 13:49:40 -0500
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:42224 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726167AbgLLStj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Dec 2020 13:49:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B983F180A7FE4;
        Sat, 12 Dec 2020 18:48:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hour92_2d166912740b
X-Filterd-Recvd-Size: 2591
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 12 Dec 2020 18:48:56 +0000 (UTC)
Message-ID: <03bb4d4436ca7022effbf23551ada24ff9eeb4c6.camel@perches.com>
Subject: Re: mmc: atmel-mci: Reduce scope for the variable
 =?UTF-8?Q?=E2=80=9Cslot=E2=80=9D?= in atmci_request_end()
From:   Joe Perches <joe@perches.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Date:   Sat, 12 Dec 2020 10:48:55 -0800
In-Reply-To: <20201212131727.GL1781038@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
         <20201210151035.GC1578121@piout.net>
         <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
         <20201210170723.GD1578121@piout.net>
         <2667790c-fad2-aaa9-36e8-6be66949ac8d@web.de>
         <20201210182150.GE1578121@piout.net>
         <4c0d8efe-de25-f168-8b8d-b7f1ede6c6b1@web.de>
         <20201211080301.GC1781038@piout.net>
         <031a64e4261e1543a136d737436abefd63dbaee1.camel@perches.com>
         <20201212131727.GL1781038@piout.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 2020-12-12 at 14:17 +0100, Alexandre Belloni wrote:
> On 12/12/2020 01:16:39-0800, Joe Perches wrote:
> > In this case Alexandre it seems true, but in the generic case
> > it may be false.  It may depend on stack size and location.
> > 
> > For instance, with large structs declared either at the top
> > of a function or in separate branches within the function:
>
> I think you realize your example is way more complicated than
> initializing basic type variable to 0 or NULL which has probably been
> optimized forever.

Maybe.

Markus does a lot of what most (or perhaps some) consider thoughtless.

A generic point might be maximizing the local scope of declarations.

Maximizing the local scope can make reading easier as the type of an
automatic used for a temporary purpose can be found closer to the code
that uses it.  This is especially true for long line-count functions.

IMO: it's a reasonable goal though in this instance perhaps unnecessary.

cheers, Joe


