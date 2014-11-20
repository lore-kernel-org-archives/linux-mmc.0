From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH] mmc: sdhci-sirf: add sirf tuning function (cmd 19)
Date: Thu, 20 Nov 2014 17:25:45 +0800
Message-ID: <CAGsJ_4xzQJ-v7mM8_gD299EN=Hb9aShY5HcR6R8XyEwXB+Ofzg@mail.gmail.com>
References: <1415720864-3936-1-git-send-email-21cnbao@gmail.com>
 <CAPDyKFopdcLXVCuoifd7K8NaRY4UXDbDmNJvyFeUQZs62or9Ag@mail.gmail.com>
 <CAGsJ_4yOCwt1YYd6UuAXjeO2iWhQB4XtouyriX1YsK7BnyNNLA@mail.gmail.com> <CAPDyKFprzeMS7Di7XUYTeZx-WE2UT+zmNKZM_8kHYhOLSoTfLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:62571 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755904AbaKTJ0J (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 04:26:09 -0500
Received: by mail-pd0-f181.google.com with SMTP id z10so2740501pdj.12
        for <linux-mmc@vger.kernel.org>; Thu, 20 Nov 2014 01:26:08 -0800 (PST)
In-Reply-To: <CAPDyKFprzeMS7Di7XUYTeZx-WE2UT+zmNKZM_8kHYhOLSoTfLQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Minda Chen <Minda.Chen@csr.com>, Barry Song <Baohua.Song@csr.com>

>>> These piece of code, which sends the tuning command don't belong in
>>> the host driver. Instead I would like this to be handled from a helper
>>> function from the mmc core.
>>>
>>> I realize that there already a few existing host drivers that
>>> implemented similar code and I don't like it. We should convert them
>>> to use a common helper function from the core instead.
>> yes. that is fine.
>>
>> our engineering is currently very busy and might have no time to
>> handle this for this moment.
>> do you think we can move your requirement to a new refine task of next
>> window after you pick up this in this window?
>
> No.
>
> You don't have to adopt the other host drivers at this point, only to
> fix yours accordingly. The rest we can take care of later.
>

Uffe, how do you think about we provide a core-level function at first:


>From 3f47dfd577ef3ff8c41dbb44d71d383a9e620ada Mon Sep 17 00:00:00 2001
From: Minda Chen <Minda.Chen@csr.com>
Date: Thu, 20 Nov 2014 10:42:41 +0800
Subject: [PATCH] mmc: ops: Add mmc_send_tuning function

According to the SD card spec, Add a manual
tuning command function for SDR104/HS200
Sending command 19 or command 21 to read data
and compare with the tunning block.

Change-Id: Ic481b78b1e247c88942788ff0d10746779f672c0
Signed-off-by: Minda Chen <Minda.Chen@csr.com>
---
 drivers/mmc/core/mmc_ops.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/core.h   |  1 +
 2 files changed, 66 insertions(+)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 7911e05..ecc7789 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -543,6 +543,71 @@ int mmc_switch(struct mmc_card *card, u8 set, u8
index, u8 value,
 }
 EXPORT_SYMBOL_GPL(mmc_switch);

+int mmc_send_tuning(struct mmc_card *card, u32 opcode)
+{
+ struct mmc_request mrq = {NULL};
+ struct mmc_command cmd = {0};
+ struct mmc_data data = {0};
+ struct scatterlist sg;
+ struct mmc_host *mmc = card->host;
+ struct mmc_ios *ios = &mmc->ios;
+ const u8 *tuning_block_pattern;
+ int size, err = 0;
+ u8 *data_buf;
+
+ if (opcode == MMC_SEND_TUNING_BLOCK_HS200) {
+ if (ios->bus_width == MMC_BUS_WIDTH_8) {
+ tuning_block_pattern = tuning_blk_pattern_8bit;
+ size = sizeof(tuning_blk_pattern_8bit);
+ } else if (ios->bus_width == MMC_BUS_WIDTH_4) {
+ tuning_block_pattern = tuning_blk_pattern_4bit;
+ size = sizeof(tuning_blk_pattern_4bit);
+ } else
+ return -EINVAL;
+ } else if (opcode == MMC_SEND_TUNING_BLOCK) {
+ tuning_block_pattern = tuning_blk_pattern_4bit;
+ size = sizeof(tuning_blk_pattern_4bit);
+ } else
+ return -EINVAL;
+
+ data_buf = kmalloc(size, GFP_KERNEL);
+ if (!data_buf)
+ return -ENOMEM;
+
+ mrq.cmd = &cmd;
+ mrq.data = &data;
+
+ cmd.opcode = opcode;
+ cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+ data.blksz = size;
+ data.blocks = 1;
+ data.flags = MMC_DATA_READ;
+
+ mmc_set_data_timeout(&data, card);
+ sg_init_one(&sg, data_buf, size);
+ memset(data_buf, 0, size);
+ mmc_wait_for_req(mmc, &mrq);
+
+ if (cmd.error) {
+ err = cmd.error;
+ goto out;
+ }
+
+ if (data.error) {
+ err = data.error;
+ goto out;
+ }
+
+ if (memcmp(data_buf, tuning_block_pattern, size))
+ err = -EIO;
+
+out:
+ kfree(data_buf);
+ return err;
+}
+EXPORT_SYMBOL_GPL(mmc_send_tuning);
+
 static int
 mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 opcode,
   u8 len)
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
index f206e29..82a0119 100644
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -154,6 +154,7 @@ extern void mmc_start_bkops(struct mmc_card *card,
bool from_exception);
 extern int __mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int, bool,
  bool, bool);
 extern int mmc_switch(struct mmc_card *, u8, u8, u8, unsigned int);
+extern int mmc_send_tuning(struct mmc_card *, u32);
 extern int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd);

 #define MMC_ERASE_ARG 0x00000000
-- 
1.9.1


> Br
> Uffe
