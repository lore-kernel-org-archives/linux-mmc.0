From: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Subject: RE: [PATCH v2 5/8] mmc: host: omap_hsmmc: trivial cleanups
Date: Mon, 19 Mar 2012 05:57:00 +0000
Message-ID: <1BAFE6F6C881BF42822005164F1491C3317F5456@DBDE01.ent.ti.com>
References: <y> <1331905144-31655-1-git-send-email-svenkatr@ti.com>
 <1331905144-31655-6-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1331905144-31655-6-git-send-email-svenkatr@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "Krishnamoorthy, Balaji T" <balajitk@ti.com>, "Balbi, Felipe" <balbi@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 16, 2012 at 19:09:01, S, Venkatraman wrote:
> From: Felipe Balbi <balbi@ti.com>
> 
> a bunch of non-functional cleanups to the omap_hsmmc
> driver.
> 
> It basically decreases indentation level, drop unneeded

s/unneeded/unneeded. Better to use unnecessary

> dereferences and drop unneded accesses to the platform_device

Same as above

> structure.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---

..snip..
..snip..

>  }
> -- 
> 1.7.10.rc0.41.gfa678
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


Regards, 
Gururaja
