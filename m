From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 2/3] dma: edma: add device_channel_caps() support
Date: Sun, 20 Jan 2013 19:16:32 -0800
Message-ID: <20130121031632.GB21551@intel.com>
References: <1357844826-30746-1-git-send-email-mporter@ti.com>
 <1357844826-30746-3-git-send-email-mporter@ti.com>
 <7bca07cce8884261b9828946dff5a076@DFLE72.ent.ti.com>
 <20130120165108.GE21407@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25247 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752643Ab3AUDlT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Jan 2013 22:41:19 -0500
Content-Disposition: inline
In-Reply-To: <20130120165108.GE21407@beef>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Dan Williams <djbw@fb.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>

On Sun, Jan 20, 2013 at 11:51:08AM -0500, Matt Porter wrote:
> The explanation in the cover letter mentions that dmaengine_slave_config() is
> required to be called prior to dmaengine_get_channel_caps(). If we
> switch to the alternative API, then that would go away including the
> dependency on direction.
Nope you got that wrong!

--
~Vinod
