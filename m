From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: Pass on the suspend failure to the PM core
Date: Tue, 11 Sep 2012 11:13:26 +0530
Message-ID: <CANfBPZ93ONzeYj=kD_7pbq=VBQLd98YM9BE9S+sPb3rrrXNFzQ@mail.gmail.com>
References: <1346764109-21174-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <1346764109-21174-1-git-send-email-gururaja.hebbar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, rob.herring@calxeda.com, linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, cjb@laptop.org, nsekhar@ti.com, sudhakar.raj@ti.com, Vaibhav Bedia <vaibhav.bedia@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 4, 2012 at 6:38 PM, Hebbar, Gururaja <gururaja.hebbar@ti.com> wrote:
> From: Vaibhav Bedia <vaibhav.bedia@ti.com>
>
> In some cases mmc_suspend_host() is not able to claim the
> host and proceed with the suspend process. The core returns
> -EBUSY to the host controller driver. Unfortunately, the
> host controller driver does not pass on this information
> to the PM core and hence the system suspend process continues.
>
> In these cases the MMC core gets to an unexpected state
> during resume and multiple issues related to MMC crop up.
> 1. Host controller driver starts accessing the device registers
> before the clocks are enabled which leads to a prefetch abort.
> 2. A file copy thread which was launched before suspend gets
> stuck due to the host not being reclaimed during resume.
>
> To avoid such problems pass on the -EBUSY status to the PM core
> from the host controller driver. With this change, MMC core
> suspend might still fail but it does not end up making the
> system unusable. Suspend gets aborted and the user can try
> suspending the system again.
>

The last time we discussed this, didn't we plan to fix this differently ?
Holding the return code of mmc_suspend_host in a separate variable and
passing it to the caller
of omap_hsmmc_suspend looks more sane to me.
