From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 6/6] ARM: shmobile: lager: disable MMCIF Command
 Completion Signal, add CLK_CTRL2
Date: Wed, 25 Sep 2013 16:12:29 +0900
Message-ID: <20130925071229.GQ6663@verge.net.au>
References: <1373484077-10460-1-git-send-email-g.liakhovetski@gmx.de>
 <1373484077-10460-7-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:48622 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab3IYHMc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Sep 2013 03:12:32 -0400
Content-Disposition: inline
In-Reply-To: <1373484077-10460-7-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, Nobuyuki HIRAI <nobuyuki.hirai.xe@renesas.com>, Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

On Wed, Jul 10, 2013 at 09:21:17PM +0200, Guennadi Liakhovetski wrote:
> MMCIF on r8a7790 doesn't support Command Completion Signal, but it does
> implement a CE_CLK_CTRL2 register. Platform parameters have to be added to
> account for these features on lager.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Thanks, I have queued this up for v3.13.
