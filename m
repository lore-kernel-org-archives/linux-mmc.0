From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [stable/4.14.y PATCH 0/3] mmc: Fix a potential resource leak
 when shutting down request queue.
Date: Wed, 19 Jun 2019 12:23:04 -0600
Message-ID: <20190619182304.GA98587@google.com>
References: <20190513175521.84955-1-rrangel@chromium.org>
 <20190514091933.GA27269@kroah.com>
 <20190619164625.GA85539@google.com>
 <20190619170917.GC10107@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190619170917.GC10107@kroah.com>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-mmc@vger.kernel.org, djkurtz@google.com, adrian.hunter@intel.com, zwisler@chromium.org, Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org, Chris Boot <bootc@bootc.net>, =?iso-8859-1?Q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 19, 2019 at 07:09:17PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jun 19, 2019 at 10:46:25AM -0600, Raul Rangel wrote:
> > On Tue, May 14, 2019 at 11:19:34AM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, May 13, 2019 at 11:55:18AM -0600, Raul E Rangel wrote:
> > > > I think we should cherry-pick 41e3efd07d5a02c80f503e29d755aa1bbb4245de
> > > > https://lore.kernel.org/patchwork/patch/856512/ into 4.14. It fixes a
> > > > potential resource leak when shutting down the request queue.
> > > 
> > > Potential meaning "it does happen", or "it can happen if we do this", or
> > > just "maybe it might happen, we really do not know?"
> > It does happen if the AMD SDHCI patches are cherry-picked into 4.14.
> > https://lkml.org/lkml/2019/5/1/398
> 
> Why are those patches somehow being required to be added to 4.14.y?  If
> they are not added, is all fine?
I was just thinking we would backport the patches to fix this AMD SDHCI
hardware bug, but I guess we don't need to.

Thanks
