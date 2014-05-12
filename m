From: Dinh Nguyen <dinguyen@altera.com>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed"
 property.
Date: Mon, 12 May 2014 12:43:09 -0500
Message-ID: <1399916589.5497.2.camel@linux-builds1>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
	 <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1bon0143.outbound.protection.outlook.com ([157.56.111.143]:32480
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751616AbaELSRV (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 12 May 2014 14:17:21 -0400
In-Reply-To: <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
> Remove the "support-highspeed" property in dw-mmc.
> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
> 

s/support-highspeed/supports-highspeed

Dinh

