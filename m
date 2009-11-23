From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH v4] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Mon, 23 Nov 2009 10:35:51 -0800
Message-ID: <6cb013310911231035p2f701b10u2d16c6b39d560353@mail.gmail.com>
References: <1258993439-4787-1-git-send-email-darkstar6262@gmail.com>
	<20091123191224.GA2076@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:33468 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200AbZKWSgF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2009 13:36:05 -0500
In-Reply-To: <20091123191224.GA2076@localhost.localdomain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ladislav Michl <ladis@linux-mips.org>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>

On Mon, Nov 23, 2009 at 11:12 AM, Ladislav Michl
<Ladislav.Michl@seznam.cz> wrote:
> Ah, there is no valid reason to make it bitfield, right? Whole struct is
> not well layed wtr alignment, but please do not make it any worse. That is
> my last complain, I swear ;-). Thank you for your patience.
>
> Other than that, tested on OMAP5910 and it works now (though it needs
> additional patch, see here:
> http://thread.gmane.org/gmane.linux.kernel.mmc/649).
>
> Tested-by: Ladislav Michl <ladis@linux-mips.org>

Heh, fair enough :)  Thanks for your patience too -- I'll convert it
to an unsigned int and resubmit.  Hopefully 5th time's the charm. :)

Glad to hear it's working with that patch too, that adds some
confidence to my changes.

Thanks
- Cory
