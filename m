From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
Date: Thu, 16 Jan 2014 10:10:05 +0800
Message-ID: <52D73F7D.60302@linaro.org>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org> <3154671.7LPLgq8X4K@wuerfel> <20140115160146.GO15937@n2100.arm.linux.org.uk> <15344443.B6eHZOpkXH@wuerfel> <20140115162210.GP15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:43805 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaAPCKS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 15 Jan 2014 21:10:18 -0500
Received: by mail-pa0-f43.google.com with SMTP id rd3so1986110pab.30
        for <linux-mmc@vger.kernel.org>; Wed, 15 Jan 2014 18:10:18 -0800 (PST)
In-Reply-To: <20140115162210.GP15937@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>
Cc: 'Kevin Hilman' <khilman@linaro.org>, 'Mike Turquette' <mturquette@linaro.org>, patches@linaro.org, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Sachin Kamat' <sachin.kamat@linaro.org>, 'Chris Ball' <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org



On 01/16/2014 12:22 AM, Russell King - ARM Linux wrote:

> Well, having this in the gpio level as well as in subsystems like MMC
> is going to create confusion - and from the results of this patch _IS_
> causing confusion.  You've just encouraged one implementation to have
> things setup such that mmc_gpio_get_cd() returns false when a card is
> inserted, rather than it correctly returning true.
>
> The issue here is that we'll potentially now end up with _three_
> inversions.  One in the GPIO layers.  One in mmc_gpio_get_cd(), and
> another in every driver which uses the GPIO layer inversion.  This
> is hardly the right approach as it leads to multiple points where
> confusion about the inverted status can occur.
>

Thanks Russell, make sense.

Double checked with the hardware guy, cd pin is high when card inserted 
on the board.
The cd pin is originally connected to vout via a resister, and 
internally short to gound, which is broken when card inserted.

Then Optional properties "caps2-mmc-cd-active-high" has to be added.

--- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
+++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt

+* caps2-mmc-cd-active-high: cd pin is high when card present

@@ -2411,6 +2414,9 @@ static struct dw_mci_board *dw_mci_parse_dt(struct 
dw_mci *host)
         if (of_find_property(np, "caps2-mmc-hs200-1_2v", NULL))
                 pdata->caps2 |= MMC_CAP2_HS200_1_2V_SDR;

+       if (of_find_property(np, "caps2-mmc-cd-active-high", NULL))
+               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
+

Thanks
