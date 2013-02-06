From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 02/13] mmc: detailed definition of CD and WP MMC line polarities in DT
Date: Wed, 6 Feb 2013 22:30:43 +0000
Message-ID: <201302062230.43680.arnd@arndb.de>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de> <1360180020-18555-3-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:64526 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752775Ab3BFWa4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Feb 2013 17:30:56 -0500
In-Reply-To: <1360180020-18555-3-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On Wednesday 06 February 2013, Guennadi Liakhovetski wrote:
> +*NOTE* on CD and WP polarity. As of 3.8, SD/MMC drivers parse their DT nodes
> +each in its own way, including calculation of CD and WP polarities. Our goal is
> +to implement a common MMC DT parser and convert all drivers to using it. For
> +this we also have to fix the meaning of the "normal" and "inverted" line levels.
> +We choose to follow the SDHCI standard, which specifies both those lines as
> +"active low." To deliver line polarity to drivers the parser will set
> +MMC_CAP2_CD_ACTIVE_HIGH and / or MMC_CAP2_RO_ACTIVE_HIGH capabilities.

As mentioned in my other comment, please leave out references to the
Linux implementation. The long-term goal is to split out the
bindings from the Linux kernel, because they are used by other
projects as well. We also cannot easily change bindings that are
already established, so referring to a specific version here is not
helpful.

Your descriptions all make sense and I think we should put them
somewhere, but for the binding, we need a more neutral text
that just describes the interface to someone writing a device
tree file.
	
	Arnd
