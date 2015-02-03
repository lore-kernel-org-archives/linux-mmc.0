From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] mmc: moxart: fix probe logic
Date: Tue, 03 Feb 2015 10:06:51 +0100
Message-ID: <11355014.PH1MhDAcRs@wuerfel>
References: <4754899.RDUhFfxBSW@wuerfel> <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com> <CAPDyKFoppJBHx4nio111GM9RPv8pkfm4yZg2+AedLjnSZhmFsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:61665 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbBCJHd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Feb 2015 04:07:33 -0500
In-Reply-To: <CAPDyKFoppJBHx4nio111GM9RPv8pkfm4yZg2+AedLjnSZhmFsg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jonas Jensen <jonas.jensen@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Tuesday 03 February 2015 09:02:22 Ulf Hansson wrote:
> > @@ -586,10 +588,11 @@ static int moxart_probe(struct platform_device *pdev)
> >                 goto out;
> >         }
> >
> > -       clk = of_clk_get(node, 0);
> 
> This code would be simpler using devm_clk_get(), since then error
> wouldn't be needed.
> 
> Any reason to why you don't want to use that?

You are absolutely right, and that would have avoided both of the bugs
I introduced.

	Arnd
