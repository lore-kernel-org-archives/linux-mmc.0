From: Jens Axboe <axboe@fb.com>
Subject: Re: 4.8-rc1 REGRESSION mmc-blk triggers WARN_ON(!host->claimed),
 related to: "drivers: use req op accessor" ?
Date: Thu, 25 Aug 2016 14:12:27 -0600
Message-ID: <41ab9b3e-cb39-fb9e-defd-f38ea6d5b791@fb.com>
References: <6e68ae5a-4b79-a636-2c46-5726cf2cc44b@redhat.com>
 <57BB23D0.3050606@redhat.com>
 <2a2ee1e8-8682-0647-a66d-04ceb54f58ec@redhat.com>
 <6bfb134a-43bf-addd-3ff0-cc1d677a1606@intel.com>
 <7210392e-2c1c-5676-bb53-274ea6a5ca74@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53715 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753140AbcHYUNK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Aug 2016 16:13:10 -0400
In-Reply-To: <7210392e-2c1c-5676-bb53-274ea6a5ca74@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Mike Christie <mchristi@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, regressions@leemhuis.info, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 08/25/2016 12:26 PM, Hans de Goede wrote:
>>> I've tried 4.8-rc3 with my hack drop and this commit cherry-picked,
>>> but the problem is still there, so this patch does not fix it.
>>
>> I wasn't able to reproduce your problem, but a possibility could be
>> accessing the request after it is completed.  You could try this:
>
> Good catch, that seems to fix things for me. Note sometimes this bug
> would not hit immediately for me. But I've been running several
> affected boards for about 1 hour or so, without issues, so I believe
> this is fixed. So this is:
>
> Tested-by: Hans de Goede <hdegoede@redhat.com>

Awesome, thanks for reporting/testing. Adrian, I have turned it into a 
real patch and applied it for 4.8. Thanks!


-- 
Jens Axboe
