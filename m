From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mmc: rtsx: add new cmd type handle and modify
 errorhandle
Date: Wed, 26 Mar 2014 09:34:41 +0100
Message-ID: <CAPDyKFqAfenktuHqcsJDVipsWVZgdOLq8VzP1=aZ+DEpxabXfw@mail.gmail.com>
References: <cover.1395625491.git.micky_ching@realsil.com.cn>
 <CAPDyKFrk-7msEVcYzY5Vc+ZODtMbiCWGAMU7G2oscgN1Ad9URA@mail.gmail.com>
 <53322D81.3050701@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53322D81.3050701@realsil.com.cn>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: micky <micky_ching@realsil.com.cn>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 26 March 2014 02:29, micky <micky_ching@realsil.com.cn> wrote:
> Hi Ulf,
>
> On 03/25/2014 06:44 PM, Ulf Hansson wrote:
>>
>> On 25 March 2014 10:47,  <micky_ching@realsil.com.cn> wrote:
>>>
>>> From: Micky Ching <micky_ching@realsil.com.cn>
>>>
>>> Add new command type(R1 without CRC) handle, without this
>>> patch mmc card initialize will be failed.
>>>
>>> Using a more careful handle in request timeout, this would
>>> improve error recover capability. Debug info is printed
>>> using non DMA mode, this would help print more accurately
>>> for DMA command failed. Smatch warning was removed.
>>
>> Hi Micky,
>>
>> Seems like this patchset has been around for some time, sorry for the
>> delay.
>>
>> I don't have any objections to it getting merged, but you need to run
>> checkpatch of your patches. Patch2 has a warning you should fix.
>
> Patch2 is based on <mmc: rtsx: fix bug and support nonblocking request>
> see: https://lkml.org/lkml/2014/2/17/270
> checkpatch.pl seems ok, is there any thing I need to check?

It seems like the checkpatch script has been recently patched. When I
ran the script for your patch I used the latest from Stephen
Rothwell's linux-next tree. Please do the same.

Kind regards
Ulf Hansson

>
> Best Regards.
> micky.
>>
>> Kind regards
>> Ulf Hansson
>>
>>
>>> Micky Ching (2):
>>>    mmc: rtsx: add R1-no-CRC mmc command type handle
>>>    mmc: rtsx: modify error handle and remove smatch warnings
>>>
>>>   drivers/mmc/host/rtsx_pci_sdmmc.c |  121
>>> ++++++++++++++++++++-----------------
>>>   1 file changed, 67 insertions(+), 54 deletions(-)
>>>
>>> --
>>> 1.7.9.5
>>
>> .
>>
>
