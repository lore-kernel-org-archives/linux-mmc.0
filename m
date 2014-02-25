From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: mmc: rtsx: add support for pre_req and post_req
Date: Tue, 25 Feb 2014 10:59:28 +0300
Message-ID: <20140225075928.GS26776@mwanda>
References: <20140224220328.GA29170@elgon.mountain>
 <530BF74C.4010603@realsil.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:32416 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaBYH7k (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Feb 2014 02:59:40 -0500
Content-Disposition: inline
In-Reply-To: <530BF74C.4010603@realsil.com.cn>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: micky <micky_ching@realsil.com.cn>
Cc: linux-mmc@vger.kernel.org

On Tue, Feb 25, 2014 at 09:52:12AM +0800, micky wrote:
> Hi Dan,
> 
> I'm wondering how to get this warning info, so I can check before
> sending patch.
> Can you give me some idea?
> 

This is a smatch thing, but you it's a cross function bug so you have to
build the database first and that takes some hours.  The commands are
simple though.  Run:

	~/path/to/smatch_scripts/build_kernel_data.sh
	~/path/to/smatch_scripts/kchecker drivers/mmc/host/rtsx_pci_sdmmc.c

regards,
dan carpenter

