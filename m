From: "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
Subject: Re: [PATCH 1/6] omap: mmc: split out init for 2420
Date: Wed, 23 Feb 2011 22:45:19 +0530
Message-ID: <AANLkTi=mO6sEtNdLAcWGG2zaqzMN4=YzcPi2+KG2WWkm@mail.gmail.com>
References: <1298481247-28808-1-git-send-email-kishore.kadiyala@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1298481247-28808-1-git-send-email-kishore.kadiyala@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org
Cc: tony@atomide.com, cjb@laptop.org, madhu.cr@ti.com, Anand Gadiyar <gadiyar@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 23, 2011 at 10:44 PM, Kishore Kadiyala
<kishore.kadiyala@ti.com> wrote:
> From: Anand Gadiyar <gadiyar@ti.com>
>
> The MMC controller on the OMAP2420 is different from those
> on the OMAP2430, OMAP3 and OMAP4 families - all of the latter
> are identical. The one on the OMAP2420 is closer to that
> on OMAP1 chips.
>
> Currently, the n8x0 is the only OMAP2420 platform supported
> in mainline which registers the MMC controller. Upcoming
> changes to register the controllers using hwmod data are
> potentially invasive. To reduce the risk, separate out the
> 2420 controller registration from the common init function
> and update its only user. Also seperating out mux settings
> for OMAP2420.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Madhusudhan Chikkature <madhu.cr@ti.com>
> Cc: Chris Ball <cjb@laptop.org>

<snip>

Please ignore this patch as its a single patch and the subject needs
update , will repost.

Regards,
Kishore
