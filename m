From: Marc Dietrich <marvin24@gmx.de>
Subject: Re: emmc power select failure
Date: Mon, 16 Apr 2012 18:44:17 +0200
Message-ID: <4147205.OrxOj4sBaM@ax5200p>
References: <1721770.czJDhHnFDk@ax5200p> <CANYdXnpBgpgOFv_rSg+tGTE_vppbV6XO66h5eyr9X2LUFk4T_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53601 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753875Ab2DPQoe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Apr 2012 12:44:34 -0400
In-Reply-To: <CANYdXnpBgpgOFv_rSg+tGTE_vppbV6XO66h5eyr9X2LUFk4T_A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: linux-mmc@vger.kernel.org

On Monday 16 April 2012 15:25:55 Shashidhar Hiremath wrote:
> Hi,
>   is the 8bit bus width supported by the hardware ?

yes. I works with just fine with a chromeos 3.0 kernel and 3.1 kernel (from nv-
tegra.nvidia.com).

Marc

> 
> On Fri, Apr 13, 2012 at 11:29 PM, Marc Dietrich <marvin24@gmx.de> wrote:
> > Hi,
> > 
> > I'm running linux-next on a tegra-sdhci host which has a Toshiba
> > THGBM2G6D2FBAI9 eMMC connected. During boot I get a "mmc1: power class
> > selection to bus width 8 failed" warning.
> > 
> > /sys/kernel/debug/mmc1# cat ios
> > clock:          48000000 Hz
> > actual clock:   48000000 Hz
> > vdd:            20 (3.2 ~ 3.3 V)
> > bus mode:       2 (push-pull)
> > chip select:    0 (don't care)
> > power mode:     2 (on)
> > bus width:      3 (8 bits)
> > timing spec:    1 (mmc high-speed)
> > 
> > Any hints?

