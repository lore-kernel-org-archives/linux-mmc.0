From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] MMC: pxamci: call pdata->setpower even when regulator is
	used
Date: Wed, 2 Dec 2009 12:34:53 +0800
Message-ID: <f17812d70912012034t57ebde8fmb7f7971109436775@mail.gmail.com>
References: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f192.google.com ([209.85.221.192]:39005 "EHLO
	mail-qy0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719AbZLBEfH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 23:35:07 -0500
Received: by qyk30 with SMTP id 30so2499993qyk.33
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2009 20:35:13 -0800 (PST)
In-Reply-To: <1259233813-2724-1-git-send-email-daniel@caiaq.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <daniel@caiaq.de>
Cc: linux-arm-kernel@lists.infradead.org, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org

On Thu, Nov 26, 2009 at 7:10 PM, Daniel Mack <daniel@caiaq.de> wrote:
> On platforms where the vmmc regulator is used, it might still be
> necessary to call the platform data's setpower() callback in order to
> drive GPIOs to power up hardware.
>
> I can't see any pxamci user with power regulators enabled, hence this
> shouldn't break anything.
>

I was thinking about this for quite a time, and I'm afraid that this patch
solves only one corner case - that some specific actions need to be
taken _after_ mmc regulator is adjusted, while excluding the possibility
for that to happen _before_. I wonder maybe for those corner cases,
if one can just manipulate the vmmc regulator and other specific stuffs
within ->setpower().
