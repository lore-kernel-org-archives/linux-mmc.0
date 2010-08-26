From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 14:12:37 -0700
Message-ID: <20100826141237.c31bc1ed.akpm@linux-foundation.org>
References: <4C33DF98.10409@renesas.com>
	<20100708144626.2091f6c1.akpm@linux-foundation.org>
	<4C3BBE77.8080000@renesas.com>
	<20100715132552.fcb5791b.akpm@linux-foundation.org>
	<20100825231107.45227d6a@linux-g6p1.site>
	<20100825160722.9c9c38c8.akpm@linux-foundation.org>
	<4C75BB0D.2030202@renesas.com>
	<20100826075320.0538043b@linux-g6p1.site>
	<AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
	<20100826072642.GB19339@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54401 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753751Ab0HZVM6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 17:12:58 -0400
In-Reply-To: <20100826072642.GB19339@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, 26 Aug 2010 08:26:42 +0100
Matt Fleming <matt@console-pimps.org> wrote:

> On Thu, Aug 26, 2010 at 03:58:38PM +0900, Magnus Damm wrote:
> >
> > Hi Matt,
> > 
> > Just FYI, the newer version of these patches also have a whole bunch
> > of acked-by and tested-by tags, see this email:
> > 
> > http://lkml.org/lkml/2010/8/20/429
> > 
> > Thanks for your help!
> 
> Argh, right. Claws-mail searching has completely failed me. I didn't
> even see that thread when searching to "tmio_mmc". Back to mutt..
> 
> Andrew, can you drop the patch with my changelog and pick up the one in
> that thread seeing as it's got all the tags and a new changelog? Thanks.

I actually already had it, as
tmio_mmc-dont-clear-unhandled-pending-interrupts.patch, scheduled for
2.6.36 and -stable.

What's the score with "tmio_mmc: allow 2 byte requests in 4-bit mode"? 
I didn't merge it because Ian said "This change needs to be modified to
test what hardware is present.  this wont work on my hardware TTBOMK.".
 Then I later _did_ merge it because it got sneakily renamed to
"tmio_mmc: revise a limit of the data size". 

