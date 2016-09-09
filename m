From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [PATCH v3] mmc: sdhci-msm: Add pm_runtime and system PM support
Date: Fri, 9 Sep 2016 13:18:32 +0300
Message-ID: <496321c5-24e7-3ac5-b3dd-7b7d5dc75536@linaro.org>
References: <20160901142335.2396-1-pramod.gurav@linaro.org>
 <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a0e314de-3590-399c-27c7-ddd6461dee42@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Pramod Gurav <pramod.gurav@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, ulf.hansson@linaro.org, Ritesh Harjani <riteshh@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-mmc@vger.kernel.org

On 09/08/2016 11:02 AM, Adrian Hunter wrote:
> On 01/09/16 17:23, Pramod Gurav wrote:
>> Provides runtime PM callbacks to enable and disable clock resources
>> when idle. Also support system PM callbacks to be called during system
>> suspend and resume.
>>
>> Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
>
> Can we get some Tested/Reviewed/Acked-by from people using this driver?
>

Hi Pramod,
Thanks for the patch. Unfortunately, my db410c board fails to
boot when i apply it.

[    1.778433] mmc0: new HS200 MMC card at address 0001
[    1.783115] mmcblk0: mmc0:0001 DS2008 7.28 GiB
[    1.783337] mmcblk0boot0: mmc0:0001 DS2008 partition 1 4.00 MiB
[    1.787025] mmcblk0boot1: mmc0:0001 DS2008 partition 2 4.00 MiB
[    1.792893] mmcblk0rpmb: mmc0:0001 DS2008 partition 3 4.00 MiB
[    1.802603]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
[    2.693631] blk_update_request: I/O error, dev mmcblk0, sector 462880
[    2.710381] blk_update_request: I/O error, dev mmcblk0, sector 462880
[    2.710443] Buffer I/O error on dev mmcblk0p10, logical block 0, 
async page read
[    2.724827] blk_update_request: I/O error, dev mmcblk0, sector 462881
[    2.724853] Buffer I/O error on dev mmcblk0p10, logical block 1, 
async page read
...

More I/O errors are following and it is unable to mount the rootfs from
the eMMC. When i retried booting, got also the following:

[    2.877149] mmcblk0: error -110 sending status command, retrying
[    2.879408] mmcblk0: error -110 sending status command, retrying
[    2.884436] mmcblk0: error -110 sending status command, aborting
[    2.896826] mmc0: cache flush error -110

BR,
Georgi
