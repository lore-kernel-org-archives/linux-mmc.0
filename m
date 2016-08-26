From: Zach Brown <zach.brown@ni.com>
Subject: Re: [PATCH 1/2] sdhci-of-arasan: Add quirk and device tree parameter
 to fake CD bit
Date: Fri, 26 Aug 2016 17:29:46 -0500
Message-ID: <20160826222945.GA6679@zach-desktop>
References: <1472080984-17373-1-git-send-email-zach.brown@ni.com>
 <20160825105640.GA5439@remoulade>
 <20160825171539.GA13571@zach-desktop>
 <20160825180959.GA14705@remoulade>
 <20160825182621.GA14817@zach-desktop>
 <20160825182852.GB15000@remoulade>
 <20160825204645.GA19450@zach-desktop>
 <CAPDyKFpcFus1oysdRuK6vUALXXdy8_SsDZ3n8LkyM1AZLZY+QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFpcFus1oysdRuK6vUALXXdy8_SsDZ3n8LkyM1AZLZY+QQ@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, linux-mmc <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 26, 2016 at 09:42:38AM +0200, Ulf Hansson wrote:
> On 25 August 2016 at 22:46, Zach Brown <zach.brown@ni.com> wrote:
> > On Thu, Aug 25, 2016 at 07:28:55PM +0100, Mark Rutland wrote:
> >> On Thu, Aug 25, 2016 at 01:26:22PM -0500, Zach Brown wrote:
> >> > On Thu, Aug 25, 2016 at 07:10:00PM +0100, Mark Rutland wrote:
> >> > > On Thu, Aug 25, 2016 at 12:15:44PM -0500, Zach Brown wrote:
> >> > > > In cases where the card is non-removable then polling doesn't make sense.
> >> > >
> >> > > We have the non-removable property to describe that, so we can also look at that.
> >> > >
> >> > > > So it doesn't make sense to tie the test mode workaround into the broken-cd
> >> > > > property, even though I agree the nature of the defect fits under the notion
> >> > > > of the CD being broken.
> >> > >
> >> > > Maybe not solely on broken-cd, but I think that we dont necessarily need a new
> >> > > DT property. As above, broken-cd, non-removable, and the compatible string may
> >> > > together give the kernel enough information to choose the right thing to do.
> >> > >
> >> > > Thanks,
> >> > > Mark.
> >> >
> >> > I'm not sure if I understand your suggestion completely. Are you suggesting
> >> > setting both the broken-cd and non-removable properties? That would make sense,
> >> > but my understanding was that the two properities are not meant to co-exist. In
> >> > /Documentation/devicetree/bindings/mmc/mmc.txt it states that only one should
> >> > be supplied. Don't the two properties conflict with each other?
> >>
> >> They do for the cases that exist today, but given we're updating the document
> >> anyway, we could simply clarify the cases in which the two can sanely co-exist
> >> (e.g.  for this particular IP block).
> 
> No, please!
> 
> Depending on the SDHCI variant there is already some difference on how
> broken-cd is treated.
> 
> Let's not add yet another, as I think it will be too complicated for
> people to understand the bindings.
> 

Shawn Lin pointed out that there might be instances of the arasan controller 
that don't have the behavior the patch addresses. Having a new DT binding
specific for this case would avoid needing to maintain a list of controllers
that need the fix.  

> >>
> >> Thanks,
> >> Mark.
> >
> > That makes sense. I'll change the documentation for broken-cd and non-removable
> > in the IP specific document and change the driver accordingly.
> 
> I rather have a new DT binding specific for this case.
> 
> Perhaps there's a better name than "fake-cd". How about "force-cd", or
> if someone can come up with a better name.
> 
> Kind regards
> Uffe

I've been trying to come up with a better name. Here are a few ideas
cd-not-wired
needs-test-cd
fails-without-force-cd
