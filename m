From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v6 8/9] mmc: dw_mmc: add support for implementation specific callbacks
Date: Sun, 23 Sep 2012 23:03:52 -0400
Message-ID: <m3haqodsvb.fsf@pullcord.laptop.org>
References: <1347905803-22742-1-git-send-email-thomas.abraham@linaro.org>
	<1347905803-22742-9-git-send-email-thomas.abraham@linaro.org>
	<001401cd966c$5fe94590$1fbbd0b0$%jun@samsung.com>
	<CAJuYYwRUhK858ixLfZPz9UVmqJBe0=LdgjhLfazPNHE3zckDjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <CAJuYYwRUhK858ixLfZPz9UVmqJBe0=LdgjhLfazPNHE3zckDjQ@mail.gmail.com>
	(Thomas Abraham's message of "Thu, 20 Sep 2012 10:08:46 +0530")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Sep 20 2012, Thomas Abraham wrote:
>> In non-Exynos platform, host->drv_data has NULL.
>
> Yes, sorry, I missed that.
>
> Chris, should I fix this and send the updated patch or shall I send a
> separate fix patch.

A separate fix patch would be good, please.

(I'd normally take an updated patch but Stephen Rothwell's asked for
people to hold off rebasing now that -rc7 is out, which is reasonable.)

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
