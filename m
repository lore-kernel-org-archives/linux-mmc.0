From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH v2 01/11] Documentation: dt: wireless: update wl1251 for
 sdio
Date: Sat, 26 Oct 2019 10:24:05 +0200
Message-ID: <3A15C879-3A17-4FFC-B41E-0B98B63E8F7C@goldelico.com>
References: <cover.1571510481.git.hns@goldelico.com>
 <741828f69eca2a9c9a0a7e80973c91f50cc71f9b.1571510481.git.hns@goldelico.com>
 <20191025211338.GA20249@bogus>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191025211338.GA20249@bogus>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, linux-wireless@vger.kernel.org, Kefeng Wang <wangkefeng.wang@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>, netdev@vger.kernel.org, linux-omap@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@linux.ibm.com>, Yangtao Li <tiny.windzz@gmail.com>, Kalle Valo <kvalo@codeaurora.org>, Petr Mladek <pmladek@suse.com>, =?utf-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Alexios Zavras <alexios.zavras@intel.com>, John Stultz <john.stultz@linaro.org>, David Sterba <dsterba@suse.com>, Thomas Gleixner <tglx@linutronix.de>, letux-kernel@openphoenux.org, Allison Randal <allison@lohutok.net>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundatio>
List-Id: linux-mmc@vger.kernel.org


> Am 25.10.2019 um 23:13 schrieb Rob Herring <robh@kernel.org>:
> 
> On Sat, Oct 19, 2019 at 08:41:16PM +0200, H. Nikolaus Schaller wrote:
>> The standard method for sdio devices connected to
>> an sdio interface is to define them as a child node
>> like we can see with wlcore.
>> 
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Acked-by: Kalle Valo <kvalo@codeaurora.org>
>> ---
>> .../bindings/net/wireless/ti,wl1251.txt       | 26 +++++++++++++++++++
>> 1 file changed, 26 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
>> index bb2fcde6f7ff..88612ff29f2d 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
>> +++ b/Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt
>> @@ -35,3 +35,29 @@ Examples:
>> 		ti,power-gpio = <&gpio3 23 GPIO_ACTIVE_HIGH>; /* 87 */
>> 	};
>> };
>> +
>> +&mmc3 {
>> +	vmmc-supply = <&wlan_en>;
>> +
>> +	bus-width = <4>;
>> +	non-removable;
>> +	ti,non-removable;
>> +	cap-power-off-card;
>> +
>> +	pinctrl-names = "default";
>> +	pinctrl-0 = <&mmc3_pins>;
> 
> None of the above are really relevant to this binding.

Ok, but how and where do we document that they are needed to make both ends of the interface work together?

> 
>> +
>> +	#address-cells = <1>;
>> +	#size-cells = <0>;
>> +
>> +	wlan: wl1251@1 {
> 
> wifi@1

Ok.

> 
>> +		compatible = "ti,wl1251";
>> +
>> +		reg = <1>;
>> +
>> +		interrupt-parent = <&gpio1>;
>> +		interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;	/* GPIO_21 */
>> +
>> +		ti,wl1251-has-eeprom;
>> +	};
>> +};
>> -- 
>> 2.19.1
>> 

BR and thanks,
Nikolaus
