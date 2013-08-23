From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCHv5 2/3] ARM: socfpga: dts: Add support for SD/MMC
Date: Fri, 23 Aug 2013 18:01:43 -0500
Message-ID: <1377298903.26742.14.camel@linux-builds1>
References: <1377272686-13253-1-git-send-email-dinguyen@altera.com>
 <1377272686-13253-2-git-send-email-dinguyen@altera.com>
 <5217E24B.3090302@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5217E24B.3090302@wwwdotorg.org>
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

On Fri, 2013-08-23 at 16:29 -0600, Stephen Warren wrote:
> On 08/23/2013 09:44 AM, dinguyen@altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > Add bindings for SD/MMC for SOCFPGA.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> 
> > +* altr,sysmgr: Should be the phandle to the system_mgr node. As this is where
> > +		this where the register that controls the CIU clock phases
> > +		reside.
> > +
> > +* altr,ciu-clk-offset: The order of the cells should be:
> > +	- First Cell: Offset of the register in the system_mgr node that controls
> > +		the smpsel bits.
> > +	- Second Cell: Shift value of the drvsel bits.
> > +	- Third Cell: Shift value of the smpsel bits.
> 
> This almost solves the issues I was thinking of. A few more thoughts though:
> 
> * What if the sysmgr node has multiple reg entries. Is the offset cell
> in altr,ciu-clk-offset an offset from the first reg entry, or across all
> reg entries? It might be better to specify this as a reg index plus
> offset, or allow the sysmgr node to define the format (#sysmgr-cells
> perhaps).
> 
> * What if the drvsel and smpsel bits are in different registers, even
> different sysmgr blocks? Wouldn't it be better to have 2 separate
> properties, each one defining the location of one bit-field?
> 
> * bikeshed: altr,ciu-clk-offset isn't a great name; the value is more
> than just an offset.
> 
> Putting those together, I might expect the following properties:
> 
> sysmgr: sysmgr {
>     /* binding for sysmgr node must specify what those 3 cells are */
>     #sysmgr-cells = <3>;
> }
> 
> dwmmc {
>     altr,drvsel-reg-field = <
>         &sysmgr /* sysmgr phandle */
>         0 /* reg index */
>         0 /* reg offset */
>         0 /* field bit position */
>         3 /* field bit size */>;
>     altr,smpsel-reg-field = <
>         &sysmgr /* sysmgr phandle */
>         0 /* reg index */
>         0 /* reg offset */
>         3 /* field bit position */
>         3 /* field bit size */>;
> };
> 
> That would allow the whole sysmgr concept to be completely generic.
> 
> But, this is a bit like representing raw register I/O in DT, which has
> been frowned upon in the past.
> 
> Finally, what if the values for drvsel, smpsel are different in
> different sysmgr implementations? Do you need a property that defines
> that values?
> 
> Another option might be to define a semantic API between the two, such
> that you only need a sysmgr=<&sysmgr> property, yet the driver for the
> sysmgr node exposes a function sysmgr_set_dwmmc_drvsel_smpsel(struct
> device_node *sysmgr_node, uint drvsel, uint smpsel); Now, the sysmgr
> driver would have to implement that on any SoC that supported a dwmmc.

I was trying to avoid adding a driver for the sysmgr, as it really does
not represent any type of device. It is a merely a register region with
miscellaneous registers that controls other IPs in the SOC.

I'm thinking perhaps I can set this register in the arch specific file,
then the SD/MMC driver would not need to bother with it at all?

Thanks,
Dinh
> 
> 
