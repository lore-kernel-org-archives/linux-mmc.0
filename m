From: Oleksandr Natalenko <pfactum@gmail.com>
Subject: Re: [Bugme-new] [Bug 16627] New: sdhci shows backtrace while resuming
 after s2disk
Date: Fri, 20 Aug 2010 15:18:21 +0300
Message-ID: <AANLkTimyq9zqqvCbBkxg01Pys_7Cs6_qK10O+L1TYJFo@mail.gmail.com>
References: <bug-16627-10286@https.bugzilla.kernel.org/>
	<20100819154539.31c4e6b9.akpm@linux-foundation.org>
	<1282289246.4600.9.camel@maxim-laptop>
	<AANLkTikRJ1ypra6Rhet5w1GPAUGGdYFku5qpJU6hdMAp@mail.gmail.com>
	<AANLkTimbpQ6K8k0GjT-2M5C=icgbE-kSkBTXrm+1A85S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41851 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab0HTMSW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 08:18:22 -0400
Received: by bwz11 with SMTP id 11so2025021bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 05:18:21 -0700 (PDT)
In-Reply-To: <AANLkTimbpQ6K8k0GjT-2M5C=icgbE-kSkBTXrm+1A85S@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, David Woodhouse <dwmw2@infradead.org>

> You can try, but it should give the same problem sooner or later.
> Nothing significant changed, so probably timing helps you.

If I disable CONFIG_MMC_RICOH_MMC in 2.6.36-rc1, shall I get the same
functionality of my card reader?

> Anyway, can you show me lspci from 2.6.36-rc1-git2 ater you did a cold boot and
> few suspend/resume cycles (one is enough)

Sure, you may grab it from attach, but there's no difference between outputs.
