From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 4/4] arm: V2 configs: update pxa910 defconfig for SoC
 Selection
Date: Wed, 16 Feb 2011 01:20:28 +0300
Message-ID: <4D5AFC2C.6010408@ru.mvista.com>
References: <5DE28962-5F04-4D34-8D65-DF4020F135CD@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46900 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932115Ab1BOWVq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 17:21:46 -0500
Received: by bwz15 with SMTP id 15so43073bwz.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 14:21:45 -0800 (PST)
In-Reply-To: <5DE28962-5F04-4D34-8D65-DF4020F135CD@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Brown <markb@marvell.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@fluxnic.net>

On 16-02-2011 0:55, Philip Rakity wrote:

> V2
> ==
> Use make savedefconfigconfig to produce reduced size defconfig
> per suggestion of Nico Pitre.

> V1
> ==

    The log of the patch changes should go under the --- tear line.

> took old pxa910_defconfig --
> did make menuconfig
> changed to CPU_PXA910

> Signed-off-by: Philip Rakity<prakity@marvell.com>
> ---
>   arch/arm/configs/pxa910_defconfig |    6 +-----
>   1 files changed, 1 insertions(+), 5 deletions(-)

WBR, Sergei
