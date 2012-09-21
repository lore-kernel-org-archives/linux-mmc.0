From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 1/2] mmc: Move mmc_delay() to include/linux/mmc/core.h
Date: Fri, 21 Sep 2012 12:33:54 +0000
Message-ID: <201209211233.54545.arnd@arndb.de>
References: <1344637513-29383-1-git-send-email-Chunhe.Lan@freescale.com> <201208101327.47789.arnd@arndb.de> <505CD3A5.6080101@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:61932 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503Ab2IUMeH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Sep 2012 08:34:07 -0400
In-Reply-To: <505CD3A5.6080101@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chunhe Lan <b25806@freescale.com>
Cc: Chunhe Lan <Chunhe.Lan@freescale.com>, linux-mmc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com, cjb@laptop.org, Kumar Gala <galak@kernel.crashing.org>

On Friday 21 September 2012, Chunhe Lan wrote:
> On 08/10/2012 09:27 AM, Arnd Bergmann wrote:
> > On Friday 10 August 2012, Chunhe Lan wrote:
> >
> >       cond_resched();
> >       mdelay(ms);
> >
> > sets off alarm bells, and I would always replace that with msleep().
>      I think that it does not replace with msleep().
>      When the time of sleep is very short, program should not been scheduled
>      in the context. Because it expends the more time.
> 

A time measured in miliseconds is never "very short" for the scheduler,
a lot of things can happen during that time span. The code I quoted
also does not care too much about accuracy, otherwise it would adapt
the time in the mdelay based on whether the cond_resched() actually
schedules to another thread.

	Arnd
