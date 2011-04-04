From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon, 4 Apr 2011 10:10:50 -0500
Message-ID: <BANLkTi=-jiPfBUa2rxBCcbwN=Y1ZXCKwag@mail.gmail.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
	<1301925644-9274-1-git-send-email-andreiw@motorola.com>
	<BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
	<BANLkTikCHcFHGaEwNEObexvvkMXaG=29vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og103.obsmtp.com ([64.18.0.145]:54862 "EHLO
	exprod5og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754269Ab1DDPKx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 11:10:53 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34FBDSd001168
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:11:13 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p34EissE016369
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Mon, 4 Apr 2011 11:11:13 -0400 (EDT)
Received: by mail-wy0-f170.google.com with SMTP id 34so6587389wyb.15
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 08:10:51 -0700 (PDT)
In-Reply-To: <BANLkTikCHcFHGaEwNEObexvvkMXaG=29vQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: linux-mmc@vger.kernel.org

On Mon, Apr 4, 2011 at 10:01 AM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
> On Mon, Apr 4, 2011 at 4:27 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> On Mon, Apr 4, 2011 at 9:00 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>>> This resolves the deadlock issue with suspend. There is no
>>> need to claim host before the remove op.
>>>
>>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
> ...
>> I think this means we can take
>> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 out (mmc: sdio: fix SDIO
>> suspend/resume regression).
>
> I don't see how is this related ?
>
> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 makes sure the -ENOSYS
> semantics of mmc_sdio_suspend() are followed.
>

I thought that code was added as a fix for problems in the
pm_notifier, but I misread the code and I was wrong.

Thanks,
A
