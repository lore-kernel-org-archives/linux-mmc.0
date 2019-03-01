From: =?utf-8?Q?Christoph_M=C3=BCllner?=
        <christoph.muellner@theobroma-systems.com>
Subject: Re: [PATCH 1/3] dt-bindings: mmc: Add DTS property to disable DCMDs
 on Arasan controllers
Date: Fri, 1 Mar 2019 19:19:59 +0100
Message-ID: <E9DB0B97-8B74-4397-87EF-ED05D991E1E9@theobroma-systems.com>
References: <20190301164349.60589-1-christoph.muellner@theobroma-systems.com>
 <9535423.1mel94qINy@phil>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9535423.1mel94qINy@phil>
Sender: linux-kernel-owner@vger.kernel.org
To: Heiko Stuebner <heiko@sntech.de>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Michal Simek <michal.simek@xilinx.com>, Douglas Anderson <dianders@chromium.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Viresh Kumar <viresh.kumar@linaro.org>, Jeffy Chen <jeffy.chen@rock-chips.com>, Shunqian Zheng <zhengsq@rock-chips.com>, Ezequiel Garcia <ezequiel@collabora.com>, Randy Li <ayaka@soulik.info>, Tony Xie <tony.xie@rock-chips.com>, Vicente Bergas <vicencb@gmail.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists
List-Id: linux-mmc@vger.kernel.org


> On 01.03.2019, at 19:17, Heiko Stuebner <heiko@sntech.de> wrote:
> 
> Am Freitag, 1. März 2019, 17:43:45 CET schrieb Christoph Muellner:
>> Direct commands (DCMDs) are an optional feature of eMMC 5.1's command
>> queue engine (CQE). The Arasan eMMC 5.1 controller uses the CQHCI,
>> which exposes a control register bit to enable the feature.
>> The current implementation sets this bit unconditionally.
>> 
>> This patch allows to surpress the feature activation,
>> by specifying the property disable-cqe-dcmd.
>> 
>> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
>> Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
> 
> Patch subject is needs improvement :-) .
> I did scratch my head a lot regarding "where is the code change"
> until I actually looked into the patch itself, so you probably want
> 
> 	mmc: sdhci-of-arasan: Add DTS property to disable DCMDs
> 
> or similar instead of "dt-bindings: ..." here to match the subsystem.

Yes, I've spotted this as well after sending it.
I've already renamed to "mmc: sdhci-of-arasan: Add DTS property to disable DCMDs." for v2.

Thanks,
Christoph

> 
> 
> Heiko
> 
>> ---
>> drivers/mmc/host/sdhci-of-arasan.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
>> index c9e3e050ccc8..88dc3f00a5be 100644
>> --- a/drivers/mmc/host/sdhci-of-arasan.c
>> +++ b/drivers/mmc/host/sdhci-of-arasan.c
>> @@ -832,7 +832,10 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>> 		host->mmc_host_ops.start_signal_voltage_switch =
>> 					sdhci_arasan_voltage_switch;
>> 		sdhci_arasan->has_cqe = true;
>> -		host->mmc->caps2 |= MMC_CAP2_CQE | MMC_CAP2_CQE_DCMD;
>> +		host->mmc->caps2 |= MMC_CAP2_CQE;
>> +
>> +		if (!of_property_read_bool(np, "disable-cqe-dcmd"))
>> +			host->mmc->caps2 |= MMC_CAP2_CQE_DCMD;
>> 	}
>> 
>> 	ret = sdhci_arasan_add_host(sdhci_arasan);
>> 
> 
> 
> 
> 
