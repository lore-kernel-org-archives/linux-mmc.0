From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2 v2] mmc: enable mmc host device to suspend/resume asynchronously
Date: Fri, 29 Jan 2016 12:40:22 +0100
Message-ID: <CAPDyKFqRGAVuWSbWFEGiDoj8ZUDgpbKty=pNDxiatn4MRKhMYw@mail.gmail.com>
References: <56A1A2C2.1030106@linux.intel.com>
	<CAPDyKFrKmTfA2GjQDmFnh0hRzeP8kcKGL6oMSzrZihyGL4pQUA@mail.gmail.com>
	<56A6D6C1.9060805@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A6D6C1.9060805@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fu, Zhonghui" <zhonghui.fu@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Venu Byravarasu <vbyravarasu@nvidia.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 26 January 2016 at 03:15, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>
>
> On 1/22/2016 10:51 PM, Ulf Hansson wrote:
>> On 22 January 2016 at 04:32, Fu, Zhonghui <zhonghui.fu@linux.intel.com> wrote:
>>> This patch enables mmc hosts to suspend/resume asynchronously.
>>> This will improve system suspend/resume speed. After applying
>>> this patch and enabling all mmc hosts' child devices to
>>> suspend/resume asynchronously on ASUS T100TA, the system
>>> suspend-to-idle time is reduced from 1645ms to 1107ms, and the
>>> system resume time is reduced from 940ms to 914ms.
>> Do you really reduce time at all with this patch by its own? I think not.
>>
>> Moreover, I thought the biggest improvement came from the patch which
>> enabled async suspend/resume for the MMC/SD/SDIO device?
>> ec076cd226c3 ("mmc: enable MMC/SD/SDIO device to suspend/resume asynchronously")
>>
>> Similar comment applies to patch2/2, but I would expect it together
>> with the $subject patch gives an improvement.
>>
>> Please update the change-logs one more round.
>
> The reduce time is not contributed by only this patch, please see the change-log: "After applying this patch and enabling all mmc hosts' child devices to suspend/resume asynchronously on ASUS T100TA .......". Actually, the biggest improvement came from the patch - "net/wireless: enable wiphy device to suspend/resume asynchronously(commit 9f0e13546ef5773b7059b531a667ec47a5f897ee)". Wiphy device(phy0) is child device of WiFi card(SDIO card).
>
> Do you mean that I should list the reduce time contributed by only this patch and patch2/2 in change-log?


Okay, fair enough. I should have read the change log a bit more detailed.

Let's keep this as is! I have applied both patch 1 and patch2.

Adrian, please tell me if you don't like patch2 (sdhci-acpi), then I
will drop it.

Thanks and kind regards
Uffe
