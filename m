From: Dinh Nguyen <dinh.linux@gmail.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-pltm: Remove Rockchip's custom dw_mmc
 driver structure
Date: Fri, 06 Dec 2013 17:27:01 -0600
Message-ID: <52A25D45.7000500@gmail.com>
References: <1386346223-18464-1-git-send-email-dinguyen@altera.com> <201312070014.53895.heiko@sntech.de> <52A25B2F.60209@gmail.com> <201312070022.03414.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61500 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759232Ab3LFX1P (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Dec 2013 18:27:15 -0500
Received: by mail-ob0-f176.google.com with SMTP id va2so1485177obc.7
        for <linux-mmc@vger.kernel.org>; Fri, 06 Dec 2013 15:27:15 -0800 (PST)
In-Reply-To: <201312070022.03414.heiko@sntech.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-15?Q?Heiko_St=FCbner?= <heiko@sntech.de>
Cc: dinguyen@altera.com, arnd@arndb.de, cjb@laptop.org, jh80.chung@samsung.com, tgih.jun@samsung.com, dianders@chromium.org, alim.akhtar@samsung.com, bzhao@marvell.com, linux-mmc@vger.kernel.org


On 12/6/13 5:22 PM, Heiko St=FCbner wrote:
> Am Samstag, 7. Dezember 2013, 00:18:07 schrieb Dinh Nguyen:
>> On 12/6/13 5:14 PM, Heiko St=FCbner wrote:
>>> Am Freitag, 6. Dezember 2013, 17:10:23 schrieb dinguyen@altera.com:=
@@ -42,7 +42,7 @@
>>>  /* Common flag combinations */
>>>  #define DW_MCI_DATA_ERROR_FLAGS        (SDMMC_INT_DRTO | SDMMC_INT=
_DCRC | \
>>>                                  SDMMC_INT_HTO | SDMMC_INT_SBE  | \
>>> -                                SDMMC_INT_EBE)
>>> +                                SDMMC_INT_EBE | SDMMC_INT_FRUN)
>>>  #define DW_MCI_CMD_ERROR_FLAGS (SDMMC_INT_RTO | SDMMC_INT_RCRC | \
>>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>>
>>>> Rockchip's implementation of the dw_mmc controller only requires t=
he
>>>> setting of the SDMMC_CMD_USE_HOLD_REG on every command. With the p=
atch
>>>> to set the SDMMC_CMD_USE_HOLD_REG by checking the slot's speed mod=
e,
>>>> this Rockchip custom driver structure is no longer necessary.
>>>>
>>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>> hmm, testing will need a bit more time, as it seems one of the chan=
ges
>>> merged during the 3.13 merge window broke the dw-mmc on the rockchi=
p.
>> Thanks Heiko. Don't bother with v1, I overlooked another aspect of u=
sing
>> the hold
>> reg. Let me send out a v2 for you to test.
> Don't worry ... as I've said, first I need to find the current issue =
:-)
What behavior are you seeing? I had to do this apply this for 3.13 when=
 the
SD driver is using IDMAC:

--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -42,7 +42,7 @@
 /* Common flag combinations */
 #define DW_MCI_DATA_ERROR_FLAGS        (SDMMC_INT_DRTO | SDMMC_INT_DCR=
C | \
                                 SDMMC_INT_HTO | SDMMC_INT_SBE  | \
-                                SDMMC_INT_EBE)
+                                SDMMC_INT_EBE | SDMMC_INT_FRUN)
 #define DW_MCI_CMD_ERROR_FLAGS (SDMMC_INT_RTO | SDMMC_INT_RCRC | \
                                 SDMMC_INT_RESP_ERR)
 #define DW_MCI_ERROR_FLAGS     (DW_MCI_DATA_ERROR_FLAGS | \
>
> Heiko
>

