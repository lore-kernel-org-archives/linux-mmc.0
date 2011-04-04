From: Frank Hofmann <frank.hofmann@tomtom.com>
Subject: Re: deadlock between mmc_pm_notify() and mmcqd
Date: Mon, 4 Apr 2011 14:11:43 +0100 (BST)
Message-ID: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
References: <alpine.DEB.2.00.1103301151140.2959@localhost6.localdomain6> <BANLkTikUjx_hRJfTZh2vOu_syxQ9GQLbYg@mail.gmail.com>
Reply-To: frank.hofmann@tomtom.com
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mxvs2.esa.t-systems.com ([81.7.202.143]:9627 "EHLO
	mxvs2.esa.t-systems.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751845Ab1DDNLs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 09:11:48 -0400
In-Reply-To: <BANLkTikUjx_hRJfTZh2vOu_syxQ9GQLbYg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: frank.hofmann@tomtom.com, linux-mmc@vger.kernel.org

On Mon, 4 Apr 2011, Andrei Warkentin wrote:

> On Wed, Mar 30, 2011 at 5:52 AM, Frank Hofmann <frank.hofmann@tomtom.com> wrote:
>> Hi linux-mmc'ers,
>>
>> (have originally posted this to linux-pm, got suggested I ask here as well)
>>
>> I'm encountering the following deadlock:
>>
[ mmcqd vs mmc_pm_notify ]
>
> Hi Frank,
>
> I was able to reproduce it on linux-next. No need for rootfs on
> mmcblk, and a "echo mem > /sys/power/state" is sufficient to trigger
> the issue.
>
> I am looking into it.
>
> Thanks,
> A
>

Thanks Andrei.

Missed to make it clear in the original email that disabling the notifier 
via CONFIG_MMC_UNSAFE_RESUME stops it from occurring.

Also found that simply reverting _part_ of the commit isn't helping 
because the deadlock just moves ... to mmc_suspend_host() eventually also 
ending up in del_gendisk(), and things are identical from there.

FrankH.
