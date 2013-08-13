From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv3] ARM: socfpga: dts: Add support for SD/MMC
Date: Tue, 13 Aug 2013 14:58:35 -0500
Message-ID: <1376423915.3167.2.camel@linux-builds1>
References: <1376322589-17606-1-git-send-email-dinguyen@altera.com>
 <520A8E71.4090508@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520A8E71.4090508@wwwdotorg.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, dinh.linux@gmail.com, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Jaehoon Chung <jh80.chung@samsung.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2013-08-13 at 13:52 -0600, Stephen Warren wrote:
> On 08/12/2013 09:49 AM, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> > Add "syscon" to the "altr,sys-mgr" binding.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> I think it's reasonable to define one binding as being based on another
> plus some additions, so, the binding,
> Acked-by: Stephen Warren <swarren@nvidia.com>

Thanks Stephen!
> 
> > +Example:
> > +	dwmmc0@ff704000 {
> > +		compatible = "altr,socfpga-dw-mshc", "snps,dw-mshc";
> > +		altr,dw-mshc-sdr-timing = <0 3>;
> > +	};
> 
> It'd be nice to provide a complete example though, rather than only
> including the properties that this binding adds to the base binding.

I'll add a complete binding.
> 
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> 
> >  		sysmgr@ffd08000 {
> > -				compatible = "altr,sys-mgr";
> > +				compatible = "altr,sys-mgr", "syscon";
> 
> That seems like an unrelated change?

This patch is to enable SD/MMC for SOCFPGA. The "syscon" is needed in
dw_mmc-socfpga.c as the clock phases for the SD IP is controlled by
registers in "altr,sys-mgr".

Thanks,

Dinh
> 
