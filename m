From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] powerpc/esdhc: enable the card insert/remove interrupt
Date: Fri, 26 Oct 2012 18:12:50 -0700
Message-ID: <20121027011249.GB9152@lizard>
References: <1350975677-8195-1-git-send-email-r66093@freescale.com>
 <20121023082648.GA21690@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1C68D9@039-SN1MPN1-003.039d.mgd.msft.net>
 <110EED8CC96DFC488B7E717A2027A27C1D7A42@039-SN1MPN1-003.039d.mgd.msft.net>
 <20121025103038.GA5107@lizard>
 <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:48408 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758292Ab2J0BPw (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Oct 2012 21:15:52 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1541516dak.19
        for <linux-mmc@vger.kernel.org>; Fri, 26 Oct 2012 18:15:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <110EED8CC96DFC488B7E717A2027A27C1DFBFB@039-SN1MPN1-004.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kumar Gala <galak@kernel.crashing.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>

Hello Huang,

On Fri, Oct 26, 2012 at 02:42:36AM +0000, Huang Changming-R66093 wrote:
> For the current polling mode, driver will send CMD13 to poll the card status periodically , which will cause too many interrupts.
> Once I sent patches to detect the card when using polling mode last year: read the state register, instead of send CMD13. But, these patches were not accepted. Now I attach them for you.

Was there any specific reason why the patches didn't get accepted?

I very briefly looked at them, and they seem to be OK (there are a few
cosmetic details I'd comment on, tho -- but please send them in a normal
way (i.e. not as attachments).

Thanks,
Anton.
