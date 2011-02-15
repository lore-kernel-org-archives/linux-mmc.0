From: Dmitry Shmidt <dimitrysh@android.com>
Subject: Re: [PATCH] mmc: core: Allow sdio operations in other thread during sdio_add_func()
Date: Tue, 15 Feb 2011 11:32:44 -0800
Message-ID: <AANLkTikXhfge29NTd0U7EHh2cir9Wer1Y71r=XG44Jc8@mail.gmail.com>
References: <loom.20110212T012443-915@post.gmane.org>
	<AANLkTimyc-sXEhnPtCjQwHbEsdnwGY-ss6SoRSqDOD+d@mail.gmail.com>
	<AANLkTinJg2t5tM6+PjUF6jbfCWZfXAG2tObXnbdbn=55@mail.gmail.com>
	<4D5AD35C.80004@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42317 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755472Ab1BOTcp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Feb 2011 14:32:45 -0500
Received: by iyj8 with SMTP id 8so403592iyj.19
        for <linux-mmc@vger.kernel.org>; Tue, 15 Feb 2011 11:32:44 -0800 (PST)
In-Reply-To: <4D5AD35C.80004@windriver.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Ross <andy.ross@windriver.com>
Cc: linux-mmc@vger.kernel.org

On Tue, Feb 15, 2011 at 11:26 AM, Andy Ross <andy.ross@windriver.com> w=
rote:
> On 02/15/2011 10:08 AM, Dmitry Shmidt wrote:
>> mmc: core: Allow sdio operations in other thread during sdio_add_fun=
c()
>>
>> This is important when wlan driver is doing sdio operations from ano=
ther
>> thread during initialization.
>> This behavior was introduced as a side-effect in patch
>> 807e8e40673d9628fa7dcdd14423424b4ee5f43b
>
> That patch made similar to mmc_attach_sd() and mmc_attach_mmc(). =A0D=
o
> they need to be audited for the same lock contention?
>
> Andy
>
No, they are not the same. mmc and sd don't have
  sdio_add_func(host->card->sdio_func[i]);
so they are Ok.

Dmitry
