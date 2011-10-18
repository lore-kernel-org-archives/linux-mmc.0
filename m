From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V9] mmc: core: Add Power Off Notify Feature eMMC 4.5
Date: Tue, 18 Oct 2011 08:53:44 -0400
Message-ID: <m239eq5ulj.fsf@bob.laptop.org>
References: <1318914301-30339-1-git-send-email-girish.shivananjappa@linaro.org>
	<4E9D0B9F.1060303@samsung.com> <m2ehya6ecb.fsf@bob.laptop.org>
	<CAGxe1ZHvRS9hek9-DSXZm1fkqPzUSVkWF5yEGXTC4K8usA31WQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAGxe1ZHvRS9hek9-DSXZm1fkqPzUSVkWF5yEGXTC4K8usA31WQ@mail.gmail.com>
	(Girish K. S.'s message of "Tue, 18 Oct 2011 11:27:26 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, patches@linaro.org, linux-samsung-soc@vger.kernel.org, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Oct 18 2011, Girish K S wrote:
>>  missing one thing.    unsigned int        power_notify_type; in include/linux/mmc/host.h
> is not alligned to the above member, which was done in my latest patch

Fixed.  Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
