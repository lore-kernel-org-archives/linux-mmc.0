From: Sheetal <sheetal.tigadoli@gmail.com>
Subject: Doubt on mmc erase command
Date: Tue, 10 Feb 2015 22:00:43 +0530
Message-ID: <54DA3233.2090701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:41920 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbBJQax (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Feb 2015 11:30:53 -0500
Received: by mail-pa0-f44.google.com with SMTP id kq14so13623036pab.3
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2015 08:30:52 -0800 (PST)
Received: from [192.168.0.101] ([103.16.70.21])
        by mx.google.com with ESMTPSA id q4sm19822325pdm.88.2015.02.10.08.30.50
        for <linux-mmc@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Feb 2015 08:30:51 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hello,

I'm trying to send ERASE Command to the emmc by deleting a file on one 
of the emmc partitions and then doing a sync, But I'm noticing that even 
this will not issue the erase command to emmc.

I did trace the code on, from where this erase command is issued, but my 
trace ended at an ioctl call "do_vfs_ioctl()" more specific 
"SYSCALL_DEFINE3(ioctl, unsigned int, fd, unsigned int, cmd, unsigned 
long, arg)" system call definition does a call to do_vfs_ioctl.

Please help me understand how to initiate this from userspace.
