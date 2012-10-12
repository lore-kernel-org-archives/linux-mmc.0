From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/4] MMC: omap_hsmmc: fix DMA config block
Date: Fri, 12 Oct 2012 16:19:46 +0200
Message-ID: <50782702.3040306@gmail.com>
References: <1350039495-360-1-git-send-email-zonque@gmail.com> <1350039495-360-3-git-send-email-zonque@gmail.com> <20121012111217.GJ28061@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20121012111217.GJ28061@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Matt Porter <mporter@ti.com>
List-Id: linux-mmc@vger.kernel.org

On 12.10.2012 13:12, Russell King - ARM Linux wrote:
> On Fri, Oct 12, 2012 at 12:58:13PM +0200, Daniel Mack wrote:
>> The .direction field of the config passed to dmaengine_slave_config()
>> must be set in order to make the generic code store the configured bus
>> width.
> 
> NAK.  The direction field is deprecated, and should not be used anymore.
> 

Yes, thanks for the heads-up. Matt already pointed me to an updated
series of his EDMA patches, so this patch can be dropped.

