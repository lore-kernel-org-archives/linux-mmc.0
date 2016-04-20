From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v3 1/1] mmc: omap_hsmmc: devm_pinctrl_get returns ERR_PTR
 upon error
Date: Wed, 20 Apr 2016 11:11:45 +0300
Message-ID: <20160420081145.GR4247@mwanda>
References: <1461099853-15011-1-git-send-email-afenkart@gmail.com>
 <1461099853-15011-2-git-send-email-afenkart@gmail.com>
 <5784587.0IP58U3KN7@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21148 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754577AbcDTIL6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2016 04:11:58 -0400
Content-Disposition: inline
In-Reply-To: <5784587.0IP58U3KN7@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andreas Fenkart <afenkart@gmail.com>, linux-mmc@vger.kernel.org

On Tue, Apr 19, 2016 at 03:12:27PM -0700, Arnd Bergmann wrote:
> On Tuesday 19 April 2016 23:04:13 Andreas Fenkart wrote:
> > Only the dummy implementation of devm_pinctrl_get returns NULL.
> > The real implementation returns ERR_PTR. By enforcing pinselect
> > in Kconfig we can simplify the test to check only for ERR_PTR.
> > detected/triggered by static code checker.
> 
> This is not how the interface is meant to work:
> 
> The dummy devm_pinctrl_get() intentionally returns NULL because IS_ERR()
> treats that as valid. All other pinctrl functions subsequently ignore
> that NULL pointer, so the second half of the patch is ok without the
> first half.
> 

We had that discussion.  The static checker warning triggered the
discussion but the real reason for this patch is that the
hardware will not work without PINCTRL.  So instead of compiling an
unusable kernel we added the select.

I forget, but I think one of ARCH_OMAP2PLUS or ARCH_KEYSTONE selects
PINCTRL already and the other doesn't.  That was part of the discussion
as well.

regards,
dan carpenter


