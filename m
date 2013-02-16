From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v4 00/13] mmc: core and driver DT and related development
Date: Sat, 16 Feb 2013 11:26:35 +0900
Message-ID: <20130216022634.GB11628@verge.net.au>
References: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1360941242-18153-1-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-mmc@vger.kernel.org

On Fri, Feb 15, 2013 at 04:13:49PM +0100, Guennadi Liakhovetski wrote:
> This is v4 of a patch-series, extending mmc subsystem device-tree usage 
> and adding more advanced DT capabilities to sh_mmcif and sh_mobile_sdhi / 
> tmio_mmc drivers. Changes since v3 are described in respective patches. 
> Thanks to all who commented on v3.

Hi,

I do not expect this code to go through the renesas tree.  However, in
order to provide a basis for work on renesas SoCs I have added this patch
to the topic/mmc topic branch in the reneas tree on kernel.org and
merged it into topic/all+next.

In other words, I am not picking this series up to merge it or add it to
linux-next, rather I am storing it for reference.

