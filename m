From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM: HIBERNATION: add resume_wait param to support
	MMC-like devices as resume file
Date: Thu, 6 Oct 2011 19:58:18 +0200
Message-ID: <20111006175818.GB9886@atrey.karlin.mff.cuni.cz>
References: <1317288548-19560-1-git-send-email-Barry.Song@csr.com>
	<CAKPcRGr3EzjS2es6HniuQziEivpsfH2r=d_Y=nkrsFW59g6xSw@mail.gmail.com>
	<CAGsJ_4zjRpEx_yLwXx74uipPN-Q2hun3AdLxKw2EYOy00cDm3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAGsJ_4zjRpEx_yLwXx74uipPN-Q2hun3AdLxKw2EYOy00cDm3Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Barry Song <21cnbao@gmail.com>
Cc: rjw@sisk.pl, Luca Tettamanti <kronos.it@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, workgroup.linux@csr.com, frank.hofmann@tomtom.com, linux-arm-kernel@lists.infradead.org, linux-pm@lists.linux-foundation.org, Barry Song <Barry.Song@csr.com>
List-Id: linux-mmc@vger.kernel.org

> 2011/9/29 Luca Tettamanti <kronos.it@gmail.com>:
> > On Thu, Sep 29, 2011 at 11:29 AM, Barry Song <Barry.Song@csr.com> wrote:
> >> From: Barry Song <baohua.song@csr.com>
> >>
> >> Some devices like mmc are async detected very slow. For example,
> >> drivers/mmc/host/sdhci.c launchs a 200ms delayed work to detect
> >> mmc partitions then add disk.
> >>
> >> we do have wait_for_device_probe and scsi_complete_async_scans
> >> before calling swsusp_check, but it is not enough to wait mmc.
> >>
> >> This patch adds resumewait kernel param just like rootwait so
> >> that we have enough time to wait mmc ready. The differene is
> >> here we wait for resume partition but rootwait waits for rootfs
> >> partition.
> >
> > I assume that such a device would need "rootwait" to boot in the first
> > place; why don't you "overload" the param to also enable waiting in
> > the resume path?
> 
> not real. for an embedded product, the type of the rootfs, the place
> of the rootfs  and the way to mount rootfs are pretty flexible.
> even though both rootfs and resume file use mmc, they will be in
> different partitions at least. so i don't think rootwait can overload
> resumewait.

It would be good to at least model it the same way. rootdelay allows
you to specify time, which is important for USB devices...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
