From: micky <micky_ching@realsil.com.cn>
Subject: Re: [PATCH 2/2] mmc: rtsx: add support for async request
Date: Mon, 16 Jun 2014 17:09:15 +0800
Message-ID: <539EB43B.8070707@realsil.com.cn>
References: <cover.1402037562.git.micky_ching@realsil.com.cn>	<7b58fb0b0915ea0b0838404c74ec22a3b6e5f5a8.1402037565.git.micky_ching@realsil.com.cn>
 <CAPDyKFq1wYZRbuwhLjTMbwN1KYgKuNuZDb7t8FV78Pa=W85oqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <CAPDyKFq1wYZRbuwhLjTMbwN1KYgKuNuZDb7t8FV78Pa=W85oqg@mail.gmail.com>
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Chris Ball <chris@printf.net>, Wei WANG <wei_wang@realsil.com.cn>, Roger <rogerable@realtek.com>, devel@linuxdriverproject.org, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: linux-mmc@vger.kernel.org

On 06/16/2014 04:42 PM, Ulf Hansson wrote:
>> @@ -36,7 +37,10 @@ struct realtek_pci_sdmmc {
>> >         struct rtsx_pcr         *pcr;
>> >         struct mmc_host         *mmc;
>> >         struct mmc_request      *mrq;
>> >+       struct workqueue_struct *workq;
>> >+#define SDMMC_WORKQ_NAME       "rtsx_pci_sdmmc_workq"
>> >
>> >+       struct work_struct      work;
> I am trying to understand why you need a work/workqueue to implement
> this feature. Is that really the case?
>
> Could you elaborate on the reasons?
Hi Uffe,

we need return as fast as possible in mmc_host_ops request(ops->request) 
callback,
so the mmc core can continue handle next request.
when next request everything is ready, it will wait previous done(if not 
done),
then call ops->request().

we can't use atomic context, because we use mutex_lock() to protect
resource, and we have to hold the lock during handle request.
So I use workq, we just queue a work and return in ops->request(),
The mmc core can continue without blocking at ops->request().

Best Regards.
micky.
