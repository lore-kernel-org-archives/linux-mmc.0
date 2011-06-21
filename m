From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 5/5] ARM: mach-shmobile: ag5evm: SDHI requires waiting for idle
Date: Wed, 22 Jun 2011 01:27:36 +0900
Message-ID: <20110621162735.GL7920@linux-sh.org>
References: <1308610812-3479-1-git-send-email-horms@verge.net.au> <1308610812-3479-6-git-send-email-horms@verge.net.au> <m2aadbtbbl.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:37187 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753018Ab1FUQ2T (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 21 Jun 2011 12:28:19 -0400
Content-Disposition: inline
In-Reply-To: <m2aadbtbbl.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Simon Horman <horms@verge.net.au>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Tue, Jun 21, 2011 at 12:10:22PM -0400, Chris Ball wrote:
> On Mon, Jun 20 2011, Simon Horman wrote:
> > Dependencies:
> > 	"mmc: sdhi: Add write16_hook"
> > 	"ARM: mach-shmobile: ag5evm: consistently name sdhi info structures"
> 
> Could I get your ACK for this one, so that I can merge patches 1/2/3/5
> together via the MMC tree?
> 
Well, this has a dependency on 4/5 which I've already applied. I was
simply going to wait for 1-3 to be merged via your tree and then roll in
this last one on top of that. If you want to take them all that's ok too,
git should be able to deal with any merge conflicts fine.
