From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/5] mmc: dw_mmc: remove the "supports-highspeed" property.
Date: Wed, 14 May 2014 13:55:58 +0900
Message-ID: <5372F75E.9010605@samsung.com>
References: <1399893256-7071-1-git-send-email-jh80.chung@samsung.com>
 <1399893256-7071-3-git-send-email-jh80.chung@samsung.com>
 <1399916589.5497.2.camel@linux-builds1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16573 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaENE4A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 May 2014 00:56:00 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N5J00MVYSDACQ40@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Wed, 14 May 2014 13:55:58 +0900 (KST)
In-reply-to: <1399916589.5497.2.camel@linux-builds1>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinguyen@altera.com>
Cc: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org, tgih.jun@samsung.com, zhangfei.gao@linaro.org

On 05/13/2014 02:43 AM, Dinh Nguyen wrote:
> On Mon, 2014-05-12 at 20:14 +0900, Jaehoon Chung wrote:
>> Remove the "support-highspeed" property in dw-mmc.
>> "support-highspeed" property can be replaced to "cap-sd/mmc-highspeed".
>>
> 
> s/support-highspeed/supports-highspeed

Will fix.
> 
> Dinh
> 
> 

