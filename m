From: Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v3 14/21] arm64: dts: hi3660: enable idle states
Date: Thu, 15 Jun 2017 10:55:07 +0800
Message-ID: <CAFGCpxyxUnML7E_vszXAX=sHOgHFEBcYkXxY=tfNK5YC9NariA@mail.gmail.com>
References: <20170614082338.15673-1-guodong.xu@linaro.org> <20170614082338.15673-15-guodong.xu@linaro.org>
 <20170615002358.GD28496@leoy-ThinkPad-T440>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33373 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdFOCzI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jun 2017 22:55:08 -0400
Received: by mail-yw0-f181.google.com with SMTP id 63so659613ywr.0
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jun 2017 19:55:08 -0700 (PDT)
In-Reply-To: <20170615002358.GD28496@leoy-ThinkPad-T440>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "xuwei (O)" <xuwei5@hisilicon.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Xuejiancheng <xuejiancheng@hisilicon.com>, Peter Griffin <peter.griffin@linaro.org>, "Chenfeng (puck)" <puck.chen@hisilicon.com>, Lee Jones <lee.jones@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, Zhangfei Gao <zhangfei.gao@linaro.org>, devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mmc@vger.kernel.org, linux-pci <linux-pci@vger.kernel.org>D

On Thu, Jun 15, 2017 at 8:23 AM, Leo Yan <leo.yan@linaro.org> wrote:
> On Wed, Jun 14, 2017 at 04:23:31PM +0800, Guodong Xu wrote:
>> From: Leo Yan <leo.yan@linaro.org>
>>
>> On Hi3660 there have two clusters, one is CA53 cluster and another is
>> CA73 cluster. This two clusters have different idle states separately.
>> With Daniel Lezcano's patch (ARM: cpuidle: Support asymmetric idle
>> definition), now ARM idle driver can support different clusters with
>> different idle states.
>>
>> Base on this, this patch is to bind two clusters idle states on Hi3660.
>> Except the "WFI" states are enabled by default for all CPUs, this patch
>> also binds below extra idle states:
>>
>> - CA53 CPUs have two more states:
>>   CPU_SLEEP:       CPU power off state
>>   CLUSTER_SLEEP_0: Cluster power off state
>>
>> - CA73 CPUs have three more states:
>>   CPU_NAP:         CPU retention state
>>   CPU_SLEEP:       CPU power off state
>>   CLUSTER_SLEEP_1: Cluster power off state
>
> Hi Guodong, Wei and all,
>
> As Daniel reminded, this patch is dependent on patch (ARM: cpuidle:
> Support asymmetric idle definition) [1] but his patch has not been
> finally merged yet. So let us hold on this patch for Daniel's patch
> is picked up firstly.
>
> At the meantime welcome the review and comment for this patch ahead.
>

Ok, so, I will drop this patch, and resend my patchset as v4.

-Guodong

> [1] https://patchwork.kernel.org/patch/9781869/
>
> [...]
>
> Thanks,
> Leo Yan
