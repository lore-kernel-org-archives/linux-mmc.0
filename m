From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH -next] mmc: dw_mmc: fix error return code in dw_mci_probe()
Date: Sun, 26 May 2013 13:28:50 -0400
Message-ID: <87a9nhr6p9.fsf@octavius.laptop.org>
References: <CAPgLHd9RGHwoitQ0EusPepKK+AApKJ=ryRbm4S32o_vOonUgeQ@mail.gmail.com>
	<002301ce4009$3a3099b0$ae91cd10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38798 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754592Ab3EZR27 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 26 May 2013 13:28:59 -0400
In-Reply-To: <002301ce4009$3a3099b0$ae91cd10$%jun@samsung.com> (Seungwon
	Jeon's message of "Tue, 23 Apr 2013 18:59:21 +0900")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Wei Yongjun' <weiyj.lk@gmail.com>, jh80.chung@samsung.com, grant.likely@linaro.org, rob.herring@calxeda.com, yongjun_wei@trendmicro.com.cn, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi,

On Tue, Apr 23 2013, Seungwon Jeon wrote:
> On Friday, April 19, 2013 , Wei Yongjun wrote:
>> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>> 
>> Fix to return -ENOMEM in alloc workqueue error case instead
>> of 0, as done elsewhere in this function.
>> 
>> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks, pushed to mmc-next for 3.11.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
