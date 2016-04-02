From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: mmc: mediatek: add HS400 support
Date: Sat, 2 Apr 2016 11:46:01 +0300
Message-ID: <20160402084601.GA25306@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:16654 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751341AbcDBIqd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 2 Apr 2016 04:46:33 -0400
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, linux-mmc@vger.kernel.org

Hello Chaotian Jing,

The patch 6397b7f5f405: "mmc: mediatek: add HS400 support" from Oct
27, 2015, leads to the following static checker warning:

	drivers/mmc/host/mtk-sd.c:1320 msdc_tune_response()
	error: uninitialized variable 'cmd_err'.

drivers/mmc/host/mtk-sd.c
  1306  static int msdc_tune_response(struct mmc_host *mmc, u32 opcode)
  1307  {
  1308          struct msdc_host *host = mmc_priv(mmc);
  1309          u32 rise_delay = 0, fall_delay = 0;
  1310          struct msdc_delay_phase final_rise_delay, final_fall_delay;
  1311          u8 final_delay, final_maxlen;
  1312          int cmd_err;
                    ^^^^^^^
  1313          int i;
  1314  
  1315          sdr_clr_bits(host->base + MSDC_IOCON, MSDC_IOCON_RSPL);
  1316          for (i = 0 ; i < PAD_DELAY_MAX; i++) {
  1317                  sdr_set_field(host->base + MSDC_PAD_TUNE,
  1318                                MSDC_PAD_TUNE_CMDRDLY, i);
  1319                  mmc_send_tuning(mmc, opcode, &cmd_err);
                                                      ^^^^^^^
No error handling.

  1320                  if (!cmd_err)
                             ^^^^^^^
  1321                          rise_delay |= (1 << i);
  1322          }


regards,
dan carpenter
