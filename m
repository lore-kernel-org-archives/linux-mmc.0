From: Roger <rogerable@realtek.com>
Subject: Re: [PATCH v4 3/3] memstick: Add realtek USB memstick host driver
Date: Fri, 21 Mar 2014 14:43:25 +0800
Message-ID: <532BDF8D.2060402@realtek.com>
References: <1392199238-14500-1-git-send-email-rogerable@realtek.com>	<1392199238-14500-4-git-send-email-rogerable@realtek.com>
 <20140320161827.5904bc407f9d3490514fd84e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20140320161827.5904bc407f9d3490514fd84e@linux-foundation.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, driverdev-devel@linuxdriverproject.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, wei_wang@realsil.com.cn, Chris Ball <cjb@laptop.org>, Lee Jones <lee.jones@linaro.org>, Dan Carpenter <dan.carpenter@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On 03/21/2014 07:18 AM, Andrew Morton wrote:
> On Wed, 12 Feb 2014 18:00:38 +0800 <rogerable@realtek.com> wrote:
>
>> From: Roger Tseng <rogerable@realtek.com>
>>
>> Realtek USB memstick host driver provides memstick host support based on the
>> Realtek USB card reader MFD driver.
>>
...
>> +static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
>> +{
>> +	struct memstick_host *msh;
>> +	struct rtsx_usb_ms *host;
>> +	struct rtsx_ucr *ucr;
>> +	int err;
>> +
>> +	ucr = usb_get_intfdata(to_usb_interface(pdev->dev.parent));
>> +	if (!ucr)
>> +		return -ENXIO;
>> +
>> +	dev_dbg(&(pdev->dev),
>> +			"Realtek USB Memstick controller found\n");
>> +
>> +	msh = memstick_alloc_host(sizeof(*host), &pdev->dev);
>> +	if (!msh)
>> +		return -ENOMEM;
>> +
>> +	host = memstick_priv(msh);
>> +	host->ucr = ucr;
>> +	host->msh = msh;
>> +	host->pdev = pdev;
>> +	host->power_mode = MEMSTICK_POWER_OFF;
>> +	platform_set_drvdata(pdev, host);
>> +
>> +	mutex_init(&host->host_mutex);
>> +	INIT_WORK(&host->handle_req, rtsx_usb_ms_handle_req);
>> +
>> +	init_completion(&host->detect_ms_exit);
>> +	host->detect_ms = kthread_create(rtsx_usb_detect_ms_card, host,
>> +			"rtsx_usb_ms_%d", pdev->id);
>> +	if (IS_ERR(host->detect_ms)) {
>> +		dev_dbg(&(pdev->dev),
>> +				"Unable to create polling thread.\n");
>> +		err = PTR_ERR(host->detect_ms);
>> +		goto err_out;
>> +	}
>> +
>> +	msh->request = rtsx_usb_ms_request;
>> +	msh->set_param = rtsx_usb_ms_set_param;
>> +	msh->caps = MEMSTICK_CAP_PAR4;
>> +
>> +	pm_runtime_enable(&pdev->dev);
>> +	err = memstick_add_host(msh);
>> +	if (err)
>> +		goto err_out;
>
> Isn't that kernel thread still running?
>
The kernel thread is created(kthread_create) but should not start before 
the "goto".

Did I miss anything or will it be better to move all kthread things 
after here?
>> +	wake_up_process(host->detect_ms);
>> +	return 0;
>> +err_out:
>> +	memstick_free_host(msh);
>> +	return err;
>> +}

Best regards,
Roger Tseng
