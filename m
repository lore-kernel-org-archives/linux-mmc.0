From: Adrien Schildknecht <adrien+dev@schischi.me>
Subject: Re: [PATCH] mmc: add ifdef around fault_create_debugfs_attr()
Date: Tue, 10 Nov 2015 16:04:20 +0100
Message-ID: <20151110160420.2ec59606.adrien+dev@schischi.me>
References: <1446812136-31526-1-git-send-email-adrien+dev@schischi.me>
	<CAPDyKFrs4VCJgVXpF405HrXZ2oJ+L=3e7hWtYAxYx4=qMHsRYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36662 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752533AbbKJPEZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2015 10:04:25 -0500
Received: by wmww144 with SMTP id w144so121567310wmw.1
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2015 07:04:24 -0800 (PST)
In-Reply-To: <CAPDyKFrs4VCJgVXpF405HrXZ2oJ+L=3e7hWtYAxYx4=qMHsRYQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 9 Nov 2015 14:33:11 +0100
Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 6 November 2015 at 13:15, Adrien Schildknecht
> <adrien+dev@schischi.me> wrote:  
> > FAIL_MMC_REQUEST can be used without FAULT_INJECTION_DEBUG_FS.
> > In this case fault_create_debugfs_attr() will always return an
> > error and lead to the deletion of the whole debugfs directory.
> >
> > This patch makes sure that FAULT_INJECTION_DEBUG_FS is enabled
> > before attempting to create the debugfs atttribute.
> >
> > Signed-off-by: Adrien Schildknecht <adrien+dev@schischi.me>
> > ---
> >  drivers/mmc/core/debugfs.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> > index 154aced..13e842c 100644
> > --- a/drivers/mmc/core/debugfs.c
> > +++ b/drivers/mmc/core/debugfs.c
> > @@ -259,11 +259,13 @@ void mmc_add_host_debugfs(struct mmc_host
> > *host) if (fail_request)
> >                 setup_fault_attr(&fail_default_attr, fail_request);
> >         host->fail_mmc_request = fail_default_attr;
> > +#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
> >         if (IS_ERR(fault_create_debugfs_attr("fail_mmc_request",
> >                                              root,
> >                                              &host->fail_mmc_request)))
> >                 goto err_node;
> >  #endif
> > +#endif
> >         return;
> >
> >  err_node:
> > --
> > 2.6.2
> >    
> 
> I think you are solving this in the wrong way. Will it really makes
> sense to use FAIL_MMC_REQUEST unless FAULT_INJECTION_DEBUG_FS is set,
> I don't think so.  
The fault attribute can be configured using either the debugfs or the
module parameter "fail_request". It is thus possible to use
FAIL_MMC_REQUEST without FAULT_INJECTION_DEBUG_FS (even if it is less
convenient).

> I suggest you to change FAIL_MMC_REQUEST from depending on
> FAULT_INJECTION to FAULT_INJECTION_DEBUG_FS in /lib/Kconfig.debug.  
The other systems that use the fault injection infrastructure (futex,
alloc_pages, slab...) can be used without the dependency on
FAULT_INJECTION_DEBUG_FS. They also use nested #ifdef to handle this
configuration. I chose the #ifdef approach for the sake of coherence.

-- 
Adrien Schildknecht
