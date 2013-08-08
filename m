From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv2] ARM: socfpga: dts: Add support for SD/MMC
Date: Thu, 8 Aug 2013 15:54:41 -0500
Message-ID: <1375995281.22740.16.camel@linux-builds1>
References: <1375735392-6836-1-git-send-email-dinguyen@altera.com>
 <5203FC1A.3090903@wwwdotorg.org> <1375993920.22740.9.camel@linux-builds1>
 <5204017A.1040607@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5204017A.1040607@wwwdotorg.org>
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

On Thu, 2013-08-08 at 14:37 -0600, Stephen Warren wrote:
> On 08/08/2013 02:32 PM, Dinh Nguyen wrote:
> > On Thu, 2013-08-08 at 14:14 -0600, Stephen Warren wrote:
> >> On 08/05/2013 02:43 PM, dinguyen@altera.com wrote:
> >>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>
> >>> Add bindings for SD/MMC for SOCFPGA.
> >>> Add "syscon" to the "altr,sys-mgr" binding.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> >>> new file mode 100644
> >>> index 0000000..dc14922
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> >>> @@ -0,0 +1,48 @@
> >>> +* Altera SOCFPGA specific extensions to the Synopsis Designware Mobile
> >>> +  Storage Host Controller
> >>> +
> >>> +Required Properties:
> >>> +
> >>> +* compatible: should be
> >>> +	- "altr,socfpga-dw-mshc": for controllers with Altera SOCFPGA
> >>> +	  specific extensions.
> >>> +
> >>> +* altr,dw-mshc-ciu-div: Specifies the divider value for the card interface
> >>> +  unit (ciu) clock. The value should be (n-1). For Altera's SOCFPGA, the divider
> >>> +  value is fixed at 3, which means parent_clock/4.
> >>
> >> This feels like something that should be represented using the common
> >> clock API; a driver should query the rate of its input clock, and then
> >> calculate the MMC block's internal divider based on that (perhaps also
> >> call clk_set_rate() on the input clock?).
> > 
> > This means a change to the dw_mmc driver, which I can look into for the
> > next round? I have promised Pawel to consolidate the bindings for both
> > exynos and socfpga in the next round already. I will also look into
> > using the common clock API for the MMC as well. 
> > 
> > This patch is the only thing that is preventing from SD/MMC working for
> > SOCFPGA in the mainline, can I get your Ack if I look into doing this
> > for 3.13 for both the exynos and socfpga driver, and address your latter
> > comments?
> 
> The problem is that if the binding supports or requires that property
> now, it has to at least support it forever. Given that we're getting
> serious about DT ABI now, we should be only introducing DT bindings that
> we believe are complete and corrrect, rather than bindings which we
> actively expect to be temporary and to change incompatibly later.
> 
Right ok. Then I guess I will have to look into consolidating the
bindings sooner rather than later.

I went back to look at the driver again, and I think it is doing as you
are suggesting:

host->bus_hz is getting its input value from the common clock API.
"altr,dw-mshc-ciu-div" is specifying the internal divider that is in the
SD/MMC IP itself.

I guess I'm still not clear on how I can represent the SD/MMC divider in
in the context of the common clock API.

Dinh
