From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 2/2] mmc: rtsx: Revert "mmc: rtsx: add support for
 pre_reqandpost_req"
Date: Thu, 8 May 2014 13:54:18 +0800
Message-ID: <536B1C0A.2050001@realsil.com.cn>
References: <cover.1398735435.git.micky_ching@realsil.com.cn>	<6a8f18cad47244e849adf8a731c621932fa777e0.1398735435.git.micky_ching@realsil.com.cn>
 <CAPDyKFqSdvjJrsbDeX1KbjQtOjfoAwC0xz3y7Rm-BsD0T8tmxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFqSdvjJrsbDeX1KbjQtOjfoAwC0xz3y7Rm-BsD0T8tmxg@mail.gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

Hi Lee

Sorry for previous email, only [PATCH 2/2] mmc: rtsx: Revert "mmc: rtsx: 
add support for pre_reqand post_req"
if need for 3.15 fix.

Best Regards.
micky.
On 04/29/2014 03:36 PM, Ulf Hansson wrote:
> On 29 April 2014 03:54,<micky_ching@realsil.com.cn>  wrote:
>> >From: Micky Ching<micky_ching@realsil.com.cn>
>> >
>> >This reverts commit c42deffd5b53c9e583d83c7964854ede2f12410d.
>> >
>> >commit <mmc: rtsx: add support for pre_req and post_req> did use
>> >mutex_unlock() in tasklet, but mutex_unlock() can't used in
>> >tasklet(atomic context). The driver need use mutex to avoid concurrency,
>> >so we can't use tasklet here, the patch need to be removed.
>> >
>> >The spinlock host->lock and pcr->lock may deadlock, one way to solve the
>> >deadlock is remove host->lock in sd_isr_done_transfer(), but if using
>> >workqueue the we can avoid using the spinlock and also avoid the problem.
>> >
>> >Signed-off-by: Micky Ching<micky_ching@realsil.com.cn>
> Acked-by: Ulf Hansson<ulf.hansson@linaro.org>
>
