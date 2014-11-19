From: Angelo Dureghello <angelo70@gmail.com>
Subject: Re: davinci_mmc issues on kernel 3.17.0
Date: Wed, 19 Nov 2014 16:31:30 +0100
Message-ID: <546CB7D2.50903@gmail.com>
References: <546CAA0D.3090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:43037 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829AbaKSPbd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 19 Nov 2014 10:31:33 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so5744319wid.9
        for <linux-mmc@vger.kernel.org>; Wed, 19 Nov 2014 07:31:32 -0800 (PST)
Received: from [192.168.0.2] (host15-234-dynamic.54-79-r.retail.telecomitalia.it. [79.54.234.15])
        by mx.google.com with ESMTPSA id w5sm101069wif.18.2014.11.19.07.31.30
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 19 Nov 2014 07:31:31 -0800 (PST)
In-Reply-To: <546CAA0D.3090107@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,

did an additional test, that i hope can help:

- prepared a 16K ASCI pattern of 0x30,0x31,0x30,0x31.. and so
- written to mmc sd

[root@barix boot]# cat 16kpattern.hex > /dev/mmcblk0p1
[root@barix boot]# Automount: /dev/mmcblk0p1 inserted
Automount: DEVICE LOCK found quiting...


[root@barix boot]# cat /dev/mmcblk0p1

i could read out _only_ 8K of patterns bytes and then i see other fs 
bytes just after.

So seems i can't write 8K blocks, seems 4K are truncated.

Regards
angelo
