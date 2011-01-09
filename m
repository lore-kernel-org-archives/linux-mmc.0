From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] ARM: mach-shmobile: mackerel: Add zboot MMCIF support
Date: Sun, 9 Jan 2011 21:46:57 +0900
Message-ID: <20110109124657.GB25591@verge.net.au>
References: <1294565415-20901-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:42563 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab1AIMrA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 9 Jan 2011 07:47:00 -0500
Content-Disposition: inline
In-Reply-To: <1294565415-20901-1-git-send-email-horms@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, Yusuke Goda <yusuke.goda.sx@renesas.com>, Kuninori Morimoto <morimoto.kuninori@renesas.com>, Paul Mundt <lethal@lethal-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

On Sun, Jan 09, 2011 at 06:30:15PM +0900, Simon Horman wrote:
> This patch wires up LED debugging for the MMCIF boot
> on the mackerel, which is all that is required to get MMCIF
> boot functioning.

Please ignore this, the patch is identical to the one
that I posted as "rfc v1: ARM: mach-shmobile: mackerel: Add zboot MMCIF
support" on the 12th of December. It depends on "mmc, ARM: Add zboot from
MMC support for SuperH Mobile ARM" which needs to go through Russell's
tree post 2.6.38-rc1 as it in turn has dependencies.
