From: Madhav Chauhan <madhav.imsec@gmail.com>
Subject: MMC insert remove issue
Date: Tue, 18 May 2010 20:02:32 +0530
Message-ID: <AANLkTimg_VbK2uPZNCn3Il8klv22JhF7iEe-MTCA5NYe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:63346 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755426Ab0EROcd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 18 May 2010 10:32:33 -0400
Received: by pxi18 with SMTP id 18so264701pxi.19
        for <linux-mmc@vger.kernel.org>; Tue, 18 May 2010 07:32:33 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi

In one ARM based boards I am facing soft lock up issue while
inserting/removing MMC/SD card continuously having 2K files.
Can someone point me where should i look whether host controller
driver or MMC block layer/Kernel block layer??

if similar issues were posted before and resolved in this list please
let me know.

Thanks
Madhav
