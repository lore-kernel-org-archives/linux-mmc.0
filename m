From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 3/8] MFD:rtsx: Declare that the DMA address limitation
 is 32bit explicitly
Date: Tue, 25 Dec 2012 12:13:41 +0100
Message-ID: <20121225111341.GE7692@liondog.tnic>
References: <cover.1356403281.git.wei_wang@realsil.com.cn>
 <7ba22b7e0e0be5a353cdfcfefbeff03a5be973c0.1356403281.git.wei_wang@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:36233 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753641Ab2LYLNv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 25 Dec 2012 06:13:51 -0500
Content-Disposition: inline
In-Reply-To: <7ba22b7e0e0be5a353cdfcfefbeff03a5be973c0.1356403281.git.wei_wang@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: wei_wang@realsil.com.cn
Cc: cjb@laptop.org, sameo@linux.intel.com, devel@linuxdriverproject.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, gregkh@linuxfoundation.org, arnd@arndb.de, oakad@yahoo.com

On Tue, Dec 25, 2012 at 10:43:09AM +0800, wei_wang@realsil.com.cn wrote:
> From: Wei WANG <wei_wang@realsil.com.cn>
> 
> Signed-off-by: Wei WANG <wei_wang@realsil.com.cn>

This one is still missing a commit message. You might want to write some
blubber about the hardware supporting only 32-bit DMA or whatever the
real reason is.

Also, with the whole patchset, please don't send it the very next day
but do wait a couple of days to collect all feedback from people -
especially now I'd wait even longer since everyone except you and me are
away :) - and then resend it after incorporating all feedback.

Thanks.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
