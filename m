From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH v2 0/3] mmc: rtsx: fix bug and support nonblocking request
Date: Fri, 21 Feb 2014 09:15:47 +0800
Message-ID: <5306A8C3.8080703@realsil.com.cn>
References: <cover.1392626511.git.micky_ching@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <cover.1392626511.git.micky_ching@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: chris@printf.net, sameo@linux.intel.com, lee.jones@linaro.org
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, rogerable@realtek.com, devel@linuxdriverproject.org, dan.carpenter@oracle.com
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

Could you please give me some idea about this patch-set?
I send this patch-set many times, but didn't get any reply.

Best Regards.
micky <micky_ching@realsil.com.cn>

On 02/17/2014 04:45 PM, micky_ching@realsil.com.cn wrote:
> From: Micky Ching <micky_ching@realsil.com.cn>
>
> First we fix the card poweroff bug: the card power is not shutdown when sd/mmc
> card removed, this will make UHS-card failed to running in high speed mode if we
> insert the card again.
>
> We offer a concise tuning searching method, it is much easier to read.
>
> At last we add support for nonblocking request, which will improve card read
> speed at about 10% write speed about 5% normally.
>
> Micky Ching (3):
>    mmc: rtsx: fix card poweroff bug
>    mmc: rtsx: modify phase searching method for tuning
>    mmc: rtsx: add support for pre_req and post_req
>
>   drivers/mfd/rtsx_pcr.c            |  132 ++++++---
>   drivers/mmc/host/rtsx_pci_sdmmc.c |  529 ++++++++++++++++++++++++++-----------
>   include/linux/mfd/rtsx_common.h   |    1 +
>   include/linux/mfd/rtsx_pci.h      |    8 +-
>   4 files changed, 481 insertions(+), 189 deletions(-)
>
> --
> 1.7.9.5
> .
>
