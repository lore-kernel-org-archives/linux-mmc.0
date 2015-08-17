From: Muni Sekhar <munisekharrms@gmail.com>
Subject: vmmc & vqmmc O2 Micro SD Host Controller
Date: Mon, 17 Aug 2015 13:01:31 +0530
Message-ID: <CAHhAz+iG82ocsT_jzKDxN4LjQpuE4LKgXi22g0Lgzb6O93Wm9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36820 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbHQHbb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 03:31:31 -0400
Received: by igcwe12 with SMTP id we12so6342718igc.3
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 00:31:31 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi,


I need to test the O2 Micro SD Host Controller.
 Once the driver is loaded, I see the following two power structs
kernel messages.

 [    2.159972] mmc0: no vqmmc regulator found
 [    2.159975] mmc0: no vmmc regulator found

I would like to know about vmmc & vqmmc, what are these? Is it okay to
ignore these messages?



Thanks,
Sekhar
