Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 204FCC4361B
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 13:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D809522D04
	for <linux-mmc@archiver.kernel.org>; Sat, 12 Dec 2020 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgLLNSL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 12 Dec 2020 08:18:11 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:42241 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgLLNSL (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Dec 2020 08:18:11 -0500
X-Greylist: delayed 159006 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Dec 2020 08:18:11 EST
X-Originating-IP: 86.194.74.19
Received: from localhost (lfbn-lyo-1-997-19.w86-194.abo.wanadoo.fr [86.194.74.19])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id AE282FF804;
        Sat, 12 Dec 2020 13:17:27 +0000 (UTC)
Date:   Sat, 12 Dec 2020 14:17:27 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Markus Elfring <Markus.Elfring@web.de>, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: mmc: atmel-mci: Reduce =?utf-8?Q?scope?=
 =?utf-8?Q?_for_the_variable_=E2=80=9Cslot=E2=80=9D?= in atmci_request_end()
Message-ID: <20201212131727.GL1781038@piout.net>
References: <466b4c6d-032f-fbcc-58ac-75f6f39d734f@web.de>
 <20201210151035.GC1578121@piout.net>
 <ec71d7b8-a36b-04f5-77a8-22874ac241e1@web.de>
 <20201210170723.GD1578121@piout.net>
 <2667790c-fad2-aaa9-36e8-6be66949ac8d@web.de>
 <20201210182150.GE1578121@piout.net>
 <4c0d8efe-de25-f168-8b8d-b7f1ede6c6b1@web.de>
 <20201211080301.GC1781038@piout.net>
 <031a64e4261e1543a136d737436abefd63dbaee1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <031a64e4261e1543a136d737436abefd63dbaee1.camel@perches.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 12/12/2020 01:16:39-0800, Joe Perches wrote:
> On Fri, 2020-12-11 at 09:03 +0100, Alexandre Belloni wrote:
> > On 11/12/2020 07:34:41+0100, Markus Elfring wrote:
> > > > > How do you think about a patch like “staging: speakup: remove redundant initialization
> > > > > of pointer p_key” for comparison?
> > > > > https://lore.kernel.org/patchwork/patch/1199128/
> > > > > https://lore.kernel.org/driverdev-devel/20200223153954.420731-1-colin.king@canonical.com/
> > > > > 
> > > > > Would you tolerate to omit the initialisation for the variable “slot”?
> > > > 
> > > > If you were able to provide one good technical reason.
> > > 
> > > I find that the positions of variable definitions (and similar assignments) influence
> > > the generation of executable code.
> > > 
> > And you are wrong, it doesn't.
> 
> I rarely reply or read any Markus' emails as everything
> from Markus goes into a 'don't read' folder but I was cc'd
> directly on one from someone else recently so I think I
> should reply to this one too.
> 
> In this case Alexandre it seems true, but in the generic case
> it may be false.  It may depend on stack size and location.
> 
> For instance, with large structs declared either at the top
> of a function or in separate branches within the function:
> 

I think you realize your example is way more complicated than
initializing basic type variable to 0 or NULL which has probably been
optimized forever.

This patch is just unnecessary churn that was generated without giving
any thought. It was easy to check whether the patch actually improved
anything. It doesn't and makes readability worse.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
