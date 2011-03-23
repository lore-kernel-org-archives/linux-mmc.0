From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/6 v2] mmc: split the tmio driver into several modules
Date: Thu, 24 Mar 2011 08:16:24 +0900
Message-ID: <20110323231624.GA30365@verge.net.au>
References: <Pine.LNX.4.64.1103231156220.6836@axis700.grange>
 <20110323230232.GN20341@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110323230232.GN20341@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <magnus.damm@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Mar 24, 2011 at 08:02:32AM +0900, Simon Horman wrote:
> Hi Guennadi,
> 
> which tree does this series apply to?
> 
> I have tried both Linus's tree and the mmc-next branch of the mmc tree
> without success.

Actually, could you consider taking my patch into your series?
Any rebase should be trivial.

The patch is:
[PATCH 1/4] mmc: tmio_mmc: Move some defines into a shared header
