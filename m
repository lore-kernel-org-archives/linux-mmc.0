From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
Date: Thu, 15 Jun 2017 08:23:58 +0800
Message-ID: <20170615002358.GD28496@leoy-ThinkPad-T440>
References: <20170614082338.15673-1-guodong.xu@linaro.org>
 <20170614082338.15673-15-guodong.xu@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170614082338.15673-15-guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guodong Xu <guodong.xu@linaro.org>
Cc: robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, wangkefeng.wang@huawei.com, xuejiancheng@hisilicon.com, peter.griffin@linaro.org, puck.chen@hisilicon.com, lee.jones@linaro.org, ulf.hansson@linaro.org, bhelgaas@google.com, arnd@arndb.de, zhangfei.gao@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Wang <jean.wangtao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 14, 2017 at 04:23:31PM +0800, Guodong Xu wrote:
> From: Leo Yan <leo.yan@linaro.org>
> 
> On Hi3660 there have two clusters, one is CA53 cluster and another is
> CA73 cluster. This two clusters have different idle states separately.
> With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
> definition), now ARM idle driver can support different clusters with
> different idle states.
> 
> Base on this, this patch is to bind two clusters idle states on Hi3660.
> Except the "WFI" states are enabled by default for all CPUs, this patch
> also binds below extra idle states:
> 
> - CA53 CPUs have two more states:
>   CPU_SLEEP:       CPU power off state
>   CLUSTER_SLEEP_0: Cluster power off state
> 
> - CA73 CPUs have three more states:
>   CPU_NAP:         CPU retention state
>   CPU_SLEEP:       CPU power off state
>   CLUSTER_SLEEP_1: Cluster power off state

Hi Guodong, Wei and all,

As Daniel reminded, this patch is dependent on patch (ARM: cpuidle:
Support asymmetric idle definition) [1] but his patch has not been
finally merged yet. So let us hold on this patch for Daniel's patch
is picked up firstly.

At the meantime welcome the review and comment for this patch ahead.

[1] https://patchwork.kernel.org/patch/9781869/

[...]

Thanks,
Leo Yan
