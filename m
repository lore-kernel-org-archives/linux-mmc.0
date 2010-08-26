From: Matt Fleming <matt@console-pimps.org>
Subject: Re: [PATCH] tmio_mmc: Revise a limit of the data size
Date: Thu, 26 Aug 2010 08:24:46 +0100
Message-ID: <20100826072446.GA19339@console-pimps.org>
References: <4C33DFF0.3040804@renesas.com>
 <20100708144647.1e77364b.akpm@linux-foundation.org>
 <4C3BD041.3020705@renesas.com>
 <20100825225208.02a906f7@linux-g6p1.site>
 <20100825150502.33649ff0.akpm@linux-foundation.org>
 <AANLkTiko3vN5APNcKbFegOn_XEySyDgBnAoGzyOKSsiZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arkanian.console-pimps.org ([212.110.184.194]:43873 "EHLO
	arkanian.console-pimps.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752825Ab0HZHYs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Aug 2010 03:24:48 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTiko3vN5APNcKbFegOn_XEySyDgBnAoGzyOKSsiZ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>

On Thu, Aug 26, 2010 at 02:50:09AM +0100, Ian Molton wrote:
> Probably dropped because I complained about two things,
> 
> 1) The patch doesnt check what the hardware is underneath before
> arbitrarily changing the parameters relied on by some hardware

Has anyone thought about adding a caps or flags field to the
tmio_mmc_host structure so that platform code set a bit if it can't do
2-byte data block transfers?
