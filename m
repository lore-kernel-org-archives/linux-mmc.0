From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone and
 SoC Selection
Date: Mon, 14 Feb 2011 13:26:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102141320410.14920@xanadu.home>
References: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relais.videotron.ca ([24.201.245.36]:58471 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab1BNS05 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 13:26:57 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MRZ22.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LGM000FPDWOCM60@VL-MR-MRZ22.ip.videotron.ca> for
 linux-mmc@vger.kernel.org; Mon, 14 Feb 2011 13:26:48 -0500 (EST)
In-reply-to: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

On Sun, 13 Feb 2011, Philip Rakity wrote:

> 
> took old mmp2_defconfig --
> did make menuconfig
> changed to CPU_MMP2
> added brownstone as supported board
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  arch/arm/configs/mmp2_defconfig | 1207 ++++++++++++++++++++++++++++++++++++++-
>  1 files changed, 1203 insertions(+), 4 deletions(-)

That's not good.

You should do a "make savedefconfig" which will produce a ./defconfig 
file which is a reduced version of your config.  Then use that instead 
of the .config file to update your default config.


Nicolas
