From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] mmc: davinci: allow driver to work without DMA resource
Date: Thu, 28 Feb 2013 16:30:29 +0530
Message-ID: <512F38CD.1070805@ti.com>
References: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59222 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163Ab3B1LAi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 28 Feb 2013 06:00:38 -0500
In-Reply-To: <1360066944-14265-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org, mporter@ti.com, davinci-linux-open-source@linux.davincidsp.com, gregkh@linuxfoundation.org, cjb@laptop.org

On 2/5/2013 5:52 PM, Manjunathappa, Prakash wrote:
> Do not return probe failure with missing DMA resources,
> allow driver to work in PIO mode.
> Tested on da850-evm by mounting partition followed by
> file creation and deletion.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>

I verified this along with your other patches enabling use of MMC with
DT boot.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
