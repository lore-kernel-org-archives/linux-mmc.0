From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Wed, 15 Jan 2014 16:54:31 +0100
Message-ID: <201401151654.31843.arnd@arndb.de>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <002c01cf11ff$6790a8a0$36b1f9e0$%jun@samsung.com> <52D6A9FF.3000603@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="euc-kr"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:56090 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751962AbaAOPyq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 10:54:46 -0500
In-Reply-To: <52D6A9FF.3000603@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei <zhangfei.gao@linaro.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, 'Kevin Hilman' <khilman@linaro.org>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, 'Mike Turquette' <mturquette@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

On Wednesday 15 January 2014, zhangfei wrote:
> 
> On 01/15/2014 10:38 PM, Seungwon Jeon wrote:
> >> Hmm, looks you are right.
> >> Though not see clearly mmc_gpio_get_cd declaratoin, other drivers
> >> directly set get_cd as mmc_gpio_get_cd.
> >> .get_cd	= mmc_gpio_get_cd
> >>
> >> However, in our board cd =0 when card is deteced while cd=1 when card is
> >> removed.
> >> In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> >> set, as well as new property "caps2-mmc-cd-active-low".
> > 
> > Ok, you could do more.
> > mmc_gpio_get_cd() is expected to return non-zero if card is detection.
> 
> > I think your board seems not to use pull-up on GPIO line for card detection.
> > So, MMC_CAP2_CD_ACTIVE_HIGH would be needed.
> 
> Unfortunately, the specific cd pin can not be configured.
> Suspect on our board the cd =1 when card is inserted, can not measure as
> no clear resister and need check with hardware guy tomorrow.
> 
> "cd-inverted" may be required as mentioned by Arnd.
> Will update the patch as following if no problem.

The patch looks right, but I wonder if a better longer-term
solution would be to just the common mmc_of_parse() function
rather than duplicating it in dw_mmc.

	Arnd
