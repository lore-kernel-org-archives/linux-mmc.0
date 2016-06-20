From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 1/4] phy: rockchip-emmc: give DLL some extra time to be
 ready
Date: Mon, 20 Jun 2016 09:50:19 -0700
Message-ID: <20160620165019.GA37207@google.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <5767EB7E.3040606@ti.com>
 <20160620161908.GA30459@google.com>
 <CAD=FV=X73R759Rum3AEUfD_yjswoD8iXQqrow_gpCu=6XJs7Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=X73R759Rum3AEUfD_yjswoD8iXQqrow_gpCu=6XJs7Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko Stuebner <heiko@sntech.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Brian Norris <computersforpeace@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 20, 2016 at 09:25:18AM -0700, Doug Anderson wrote:
> On Mon, Jun 20, 2016 at 9:19 AM, Brian Norris <briannorris@chromium.org> wrote:
> > Ulf,
> >
> > I see I didn't CC you or linux-mmc on this patch series. Please let me
> > know if I should resend, or if you can pick these up off of LKML -- Doug
> > gave nice patchwork links in his linked series. NB: patch 2 has a
> > version 2, while the others were left unmodified.
> 
> I actually need to spin my series to address a small bit of feedback
> from Heiko.  Since Brian's original patches weren't on linux-mmc, I'll
> include them in my series (along with collected tags) to make it easy.
> Hope this is OK.

Fine with me. Thanks.

Brian
