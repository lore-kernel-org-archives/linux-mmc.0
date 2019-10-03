From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v4 0/7] Add SD/MMC driver for Actions Semi S900 SoC
Date: Thu, 3 Oct 2019 21:47:14 +0530
Message-ID: <20191003161714.GA14774@Mani-XPS-13-9360>
References: <20190916154546.24982-1-manivannan.sadhasivam@linaro.org>
 <CAPDyKFqsZ1mZ53b9wLruATzi+ymFrUCLhxzx7NFUq48p5w0Gtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqsZ1mZ53b9wLruATzi+ymFrUCLhxzx7NFUq48p5w0Gtw@mail.gmail.com>
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
Cc: DTML <devicetree@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, linux-actions@lists.infradead.org, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, thomas.liau@actions-semi.com, linux-clk <linux-clk@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, Oct 03, 2019 at 12:01:18PM +0200, Ulf Hansson wrote:
> On Mon, 16 Sep 2019 at 17:46, Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hello,
> >
> > This patchset adds SD/MMC driver for Actions Semi S900 SoC from Owl
> > family SoCs. There are 4 SD/MMC controller present in this SoC but
> > only 2 are enabled currently for Bubblegum96 board to access uSD and
> > onboard eMMC. SDIO support for this driver is not currently implemented.
> >
> > Note: Currently, driver uses 2 completion mechanisms for maintaining
> > the coherency between SDC and DMA interrupts and I know that it is not
> > efficient. Hence, I'd like to hear any suggestions for reimplementing
> > the logic if anyone has.
> >
> > With this driver, this patchset also fixes one clk driver issue and enables
> > the Actions Semi platform in ARM64 defconfig.
> >
> > Thanks,
> > Mani
> >
> > Changes in v4:
> >
> > * Incorporated review comments from Rob on dt binding
> >
> > Changes in v3:
> >
> > * Incorporated a review comment from Andreas on board dts patch
> > * Modified the MAINTAINERS entry for devicetree YAML binding
> >
> > Changes in v2:
> >
> > * Converted the devicetree bindings to YAML
> > * Misc changes to bubblegum devicetree as per the review from Andreas
> > * Dropped the read/write wrappers and renamed all functions to use owl-
> >   prefix as per the review from Ulf
> > * Renamed clk_val_best to owl_clk_val_best and added Reviewed-by tag
> >   from Stephen
> >
> > Manivannan Sadhasivam (7):
> >   clk: actions: Fix factor clk struct member access
> >   dt-bindings: mmc: Add Actions Semi SD/MMC/SDIO controller binding
> >   arm64: dts: actions: Add MMC controller support for S900
> >   arm64: dts: actions: Add uSD and eMMC support for Bubblegum96
> >   mmc: Add Actions Semi Owl SoCs SD/MMC driver
> >   MAINTAINERS: Add entry for Actions Semi SD/MMC driver and binding
> >   arm64: configs: Enable Actions Semi platform in defconfig
> >
> >  .../devicetree/bindings/mmc/owl-mmc.yaml      |  59 ++
> >  MAINTAINERS                                   |   2 +
> >  .../boot/dts/actions/s900-bubblegum-96.dts    |  62 ++
> >  arch/arm64/boot/dts/actions/s900.dtsi         |  45 ++
> >  arch/arm64/configs/defconfig                  |   1 +
> >  drivers/clk/actions/owl-factor.c              |   7 +-
> >  drivers/mmc/host/Kconfig                      |   8 +
> >  drivers/mmc/host/Makefile                     |   1 +
> >  drivers/mmc/host/owl-mmc.c                    | 696 ++++++++++++++++++
> >  9 files changed, 877 insertions(+), 4 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/owl-mmc.yaml
> >  create mode 100644 drivers/mmc/host/owl-mmc.c
> >
> > --
> > 2.17.1
> >
> 
> I have picked up the mmc patches for next

Thanks :)

> and as Stephen picked the
> clock patch, the rest are now for arm-soc, I guess!?
> 

Yes, I'll queue them through actions tree (unless Andreas wants to do the PR).

Regards,
Mani

> Kind regards
> Uffe
