From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Date: Tue, 19 Feb 2013 12:20:44 -0700
Message-ID: <5123D08C.9060904@wwwdotorg.org>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:44463 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933020Ab3BSTUs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Feb 2013 14:20:48 -0500
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On 02/15/2013 08:13 AM, Guennadi Liakhovetski wrote:
> This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> tmio_mmc drivers. Changes since v3 are described in respective patches. 
> Thanks to all who commented on v3.

Chris, do you know if this series is going into 3.9 or if it'll only
make 3.10?

If it goes into 3.10, I may need to merge the MMC tree into the Tegra
tree to resolve some conflicts. Perhaps this series could be applied in
a topic branch on its own to simplify this?
