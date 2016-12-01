From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH 1/1] mmc: mmc: Relax checking for switch errors after
 HS200 switch
Date: Thu, 1 Dec 2016 15:40:41 +0200
Message-ID: <dd764c3d-6303-2d26-4201-d491957dc980@intel.com>
References: <1479988969-1747-1-git-send-email-adrian.hunter@intel.com>
 <1479988969-1747-2-git-send-email-adrian.hunter@intel.com>
 <CAPDyKFpxHVYc2wYc-yV3YLa=NKg1k1aktKhzCKfaZ2oaA_QLSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:22072 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751676AbcLANpp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 1 Dec 2016 08:45:45 -0500
In-Reply-To: <CAPDyKFpxHVYc2wYc-yV3YLa=NKg1k1aktKhzCKfaZ2oaA_QLSQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Stephen Boyd <sboyd@codeaurora.org>, Michael Walle <michael@walle.cc>, Yong Mao <yong.mao@mediatek.com>, Shawn Lin <shawn.lin@rock-chips.com>

On 01/12/16 12:18, Ulf Hansson wrote:
> On 24 November 2016 at 13:02, Adrian Hunter <adrian.hunter@intel.com> wrote:
>> The JEDEC specification indicates CMD13 can be used after a HS200 switch
>> to check for errors. However in practice some boards experience CRC errors
>> in the CMD13 response. Consequently, for HS200, CRC errors are not a
>> reliable way to know the switch failed. If there really is a problem, we
>> would expect tuning will fail and the result ends up the same. So change
>> the error condition to ignore CRC errors in that case.
> 
> I agree, this seems like a good idea.
> 
> However...
> 
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  drivers/mmc/core/mmc.c | 15 ++++++++++++++-
>>  1 file changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index 3268fcd3378d..34d30e2a09ff 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1223,7 +1223,12 @@ int mmc_hs400_to_hs200(struct mmc_card *card)
>>         mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>>
>>         err = mmc_switch_status(card);
>> -       if (err)
>> +       /*
>> +        * For HS200, CRC errors are not a reliable way to know the switch
>> +        * failed. If there really is a problem, we would expect tuning will
>> +        * fail and the result ends up the same.
>> +        */
>> +       if (err && err != -EILSEQ)
> 
> I would rather change mmc_switch_status() to take a new parameter,
> which tells it about ignoring CRC errors.
> 
> The reason is simply that I think these changes should probably apply
> to HS400 as well, and then it just gets lots of duplicated code for
> the same error check.

In the HS200 case, we have not yet done tuning and are not yet at the HS200 frequency - so there are reasons to ignore CRC errors.  As well as the fact that there is hardware that is known to have that weakness.

The HS400 case is a little different because we have already done tuning (in HS200 mode) by that time.  After the final switch, both the card and host controller have reached their final operating point, and then CMD13 is sent - so CRC errors would be unexpected.

The switches on the way from HS200 to HS400 are either done:
	- in HS200 mode after tuning is done and at HS200 frequency
	- in a mode that does not require tuning
So again in those cases, CRC errors would be unexpected.

Which does not mean I am against relaxing those cases too, but the rational is different, and I have no strong opinion on it - other than the obvious: that returning a fatal error when the hardware can in fact work, is counterproductive.

> 
>>                 goto out_err;
>>
>>         mmc_set_bus_speed(card);
>> @@ -1387,6 +1392,14 @@ static int mmc_select_hs200(struct mmc_card *card)
>>
>>                 err = mmc_switch_status(card);
>>                 /*
>> +                * For HS200, CRC errors are not a reliable way to know the
>> +                * switch failed. If there really is a problem, we would expect
>> +                * tuning will fail and the result ends up the same.
>> +                */
>> +               if (err == -EILSEQ)
>> +                       err = 0;
>> +
>> +               /*
>>                  * mmc_select_timing() assumes timing has not changed if
>>                  * it is a switch error.
>>                  */
>> --
>> 1.9.1
>>
> 
> Moreover, and somewhat related to this change:
> 
> Do we want to change mmc_switch_status() to be able to tell
> mmc_send_status() about the number of command retries? Currently it
> defaults to MMC_CMD_RETRIES, but I guess we only want to send *one*
> CMD13?

Yeah, although there is always the possibility that the retries overcome sporadic CRC errors, which would otherwise be fatal.

I tend to think this patch should still be separate because it's rational is different.
However we could consider something like this:

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index c0cfaaeb7637..d61a955b69fc 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -54,7 +54,7 @@
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
-int mmc_send_status(struct mmc_card *card, u32 *status)
+int __mmc_send_status(struct mmc_card *card, u32 *status, int retries)
 {
 	int err;
 	struct mmc_command cmd = {0};
@@ -67,7 +67,7 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 		cmd.arg = card->rca << 16;
 	cmd.flags = MMC_RSP_SPI_R2 | MMC_RSP_R1 | MMC_CMD_AC;
 
-	err = mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	err = mmc_wait_for_cmd(card->host, &cmd, retries);
 	if (err)
 		return err;
 
@@ -80,6 +80,11 @@ int mmc_send_status(struct mmc_card *card, u32 *status)
 	return 0;
 }
 
+int mmc_send_status(struct mmc_card *card, u32 *status)
+{
+	return __mmc_send_status(card, status, MMC_CMD_RETRIES);
+}
+
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *card)
 {
 	struct mmc_command cmd = {0};
@@ -453,7 +458,9 @@ int mmc_switch_status(struct mmc_card *card)
 	u32 status;
 	int err;
 
-	err = mmc_send_status(card, &status);
+	err = __mmc_send_status(card, &status, 0);
+	if (err == -EILSEQ)
+		return 0;
 	if (err)
 		return err;
 

