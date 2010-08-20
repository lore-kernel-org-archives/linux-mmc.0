From: Oleksandr Natalenko <pfactum@gmail.com>
Subject: Re: [Bugme-new] [Bug 16627] New: sdhci shows backtrace while resuming
 after s2disk
Date: Fri, 20 Aug 2010 13:38:14 +0300
Message-ID: <AANLkTimbpQ6K8k0GjT-2M5C=icgbE-kSkBTXrm+1A85S@mail.gmail.com>
References: <bug-16627-10286@https.bugzilla.kernel.org/>
	<20100819154539.31c4e6b9.akpm@linux-foundation.org>
	<1282289246.4600.9.camel@maxim-laptop>
	<AANLkTikRJ1ypra6Rhet5w1GPAUGGdYFku5qpJU6hdMAp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51397 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132Ab0HTKiQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 Aug 2010 06:38:16 -0400
Received: by bwz11 with SMTP id 11so1967234bwz.19
        for <linux-mmc@vger.kernel.org>; Fri, 20 Aug 2010 03:38:14 -0700 (PDT)
In-Reply-To: <AANLkTikRJ1ypra6Rhet5w1GPAUGGdYFku5qpJU6hdMAp@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, bugzilla-daemon@bugzilla.kernel.org, bugme-daemon@bugzilla.kernel.org, David Woodhouse <dwmw2@infradead.org>

2.6.36-rc1-git2 with CONFIG_MMC_RICOH_MMC=y seems to work well. So,
should I leave this option enabled?
