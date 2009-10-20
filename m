From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next V2 1/3] iwmc3200top: Add Intel Wireless
 MultiCom 3200 top driver.
Date: Mon, 19 Oct 2009 21:54:57 -0700 (PDT)
Message-ID: <20091019.215457.43252934.davem@davemloft.net>
References: <1255806576-26869-1-git-send-email-tomas.winkler@intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40961
	"EHLO sunset.davemloft.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751186AbZJTEyf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Oct 2009 00:54:35 -0400
In-Reply-To: <1255806576-26869-1-git-send-email-tomas.winkler@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: tomas.winkler@intel.com
Cc: linville@tuxdriver.com, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org, yi.zhu@intel.com, inaky.perez-gonzalez@intel.com, cindy.h.kao@intel.com, guy.cohen@intel.com, ron.rindjunsky@intel.com

From: Tomas Winkler <tomas.winkler@intel.com>
Date: Sat, 17 Oct 2009 21:09:34 +0200

> This patch adds Intel Wireless MultiCom 3200 top driver.
> IWMC3200 is 4Wireless Com CHIP (GPS/BT/WiFi/WiMAX).
> Top driver is responsible for device initialization and firmware download.
> Firmware handled by top is responsible for top itself and
> as well as bluetooth and GPS coms. (Wifi and WiMax provide their own firmware)
> In addition top driver is used to retrieve firmware logs
> and supports other debugging features
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Applied to net-next-2.6
