From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Tue, 28 Jun 2011 11:22:24 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1308752314-32079-3-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com, adrian.hunter@nokia.com
List-Id: linux-mmc@vger.kernel.org

(cc'ing Adrian also)

Hi Balaji

On Wed, 22 Jun 2011, Balaji T K wrote:

> Use runtime autosuspend APIs to enable auto suspend delay

Does this really need to use runtime autosuspend?  Seems to me that since 
PM runtime is just controlling the MMC IP blocks and not the regulators in 
this instance, this could simply use pm_runtime_put*() and just avoid the 
extra power wastage and complexity involved in autosuspend.

Besides, the correct autosuspend timeout seems use-case dependent.

By the way, if possible, it would be really good if you could update this 
patch series soon to address the comments.  If these MMC driver changes 
can be ready to merge for 3.1, then we also have a chance of 
integrating some hwmod cleanup patches that depend on this driver's PM 
runtime conversion.


- Paul
