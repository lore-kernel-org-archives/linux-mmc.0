From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/4] MMC: omap_hsmmc: fix DMA config block
Date: Fri, 12 Oct 2012 12:12:17 +0100
Message-ID: <20121012111217.GJ28061@n2100.arm.linux.org.uk>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-3-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51033 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787Ab2JLLMY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Oct 2012 07:12:24 -0400
Content-Disposition: inline
In-Reply-To: <1350039495-360-3-git-send-email-zonque@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Matt Porter <mporter@ti.com>

On Fri, Oct 12, 2012 at 12:58:13PM +0200, Daniel Mack wrote:
> The .direction field of the config passed to dmaengine_slave_config()
> must be set in order to make the generic code store the configured bus
> width.

NAK.  The direction field is deprecated, and should not be used anymore.
