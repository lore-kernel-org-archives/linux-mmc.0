From: David Miller <davem@davemloft.net>
Subject: Re: [net-next 1/3] iwmc3200top: clean up fw_download
Date: Wed, 23 Dec 2009 14:16:37 -0800 (PST)
Message-ID: <20091223.141637.48501143.davem@davemloft.net>
References: <1260973586-10243-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44651
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757474AbZLWWQf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 23 Dec 2009 17:16:35 -0500
In-Reply-To: <1260973586-10243-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tomas.winkler@intel.com
Cc: netdev@vger.kernel.org, linux-mmc@vger.kernel.org, yi.zhu@intel.com, inaky.perez-gonzalez@intel.com, guy.cohen@intel.com, ron.rindjunsky@intel.com

From: Tomas Winkler <tomas.winkler@intel.com>
Date: Wed, 16 Dec 2009 16:26:24 +0200

> 1. removed redundant NULL-pointers checks in iwmct_fw_load
> as release_firmware and kfree are NULL pointer friendly
> 2. remove redundant memset of the parser since the structure
> is fully initialized in iwmct_fw_parser_init function
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Applied.
