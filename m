From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/7 v3] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Date: Tue, 9 Sep 2014 12:56:21 +0900
Message-ID: <20140909035618.GI31320@verge.net.au>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
 <87bnqx78xr.wl%kuninori.morimoto.gx@gmail.com>
 <20140909024310.GE31320@verge.net.au>
 <87sik17bqg.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87sik17bqg.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Sep 08, 2014 at 07:45:46PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > Kuninori Morimoto (7):
> > >       mmc: add .multi_io_quirk callback for multi I/O HW bug
> > >       mmc: use .multi_io_quirk on omap_hsmmc
> > >       mmc: use .multi_io_quirk on tmio_mmc
> > >       mmc: use .multi_io_quirk on sh_mobile
> > >       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from koelsch
> > >       ARM: shmobile: remove MMC_CAP2_NO_MULTI_READ from lager
> > 
> > Hi Morimoto-san,
> > 
> > could you let me know about the dependencies for the above two patches?
> 
> These have deep dependencies.
> "ARM: shmobile: remove xxx" patches are based on 1) - 4) patches,
> and, it is required to last patch.

Thanks, I understand.
