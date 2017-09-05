From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 4/5] mmc: sdhci-omap: Add OMAP SDHCI driver
Date: Tue, 5 Sep 2017 14:27:05 +0530
Message-ID: <3782edd2-af90-c6c9-1358-1721a1dae28f@ti.com>
References: <20170821074132.4622-1-kishon@ti.com>
 <20170821074132.4622-5-kishon@ti.com>
 <4f0a7225-1843-b353-1a2a-9adcb49554d3@intel.com>
 <c7972f00-ef62-1736-822f-ebf6822b6d33@ti.com>
 <dfe1b4e2-bcb5-c969-efe6-7cddd0eb0bf9@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <dfe1b4e2-bcb5-c969-efe6-7cddd0eb0bf9@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ravikumar Kattekola <rk@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thursday 31 August 2017 06:32 PM, Adrian Hunter wrote:
> On 30/08/17 16:53, Kishon Vijay Abraham I wrote:
>> On Monday 28 August 2017 02:36 PM, Adrian Hunter wrote:
>>> On 21/08/17 10:41, Kishon Vijay Abraham I wrote:
>>>> +
>>>> +static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
>>>> +{
>>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>>> +	unsigned long clkdiv;
>>>> +
>>>> +	if (!clock)
>>>> +		return;
>>>
>>> Are you sure you don't want to stop the clock.
>>
>> There is never a case where the MMC core sends a request to stop the clock.
>> Maybe this check is not required at all.
> 
> It does when voltage switching e.g. mmc_set_uhs_voltage(), but host drivers
> should support the possibility anyway.

Indeed! Will fix it and send a new revision once everyone agrees on the dt binding.

Thanks
Kishon
