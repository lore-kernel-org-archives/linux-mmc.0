From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 0/2] mmc: rtsx: revert support for mmc async request
Date: Wed, 30 Apr 2014 09:32:57 +0800
Message-ID: <536052C9.309@realsil.com.cn>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>
 <20140429080240.GC29462@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140429080240.GC29462@lee--X1>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Lee Jones <lee.jones@linaro.org>
Cc: ulf.hansson@linaro.org, sameo@linux.intel.com, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, chris@printf.net, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

Hi Lee,

On 04/29/2014 04:02 PM, Lee Jones wrote:
>> From: Micky Ching <micky_ching@realsil.com.cn>
>>
>> The commit <mmc: rtsx: add support for pre_req and post_req> have some problem,
>> using mutex_unlock() in atomic context, spinlock deadlock, it is hard to fix
>> these problem, and better to use a new method. So just remove it.
>>
>> The commit <mmc: rtsx: modify error handle and remove smatch warnings> depends
>> on the previous patch. And mainly fix some problem for the previous patch. So
>> need remove.
>>
>> Micky Ching (2):
>>    mmc: rtsx: Revert "mmc: rtsx: modify error handle and remove smatch
>>      warnings"
>>    mmc: rtsx: Revert "mmc: rtsx: add support for pre_req and post_req"
>>
>>   drivers/mfd/rtsx_pcr.c            |  132 ++++-------
>>   drivers/mmc/host/rtsx_pci_sdmmc.c |  459 +++++++------------------------------
>>   include/linux/mfd/rtsx_common.h   |    1 -
>>   include/linux/mfd/rtsx_pci.h      |    6 -
>>   4 files changed, 124 insertions(+), 474 deletions(-)
> Just to clarify, what commit did you base these changes on? Have you
> tested to ensure everything works as it should with these two
> reversions?
>
I base on linux-nex tree
commit d397246adc001ee5235f32de10db112ad23175df
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Thu Apr 24 16:22:09 2014 +1000

     Add linux-next specific files for 20140424

     Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

And tested, so it can works ok.

Best Regards.
micky.
