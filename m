From: Rajendra Nayak <rnayak@ti.com>
Subject: Re: [PATCH v2 6/6] mmc: omap_hsmmc: Don't expect MMC1 to always have
 vmmc supply
Date: Tue, 21 Feb 2012 18:11:52 +0530
Message-ID: <4F439110.5020001@ti.com>
References: <1329818589-10062-1-git-send-email-rnayak@ti.com> <1329818589-10062-7-git-send-email-rnayak@ti.com> <CANfBPZ89Wdu2hWRU2XiPpWpU-BMbs3Z+yhNoR7hp4MH3vRYfbg@mail.gmail.com> <20120221122022.GC22675@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:50559 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753795Ab2BUMmA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Feb 2012 07:42:00 -0500
In-Reply-To: <20120221122022.GC22675@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "S, Venkatraman" <svenkatr@ti.com>, cjb@laptop.org, linaro-dev@lists.linaro.org, balajitk@ti.com, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tuesday 21 February 2012 05:50 PM, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2012 at 05:43:54PM +0530, S, Venkatraman wrote:
>> On Tue, Feb 21, 2012 at 3:33 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>> @@ -324,8 +302,8 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host
>>> *host)
>>>                         mmc_slot(host).ocr_mask = ocr_value;
>>>                 } else {
>>>                         if (!(mmc_slot(host).ocr_mask&  ocr_value)) {
>>> -                               pr_err("MMC%d ocrmask %x is not
>>> supported\n",
>>> -                                       host->id,
>>> mmc_slot(host).ocr_mask);
>>> +                               pr_err("MMC ocrmask %x is not
>>> supported\n",
>>> +                                       mmc_slot(host).ocr_mask);
>
> You're dropping the MMC number from these error messages.  It would be
> much better to fix them instead.  Use dev_info(mmc_dev(host->mmc), "blah"
> rather than pr_err().

Thanks for catching this. There are a few other instance of pr_* usage
within the driver. I will post a patch to fix all of them.

>
> Drivers should not be using pr_* unless they really do not have a struct
> device.

