From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 4/4] mmc: sdhci: host: add new f_sdh30
Date: Fri, 16 Jan 2015 09:36:56 +0100
Message-ID: <CAPDyKFp+sF5J2geen0K1SmU67O9vNDc_w8q92vq+ywZhv9snuw@mail.gmail.com>
References: <1420803705-4539-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<1420803705-4539-5-git-send-email-Vincent.Yang@tw.fujitsu.com>
	<CAPDyKFqHk5cqFziwsDRa+RttjdiWZ9fYx9UP5nQdWEAJS=Cstg@mail.gmail.com>
	<CAOEd-H3eU=OJQp5+-yzP02ccpzZdoBJ1BUeFoZiu-DhLYDhGWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:40631 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752762AbbAPIg4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jan 2015 03:36:56 -0500
Received: by mail-qc0-f178.google.com with SMTP id p6so15977811qcv.9
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2015 00:36:56 -0800 (PST)
In-Reply-To: <CAOEd-H3eU=OJQp5+-yzP02ccpzZdoBJ1BUeFoZiu-DhLYDhGWA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vincent Yang <vincent.yang.fujitsu@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Andy Green <andy.green@linaro.org>, Patch Tracking <patches@linaro.org>, Jaswinder Singh <jaswinder.singh@linaro.org>, Vincent Yang <Vincent.Yang@tw.fujitsu.com>, Tetsuya Takinishi <t.takinishi@jp.fujitsu.com>

[...]

>>> +       pm_runtime_set_active(&pdev->dev);
>>> +       pm_runtime_enable(&pdev->dev);
>>> +       ret = pm_runtime_get_sync(&pdev->dev);
>>> +       if (ret < 0)
>>> +               dev_err(dev, "Failed to pm_runtime_get_sync: %d\n", ret);
>>
>> As I stated earlier I think this is a strange behaviour of how to
>> implement runtime PM support. Could you elaborate one more time why
>> this actually is needed?
>
> Thanks for pointing out this.
> We studied again and realized that this runtime PM support was only there for
> powerdomain management, but we have not yet upstreamed the powerdomain
> support. Thus we would like to remove it in next version.

I am fine with you removing the runtime PM support in the next
version. I also hope you to upstream the power domain support later
on, that would be nice.

A small note:
>From a driver perspective, you shall be able to implement runtime PM
support even if you haven't upstreamed the power domain support yet.
But, let's then deal with that as a separate patch later on.

Kind regards
Uffe
