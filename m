From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 3/5 v4] mmc: sh_mmcif: re-read the clock frequency every
 time the clock is turned on
Date: Wed, 20 Jun 2012 14:23:20 +0900
Message-ID: <20120620052319.GG20030@verge.net.au>
References: <Pine.LNX.4.64.1206131515180.17854@axis700.grange>
 <Pine.LNX.4.64.1206131533560.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206131533560.17854@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 13, 2012 at 03:37:23PM +0200, Guennadi Liakhovetski wrote:
> With aggressive clock gating the clock can be disabled during interface
> inactivity. During this time its frequency can be changed by another its
> user. Therefore when the interface is activated again and the clock is
> re-enabled, its frequency has to be re-read.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Reviewed-by: Simon Horman <horms@verge.net.au>
