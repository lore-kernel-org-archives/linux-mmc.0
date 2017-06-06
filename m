From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 0/7] dra7: Fixes for MMC devicetree node
Date: Tue, 6 Jun 2017 17:27:13 +0530
Message-ID: <08b140b7-de76-c912-9f81-c7cdeca45641@ti.com>
References: <20170601143401.16852-1-kishon@ti.com>
 <CAPDyKFqHHjZQnnaGLP=xDj3eYgzADDYoomzBuXRviBgh-n2QFw@mail.gmail.com>
 <f78dd61c-6689-4dbc-d1db-128f92be8e51@ti.com>
 <1d15c9e9-f257-fd97-a9a2-055ee90d7e84@ti.com>
 <20170606105131.GZ3730@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170606105131.GZ3730@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Russell King <linux@armlinux.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tuesday 06 June 2017 04:21 PM, Tony Lindgren wrote:
> * Kishon Vijay Abraham I <kishon@ti.com> [170606 03:40]:
>> omap3-overo-base.dtsi has the following dt node for mmc.
>> /* optional on board WiFi */
>> &mmc2 {
>>         pinctrl-names = "default";
>>         pinctrl-0 = <&mmc2_pins>;
>>         vmmc-supply = <&w3cbw003c_npoweron>;
>>         vqmmc-supply = <&w3cbw003c_bt_nreset>;
>>         vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>>         bus-width = <4>;
>>         cap-sdio-irq;
>>         non-removable;
>> };
>>
>> It has both "vqmmc-supply" and "vmmc_aux-supply". However omap-hsmmc driver has
>> never parsed vqmmc so far. So I'd assume bt was never functional and it's used
>> only for wifi.
> 
> Hmm yeah the vqmmc-supply probably got copied from some
> other SoC for w3cbw003c.

Okay. So I think we can remove vqmmc-supply here without breaking any existing
functionality.
> 
>> So for the change suggested by Ulf, Can I do something like below, so that we
>> can keep wifi functional (ignoring bt since that was never functional)?
>> -       vqmmc-supply = <&w3cbw003c_bt_nreset>;
>> -       vmmc_aux-supply = <&w3cbw003c_wifi_nreset>;
>> +       vqmmc-supply = <&w3cbw003c_wifi_nreset>;
> 
> Optional sdio pins 4 - 8 need separate power and that's
> why we have the vmmc_aux supply to start with. But here
> there are only four pins, so my guess is that only one
> regulator is needed and the the other two are gpio pins
> for wland and bt that nowadays should be handled by the
> mmc power sequence driver.

Yeah. Just now checked the pwrseq driver (pwrseq_simple), but it has it's own
binding. So even if we move to the pwrseq, we still have to support
"vqmmc-supply = <&w3cbw003c_wifi_nreset>" to avoid breaking old dt compatibiltiy.

Thanks
Kishon
