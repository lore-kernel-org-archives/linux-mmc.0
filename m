From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
Date: Thu, 15 Mar 2012 15:32:44 +0000
Message-ID: <201203151532.44363.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org> <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com> <4F6209DA.1080809@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58817 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760965Ab2COPdJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Mar 2012 11:33:09 -0400
In-Reply-To: <4F6209DA.1080809@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Per Forlin <per.forlin@stericsson.com>, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org

On Thursday 15 March 2012, Lee Jones wrote:
> > I would like to see what the minimal required change is to support DT
> > for mmci without factorization.
> > 1. Minimal change in mmci.
> > 2. Add mmci_dt.c which contains the DT-populate code.
> > 
> > The factorization could be done as step 2 I think.
> > 
> > What do you say?
> 
> I'm wondering what the difference is as the work has already been done.
> 
> It was Arnd's suggestion to separate out the two types of variants, and
> I'm quite fond of the new (fully featured) layout.

Right, I usually prefer cleanups or other refactoring to be done first, and
then features added on top.

You could in theory add have just patches 3/4/5 all applied without
the refactoring, but that I would be worried that this causes dependencies
between the mmci driver and ux500 specific functionality like the
stedma40_filter function.

	Arnd
