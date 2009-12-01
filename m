From: Matt Fleming <matt@console-pimps.org>
Subject: Re: crash in mmc subsystem during suspend
Date: Tue, 1 Dec 2009 13:40:10 +0000
Message-ID: <20091201134010.GA21413@console-pimps.org>
References: <1258707087.2235.6.camel@localhost.localdomain> <1258729858.2235.29.camel@localhost.localdomain> <20091121123149.GA18478@console-pimps.org> <1259671766.2124.34.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:57021 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbZLANiZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Dec 2009 08:38:25 -0500
Content-Disposition: inline
In-Reply-To: <1259671766.2124.34.camel@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Tue, Dec 01, 2009 at 12:49:26PM +0000, Daniel Drake wrote:
> On Sat, 2009-11-21 at 12:31 +0000, Matt Fleming wrote:
> > Fancy giving this patch a try? I think it's just a case of removing too
> > many funcs in the error path.
> 
> Thanks!
> Yes, I agree that looks like the culprit.
> I applied something very similar to your patch and the crash went away.
> 
> The one additional change I made is in sdio_bus.c :
> 
>  void sdio_remove_func(struct sdio_func *func)
>  {
> -       if (sdio_func_present(func))
> -               device_del(&func->dev);
> +       if (!sdio_func_present(func))
> +               return;
>  
> +       device_del(&func->dev);
>         put_device(&func->dev);
>  }
> 
> I think this is necessary because the error path will go mmc_sdio_remove
> --> sdio_remove_func
> Hence sdio_remove_func() will be called when sdio_add_func() was never
> called beforehand, so there is no func->dev reference to drop.
> 
> Do you agree? I'm not certain about this one.
> 
> Thanks!
> Daniel
> 

Yep, your patch looks correct. Good catch.

Would you mind making a proper patch (S-O-B line and all) and submitting
it to the linux-mmc mailing list and CC'ing Andrew Morton?

Cheers

