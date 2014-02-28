From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: rtsx: add support for pre_req and post_req
Date: Fri, 28 Feb 2014 23:35:42 +0300
Message-ID: <20140228202432.GA29547@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:25904 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbaB1UiV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Feb 2014 15:38:21 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky_ching@realsil.com.cn
Cc: linux-mmc@vger.kernel.org

Hello Micky Ching,

The patch c42deffd5b53: "mmc: rtsx: add support for pre_req and
post_req" from Feb 17, 2014, leads to the following static checker
warning:

	drivers/mmc/host/rtsx_pci_sdmmc.c:525 sd_pre_dma_transfer()
	warn: we tested 'next' before and it was 'false'

drivers/mmc/host/rtsx_pci_sdmmc.c
   520                          "error: invalid cookie data[%d] host[%d]\n",
   521                          data->host_cookie, host->next_data.cookie);
   522                  data->host_cookie = 0;
   523          }
   524  
   525          if (next || (!next && data->host_cookie != host->next_data.cookie))
                             ^^^^^
We are testing "next" twice.  Often that means the intention was to test
a different variable?

   526                  sg_count = rtsx_pci_dma_map_sg(pcr,
   527                                  data->sg, data->sg_len, read);
   528          else
   529                  sg_count = host->next_data.sg_count;

regards,
dan carpenter
