From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Ricoh SDHCI reader got broken by 3.3-rc1
Date: Sun, 29 Jan 2012 12:06:47 +0200
Message-ID: <1327831607.3960.2.camel@maxim-laptop>
References: <1327781974.3231.1.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60764 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab2A2KGw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Jan 2012 05:06:52 -0500
Received: by werb13 with SMTP id b13so2649483wer.19
        for <linux-mmc@vger.kernel.org>; Sun, 29 Jan 2012 02:06:50 -0800 (PST)
In-Reply-To: <1327781974.3231.1.camel@maxim-laptop>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

On Sat, 2012-01-28 at 22:19 +0200, Maxim Levitsky wrote: 
> I just installed that kernel, and card reader is completely quiet about
> SD/MMC/SDHCI cards. Nothing in the logs.
> I'll investigate that later.
> 
> 
As expected, CONFIG_MMC_UNSAFE_RESUME got broken again.
(Actually I just tested and on SD cards it was useless in 3.2 as well).
Awesome.


-- 
Best regards,
        Maxim Levitsky

Visit my blog: http://maximlevitsky.wordpress.com
Warning: Above blog contains rants.

