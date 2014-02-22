From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/3] mmc: core: Add DT bindings for SD card's UHS bus speed modes
Date: Sat, 22 Feb 2014 18:52:31 +0000
Message-ID: <86y513t1xs.fsf@void.printf.net>
References: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49426 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbaBVSwf (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 22 Feb 2014 13:52:35 -0500
In-Reply-To: <1392380829-8473-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Fri, 14 Feb 2014 13:27:07 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, devicetree@vger.kernel.org

Hi Ulf,

On Fri, Feb 14 2014, Ulf Hansson wrote:
> Provide the option to configure these speed modes per host, for those
> host driver's that can't distinguish this in runtime.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks, pushed all 3/3 to mmc-next for 3.15.

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
