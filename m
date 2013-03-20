From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v6 3/5] mmc: davinci_mmc: add DT support
Date: Wed, 20 Mar 2013 13:26:09 +0000
Message-ID: <201303201326.09265.arnd@arndb.de>
References: <1363779852-24083-1-git-send-email-prakash.pm@ti.com> <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1363779852-24083-4-git-send-email-prakash.pm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, linux-mmc@vger.kernel.org, cjb@laptop.org, nsekhar@ti.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mporter@ti.com
List-Id: linux-mmc@vger.kernel.org

On Wednesday 20 March 2013, Manjunathappa, Prakash wrote:
> Adds device tree support for davinci_mmc. Also add binding documentation.
> As of now in non-dma PIO mode and without GPIO card_detect/write_protect
> option because of dependencies on EDMA and GPIO module DT support.

Shouldn't the binding at least specify the names for the DMA channels?
It's fine if the driver works without those, but I think there is no
strict dependency here: If dma_request_slave_channel does not find
a channel, the driver can just continue in PIO mode, and as soon
as the EDMA driver is merged, it will work with DMA.

	Arnd
