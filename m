From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: sdhci-omap: Add bindings for the
 sdhci-omap controller
Date: Tue, 5 Sep 2017 14:23:59 +0530
Message-ID: <37ea03ef-688f-40e6-32ce-f4637e8faf9b@ti.com>
References: <20170821142132.GH6008@atomide.com>
 <20170823054246.23927-1-kishon@ti.com>
 <20170829171121.cxjwrzhbotdkddec@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170829171121.cxjwrzhbotdkddec@rob-hp-laptop>
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
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, linux-mmc@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Adrian Hunter <adrian.hunter@intel.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tuesday 29 August 2017 10:41 PM, Rob Herring wrote:
> On Wed, Aug 23, 2017 at 11:12:46AM +0530, Kishon Vijay Abraham I wrote:
>> Add binding for the TI's sdhci-omap controller. This now includes only
>> a subset of properties documented in ti-omap-hsmmc.txt but will eventually
>> include all the properties.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> ---
>> Changes from v2:
>> *) Fixed example to use the updated compatible
>>
>> Changes from v1:
>> *) Create a new sdhci-omap.txt document for TI's sdhci-omap controller instead
>>    of using the ti-omap-hsmmc.txt as suggested by Tony
>>  .../devicetree/bindings/mmc/sdhci-omap.txt         | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-omap.txt b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> new file mode 100644
>> index 000000000000..139695ad2d58
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mmc/sdhci-omap.txt
>> @@ -0,0 +1,22 @@
>> +* TI OMAP SDHCI Controller
>> +
>> +Refer to mmc.txt for standard MMC bindings.
>> +
>> +Required properties:
>> +- compatible: Should be "ti,dra7-sdhci" for DRA7 and DRA72 controllers
>> +- ti,hwmods: Must be "mmc<n>", <n> is controller instance starting 1
>> +
>> +Optional properties:
>> +- ti,dual-volt: boolean, supports dual voltage cards
>> +- ti,non-removable: non-removable slot (like eMMC)
> 
> Well, if you are doing a new compatible, then why aren't you using 
> common properties?

yeah, now moved to generic bindings.
> 
>> +
>> +Example:
>> +	mmc1: mmc@0x4809c000 {
> 
> Drop the '0x'.

sure, will fix it.

Thanks
Kishon
