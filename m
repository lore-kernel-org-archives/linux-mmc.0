From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: via-sdmmc: Use module_pci_driver
Date: Thu, 30 Aug 2012 11:11:47 -0400
Message-ID: <87ehmoqurw.fsf@octavius.laptop.org>
References: <1346049731-21085-1-git-send-email-sachin.kamat@linaro.org>
	<20120827075052.GJ31372@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:39529 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041Ab2H3PLy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 30 Aug 2012 11:11:54 -0400
In-Reply-To: <20120827075052.GJ31372@prithivi.gnumonks.org> (Harald Welte's
	message of "Mon, 27 Aug 2012 09:50:52 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Sachin Kamat <sachin.kamat@linaro.org>, linux-mmc@vger.kernel.org, brucechang@via.com.tw, patches@linaro.org

Hi,

On Mon, Aug 27 2012, Harald Welte wrote:
> Hi Sachin,
>
> On Mon, Aug 27, 2012 at 12:12:11PM +0530, Sachin Kamat wrote:
>> module_pci_driver makes the code simpler by eliminating
>> module_init and module_exit calls.
>> 
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Acked-by: Harald Welte <laforge@gnumonks.org>

Thanks, pushed to mmc-next for 3.7.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
