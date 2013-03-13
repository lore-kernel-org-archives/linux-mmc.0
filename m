From: Mark Deneen <mdeneen@gmail.com>
Subject: Re: MMC block discard / erase ioctl
Date: Wed, 13 Mar 2013 10:53:50 -0400
Message-ID: <CAP6JJ88URs8Si-xPVVufvJXJ23RMAb4H6KL8g9gVNPG0sn1G9g@mail.gmail.com>
References: <CAP6JJ88G-7XXU=a+ukj=EkS-=X7F19kQ_AHfga_ApHSwEKwT=A@mail.gmail.com>
 <514031D5.4020303@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:55251 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932295Ab3CMOyL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Mar 2013 10:54:11 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so1535125iec.32
        for <linux-mmc@vger.kernel.org>; Wed, 13 Mar 2013 07:54:10 -0700 (PDT)
In-Reply-To: <514031D5.4020303@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>

On Wed, Mar 13, 2013 at 3:59 AM, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 12/03/13 18:13, Mark Deneen wrote:
>> I assume that this never made it into mainline?  I'm looking to do something
>> similar, and I was wondering if it somehow did make it in but in a different
>> form that I'm not seeing.
>
> There is BLKDISCARD and BLKSECDISCARD
>
> Perhaps MMC_IOC_CMD could be useful too
>
Hmm.  I tried the BLKDISCARD ioctl and received "ioctl: Operation not
supported", so I started digging into the mmc layer to see if this
ioctl was implemented.  I must have been looking in the wrong place.
