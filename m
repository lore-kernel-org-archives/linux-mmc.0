From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH 1/1] CMD12 error recovery support for SD cards
Date: Wed, 23 Sep 2009 11:27:15 +0100
Message-ID: <20090923102715.GA4307@console-pimps.org>
References: <bd31ea570909160334u1b17a068hd8be89c7035232f9@mail.gmail.com> <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:34979 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751252AbZIWK0y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Sep 2009 06:26:54 -0400
Content-Disposition: inline
In-Reply-To: <bd31ea570909160339l5f996e9eh1f87abdbe527a404@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mahadev Cholachagudda <mgudda@gmail.com>
Cc: linux-mmc@vger.kernel.org

On Wed, Sep 16, 2009 at 04:09:11PM +0530, Mahadev Cholachagudda wrote:
> Dear All,
> 
> I've a kernel code base of 2.6.28.9, where in I find that CMD12 error
> recovery is not been implemented. It is a wise idea to implement CMD12
> error recovery, that involves sending CMD13 to get the status of the
> card. If the card is in "trans" state, it means CMD12 error shall be
> treated as successfull. If card state is not in "trans", then we have
> to send CMD12 again to stop the data transfer and then checking of the
> card status through CMD13. This sequence is detailed in the
> "Simplified Host Controller specification" on SDCard website. I
> believe this is the case for any controller, though I may be wrong.
> 
> With the modification done to the code which is attached as patch to
> the latest mmc git, it is working at our site. And we do see some
> errors with the SDIO controller (proprietary but meets Standard SD
> host controller specification) that we are using.
> 
> Request you to comment on the patch.
> 

In principal this patch seems OK. However, I recommend reading
Documentation/CodingStyle and sending this patch again once you've fixed
up the coding style and whitespace errors.

Is there a specific reason that you have used mmc_wait_for_req() instead
of mmc_wait_for_cmd() and reusing the "cmd" local variable? The empty
"else" clauses can also probably be deleted.
