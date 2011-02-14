From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] arm: configs: update mmp2 defconfig for brownstone and SoC Selection
Date: Mon, 14 Feb 2011 15:05:39 +0100
Message-ID: <201102141505.39981.arnd@arndb.de>
References: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:57050 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754311Ab1BNOFr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Feb 2011 09:05:47 -0500
In-Reply-To: <04A50A49-CBBC-4E5D-B19E-391B4DF77DF3@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>

On Monday 14 February 2011, Philip Rakity wrote:
> took old mmp2_defconfig --
> did make menuconfig
> changed to CPU_MMP2
> added brownstone as supported board
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>

You should not use full .config files as defconfig any more these days.
Please use 'make defconfig' as a final step to create the minimum
list of config symbols. This applies to the other two as well.

	Arnd
