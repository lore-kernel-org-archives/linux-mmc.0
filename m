From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: Question for emmc ioctl sync issue
Date: Fri, 23 May 2014 11:32:48 +0200
Message-ID: <CA+20K0A54cRUtf8SN0sRVPLMcL+zt0_VcDegCacPqCFrxG5rRw@mail.gmail.com>
References: <CAKT61h8cVG_r3girMYAjO+HT9EQG5sPfYw2Yvgx8j6vsD7M4Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:46258 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbaEWJct (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 May 2014 05:32:49 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so7587189qcx.41
        for <linux-mmc@vger.kernel.org>; Fri, 23 May 2014 02:32:49 -0700 (PDT)
In-Reply-To: <CAKT61h8cVG_r3girMYAjO+HT9EQG5sPfYw2Yvgx8j6vsD7M4Ng@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan ZongShun <mcuos.com@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Wan,

2014-05-19 9:55 GMT+02:00 Wan ZongShun <mcuos.com@gmail.com>:
> Hi all,
>
> I have a question for mmc_blk_ioctl_cmd.
>
> I did not see any sync code in this function like mutex, semphere.., why?
> The ioctl will do partition switch as I know, so If more partitions
> call the ioctl from user layer at the same time, how to sync with
> them?

I guess because locking here could result in deadlocks when the device
is accessed from for instance the block driver. There is no guarantee
that any commands you send to the card via consecutive calls to the
ioctl interface are not interlaced by other commands sent via the
block driver or other ioctl calls.

Kind regards, Johan
