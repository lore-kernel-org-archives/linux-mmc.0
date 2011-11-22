From: Greg KH <greg@kroah.com>
Subject: Re: [GIT PULL] ARM: amba: Enable module alias
 autogeneration for AMBA drivers
Date: Tue, 22 Nov 2011 11:20:30 -0800
Message-ID: <20111122192030.GA4930@kroah.com>
References: <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
	<20111122115632.GA5165@mail.gnudd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20111122115632.GA5165@mail.gnudd.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alessandro Rubini <rubini@unipv.it>
Cc: dave.martin@linaro.org, Pawel.Moll@arm.com, tiwai@suse.de, linus.walleij@linaro.org, alsa-devel@alsa-project.org, grant.likely@secretlab.ca, wim@iguana.be, julia@diku.dk, linux@arm.linux.org.uk, vinod.koul@intel.com, jassisinghbrar@gmail.com, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, cjb@laptop.org, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, patches@linaro.org, linux-fbdev@vger.kernel.org, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, a.zummo@towertech.it, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, lethal@linux-sh.org, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 22, 2011 at 12:56:32PM +0100, Alessandro Rubini wrote:
> > I have Acks on some of the driver patches and no comments on the
> > rest.  I've been circulating these for some time, so if you're
> > happy to pull those driver patches via your tree, please go ahead.
> 
> Sure I have no problem with the nomadik-rng.c, (so please have my
> Acked-by: -- sorry for not noting it earlier) but I think this
> file2alias thing needs a serious rework to split each bus in a
> different file, using ELF sections like we do elsewhere.
> 
> I posted a patch last week but I got no comment at all. Maybe this
> is the time to ask for comments? I can rebase and repost if needed.
> 
>   lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
>   lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
>   lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).

Ah, I missed that, yes, this would be a good thing to have, we've been
wanting it for _years_.

greg k-h
