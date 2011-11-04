From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/4] mmc: Add additional binding for mmc host controller
Date: Fri, 4 Nov 2011 12:58:38 -0700
Message-ID: <20111104195838.GB3045@quad.lixom.net>
References: <1320407441-29697-1-git-send-email-rnayak@ti.com>
 <1320407441-29697-2-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1320407441-29697-2-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, thomas.abraham@linaro.org, balajitk@ti.com, cjb@laptop.org, tony@atomide.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Nov 04, 2011 at 05:20:38PM +0530, Rajendra Nayak wrote:
> Add mmc host controller capability binding to support
> 'MMC_CAP_POWER_OFF_CARD' powering off of the card after boot.

This adds a new undocumented property (also, see comments on Thomas Abraham's
patch for more comments on that approach and why it's the wrong thing to do).

This needs to be handled differently.


-Olof

