From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH 4/5] mmc: dw_mmc: Indicate that regulators may be absent
Date: Tue, 30 Jul 2013 22:33:30 +0900
Message-ID: <003901ce8d29$610ab3f0$23201bd0$%jun@samsung.com>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
 <1375184777-25404-4-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:45115 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab3G3Ndb (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Jul 2013 09:33:31 -0400
In-reply-to: <1375184777-25404-4-git-send-email-broonie@kernel.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Mark Brown' <broonie@kernel.org>, 'Liam Girdwood' <lgirdwood@gmail.com>, 'Chris Ball' <cjb@laptop.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, 'Mark Brown' <broonie@linaro.org>

On Tue, July 30, 2013, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Use regulator_get_optional() to tell the core that requests for regulators
> can fail in a real system.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon

