From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 2/3] MMC: OMAP: HSMMC: add runtime pm support
Date: Wed, 29 Jun 2011 09:38:07 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1106290937350.2874@utopia.booyaka.com>
References: <1308752314-32079-1-git-send-email-balajitk@ti.com> <1308752314-32079-3-git-send-email-balajitk@ti.com> <alpine.DEB.2.00.1106281116530.2874@utopia.booyaka.com> <BANLkTimT6nGP_ecJjZ6201=CiddN7BrsPg@mail.gmail.com> <alpine.DEB.2.00.1106281240390.2874@utopia.booyaka.com>
 <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <BANLkTikni_xO7NQXQyv7XVeEH4Nowpr1Ow@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, tony@atomide.com, madhu.cr@ti.com, khilman@ti.com, b-cousson@ti.com
List-Id: linux-mmc@vger.kernel.org

On Wed, 29 Jun 2011, T Krishnamoorthy, Balaji wrote:

> There have been some experiments on our customer programs to reduce this 
> value to a few ms and infrequent crashes were observed (stress testing 
> for several hours) while trying to access the controller registers.

By the way, could you send along a copy of the stress test script?


- Paul
