From: Oleksandr Natalenko <pfactum@gmail.com>
Subject: Re: [Bugme-new] [Bug 16627] New: sdhci shows backtrace while resuming
 after s2disk
Date: Fri, 20 Aug 2010 12:16:19 +0300
Message-ID: <AANLkTikRJ1ypra6Rhet5w1GPAUGGdYFku5qpJU6hdMAp@mail.gmail.com>
References: <bug-16627-10286@https.bugzilla.kernel.org/>
	<20100819154539.31c4e6b9.akpm@linux-foundation.org>
	<1282289246.4600.9.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:57107 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143Ab0HTJQU (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 05:16:20 -0400
Received: by bwz11 with SMTP id 11so1924480bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 02:16:19 -0700 (PDT)
In-Reply-To: <1282289246.4600.9.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, David Woodhouse <dwmw2@infradead.org>

> This doesn't happen very often I guess, right?

It happens on every resume.

> If you can recompile kernel, try to disable CONFIG_MMC_RICOH_MMC
> (This will make you loose the mmc support, but if you get 2.6.36-rc1,
> you will get mmc support anyway via the non standard mmc controller,
> which turned out to be almost standard SDHCI controller.)

Yes, disabling CONFIG_MMC_RICOH_MMC resolves the problem. It seems,
it's buggy enough.
