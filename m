From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2] mmc: tmio: Don't access hardware registers after
 stopping clocks
Date: Wed, 13 Jun 2012 10:17:12 +0900
Message-ID: <20120613011712.GF16686@verge.net.au>
References: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46676 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035Ab2FMBRO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Jun 2012 21:17:14 -0400
Content-Disposition: inline
In-Reply-To: <1339536575-6578-1-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Tue, Jun 12, 2012 at 11:29:35PM +0200, Laurent Pinchart wrote:
> The tmio_mmc_set_ios() function configures the MMC power, clock and bus
> width. When the mmc core requests the driver to power off the card, we
> inform runtime PM, that the controller can be suspended. This can lead
> to the MSTP clock being turned off.
> 
> Writing to any 16-bit hardware registers with the MSTP clock off leads
> to timeouts and errors being printed to the kernel log. This can occur
> both when stopping the MMC clock and when configuring the bus width.
> 
> To fix this, stop the MMC clock before calling put_runtime_pm(), and
> skip bus width configuration when power is off.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Hi Laurent,

could you let me know if there is a (simple :) way for me to exercise this?

> ---
>  drivers/mmc/host/tmio_mmc_pio.c |   18 ++++++++++--------
>  1 files changed, 10 insertions(+), 8 deletions(-)
