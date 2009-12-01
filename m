From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] sdio: Fix crash in mmc_attach_sdio() error path
Date: Tue, 01 Dec 2009 16:00:29 +0000
Message-ID: <1259683229.2124.35.camel@localhost.localdomain>
References: <20091201151300.A34C29D404F@zog.reactivated.net>
	 <20091201155325.GB21413@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:64874 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753093AbZLAQA1 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 11:00:27 -0500
Received: by ewy19 with SMTP id 19so5083426ewy.21
        for <linux-mmc@vger.kernel.org>; Tue, 01 Dec 2009 08:00:32 -0800 (PST)
In-Reply-To: <20091201155325.GB21413@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: akpm@linux-foundation.org, linux-mmc@vger.kernel.org

On Tue, 2009-12-01 at 15:53 +0000, Matt Fleming wrote:
> I don't understand what you're trying to do here. The card->sdio_funcs++
> should take care of incrementing the sdio_funcs count properly. When the
> loop terminates both "i" and "card->sdio_funcs" will be equal to
> "funcs", unless we jump to the remove label. Unless I've missed
> something?

Sorry, that was indeed a small mistake.

> Isn't this hunk below fixing a slightly different bug? Admittedly, it
> could cause a crash, but I think it warrants a separate patch and
> changelog.
> 
> I assumed you would be sending a patch just for this bug below and not
> for the one above (which I is why I submitted one). I wasn't very clear
> about that though ;-)

OK, I'll resend that part alone.

Thanks,
Daniel


