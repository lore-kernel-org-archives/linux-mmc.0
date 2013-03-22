From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: sirf: add mmc host sdhci-pltfm based driver for SiRF SoCs
Date: Fri, 22 Mar 2013 13:14:51 -0400
Message-ID: <87fvznl5kk.fsf@octavius.laptop.org>
References: <1363854439-6859-1-git-send-email-Barry.Song@csr.com>
	<1605490.1WxfNfZQTh@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:47787 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422636Ab3CVRO6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Mar 2013 13:14:58 -0400
In-Reply-To: <1605490.1WxfNfZQTh@wuerfel> (Arnd Bergmann's message of "Thu, 21
	Mar 2013 11:13:34 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Barry Song <Barry.Song@csr.com>, linux-mmc@vger.kernel.org, workgroup.linux@csr.com, linux-arm-kernel@lists.infradead.org, Barry Song <Baohua.Song@csr.com>, Bin Shi <Bin.Shi@csr.com>

Hi,

On Thu, Mar 21 2013, Arnd Bergmann wrote:
> On Thursday 21 March 2013 16:27:19 Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>> 
>> this patch adds the new driver for CSR SiRF SoCs:
>> SiRFprimaII: unicore ARM Cortex-A9
>> SiRFatlas6: unicore ARM Cortex-A9
>> SiRFmarco: dual core ARM Cortex-A9 SMP
>> 
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Signed-off-by: Bin Shi <Bin.Shi@csr.com>
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks, pushed to mmc-next for 3.10.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
