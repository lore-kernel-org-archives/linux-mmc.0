From: Kevin Liu <keyuan.liu@gmail.com>
Subject: Re: [PATCH v3 01/11] mmc: sdhci: fix transfer mode setting bug for
 cmds w/o data transfer
Date: Tue, 25 Sep 2012 23:49:16 +0800
Message-ID: <CADz5_gLz1vHBaHKyAb+bSBxJeoq3X9rJA4EwLW-J3t1xvUGTqA@mail.gmail.com>
References: <1348569546-13242-1-git-send-email-keyuan.liu@gmail.com>
	<1348569546-13242-2-git-send-email-keyuan.liu@gmail.com>
	<CAGxe1ZH-7Gvydqy3vBrpXEzFmkU1EOOL75OTVOgUdA8f+OOpSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:37263 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab2IYPtS (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Sep 2012 11:49:18 -0400
Received: by weyt9 with SMTP id t9so989251wey.19
        for <linux-mmc@vger.kernel.org>; Tue, 25 Sep 2012 08:49:16 -0700 (PDT)
In-Reply-To: <CAGxe1ZH-7Gvydqy3vBrpXEzFmkU1EOOL75OTVOgUdA8f+OOpSw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Girish K S <girish.shivananjappa@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, pierre@ossman.eu, ulf.hansson@linaro.org, zgao6@marvell.com, hzhuang1@marvell.com, cxie4@marvell.com, prakity@marvell.com, kliu5@marvell.com, Jialing Fu <jlfu@marvell.com>, Tim Wang <wangtt@marvell.com>

2012/9/25 Girish K S <girish.shivananjappa@linaro.org>:
> On 25 September 2012 19:38, Kevin Liu <keyuan.liu@gmail.com> wrote:
>> From: Kevin Liu <kliu5@marvell.com>
>>
>> Commands without data transfer like cmd5/cmd7 will use previous
>> transfer mode setting, which may lead to error since some bits
>> may have been set unexpectedly.
>> For example, cmd5 following cmd18/cmd25 will have timeout error
>> since audo cmd23 has been enabled.
>>
>> Signed-off-by: Jialing Fu <jlfu@marvell.com>
>> Signed-off-by: Tim Wang <wangtt@marvell.com>
>> Signed-off-by: Kevin Liu <kliu5@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c |   22 ++++++++++++++--------
>>  1 files changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e15c79..2f844e5 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -886,8 +886,21 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
>>         u16 mode;
>>         struct mmc_data *data = cmd->data;
>>
>> -       if (data == NULL)
>> +       if (data == NULL) {
> Even though its kept as it is in the prev code. avoid explicit check
> for NULL. can use !data which is commonly used

Ok, I will update the patch.

Thanks
Kevin
