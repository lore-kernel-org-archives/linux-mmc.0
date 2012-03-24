From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/4] arm: at91: dt: sam9g25ek add mci support
Date: Sat, 24 Mar 2012 19:10:06 +0000
Message-ID: <20120324191006.8FC3A3E0AD0@localhost>
References: <1332352994-20983-1-git-send-email-ludovic.desroches@atmel.com>
 <1332352994-20983-5-git-send-email-ludovic.desroches@atmel.com>
 <4F6B3CCD.7070105@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F6B3CCD.7070105@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, ludovic.desroches@atmel.com
Cc: linux-mmc@vger.kernel.org, devicetree-discuss <devicetree-discuss@lists.ozlabs.org>, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Thu, 22 Mar 2012 15:53:01 +0100, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 03/21/2012 07:03 PM, ludovic.desroches@atmel.com :
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

I think you really mean "Acked-by".  It is only appropriate to add a
"Signed-off-by" tag when you have actually picked up and either
committed or reposted a patch.  When replying to a patch on the
mailing list and giving your okay, the correct tag is either
"Acked-by" or "Reviewed-by"  (The difference being that "Acked-by"
infers that you have some authority over the areas touched by the
patch).

See Documentation/SubmittingPatches

g.

> 
> > ---
> >  arch/arm/boot/dts/at91sam9g25ek.dts |   16 ++++++++++++++++
> >  1 files changed, 16 insertions(+), 0 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
> > index 7a13d09..960de2b 100644
> > --- a/arch/arm/boot/dts/at91sam9g25ek.dts
> > +++ b/arch/arm/boot/dts/at91sam9g25ek.dts
> > @@ -32,6 +32,22 @@
> >  				phy-mode = "rmii";
> >  				status = "okay";
> >  			};
> > +
> > +			mmc0: mmc@f0008000 {
> > +				status = "okay";
> > +				slot@0 {
> > +					bus-width = <4>;
> > +					cd-gpios = <&pioD 15 0>;
> > +				};
> > +			};
> > +
> > +			mmc1: mmc@f000c000 {
> > +				status = "okay";
> > +				slot@0 {
> > +					bus-width = <4>;
> > +					cd-gpios = <&pioD 14 0>;
> > +				};
> > +			};
> >  		};
> >  
> >  		usb0: ohci@00600000 {
> 
> 
> -- 
> Nicolas Ferre
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
