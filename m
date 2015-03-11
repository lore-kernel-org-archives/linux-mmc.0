From: Simon Horman <horms@verge.net.au>
Subject: Re: Possible regression in next-20150306 due to "mmc: tmio: Fix PIO
 mode with CONFIG_HIGHMEM"
Date: Wed, 11 Mar 2015 09:34:54 +0900
Message-ID: <20150311003454.GD6958@verge.net.au>
References: <20150307060915.GA24323@verge.net.au>
 <CAPDyKFqb9__nFZ9i0qDP5j0J67MCh2CFeo7p-X=i57Lqx+LBng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqb9__nFZ9i0qDP5j0J67MCh2CFeo7p-X=i57Lqx+LBng@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: keita kobayashi <keita.kobayashi.ym@renesas.com>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 10, 2015 at 11:13:38AM +0100, Ulf Hansson wrote:
> On 7 March 2015 at 07:09, Simon Horman <horms@verge.net.au> wrote:
> > Hi Kobayashi-san, Hi All,
> >
> > I have noticed what appears to be a regression in next-20150306.  Using
> > shmobile_defconfig I am unable to boot the koelsch or lager boards to
> > user-space. However, if I revert be7de0b8a90a0b06d ("mmc: tmio: Fix PIO
> > mode with CONFIG_HIGHMEM") then all seems well.
> 
> Simon, thanks for testing and reporting!
> 
> I decided to drop the above commit from my next branch. Let's see if
> Kobayashi-san comes back with an updated patch, later on.

Thanks, I appreciate it.
