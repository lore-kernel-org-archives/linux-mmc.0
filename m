From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Mon, 20 Jun 2016 20:29:55 +0800
Message-ID: <CAGb2v65nuVyHjQY7-shvygCTVxG6eHbwGygr_Cw2Hg7mg+rAwg@mail.gmail.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com>
 <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20160620112651.GA26936@shlinux2>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Chen <hzpeterchen@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Peter Chen <peter.chen@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Boyd <stephen.boyd@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Javier Martinez Canillas <javier@osg.samsung.com>, Alan Stern <stern@rowland.harvard.edu>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, troy.kisky@boundarydevices.com, Rob Herring <robh+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, oscar@naiandei.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB List <linux-usb@vger.kernel.org>, linux-mmc@vger
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 20, 2016 at 7:26 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
>> On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
>> > Add binding doc for generic usb power sequence driver, and update
>> > generic usb device binding-doc accordingly.
>> >
>> > Signed-off-by: Peter Chen <peter.chen@nxp.com>
>> > ---
>> >  .../bindings/power/pwrseq/pwrseq-usb-generic.txt   | 31 ++++++++++++++++++++++
>> >  .../devicetree/bindings/usb/usb-device.txt         |  2 ++
>> >  2 files changed, 33 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
>> > new file mode 100644
>> > index 0000000..8ad98382
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/power/pwrseq/pwrseq-usb-generic.txt
>> > @@ -0,0 +1,31 @@
>> > +The power sequence for generic USB Devices
>> > +
>> > +Some hard-wired USB devices need to do power sequence to let the
>> > +device work normally, the typical power sequence like: enable USB
>> > +PHY clock, toggle reset pin, etc. But current Linux USB driver
>> > +lacks of such code to do it, it may cause some hard-wired USB devices
>> > +works abnormal or can't be recognized by controller at all. The
>> > +power sequence will be done before this device can be found at USB
>> > +bus.
>> > +
>> > +Required properties:
>> > +- compatible : contains "usb-pwrseq-generic".
>>
>> In case I have not been clear, no.
>>
>> I am not going to accept anything along the lines of the current mmc
>> pwrseq. I am basically okay with Krzysztof's proposal as it is *only*
>> an added property and not a duplication of information. I'd suggest
>> you figure out how to make the kernel work with that rather than
>> trying to work-around whatever kernel limitations there are.
>>
>
> I see.
>
> Would you agree with below:
>
> &usbotg1 {
>         vbus-supply = <&reg_usb_otg1_vbus>;
>         pinctrl-names = "default";
>         pinctrl-0 = <&pinctrl_usb_otg1_id>;
>         status = "okay";
>
>         #address-cells = <1>;
>         #size-cells = <0>;
>         hub: genesys@1 {
>                 compatible = "usb5e3,608";
>                 reg = <1>;
>
>                 power-sequence;
>                 reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
>                 reset-duration-us = <10>;
>                 clocks = <&clks IMX6SX_CLK_CKO>;
>
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>                 ethernet: asix@1 {
>                         compatible = "usbb95,1708";
>                         reg = <1>;
>
>                         power-sequence;
>                         reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
>                         reset-duration-us = <15>;
>                         clocks = <&clks IMX6SX_CLK_IPG>;
>                 };
>         };
> };
>
> If the node has property "power-sequence", the pwrseq core will create
> related platform device, and the driver under pwrseq driver will handle
> power sequence stuffs. The property below "power-sequence" will be
> handled at pwrseq driver.

Isn't this binding what Krzysztof proposed? His series also provides example
code for enabling USB device power sequencing. Does it not work for you?

Having 2 series by 2 separate people doing the same thing but slightly
different is very confusing.

Regards
ChenYu
