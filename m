From: Peter Chen <hzpeterchen@gmail.com>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Wed, 22 Jun 2016 09:14:39 +0800
Message-ID: <20160622011439.GA21361@shlinux2>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2>
 <20160620161607.GA11427@rob-hp-laptop>
 <20160621021117.GD26936@shlinux2>
 <20160621212653.GA22764@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20160621212653.GA22764@rob-hp-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, troy.kisky@boundarydevices.com, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, oscar@naiandei.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB List <linux-usb@vger.kernel.org>, linux-mmc@vger.
List-Id: linux-mmc@vger.kernel.org

On Tue, Jun 21, 2016 at 04:26:53PM -0500, Rob Herring wrote:
> On Tue, Jun 21, 2016 at 10:11:17AM +0800, Peter Chen wrote:
> > On Mon, Jun 20, 2016 at 11:16:07AM -0500, Rob Herring wrote:
> > > On Mon, Jun 20, 2016 at 07:26:51PM +0800, Peter Chen wrote:
> > > > On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
> > > > > On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
> > > > > > Add binding doc for generic usb power sequence driver, and update
> > > > > > generic usb device binding-doc accordingly.
> 
> [...]
> 
> > > > 		clocks = <&clks IMX6SX_CLK_CKO>;
> > > > 
> > > > 		#address-cells = <1>;
> > > > 		#size-cells = <0>;
> > > > 		ethernet: asix@1 {
> > > > 			compatible = "usbb95,1708";
> > > > 			reg = <1>;
> > > > 
> > > > 			power-sequence;
> > > > 			reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
> > > > 			reset-duration-us = <15>;
> > > > 			clocks = <&clks IMX6SX_CLK_IPG>;
> > > > 		};
> > > > 	};
> > > > };
> > > > 
> > > > If the node has property "power-sequence", the pwrseq core will create
> > > > related platform device, and the driver under pwrseq driver will handle
> > > > power sequence stuffs. 
> > > 
> > > This I have issue with. If you are creating a platform device here, you 
> > > are trying to work-around limitations in the linux driver model.
> > 
> > My current solution like below, but it seems you didn't agree with that.
> > I just double confirm here, if you don't, I give up the solution for
> > using generic power sequence framework.
> > 
> > In drivers/usb/core/hub.c
> > 
> > 	for_each_child_of_node(parent->of_node, node) {
> > 		hdev_pwrseq = pwrseq_alloc(node, "usb_pwrseq_generic");
> > 		if (!IS_ERR_OR_NULL(hdev_pwrseq)) {
> > 			pwrseq_node = kzalloc(sizeof(pwrseq_node), GFP_KERNEL);
> > 			if (!pwrseq_node) {
> > 				ret = -ENOMEM;
> > 				goto err1;
> > 			}
> > 			/* power on sequence */
> > 			ret = pwrseq_pre_power_on(hdev_pwrseq);
> 
> Why does this function need to do anything more than:
> 
> - Check if the child has a "power-sequence" property
> - Get the "reset-gpios" GPIO
> - Assert reset for specified/default time
> - Deassert reset
> 

Besides gpios, it may exist clock and regulator operation, and the
operation may be failed. I thought these operations can be easy
done belongs to a device, but now, let me try this straight-forward
way, thanks.

Peter
> Then continue on as normal. That seems straight-forward to me.
> 
> There is no reason you need a platform device in the mix. Perhaps trying 
> to move the MMC pwr-seq code is pointless as it adds needless 
> complexity.
> 
> [...]
> 
> > > Either 
> > > we need some sort of pre-probe hook to the drivers to call or each 
> > > parent node driver is responsible for checking and calling pwr-seq 
> > > functions for child nodes. e.g. The host controller calls pwr-seq for 
> > > the hub, the hub driver calls the power seq for the asix chip. Soon as 
> > > we have a case too complex for the generic pwr-seq, we're going to need 
> > > the pre-probe hook as I don't want to see a continual expansion of 
> > > generic pwr-seq binding for ever more complex cases.
> > > 
> > 
> > How the driver know what it needs to handle (eg, gpio, clock) if there
> > is no device for it? The most important we need to consider is which
> > device owns there power sequence properties, then the corresponding
> > driver can handle it.
> 
> What can be handled by is defined by presence of power-sequence 
> property. There can be 1 driver for the device. That is the USB hub 
> driver in this example. You should not have 2 "devices".
> 
> Rob

-- 

Best Regards,
Peter Chen
