From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/6 v2] mmc: split the tmio driver into several modules
Date: Wed, 23 Mar 2011 22:50:32 +0900
Message-ID: <20110323135032.GA25892@linux-sh.org>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Mar 23, 2011 at 02:42:29PM +0100, Guennadi Liakhovetski wrote:
> This patch-series touches code under
> 
> arch/arm/mach-shmobile
> arch/sh/boards
> drivers/mfd
> drivers/mmc/host
> 
> Perhaps, it would be best to collect necessary acks from Paul and push 
> them all via mmc?
> 
That works fine for me, it would be better to keep these grouped together
due to the ordering and it would take several merges to get everything in
sync otherwise. The bulk of this is drivers/mmc churn, so I'll let Chris
decide how he wants to handle it.

Anyways, for the series:

	Acked-by: Paul Mundt <lethal@linux-sh.org>
