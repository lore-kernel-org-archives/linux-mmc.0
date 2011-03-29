From: NamJae Jeon <linkinjeon@gmail.com>
Subject: About mmc delayed workqueue.
Date: Wed, 30 Mar 2011 08:33:12 +0900
Message-ID: <AANLkTikB-g44H80hLsrBUcJ4svOZAXisBvFvno4uqKm+@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60951 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746Ab1C2XdN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Mar 2011 19:33:13 -0400
Received: by wya21 with SMTP id 21so614635wya.19
        for <linux-mmc@vger.kernel.org>; Tue, 29 Mar 2011 16:33:12 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org, linux-mmc@vger.kernel.org

Hi. Chris.

I found some problem in mmc driver.  As you know, in nand trend, emmc
nand is used  booting device in embededd product.

It means that kernel, rootfs image is stored in emmc nand device. and
when rescaning mmc, mmc driver is working by delay work queue.

It can be cause "can not mount rootfs".  If  kernel mounting is faster
than mmc rescan, this problem would occur..

I changed to schedule_work instead of mmc_schedule_delayed_work. I can
make patch & test.

could you tell me your opinion ?

Thanks.
