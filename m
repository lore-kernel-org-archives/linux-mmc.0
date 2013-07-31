From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
Date: Wed, 31 Jul 2013 12:29:27 +0900
Message-ID: <51F88497.5020909@samsung.com>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
 <1375184777-25404-4-git-send-email-broonie@kernel.org>
 <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:9702 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753785Ab3GaD3W (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 23:29:22 -0400
In-reply-to: <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: 'Mark Brown' <broonie@kernel.org>, 'Liam Girdwood' <lgirdwood@gmail.com>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, 'Mark Brown' <broonie@linaro.org>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

On 07/30/2013 10:33 PM, Seungwon Jeon wrote:
> On Tue, July 30, 2013, Mark Brown wrote:
>> From: Mark Brown <broonie@linaro.org>
>>
>> Use regulator_get_optional() to tell the core that requests for regulators
>> can fail in a real system.
>>
>> Signed-off-by: Mark Brown <broonie@linaro.org>
> Acked-by: Seungwon Jeon <tgih.jun@samsung.com>
> 
> Thanks,
> Seungwon Jeon
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

