From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V4] mmc: core: eMMC 4.5 Power Class Selection Feature
Date: Fri, 23 Sep 2011 11:01:21 -0400
Message-ID: <m2ehz7xpz2.fsf@bob.laptop.org>
References: <1316788353-11411-1-git-send-email-girish.shivananjappa@linaro.org>
	<m2pqirxr0a.fsf@bob.laptop.org>
	<CAGxe1ZEz2MNzK1dA-5xJQrp3hq4vOw+wGrCg4Cccu_dtq888GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:54732 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752865Ab1IWPBZ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 23 Sep 2011 11:01:25 -0400
In-Reply-To: <CAGxe1ZEz2MNzK1dA-5xJQrp3hq4vOw+wGrCg4Cccu_dtq888GA@mail.gmail.com>
	(Girish K. S.'s message of "Fri, 23 Sep 2011 20:27:03 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org, linux-samsung-soc@vger.kernel.org

Hi Girish,

On Fri, Sep 23 2011, Girish K S wrote:
>> I suggested replacing your BUG(); here with a return, but you just have
>> a break here. Is having the function continue in this case intentional?
>
> sorry for that.
> will update with a return -EBADMSG

Thanks; let's go with -EINVAL, though.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
