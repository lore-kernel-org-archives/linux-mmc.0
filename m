From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP4: MMC: increase delay for pbias
Date: Tue, 31 May 2011 06:28:03 -0700
Message-ID: <20110531132802.GS11352@atomide.com>
References: <1306765534-20103-1-git-send-email-balajitk@ti.com>
 <1306765534-20103-2-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306765534-20103-2-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, madhu.cr@ti.com
List-Id: linux-mmc@vger.kernel.org

* Balaji T K <balajitk@ti.com> [110530 07:23]:
> 4 micro seconds is not enough for PBIAS if MMC regulator is
> enabled from MMC regulator OFF.
> Increase the delay for PBIAS to stabilize.
> Wait for PBIAS and timeout if not.
> 
> Resolves MMC/SD failure on OMAP4
> "Pbias Voltage is not same as LDO"

Thanks will queue as a fix.

Tony
