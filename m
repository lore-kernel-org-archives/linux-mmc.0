From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 4/4] mmc: Add mmc_host_<level> logging
Date: Tue, 15 Nov 2011 16:57:29 -0800
Message-ID: <1321405049.21286.35.camel@Joe-Laptop>
References: <cover.1321398814.git.joe@perches.com>
	 <631c53d126feff0a99b61d9c9a00b308d2b638ee.1321398815.git.joe@perches.com>
	 <CAKYAXd_wtGVQYgr_MUtVGGpkpqJgF56bfm0zO-nnAK0YpkT+bg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from perches-mx.perches.com ([206.117.179.246]:50747 "EHLO
	labridge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932708Ab1KPA5a (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 15 Nov 2011 19:57:30 -0500
In-Reply-To: <CAKYAXd_wtGVQYgr_MUtVGGpkpqJgF56bfm0zO-nnAK0YpkT+bg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: NamJae Jeon <linkinjeon@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, David Brown <davidb@codeaurora.org>, Daniel Walker <dwalker@fifo99.com>, Bryan Huntsman <bryanh@codeaurora.org>, Nicolas Pitre <nico@fluxnic.net>, Chris Ball <cjb@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Ian Molton <ian@mnementh.co.uk>, Bruce Chang <brucechang@via.com.tw>, Harald Welte <HaraldWelte@viatech.com>, Pierre Ossman <pierre@ossman.eu>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org

On Wed, 2011-11-16 at 09:52 +0900, NamJae Jeon wrote:
> 2011/11/16 Joe Perches <joe@perches.com>:
> > Centralize the pr_<level> uses of mmc_hostname into specific
> > mmc_host_<level> calls to allow a flexible presentation style
> > and shorten the code a bit.

> I don't know why pr_info should be surely replaced by mmc_host_info.
> if it is needed for only host name, I think that existing
> pr_info/err/debug is sufficient.

Please trim your replies and read the patch description.


