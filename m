From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH v3 02/12] mmc: mmc_test: add debugfs file to list all tests
Date: Sun, 8 May 2011 15:12:46 +0200
Message-ID: <BANLkTindMsH4ozajW3E3ifBnrsS=gpOaOQ@mail.gmail.com>
References: <1304795706-27308-1-git-send-email-per.forlin@linaro.org>
	<1304795706-27308-3-git-send-email-per.forlin@linaro.org>
	<BANLkTim2k_hb0Bw_cYeTUv-dMzyWVPO+gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52100 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab1EHNMr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 May 2011 09:12:47 -0400
In-Reply-To: <BANLkTim2k_hb0Bw_cYeTUv-dMzyWVPO+gA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-dev@lists.linaro.org, Chris Ball <cjb@laptop.org>

On 8 May 2011 00:18, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Sat, May 7, 2011 at 10:14 PM, Per Forlin <per.forlin@linaro.org> w=
rote:
>> Add a debugfs file "testlist" to print all available tests
>>
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> ---
>> =A0drivers/mmc/card/mmc_test.c | =A0 30 ++++++++++++++++++++++++++++=
++
>> =A01 files changed, 30 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test=
=2Ec
>> index abc1a63..c1c3c5a 100644
>> --- a/drivers/mmc/card/mmc_test.c
>> +++ b/drivers/mmc/card/mmc_test.c
>
>
>> @@ -2476,6 +2502,10 @@ static int mmc_test_register_file_test(struct=
 mmc_card *card)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0file =3D debugfs_create_file("test", =
S_IWUSR | S_IRUGO,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->debugfs_root, c=
ard, &mmc_test_fops_test);
>>
>> + =A0 =A0 =A0 if (card->debugfs_root)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 file =3D debugfs_create_file("testlist=
", S_IRUGO,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->debugfs_root, ca=
rd, &mmc_test_fops_testlist);
>> +
>> =A0 =A0 =A0 =A0if (IS_ERR_OR_NULL(file)) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&card->dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Can't create file. P=
erhaps debugfs is disabled.\n");
> I think you also need to use similar error path for both files: test
> and testlist.
Thanks, I'll fix that and add this check for both.

>
>
> --
> With Best Regards,
> Andy Shevchenko
>
Regards,
Per
