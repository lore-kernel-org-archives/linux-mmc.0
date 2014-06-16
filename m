From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mfd: rtsx: add dma transfer function
Date: Mon, 16 Jun 2014 16:24:31 +0200
Message-ID: <CAPDyKFpJ5tToJOk6try-jrRCCzcKtJkszNE5Nuc3Uarhpta1BQ@mail.gmail.com>
References: <cover.1402037562.git.micky_ching@realsil.com.cn>
 <9021eae37d96aa027d00ae4a7b6cd84dbbd1b6b5.1402037564.git.micky_ching@realsil.com.cn>
 <20140616122032.GS14323@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140616122032.GS14323@lee--X1>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2014 14:20, Lee Jones <lee.jones@linaro.org> wrote:
>> From: Micky Ching <micky_ching@realsil.com.cn>
>>
>> rtsx driver using a single function for transfer data, dma map/unmap are
>> placed in one fix function. We need map/unmap dma in different place(for
>> mmc async driver), so add three function for dma map, dma transfer and
>> dma unmap.
>>
>> Signed-off-by: Micky Ching <micky_ching@realsil.com.cn>
>> ---
>>  drivers/mfd/rtsx_pcr.c       |   76 ++++++++++++++++++++++++++----------------
>>  include/linux/mfd/rtsx_pci.h |    6 ++++
>>  2 files changed, 54 insertions(+), 28 deletions(-)
>
> I don't see any glaring issues with this patch.  Does it rely on the
> first patch, or vise versa, or can it just be applied?

The mmc part in patch2 relies on this one, but please go ahead and
apply the mfd patch if you see it good.

I can later provide my ack for the mmc parts, in patch2, when it's a
reviewed properly and thus you can take it through your tree.

Kind regards
Uffe
