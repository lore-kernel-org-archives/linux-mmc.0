From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 5/6] OMAP: adapt hsmmc to hwmod framework
Date: Thu, 24 Feb 2011 15:32:15 -0800
Message-ID: <20110224233215.GX20560@atomide.com>
References: <1298575614-9388-1-git-send-email-kishore.kadiyala@ti.com>
 <1298575614-9388-6-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1298575614-9388-6-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, cjb@laptop.org, madhu.cr@ti.com, khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

* Kishore Kadiyala <kishore.kadiyala@ti.com> [110224 11:17]:
> Changes involves:
> 1) Remove controller reset in devices.c which is taken care of
>    by hwmod framework.
> 2) Omap2420 platform consists of mmc block as in omap1 and not the
>    hsmmc block as present in omap2430, omap3, omap4 platforms.
>    Removing all base address macro defines except keeping one for OMAP2420.
> 3) Using omap-device layer to register device and utilizing data from
>    hwmod data file for base address, dma channel number, Irq_number,
>    device attribute.
> 4) Update the driver to use dev_attr to find whether controller
>    supports dual volt cards

This patch is too hard to read. Can you please split it into 
more readable patches?

Thanks,

Tony
