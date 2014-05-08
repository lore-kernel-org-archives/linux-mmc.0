From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 1/2] mmc: rtsx: Revert "mmc: rtsx: modify error
 handleandremove smatch warnings"
Date: Thu, 8 May 2014 13:49:57 +0800
Message-ID: <536B1B05.6010604@realsil.com.cn>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>	<1076b1824732688774d223a14595ecf26a375d82.1398735435.git.micky_ching@realsil.com.cn>
 <CAPDyKFoZ2_H6Jh0+84zLBhayMb0=q1eJw=vC_m41iCsbz0siFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFoZ2_H6Jh0+84zLBhayMb0=q1eJw=vC_m41iCsbz0siFw@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

Hi Lee

It seems Chris is too busy to responding, so would you help to pick this 
patch for 3.15 fix.

Best Regards.
micky.
On 04/29/2014 03:30 PM, Ulf Hansson wrote:
> On 29 April 2014 03:54,<micky_ching@realsil.com.cn>  wrote:
>> >From: Micky Ching<micky_ching@realsil.com.cn>
>> >
>> >This reverts commit 1f7b581b3ffcb2a8437397a02f4af89fa6934d08.
>> >
>> >The patch depend on commit c42deffd5b53c9e583d83c7964854ede2f12410d
>> ><mmc: rtsx: add support for pre_req and post_req>, but the previous
>> >patch was discard. So we have to delete the patch.
>> >
>> >Signed-off-by: Micky Ching<micky_ching@realsil.com.cn>
> Acked-by: Ulf Hansson<ulf.hansson@linaro.org>
