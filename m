From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: -ENOSYS suspend-powerdown regression
Date: Sun, 5 Jun 2011 16:49:50 +0300
Message-ID: <BANLkTi=LJMjJG2xwZqgmWV9SA7n8Pei=qg@mail.gmail.com>
References: <BANLkTimdp2n1qhLQmTk+k_M5_WowhJqPyQ@mail.gmail.com>
 <BANLkTimRWqo1M7OOQmdWOxSQvqiNx48Ftg@mail.gmail.com> <BANLkTikvP3hc+CHEwrUEDqN6McwswikS-Q@mail.gmail.com>
 <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:62913 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079Ab1FENuL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 5 Jun 2011 09:50:11 -0400
Received: by wya21 with SMTP id 21so2258227wya.19
        for <linux-mmc@vger.kernel.org>; Sun, 05 Jun 2011 06:50:10 -0700 (PDT)
In-Reply-To: <BANLkTimKYKX=k2U1_WyhaWZ1wRpWUF6pMQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-mmc@vger.kernel.org

On Sun, Jun 5, 2011 at 3:31 PM, Daniel Drake <dsd@laptop.org> wrote:
> On 5 June 2011 00:08, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> We can stop checking the return value of pm_runtime_get_sync in
>> sdio_bus_remove, like pci_device_remove is doing, but I don't think
>> that's enough: I guess libertas' if_sdio_remove won't be so happy
>> dealing with a powered off card.
>>
>> Can you try the following please (untested):
>
> Thanks, that seems to be working.

Thanks.
