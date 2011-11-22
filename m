From: Alessandro Rubini <rubini@unipv.it>
Subject: Re: [GIT PULL] ARM: amba: Enable module alias autogeneration for
 AMBA drivers
Date: Tue, 22 Nov 2011 12:56:32 +0100
Message-ID: <20111122115632.GA5165@mail.gnudd.com>
References: <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1321961573-4562-1-git-send-email-dave.martin@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: dave.martin@linaro.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linus.walleij@linaro.org, linux-fbdev@vger.kernel.org, perex@perex.cz, grant.likely@secretlab.ca, wim@iguana.be, julia@diku.dk, linux@arm.linux.org.uk, rtc-linux@googlegroups.com, vinod.koul@intel.com, jassisinghbrar@gmail.com, linux-serial@vger.kernel.org, linux-input@vger.kernel.org, cjb@laptop.org, linux-watchdog@vger.kernel.org, Pawel.Moll@arm.com, patches@linaro.org, dan.j.williams@intel.com, linux-arm-kernel@lists.infradead.org, alan@linux.intel.com, a.zummo@towertech.it, dmitry.torokhov@gmail.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, lethal@linux-sh.org, spi-devel-general@lists.sourceforge.net
List-Id: linux-mmc@vger.kernel.org

> I have Acks on some of the driver patches and no comments on the
> rest.  I've been circulating these for some time, so if you're
> happy to pull those driver patches via your tree, please go ahead.

Sure I have no problem with the nomadik-rng.c, (so please have my
Acked-by: -- sorry for not noting it earlier) but I think this
file2alias thing needs a serious rework to split each bus in a
different file, using ELF sections like we do elsewhere.

I posted a patch last week but I got no comment at all. Maybe this
is the time to ask for comments? I can rebase and repost if needed.

  lkml.org/lkml/2011/11/4/125 (0/2: description of the work)
  lkml.org/lkml/2011/11/4/126 (1/2: turn the if plethora to table lookup)
  lkml.org/lkml/2011/11/4/127 (2/2: partial split to type-specific files).

thanks
/alessandro
