From: Phil Edworthy <phil.edworthy@renesas.com>
Subject: RE: [PATCH] mmc: sdhci-of-arasan: Add quirk to avoid erroneous msg
Date: Tue, 27 Feb 2018 14:31:36 +0000
Message-ID: <HK2PR0601MB1393B39958A128DCB8CA0E44F5C00@HK2PR0601MB1393.apcprd06.prod.outlook.com>
References: <1519739731-27920-1-git-send-email-phil.edworthy@renesas.com>
 <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <b35a8ac6-af47-5851-95ae-371288bb5f25@rock-chips.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On 27 February 2018 14:28, Shawn Lin wrote:
> 在 2018/2/27 21:55, Phil Edworthy 写道:
> > Since the controller does not support the end-of-busy IRQ, don't use it.
> > Otherwise, on older SD cards you will get lots of these messages:
> > "mmc0: Got data interrupt 0x00000002 even though no data operation was
> in progress"
> >
> 
> I'm afraid you have to explain which version of arasan's IP suffer from this
> and what does the "older SD cards" mean?
Ok, I'll try to find out the IP version...
For "older SD cards", I can provide a list of a few cards that exhibit this problem
and others that don't, is that enough info?

Thanks
Phil

> > This has been reported on Xilinx devices that also use the Arasan IP.
> > See https://patchwork.kernel.org/patch/8062871/
> >
> > This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC.
> >
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-of-arasan.c
> > b/drivers/mmc/host/sdhci-of-arasan.c
> > index c33a5f7..ab66e32 100644
> > --- a/drivers/mmc/host/sdhci-of-arasan.c
> > +++ b/drivers/mmc/host/sdhci-of-arasan.c
> > @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data
> sdhci_arasan_pdata = {
> >   	.ops = &sdhci_arasan_ops,
> >   	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
> >   	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> > -			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> > +			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> > +			SDHCI_QUIRK2_STOP_WITH_TC,
> >   };
> >
> >   static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32
> > intmask)
> >
> 
> 
> --
> Best Regards
> Shawn Lin
