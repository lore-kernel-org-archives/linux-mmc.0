From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3] mmc: moxart: fix probe logic
Date: Mon, 02 Feb 2015 21:03:02 +0100
Message-ID: <6294882.EhDcdWGRYz@wuerfel>
References: <4754899.RDUhFfxBSW@wuerfel> <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54478 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754128AbbBBUDS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Feb 2015 15:03:18 -0500
In-Reply-To: <1422891786-23071-1-git-send-email-jonas.jensen@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jonas Jensen <jonas.jensen@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ulf.hansson@linaro.org, linux@arm.linux.org.uk

On Monday 02 February 2015 16:43:06 Jonas Jensen wrote:
> 
> Notes:
>     This is a forward (with a single line fix) of Arnd's v2 patch.
>     
>     v2:  do not call clk_put() on an error pointer
>     v3:  fix NULL dereference on host->clk
>     
>     Applies to next-20150113

Thanks for forwarding the fixed version. I just realized that you
probably haven't forwarded a lot of patches from other people, so you
missed two things:

- to preserve patch ownership, the first line (before the rest of the
description) should be 'From: Arnd Bergmann <arnd@arndb.de>'

- It is common to include the entire signoff chain, which in this case
is my Signed-off-by on one line, followed by yours on the next line
at the end of the description.

Ulf can probably fix this up when he applies the patch, or you can
send it again to be sure.

	Arnd
