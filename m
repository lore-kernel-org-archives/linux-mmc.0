From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V5] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Fri, 23 Sep 2011 11:21:28 -0400
Message-ID: <m2aa9vxp1j.fsf@bob.laptop.org>
References: <1316790707-12012-1-git-send-email-girish.shivananjappa@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:41252 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753089Ab1IWPVd (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 11:21:33 -0400
In-Reply-To: <1316790707-12012-1-git-send-email-girish.shivananjappa@linaro.org>
	(Girish K. S.'s message of "Fri, 23 Sep 2011 20:41:47 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

On Fri, Sep 23 2011, Girish K S wrote:
> This patch adds the power class selection feature available
> for mmc versions 4.0 and above.
> During the enumeration stage before switching to the lower
> data bus, check if the power class is supported for the
> current bus width. If the power class is available then
> switch to the power class and use the higher data bus. If
> power class is not supported then switch to the lower data
> bus in a worst case.
>
> Signed-off-by: Girish K S <girish.shivananjappa@linaro.org>

Thanks, pushed to mmc-next for 3.2 now.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
