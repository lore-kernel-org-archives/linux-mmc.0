From: Wan ZongShun <mcuos.com@gmail.com>
Subject: Question for emmc ioctl sync issue
Date: Mon, 19 May 2014 15:55:20 +0800
Message-ID: <CAKT61h8cVG_r3girMYAjO+HT9EQG5sPfYw2Yvgx8j6vsD7M4Ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:61386 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbaESHzm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 May 2014 03:55:42 -0400
Received: by mail-wi0-f180.google.com with SMTP id hi2so3650018wib.13
        for <linux-mmc@vger.kernel.org>; Mon, 19 May 2014 00:55:40 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all,

I have a question for mmc_blk_ioctl_cmd.

I did not see any sync code in this function like mutex, semphere.., why?
The ioctl will do partition switch as I know, so If more partitions
call the ioctl from user layer at the same time, how to sync with
them?

-- 
Wan ZongShun.
www.mcuos.com
