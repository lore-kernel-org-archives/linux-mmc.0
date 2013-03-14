From: Sergey Yanovich <ynvich@gmail.com>
Subject: Re: [PATCH] wait while adding MMC host to ensure root mounts
Date: Thu, 14 Mar 2013 14:28:22 +0400
Message-ID: <5141A646.2060406@gmail.com>
References: <1363223183-3772-1-git-send-email-ynvich@gmail.com> <20130314024719.GA9342@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130314024719.GA9342@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, Namjae Jeon <linkinjeon@gmail.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 14/03/13 06:47, Greg Kroah-Hartman wrote:
> On Thu, Mar 14, 2013 at 05:06:23AM +0400, Sergey Yanovich wrote:
>>   	/* wait for the known devices to complete their probing */
>> -
>>   	wait_event(probe_waitqueue, atomic_read(&probe_count) == 0);
>
> You didn't need to change this file, please don't.

Got the point.

>>   	mmc_detect_change(host, 0);
>> +	mmc_flush_scheduled_work();
>
> If this is the only fix, then you don't need to change it from being
> static or need to export it.
>
> Please be more careful when making kernel patches.

I will. I apologize for spamming.
