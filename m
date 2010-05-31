From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 3/3 v2] ARM: mach-shmobile: add support for the second SD-/MMC-card slot on ap4evb
Date: Mon, 31 May 2010 13:49:01 +0900
Message-ID: <20100531044900.GC20358@linux-sh.org>
References: <Pine.LNX.4.64.1005141228510.6147@axis700.grange> <Pine.LNX.4.64.1005141233510.6147@axis700.grange> <Pine.LNX.4.64.1005231611390.3571@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 124x34x33x190.ap124.ftth.ucom.ne.jp ([124.34.33.190]:49522 "EHLO
	master.linux-sh.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933Ab0EaEtT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 31 May 2010 00:49:19 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1005231611390.3571@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On Sun, May 23, 2010 at 04:12:46PM +0200, Guennadi Liakhovetski wrote:
> The ap4evb board is equipped with two card slots: one SD-card slot and one
> SD-/MMC-card slot. The latter is connected to the second SDHI interface on
> sh7372 (SDHI1). Its power supply can be jumpered either to 1.8 or 3.3V, we fix
> it at default 1.8V for now.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Now that all of the dependencies are out of the way, I've applied this
too.
