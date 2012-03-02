From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 4/4] mmc: omap_hsmmc: Simplify init for twl6030 MMC card
 detect
Date: Fri, 2 Mar 2012 11:25:20 +0100
Message-ID: <20120302102520.GQ9008@sortiz-mobl>
References: <20120301185044.29210.44521.stgit@kaulin.local>
 <20120301185535.29210.71546.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120301185535.29210.71546.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linuxkernel@vger.kernel.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Tony,

On Thu, Mar 01, 2012 at 10:55:35AM -0800, Tony Lindgren wrote:
> There's no need to use callbacks for this, we can
> do it directly between MMC driver and twl6030.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
