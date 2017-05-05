From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: rockchip-dw-mshc: add optional
 rockchip,default-num-phases
Date: Fri, 5 May 2017 14:44:48 -0500
Message-ID: <20170505194448.hhre4mls2t3makzf@rob-hp-laptop>
References: <1492592434-81312-1-git-send-email-shawn.lin@rock-chips.com>
 <1492592434-81312-2-git-send-email-shawn.lin@rock-chips.com>
 <20170428133403.mmdvtp3ohff6v7gh@rob-hp-laptop>
 <8785b011-cec6-1556-5c96-a462182e8d85@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34968 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751305AbdEETou (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 5 May 2017 15:44:50 -0400
Content-Disposition: inline
In-Reply-To: <8785b011-cec6-1556-5c96-a462182e8d85@rock-chips.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Ziyuan Xu <xzy.xu@rock-chips.com>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org

On Tue, May 02, 2017 at 03:03:03PM +0800, Shawn Lin wrote:
> Hi Rob,
> 
> 在 2017/4/28 21:34, Rob Herring 写道:
> > On Wed, Apr 19, 2017 at 05:00:33PM +0800, Shawn Lin wrote:
> > > By default, dw_mmc-rockchip will execute tuning for each degree.
> > > So we won't miss every point of the good sample windows. However,
> > > probably the phases are linear inside the good sample window.
> > > Actually we don't need to do tuning for each degree so that we could
> > > save some time, for instance, probe the driver or resume from S3.
> > > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > ---
> > > 
> > >  Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> > > index 520d61d..ea47ec0 100644
> > > --- a/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> > > +++ b/Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
> > > @@ -31,6 +31,10 @@ Optional Properties:
> > >    probing, low speeds or in case where all phases work at tuning time.
> > >    If not specified 0 deg will be used.
> > > 
> > > +* rockchip,default-num-phases: The default number of times that the host
> > > +  execute tuning when needed. If not specified, the host will do tuning
> > > +  for 360 times, namely tuning for each degree.
> > 
> > How is it default when you specify it? I would think default here is
> > 360.
> > 
> 
> I don't get your point here. Do you mean the name, default-num-phases,
> isn't correct, so I need another one?

Right, as we usually say "if not present, the default value is X."

Rob
