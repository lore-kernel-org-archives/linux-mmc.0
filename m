From: loody <miloody@gmail.com>
Subject: question about bounce
Date: Mon, 7 Nov 2011 21:36:18 +0800
Message-ID: <CANudz+vMxzRTspx0HkJ6DkFVmGLk3PC9Yy+Wbj1L7N7E41F7kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:35853 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755581Ab1KGNgT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2011 08:36:19 -0500
Received: by qao25 with SMTP id 25so584918qao.19
        for <linux-mmc@vger.kernel.org>; Mon, 07 Nov 2011 05:36:18 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

Hi all:
There is a comment from card/Kconfig as below:
         controllers, however, are restricted to continuous memory
          (i.e. they can't do scatter-gather), something the kernel
          rarely can provide.
if my controller support ADMA, should I use bounce again?
Since each scatter-gather list can be made as an ADMA command, right?

-- 
Regards,
