From: Manish Narani <MNARANI@xilinx.com>
Subject: RE: [PATCH 3/3] mmc: sdhci-of-arasan: Add support for ZynqMP Platform
 Tap Delays Setup
Date: Wed, 19 Jun 2019 08:40:36 +0000
Message-ID: <MN2PR02MB6029DB87CEE32655B0F1E794C1E50@MN2PR02MB6029.namprd02.prod.outlook.com>
References: <1560247011-26369-1-git-send-email-manish.narani@xilinx.com>
 <1560247011-26369-4-git-send-email-manish.narani@xilinx.com>
 <CAPDyKFrJwpwUUX_q2kcR9QY_fv9Lgos+ixPmU6JMeJVqJAiFpg@mail.gmail.com>
 <5feac3fb-bef3-b7d1-57d6-81e115e1f555@xilinx.com>
 <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAPDyKFp_ZvSjFp2FGonzGsnc9xPyZ7qOCaRnX1SimBxLpfz9-Q@mail.gmail.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Michal Simek <michals@xilinx.com>
Cc: Mark Rutland <mark.rutland@arm.com>, DTML <devicetree@vger.kernel.org>, Nava kishore Manne <navam@xilinx.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>, Rob Herring <robh+dt@kernel.org>, Olof Johansson <olof@lixom.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Uffe,


> -----Original Message-----
> From: Ulf Hansson <ulf.hansson@linaro.org>
> Sent: Monday, June 17, 2019 5:51 PM
[...]
> 
> The "const struct zynqmp_eemi_ops *eemi_ops; should then be moved into
> a clock provider specific struct, which is assigned when calling
> sdhci_arasan_register_sdclk. I understand that all the clock data is
> folded into struct sdhci_arasan_data today, but I think that should be
> moved into a "sub-struct" for the clock specifics.
> 
> Moreover, when registering the clock, we should convert from using
> devm_clk_register() into devm_clk_hw_register() as the first one is
> now deprecated.

Just a query here:
When we switch to using devm_clk_hw_register() here, it will register the clk_hw and return int.
Is there a way we can get the clk (related to the clk_hw registered) from the
clock framework?
I am asking this because we will need that clk pointer while calling clk_set_phase() function.

Thanks,
Manish
