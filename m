From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: Add YAML schemas for the generic
 MMC options
Date: Fri, 10 May 2019 07:59:56 -0500
Message-ID: <CAL_JsqL+R3nWZi8u7_QRuGj=k7M2qB+NkM982OZfw0=n3+uLWA@mail.gmail.com>
References: <68d3fb999d16e49696e832e1d1a6bcd7b76a6e8d.1557389988.git-series.maxime.ripard@bootlin.com>
 <CAL_JsqJi0iwM61anziC-cHXp0PL2AEtXiWFCLn943vTxK5eeig@mail.gmail.com>
 <20190510105759.z2ob5tl4ovn2ctdo@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190510105759.z2ob5tl4ovn2ctdo@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, Frank Rowand <frowand.list@gmail.com>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, May 10, 2019 at 5:58 AM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> Hi Rob,
>
> On Thu, May 09, 2019 at 11:45:26AM -0500, Rob Herring wrote:
> > > +dependencies:
> > > +  cd-inverted: [ cd-gpios ]
> >
> > The note (which you dropped) says 'cd-inverted' applies for built-in CD too.
> >
> > At least that is what I take "Polarity of dedicated pins can be
> > specified, using *-inverted properties." to mean.
>
> Indeed, my bad. i guess we should probably keep that note. How are we
> supposed to keep a note that would apply to multiple properties? In
> the global description?

You could do a comment next to both properties or add it to the
description on one and refer to it from the other property (and group
the 2 properties together).

Rob
