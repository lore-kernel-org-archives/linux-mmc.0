From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mmc: sdhci-pci: add Intel Merrifield support
Date: Sun, 20 Oct 2013 21:19:58 -0400
Message-ID: <87hacba08x.fsf@octavius.laptop.org>
References: <1380658695-20047-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:33380 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081Ab3JUBUO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Oct 2013 21:20:14 -0400
In-Reply-To: <1380658695-20047-1-git-send-email-david.a.cohen@linux.intel.com>
	(David Cohen's message of "Tue, 1 Oct 2013 13:18:15 -0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Cohen <david.a.cohen@linux.intel.com>
Cc: bhelgaas@google.com, adrian.hunter@intel.com, wfp5p@virginia.edu, gregkh@linuxfoundation.org, g.liakhovetski@gmx.de, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

Hi David,

On Tue, Oct 01 2013, David Cohen wrote:
> Implement initial SDHCI Intel Merrifield support.
> This patch is based on previous one from Yunpeng Gao <yunpeng.gao@intel.com>
>
> Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
> ---
>  drivers/mmc/host/sdhci-pci.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Thanks, pushed to mmc-next for 3.13.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
