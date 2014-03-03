From: micky <micky_ching@realsil.com.cn>
Subject: Re: mmc: rtsx: add support for pre_req and post_req
Date: Mon, 3 Mar 2014 09:13:44 +0800
Message-ID: <5313D748.1080404@realsil.com.cn>
References: <20140228202432.GA29547@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rtits2.realtek.com ([60.250.210.242]:43518 "EHLO
	rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753663AbaCCBKe (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 2 Mar 2014 20:10:34 -0500
In-Reply-To: <20140228202432.GA29547@elgon.mountain>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-mmc@vger.kernel.org

On 03/01/2014 04:35 AM, Dan Carpenter wrote:
> Hello Micky Ching,
>
> The patch c42deffd5b53: "mmc: rtsx: add support for pre_req and
> post_req" from Feb 17, 2014, leads to the following static checker
> warning:
>
> 	drivers/mmc/host/rtsx_pci_sdmmc.c:525 sd_pre_dma_transfer()
> 	warn: we tested 'next' before and it was 'false'
>
> drivers/mmc/host/rtsx_pci_sdmmc.c
>     520                          "error: invalid cookie data[%d] host[%d]\n",
>     521                          data->host_cookie, host->next_data.cookie);
>     522                  data->host_cookie = 0;
>     523          }
>     524
>     525          if (next || (!next && data->host_cookie != host->next_data.cookie))
>                               ^^^^^
> We are testing "next" twice.  Often that means the intention was to test
> a different variable?
Yes, it can be write as follow.
if (next || data->host_cookie != host->next_data.cookie)
>
>     526                  sg_count = rtsx_pci_dma_map_sg(pcr,
>     527                                  data->sg, data->sg_len, read);
>     528          else
>     529                  sg_count = host->next_data.sg_count;
>
> regards,
> dan carpenter
>

