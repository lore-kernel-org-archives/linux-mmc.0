From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: dw_mmc: HLE errors
Date: Mon, 23 Nov 2015 09:10:03 -0500
Message-ID: <56531E3B.6060601@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36330 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752907AbbKWOKH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2015 09:10:07 -0500
Received: by vkay187 with SMTP id y187so37485102vka.3
        for <linux-mmc@vger.kernel.org>; Mon, 23 Nov 2015 06:10:05 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dianders@chromium.org, jh80.chung@samsung.com
Cc: ulf.hansson@linaro.org, alim.akhtar@samsung.com, sonnyrao@chromium.org, abrestic@chromium.org, heiko@sntech.de, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Doug/Jaehoon,

Were there any follow ups to this thread [1] from March 30, 2015?
We are seeing HLE errors on 3.18 and we are trying to determine if a solution
was ever delivered.
On inspection, I can't find anything specific in recent kernels that address
this particular issue (was the actual root cause identified?)

I put together a possible work-around that avoids the HLE storm from occurring
for this specific SoC [2].
However we'd rather not merge this -or any other similar fix- if there is a
generic solution already that we can pick up from mainline.

thanks

Jorge




[1] https://lkml.org/lkml/headers/2015/3/30/423
[2]
https://github.com/96boards/linux/commit/fe8d7f714d420121cec460e69f6529044a2cb6d8
