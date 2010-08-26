From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Prevents unexpected status clear
Date: Thu, 26 Aug 2010 08:26:42 +0100
Message-ID: <20100826072642.GB19339@console-pimps.org>
References: <4C33DF98.10409@renesas.com>
 <20100708144626.2091f6c1.akpm@linux-foundation.org>
 <4C3BBE77.8080000@renesas.com>
 <20100715132552.fcb5791b.akpm@linux-foundation.org>
 <20100825231107.45227d6a@linux-g6p1.site>
 <20100825160722.9c9c38c8.akpm@linux-foundation.org>
 <4C75BB0D.2030202@renesas.com>
 <20100826075320.0538043b@linux-g6p1.site>
 <AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:43882 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752239Ab0HZH0o (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 03:26:44 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTim2_8UU62hnvSrPK94MgaM35K0PbppGe8yeW-bC@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Yusuke Goda <yusuke.goda.sx@renesas.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Paul Mundt <lethal@linux-sh.org>

On Thu, Aug 26, 2010 at 03:58:38PM +0900, Magnus Damm wrote:
>
> Hi Matt,
> 
> Just FYI, the newer version of these patches also have a whole bunch
> of acked-by and tested-by tags, see this email:
> 
> http://lkml.org/lkml/2010/8/20/429
> 
> Thanks for your help!

Argh, right. Claws-mail searching has completely failed me. I didn't
even see that thread when searching to "tmio_mmc". Back to mutt..

Andrew, can you drop the patch with my changelog and pick up the one in
that thread seeing as it's got all the tags and a new changelog? Thanks.
