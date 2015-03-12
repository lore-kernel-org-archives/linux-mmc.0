From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Thu, 12 Mar 2015 10:09:49 +0100
Message-ID: <CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35130 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbbCLJJu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Mar 2015 05:09:50 -0400
Received: by qgfh3 with SMTP id h3so16439505qgf.2
        for <linux-mmc@vger.kernel.org>; Thu, 12 Mar 2015 02:09:50 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

[...]

>> > Also, I think we need to clarify one more point for this patch:
>> > As was mentioned in commit message - Sleep_Notification can be interrupted
>> by HPI.
>> > This allows not blocking the host during the Sleep_Notification busy
>> > time and allows accepting requests coming during this stage. Thus,
>> > without having HPI supported, suspend/resume process might be
>> > influenced by Sleep_Notification busy time, and this should not happen -
>> suspend/resume should be done in very fast and not blocking manner.
>>
>> I fail to understand your comment here.
>>
>> Please tell me at what point(s) your think it make sense to issue the
>> SLEEP_NOTIFICATION? If that is during the suspend phase, then a HPI request
>> can't be triggered.
>
> I think SLEEP_NOTIFICATION should be issued on mmc_pm_notify() call,
> on PM_SUSPEND_PREPARE case.

So, exactly why is that to prefer, comparing doing it in system PM
->suspend() callback?

Kind regards
Uffe
