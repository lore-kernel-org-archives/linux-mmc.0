From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] MMC: fix mmc_pm_notify bus_ops->remove deadlock.
Date: Mon, 4 Apr 2011 18:01:23 +0300
Message-ID: <BANLkTikCHcFHGaEwNEObexvvkMXaG=29vQ@mail.gmail.com>
References: <alpine.DEB.2.00.1104041407340.2513@localhost6.localdomain6>
 <1301925644-9274-1-git-send-email-andreiw@motorola.com> <BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48050 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754628Ab1DDPBn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Apr 2011 11:01:43 -0400
Received: by iyb14 with SMTP id 14so5964741iyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 04 Apr 2011 08:01:43 -0700 (PDT)
In-Reply-To: <BANLkTikBdgt7LFW-8OFphV0r-UMu9CfKcw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrei Warkentin <andreiw@motorola.com>
Cc: linux-mmc@vger.kernel.org, frank.hofmann@tomtom.com

On Mon, Apr 4, 2011 at 4:27 PM, Andrei Warkentin <andreiw@motorola.com> wrote:
> On Mon, Apr 4, 2011 at 9:00 AM, Andrei Warkentin <andreiw@motorola.com> wrote:
>> This resolves the deadlock issue with suspend. There is no
>> need to claim host before the remove op.
>>
>> Signed-off-by: Andrei Warkentin <andreiw@motorola.com>
...
> I think this means we can take
> 1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 out (mmc: sdio: fix SDIO
> suspend/resume regression).

I don't see how is this related ?

1c8cf9c997a4a6b36e907c7ede5f048aeaab1644 makes sure the -ENOSYS
semantics of mmc_sdio_suspend() are followed.
