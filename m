From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 1/2] mmc: omap_hsmmc: Add support for quirky omap3
 hsmmc controller
Date: Fri, 14 Feb 2014 08:31:03 -0800
Message-ID: <20140214163102.GA21592@atomide.com>
References: <1392356749-32091-1-git-send-email-nm@ti.com>
 <1392356749-32091-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392356749-32091-2-git-send-email-nm@ti.com>
Sender: linux-doc-owner@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>
List-Id: linux-mmc@vger.kernel.org

* Nishanth Menon <nm@ti.com> [140213 21:48]:
> When device is booted using devicetree, platforms impacted by Erratum
> 2.1.1.128 is not detected easily in the mmc driver. This erratum
> indicates that the module cannot do multi-block transfers. Platforms
> such as LDP which use OMAP3 ES revision prior to ES3.0 are impacted by
> this.
> 
> Provide a new compatible property "ti,omap3-pre-es3-hsmmc" to allow
> driver to determine if driver needs to implement quirks associated
> with the specific module version (primarily because the IP revision
> information is not sufficient for the same).
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Looks good to me, would be good to get this into the -rc cycle
as LDP is one of the automated boot testing boards for us.

If you guys want me to pick up both of the patches let me know,
otherwise feel free to add my ack.

Regards,

Tony
